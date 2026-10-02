<template>
  <div class="app-container info-container">
    <el-card class="search-card">
      <div slot="header" class="clearfix">
        <span>鲜花筛选</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleSearch">
          {{ showSearch ? '收起' : '展开' }}筛选
        </el-button>
      </div>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
        <el-form-item label="鲜花名称" prop="flowerName">
          <el-input
            v-model="queryParams.flowerName"
            placeholder="请输入鲜花名称"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="queryParams.categoryId" placeholder="请选择分类" clearable>
            <el-option
              v-for="category in categoryList"
              :key="category.id"
              :label="category.categoryName"
              :value="category.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card class="table-card">
      <div slot="header" class="clearfix">
        <span>鲜花列表</span>
      </div>
      
      <!-- 美化工具栏 -->
      <div class="toolbar-container">
        <div class="toolbar-left">
          <el-button
            plain
            type="primary"
            icon="el-icon-circle-plus"
            size="small"
            @click="handleAdd"
            v-hasPermi="['info:info:add']"
            class="toolbar-btn"
          >新增</el-button>
          <el-button
            plain
            type="success"
            icon="el-icon-edit"
            size="small"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['info:info:edit']"
            class="toolbar-btn"
          >修改</el-button>
          <el-button
            plain
            type="danger"
            icon="el-icon-delete"
            size="small"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['info:info:remove']"
            class="toolbar-btn"
          >删除</el-button>
          <el-button
            plain
            type="warning"
            icon="el-icon-download"
            size="small"
            @click="handleExport"
            v-hasPermi="['info:info:export']"
            class="toolbar-btn"
          >导出</el-button>
        </div>
        <div class="toolbar-right">
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </div>
      </div>

      <el-table 
        v-loading="loading" 
        :data="infoList" 
        @selection-change="handleSelectionChange"
        border
        highlight-current-row
        style="width: 100%"
        :header-cell-style="{background:'#f5f7fa', color:'#606266'}"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="鲜花名称" align="center" prop="flowerName">
          <template slot-scope="scope">
            <span class="flower-name">{{ scope.row.flowerName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="分类名称" align="center" prop="categoryName" />
        <el-table-column label="价格" align="center" prop="price" />
        <el-table-column label="库存数量" align="center" prop="stock" />
        <el-table-column label="销售数量" align="center" prop="salesCount" />
        <el-table-column label="状态" align="center" prop="status">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 1 ? 'success' : 'danger'">
              <dict-tag :options="dict.type.flower_status" :value="scope.row.status"/>
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['info:info:edit']"
              class="edit-link"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleUploadImage(scope.row)"
              v-hasPermi="['info:info:edit']"
              class="upload-link"
            >设置图片</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleDelete(scope.row)"
              v-hasPermi="['info:info:remove']"
              class="delete-link"
            >删除</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleView(scope.row)"
              v-hasPermi="['info:info:query']"
              class="view-link"
            >详情</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <!-- 添加或修改鲜花信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="鲜花名称" prop="flowerName">
              <el-input v-model="form.flowerName" placeholder="请输入鲜花名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="分类" prop="categoryId">
              <el-select v-model="form.categoryId" placeholder="请选择分类" style="width: 100%">
                <el-option
                  v-for="category in categoryList"
                  :key="category.id"
                  :label="category.categoryName"
                  :value="category.id">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="鲜花描述" prop="flowerDesc">
              <el-input 
                v-model="form.flowerDesc" 
                type="textarea" 
                :rows="3" 
                placeholder="请输入鲜花描述" 
              />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="价格" prop="price">
              <el-input v-model="form.price" placeholder="请输入价格" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="市场价" prop="marketPrice">
              <el-input v-model="form.marketPrice" placeholder="请输入市场价" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="成本价" prop="costPrice">
              <el-input v-model="form.costPrice" placeholder="请输入成本价" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="库存数量" prop="stock">
              <el-input-number 
                v-model="form.stock" 
                controls-position="right" 
                :min="0" 
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option label="上架" :value="1"></el-option>
                <el-option label="下架" :value="0"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 鲜花详情对话框 -->
    <el-dialog title="鲜花详情" :visible.sync="openView" width="800px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="鲜花名称">{{ viewForm.flowerName }}</el-descriptions-item>
        <el-descriptions-item label="分类名称">{{ viewForm.categoryName }}</el-descriptions-item>
        <el-descriptions-item label="价格">{{ viewForm.price }}</el-descriptions-item>
        <el-descriptions-item label="市场价">{{ viewForm.marketPrice }}</el-descriptions-item>
        <el-descriptions-item label="成本价">{{ viewForm.costPrice }}</el-descriptions-item>
        <el-descriptions-item label="库存数量">{{ viewForm.stock }}</el-descriptions-item>
        <el-descriptions-item label="销售数量">{{ viewForm.salesCount }}</el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="viewForm.status === 1 ? 'success' : 'danger'">
            <dict-tag :options="dict.type.flower_status" :value="viewForm.status"/>
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建人">{{ viewForm.createBy }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ viewForm.createTime }}</el-descriptions-item>
        <el-descriptions-item label="更新人">{{ viewForm.updateBy }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ viewForm.updateTime }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ viewForm.remark }}</el-descriptions-item>
        <el-descriptions-item label="二维码和图片" :span="2">
          <div class="image-container">
            <div class="image-item" v-if="viewForm.qrCodeUrl">
              <div class="image-label">二维码</div>
              <img :src="getFullImageUrl(viewForm.qrCodeUrl)" alt="二维码" class="preview-image" />
            </div>
            <div class="image-item" v-if="viewForm.imageUrls">
              <div class="image-label">鲜花图片</div>
              <el-image
                v-for="(url, index) in parseImageUrls(viewForm.imageUrls)"
                :key="index"
                :src="getFullImageUrl(url)"
                :preview-src-list="parseImageUrls(viewForm.imageUrls).map(u => getFullImageUrl(u))"
                class="preview-image"
              ></el-image>
            </div>
          </div>
        </el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="openView = false">关 闭</el-button>
      </div>
    </el-dialog>
    
    <!-- 图片地址设置对话框 -->
    <el-dialog title="设置图片地址" :visible.sync="openUpload" width="500px" append-to-body>
      <el-form ref="uploadForm" :model="uploadForm" label-width="80px">
        <el-form-item label="图片地址">
          <el-input 
            v-model="uploadForm.imageUrl" 
            placeholder="请输入图片地址" 
            type="textarea"
            :rows="3"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitImageUpload">确定</el-button>
        <el-button @click="cancelImageUpload">取消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listInfo, getInfo, delInfo, addInfo, updateInfo, uploadFlowerImages, updateFlowerImageUrl } from "@/api/info/info"
