<template>
  <div class="app-container category-container">
    <el-card class="search-card">
      <div slot="header" class="clearfix">
        <span>分类筛选</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleSearch">
          {{ showSearch ? '收起' : '展开' }}筛选
        </el-button>
      </div>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
        <el-form-item label="分类名称" prop="categoryName">
          <el-input
            v-model="queryParams.categoryName"
            placeholder="请输入分类名称"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option
              v-for="dict in dict.type.category_status"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
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
        <span>分类列表</span>
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
            v-hasPermi="['category:category:add']"
            class="toolbar-btn"
          >新增</el-button>
          <el-button
            plain
            type="success"
            icon="el-icon-edit"
            size="small"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['category:category:edit']"
            class="toolbar-btn"
          >修改</el-button>
          <el-button
            plain
            type="danger"
            icon="el-icon-delete"
            size="small"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['category:category:remove']"
            class="toolbar-btn"
          >删除</el-button>
          <el-button
            plain
            type="warning"
            icon="el-icon-download"
            size="small"
            @click="handleExport"
            v-hasPermi="['category:category:export']"
            class="toolbar-btn"
          >导出</el-button>
        </div>
        <div class="toolbar-right">
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </div>
      </div>

      <el-table 
        v-loading="loading" 
        :data="categoryList" 
        @selection-change="handleSelectionChange"
        border
        highlight-current-row
        style="width: 100%"
        :header-cell-style="{background:'#f5f7fa', color:'#606266'}"
      >
        <el-table-column type="selection" width="55" align="center" />
        <!-- 隐藏ID列 -->
        <!-- <el-table-column label="分类ID" align="center" prop="id" /> -->
        <el-table-column label="分类名称" align="center" prop="categoryName">
          <template slot-scope="scope">
            <span class="category-name">{{ scope.row.categoryName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="分类描述" align="center" prop="categoryDesc" show-overflow-tooltip>
          <template slot-scope="scope">
            <span class="category-desc">{{ scope.row.categoryDesc }}</span>
          </template>
        </el-table-column>
        <!-- 删除排序字段 -->
        <!-- <el-table-column label="排序" align="center" prop="sortOrder" width="80">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.sortOrder }}</el-tag>
          </template>
        </el-table-column> -->
        <el-table-column label="状态" align="center" prop="status">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === '1' ? 'success' : 'danger'">
              <dict-tag :options="dict.type.category_status" :value="scope.row.status"/>
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" show-overflow-tooltip />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['category:category:edit']"
              class="edit-link"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleDelete(scope.row)"
              v-hasPermi="['category:category:remove']"
              class="delete-link"
            >删除</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleView(scope.row)"
              v-hasPermi="['category:category:query']"
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

    <!-- 添加或修改鲜花分类对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="分类名称" prop="categoryName">
              <el-input v-model="form.categoryName" placeholder="请输入分类名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="分类描述" prop="categoryDesc">
              <el-input 
                v-model="form.categoryDesc" 
                type="textarea" 
                :rows="3" 
                placeholder="请输入分类描述" 
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="排序" prop="sortOrder">
              <el-input-number 
                v-model="form.sortOrder" 
                controls-position="right" 
                :min="0" 
                :max="999" 
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option
                  v-for="dict in dict.type.category_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
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

    <!-- 分类详情对话框 -->
    <el-dialog title="分类详情" :visible.sync="openView" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="分类名称">{{ viewForm.categoryName }}</el-descriptions-item>
        <el-descriptions-item label="分类描述">{{ viewForm.categoryDesc }}</el-descriptions-item>
        <el-descriptions-item label="排序">{{ viewForm.sortOrder }}</el-descriptions-item>
        <el-descriptions-item label="状态">
          <dict-tag :options="dict.type.category_status" :value="viewForm.status"/>
        </el-descriptions-item>
        <el-descriptions-item label="创建人">{{ viewForm.createBy }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ viewForm.createTime }}</el-descriptions-item>
        <el-descriptions-item label="更新人">{{ viewForm.updateBy }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ viewForm.updateTime }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ viewForm.remark }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="openView = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCategory, getCategory, delCategory, addCategory, updateCategory } from "@/api/category/category"

export default {
  name: "Category",
  dicts: ['category_status'],
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
      // 鲜花分类表格数据
      categoryList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示详情弹出层
      openView: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        categoryName: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 详情表单参数
      viewForm: {},
      // 表单校验
      rules: {
        categoryName: [
          { required: true, message: "分类名称不能为空", trigger: "blur" }
        ],
        categoryDesc: [
          { required: true, message: "分类描述不能为空", trigger: "blur" }
        ],
        sortOrder: [
          { required: true, message: "排序不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态不能为空", trigger: "change" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询鲜花分类列表 */
    getList() {
      this.loading = true
      listCategory(this.queryParams).then(response => {
        this.categoryList = response.rows
        this.total = response.total
        this.loading = false
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
        categoryName: null,
        categoryDesc: null,
        sortOrder: null,
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
      this.title = "添加鲜花分类"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getCategory(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改鲜花分类"
      })
    },
    /** 详情按钮操作 */
    handleView(row) {
      this.reset()
      const id = row.id || this.ids
      getCategory(id).then(response => {
        this.viewForm = response.data
        this.openView = true
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateCategory(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCategory(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除鲜花分类编号为"' + ids + '"的数据项？').then(function() {
        return delCategory(ids)
      }).then((response) => {
        // 检查响应状态
        if (response.code === 200) {
          this.getList()
          this.$modal.msgSuccess("删除成功")
        } else {
          this.$modal.msgError(response.msg)
        }
      }).catch((error) => {
        // 处理错误响应
        if (error && error.msg) {
          this.$modal.msgError(error.msg)
        } else {
          this.$modal.msgError("删除失败")
        }
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('category/category/export', {
        ...this.queryParams
      }, `category_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.category-container {
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

.category-name {
  font-weight: 600;
  color: #409EFF;
}

.category-desc {
  color: #606266;
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

.edit-link:hover, .delete-link:hover, .view-link:hover {
  opacity: 0.8;
  font-weight: 600;
}

/* 分页组件美化 */
::v-deep .el-pagination {
  margin-top: 20px;
  padding: 15px 20px;
  background-color: #fff;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}
</style>