import { listCategory } from "@/api/category/category"
import { getToken } from "@/utils/auth"

export default {
  name: "Info",
  dicts: ['flower_status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 鲜花信息表格数据
      infoList: [],
      // 分类列表
      categoryList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示详情弹出层
      openView: false,
      // 是否显示图片地址设置弹出层
      openUpload: false,
      // 当前设置图片的鲜花ID
      currentUploadId: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        flowerName: null,
        categoryId: null,
      },
      // 表单参数
      form: {},
      // 详情表单参数
      viewForm: {},
      // 上传表单参数
      uploadForm: {
        imageUrl: ''
      },
      // 表单校验
      rules: {
        flowerName: [
          { required: true, message: "鲜花名称不能为空", trigger: "blur" }
        ],
        categoryId: [
          { required: true, message: "分类不能为空", trigger: "change" }
        ],
        flowerDesc: [
          { required: true, message: "鲜花描述不能为空", trigger: "blur" }
        ],
        price: [
          { required: true, message: "价格不能为空", trigger: "blur" }
        ],
        stock: [
          { required: true, message: "库存数量不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态不能为空", trigger: "change" }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.getCategoryList()
  },
  methods: {
    /** 查询鲜花信息列表 */
    getList() {
      this.loading = true
      listInfo(this.queryParams).then(response => {
        this.infoList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 查询分类列表 */
    getCategoryList() {
      listCategory({}).then(response => {
        this.categoryList = response.rows
      })
    },
    // 切换搜索栏显示状态
    toggleSearch() {
      this.showSearch = !this.showSearch
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        flowerName: null,
        categoryId: null,
        flowerDesc: null,
        price: null,
        marketPrice: null,
        costPrice: null,
        imageUrls: null,
        qrCodeUrl: null,
        stock: null,
        salesCount: null,
        status: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加鲜花信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getInfo(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改鲜花信息"
      })
    },
    /** 详情按钮操作 */
    handleView(row) {
      this.reset()
      const id = row.id || this.ids
      getInfo(id).then(response => {
        this.viewForm = response.data
        this.openView = true
      })
    },
    /** 上传图片按钮操作 */
    handleUploadImage(row) {
      this.currentUploadId = row.id;
      // 初始化图片地址为空
      this.uploadForm.imageUrl = row.imageUrls ? this.parseImageUrls(row.imageUrls)[0] : '';
      this.openUpload = true;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            // 修改（不包含图片上传）
            const basicData = {
              id: this.form.id,
              flowerName: this.form.flowerName,
              categoryId: this.form.categoryId,
              flowerDesc: this.form.flowerDesc,
              price: this.form.price,
              marketPrice: this.form.marketPrice,
              costPrice: this.form.costPrice,
              stock: this.form.stock,
              status: this.form.status,
              remark: this.form.remark
            }
            
            updateInfo(basicData).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            }).catch(error => {
              this.$modal.msgError("修改失败: " + (error.message || "未知错误"))
              console.error("修改失败:", error)
            })
          } else {
            // 新增
            const basicData = {
              flowerName: this.form.flowerName,
              categoryId: this.form.categoryId,
              flowerDesc: this.form.flowerDesc,
              price: this.form.price,
              marketPrice: this.form.marketPrice,
              costPrice: this.form.costPrice,
              stock: this.form.stock,
              status: this.form.status,
              remark: this.form.remark
            }
            
            addInfo(basicData).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            }).catch(error => {
              this.$modal.msgError("新增失败: " + (error.message || "未知错误"))
              console.error("新增失败:", error)
            })
          }
        }
      })
    },
    /** 上传图片 */
    uploadImages(id) {
      // 创建FormData对象用于图片上传
      const formData = new FormData()
      
      // 只添加第一张图片
      if (this.fileList[0] && this.fileList[0].raw) {
        formData.append("imageFile", this.fileList[0].raw)
      }
      
      // 上传图片
      uploadFlowerImages(id, formData).then(response => {
        this.$modal.msgSuccess("图片上传成功")
        this.getList()
      }).catch(error => {
        this.$modal.msgError("图片上传失败: " + (error.message || "未知错误"))
        console.error("图片上传失败:", error)
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除鲜花信息编号为"' + ids + '"的数据项？').then(function() {
        return delInfo(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('info/info/export', {
        ...this.queryParams
      }, `info_${new Date().getTime()}.xlsx`)
    },
    // 图片文件超出个数限制时的钩子
    handleImageExceed(files, fileList) {
      this.$message.warning(`只能上传1张图片`)
    },
    // 图片文件移除时的钩子
    handleImageRemove(file, fileList) {
      this.imageFileList = fileList
    },
    // 图片文件状态改变时的钩子
    handleImageChange(file, fileList) {
      this.imageFileList = fileList
    },
    // 取消图片上传
    cancelImageUpload() {
      this.openUpload = false
      this.uploadForm.imageUrl = ''
    },
    // 提交图片上传
    submitImageUpload() {
      if (!this.uploadForm.imageUrl) {
        this.$modal.msgWarning("请输入图片地址")
        return
      }
      
      // 创建包含图片地址的数据对象
      const imageData = {
        id: this.currentUploadId,
        imageUrl: this.uploadForm.imageUrl
      }
      
      // 调用新的API接口设置图片地址
      updateFlowerImageUrl(imageData).then(response => {
        this.$modal.msgSuccess("图片地址设置成功")
        this.openUpload = false
        this.uploadForm.imageUrl = ''
        this.getList()
      }).catch(error => {
        this.$modal.msgError("图片地址设置失败: " + (error.message || "未知错误"))
        console.error("图片地址设置失败:", error)
      })
    },
    getFullImageUrl(url) {
      // 如果URL已经是完整URL，则直接返回
      if (url && (url.startsWith('http://') || url.startsWith('https://'))) {
        return url;
      }
      // 否则添加基础API路径
      return process.env.VUE_APP_BASE_API + (url.startsWith('/') ? url : '/' + url);
    },
    parseImageUrls(imageUrls) {
      // 如果imageUrls已经是字符串URL，直接返回包含该URL的数组
      if (typeof imageUrls === 'string' && (imageUrls.startsWith('http://') || imageUrls.startsWith('https://'))) {
        return [imageUrls];
      }
      
      // 兼容旧的JSON数组格式
      try {
        if (typeof imageUrls === 'string') {
          const parsed = JSON.parse(imageUrls);
          // 如果解析结果是数组，返回该数组
          if (Array.isArray(parsed)) {
            return parsed;
          }
          // 如果解析结果是字符串，返回包含该字符串的数组
          else if (typeof parsed === 'string') {
            return [parsed];
          }
        }
        return imageUrls || [];
      } catch (e) {
        // 如果解析失败但imageUrls是字符串，将其作为单个URL处理
        if (typeof imageUrls === 'string' && imageUrls.trim() !== '') {
          return [imageUrls];
        }
        console.error('解析图片URL失败:', e);
        return [];
      }
    }
  }
}
</script>

<style scoped>
.info-container {
  background-color: #f0f2f5;
  padding: 20px;
}

.search-card {
  margin-bottom: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.search-card ::v-deep .el-card__header {
  background-color: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
  padding: 15px 20px;
  font-weight: 600;
  color: #495057;
}

.table-card {
  margin-bottom: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.table-card ::v-deep .el-card__header {
  background-color: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
  padding: 15px 20px;
  font-weight: 600;
  color: #495057;
}

.toolbar-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px 20px;
  background-color: #fff;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.toolbar-left {
  display: flex;
  gap: 12px;
}

.toolbar-btn {
  padding: 9px 16px;
  border-radius: 4px;
  transition: all 0.3s ease;
  font-weight: 500;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.toolbar-btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.toolbar-right {
  display: flex;
  align-items: center;
}

/* 表格样式优化 */
::v-deep .el-table {
  border-radius: 6px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

::v-deep .el-table th {
  background-color: #f8f9fa !important;
  font-weight: 600;
  color: #495057;
}

.flower-name {
  font-weight: 600;
  color: #409EFF;
}

/* 对话框样式优化 */
::v-deep .el-dialog {
  border-radius: 8px;
  overflow: hidden;
}

::v-deep .el-dialog__header {
  background-color: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
  padding: 15px 20px;
  font-weight: 600;
  color: #495057;
}

.el-dialog__body {
  padding: 25px 30px;
}

/* 表单元素美化 */
::v-deep .el-form-item__label {
  font-weight: 500;
  color: #606266;
}

::v-deep .el-input__inner, ::v-deep .el-textarea__inner {
  border-radius: 4px;
  transition: border-color 0.3s;
}

::v-deep .el-input__inner:focus, ::v-deep .el-textarea__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 详情对话框样式 */
.el-descriptions {
  margin-top: 20px;
  background-color: #fafafa;
  padding: 20px;
  border-radius: 6px;
}

.el-descriptions__label {
  width: 120px;
  font-weight: 600;
  color: #606266;
}

/* 图片容器样式 */
.image-container {
  display: flex;
  gap: 20px;
  align-items: flex-start;
}

.image-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.image-label {
  font-weight: bold;
  margin-bottom: 10px;
  color: #606266;
}

.preview-image {
  max-width: 200px;
  max-height: 200px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 5px;
}

/* 分页组件美化 */
::v-deep .el-pagination {
  margin-top: 20px;
  padding: 15px 20px;
  background-color: #fff;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

/* 操作链接样式 */
.edit-link {
  color: #409EFF; /* 蓝色 */
}

.delete-link {
  color: #F56C6C; /* 红色 */
}

.view-link {
  color: #67C23A; /* 绿色 */
}

.upload-link {
  color: #E6A23C; /* 橙色 */
}

.edit-link:hover, .delete-link:hover, .view-link:hover, .upload-link:hover {
  opacity: 0.8;
  font-weight: 600;
}
</style>