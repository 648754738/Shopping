<template>
  <div class="app-container customer-container">
    <el-card class="search-card">
      <div slot="header" class="clearfix">
        <span>客户筛选</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleSearch">
          {{ showSearch ? '收起' : '展开' }}筛选
        </el-button>
      </div>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
        <el-form-item label="客户姓名" prop="customerName">
          <el-input
            v-model="queryParams.customerName"
            placeholder="请输入客户姓名"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-select v-model="queryParams.gender" placeholder="请选择性别" clearable>
            <el-option
              v-for="dict in dict.type.sys_user_sex"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="客户等级" prop="level">
          <el-select v-model="queryParams.level" placeholder="请选择客户等级" clearable>
            <el-option
              v-for="dict in dict.type.customer_level"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option
              v-for="dict in dict.type.customer_status"
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
        <span>客户列表</span>
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
            v-hasPermi="['customer:customer:add']"
            class="toolbar-btn add-btn"
          >新增</el-button>
          <el-button
            plain
            type="success"
            icon="el-icon-edit"
            size="small"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['customer:customer:edit']"
            class="toolbar-btn update-btn"
          >修改</el-button>
          <el-button
            plain
            type="danger"
            icon="el-icon-delete"
            size="small"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['customer:customer:remove']"
            class="toolbar-btn delete-btn"
          >删除</el-button>
          <el-button
            plain
            type="warning"
            icon="el-icon-download"
            size="small"
            @click="handleExport"
            v-hasPermi="['customer:customer:export']"
            class="toolbar-btn export-btn"
          >导出</el-button>
        </div>
        <div class="toolbar-right">
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </div>
      </div>

      <el-table 
        v-loading="loading" 
        :data="customerList" 
        @selection-change="handleSelectionChange"
        border
        highlight-current-row
        style="width: 100%"
        :header-cell-style="{background:'#f5f7fa', color:'#606266'}"
      >
        <el-table-column type="selection" width="55" align="center" />
        <!-- 隐藏ID列 -->
        <!-- <el-table-column label="客户ID" align="center" prop="id" /> -->
        <el-table-column label="客户姓名" align="center" prop="customerName">
          <template slot-scope="scope">
            <span class="customer-name">{{ scope.row.customerName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="性别" align="center" prop="gender">
          <template slot-scope="scope">
            <dict-tag :options="dict.type.sys_user_sex" :value="scope.row.gender"/>
          </template>
        </el-table-column>
        <el-table-column label="联系电话" align="center" prop="phone" />
        <el-table-column label="邮箱" align="center" prop="email" />
        <el-table-column label="生日" align="center" prop="birthday">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.birthday, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="客户等级" align="center" prop="level">
          <template slot-scope="scope">
            <el-tag :type="getLevelTagType(scope.row.level)">
              <dict-tag :options="dict.type.customer_level" :value="scope.row.level"/>
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              @click="handleView(scope.row)"
              v-hasPermi="['customer:customer:query']"
              class="view-link"
            >详情</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['customer:customer:edit']"
              class="edit-link"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleDelete(scope.row)"
              v-hasPermi="['customer:customer:remove']"
              class="delete-link"
            >删除</el-button>
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

    <!-- 添加或修改客户信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="客户姓名" prop="customerName">
              <el-input v-model="form.customerName" placeholder="请输入客户姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-select v-model="form.gender" placeholder="请选择性别" style="width: 100%">
                <el-option
                  v-for="dict in dict.type.sys_user_sex"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="生日" prop="birthday">
              <el-date-picker clearable
                              v-model="form.birthday"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择生日"
                              style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户等级" prop="level">
              <el-select v-model="form.level" placeholder="请选择客户等级" style="width: 100%">
                <el-option
                  v-for="dict in dict.type.customer_level"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="积分" prop="points">
              <el-input-number 
                v-model="form.points" 
                controls-position="right" 
                :min="0" 
                :max="99999" 
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option
                  v-for="dict in dict.type.customer_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="客户偏好" prop="preference">
              <el-checkbox-group v-model="form.selectedPreferences">
                <el-checkbox v-for="option in preferenceOptions" :key="option.value" :label="option.label">
                  {{ option.label }}
                </el-checkbox>
              </el-checkbox-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="地址" prop="address">
              <el-input v-model="form.address" placeholder="请输入地址" />
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

    <!-- 客户详情对话框 -->
    <el-dialog title="客户详情" :visible.sync="openView" width="900px" append-to-body>
      <el-tabs v-model="activeTab" type="card">
        <el-tab-pane label="基本信息" name="basic">
          <el-descriptions :column="2" border>
            <el-descriptions-item label="客户姓名">{{ viewForm.customerName }}</el-descriptions-item>
            <el-descriptions-item label="联系电话">{{ viewForm.phone }}</el-descriptions-item>
            <el-descriptions-item label="邮箱">{{ viewForm.email }}</el-descriptions-item>
            <el-descriptions-item label="地址" :span="2">{{ viewForm.address }}</el-descriptions-item>
            <el-descriptions-item label="生日">{{ parseTime(viewForm.birthday, '{y}-{m}-{d}') }}</el-descriptions-item>
            <el-descriptions-item label="性别">
              <dict-tag :options="dict.type.sys_user_sex" :value="viewForm.gender"/>
            </el-descriptions-item>
            <el-descriptions-item label="客户等级">
              <dict-tag :options="dict.type.customer_level" :value="viewForm.level"/>
            </el-descriptions-item>
            <el-descriptions-item label="积分">{{ viewForm.points }}</el-descriptions-item>
            <el-descriptions-item label="状态">
              <dict-tag :options="dict.type.customer_status" :value="viewForm.status"/>
            </el-descriptions-item>
            <el-descriptions-item label="客户偏好" :span="2">
              <div v-if="viewForm.preference">
                <el-tag v-for="pref in parsePreferences(viewForm.preference)" :key="pref" type="success" style="margin-right: 5px;">{{ pref }}</el-tag>
              </div>
              <div v-else>无</div>
            </el-descriptions-item>
            <el-descriptions-item label="创建人">{{ viewForm.createBy }}</el-descriptions-item>
            <el-descriptions-item label="创建时间">{{ viewForm.createTime }}</el-descriptions-item>
            <el-descriptions-item label="更新人">{{ viewForm.updateBy }}</el-descriptions-item>
            <el-descriptions-item label="更新时间">{{ viewForm.updateTime }}</el-descriptions-item>
            <el-descriptions-item label="备注" :span="2">{{ viewForm.remark }}</el-descriptions-item>
          </el-descriptions>
        </el-tab-pane>
        
        <el-tab-pane label="推荐记录" name="recommendations">
          <el-table 
            :data="recommendationList" 
            border 
            style="width: 100%"
            v-loading="recommendationLoading"
          >
            <el-table-column label="推荐鲜花" align="center" prop="flowerId">
              <template slot-scope="scope">
                <span v-if="scope.row.flower">{{ scope.row.flower.flowerName }}</span>
                <span v-else>未知鲜花</span>
              </template>
            </el-table-column>
            <el-table-column label="推荐类型" align="center" prop="recommendType">
              <template slot-scope="scope">
                <el-tag v-if="scope.row.recommendType === 1">购买推荐</el-tag>
                <el-tag v-else-if="scope.row.recommendType === 2" type="success">偏好推荐</el-tag>
                <el-tag v-else-if="scope.row.recommendType === 3" type="warning">热销推荐</el-tag>
                <el-tag v-else>其他推荐</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="推荐理由" align="center" prop="recommendReason" :show-overflow-tooltip="true" />
            <el-table-column label="是否接受" align="center" prop="isAccepted">
              <template slot-scope="scope">
                <el-tag v-if="scope.row.isAccepted === 1" type="success">已接受</el-tag>
                <el-tag v-else type="info">未接受</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="接受时间" align="center" prop="acceptanceTime">
              <template slot-scope="scope">
                <span>{{ parseTime(scope.row.acceptanceTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
              </template>
            </el-table-column>
            <el-table-column label="创建时间" align="center" prop="createTime">
              <template slot-scope="scope">
                <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
              </template>
            </el-table-column>
            <el-table-column label="备注" align="center" prop="remark" :show-overflow-tooltip="true" />
          </el-table>
          
          <pagination
            v-show="recommendationTotal>0"
            :total="recommendationTotal"
            :page.sync="recommendationQueryParams.pageNum"
            :limit.sync="recommendationQueryParams.pageSize"
            @pagination="getRecommendations"
          />
        </el-tab-pane>
      </el-tabs>
      
      <div slot="footer" class="dialog-footer">
        <el-button @click="openView = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCustomer, getCustomer, delCustomer, addCustomer, updateCustomer, exportCustomer, getCustomerRecommendations } from "@/api/customer/customer"

export default {
  name: "Customer",
  dicts: ['sys_user_sex', 'customer_level', 'customer_status'],
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
      // 客户信息表格数据
      customerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示详情弹出层
      openView: false,
      // 活动的Tab页
      activeTab: "basic",
      // 客户偏好选项
      preferenceOptions: [
        { label: '鲜花', value: 'flowers' },
        { label: '绿植', value: 'plants' },
        { label: '花束', value: 'bouquets' },
        { label: '花篮', value: 'baskets' },
        { label: '开业花篮', value: 'opening_baskets' },
        { label: '婚庆花艺', value: 'wedding_flowers' },
        { label: '商务会议', value: 'business_meetings' },
        { label: '节日礼品', value: 'holiday_gifts' }
      ],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        customerName: null,
        gender: null,
        level: null,
        status: null,
      },
      // 表单参数
      form: {
        id: null,
        customerName: null,
        phone: null,
        email: null,
        address: null,
        birthday: null,
        gender: null,
        preference: null,
        selectedPreferences: [], // 确保初始化为空数组
        level: null,
        points: null,
        status: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      },
      // 详情表单参数
      viewForm: {},
      // 推荐记录数据
      recommendationList: [],
      recommendationTotal: 0,
      recommendationLoading: false,
      recommendationQueryParams: {
        pageNum: 1,
        pageSize: 5,
        customerId: null
      },
      // 表单校验
      rules: {
        customerName: [
          { required: true, message: "客户姓名不能为空", trigger: "blur" }
        ],
        phone: [
          { required: true, message: "联系电话不能为空", trigger: "blur" }
        ],
        email: [
          { required: true, message: "邮箱不能为空", trigger: "blur" }
        ],
        address: [
          { required: true, message: "地址不能为空", trigger: "blur" }
        ],
        birthday: [
          { required: true, message: "生日不能为空", trigger: "blur" }
        ],
        gender: [
          { required: true, message: "性别不能为空", trigger: "change" }
        ],
        level: [
          { required: true, message: "客户等级不能为空", trigger: "change" }
        ],
        points: [
          { required: true, message: "积分不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态不能为空", trigger: "change" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询客户信息列表 */
    getList() {
      this.loading = true
      listCustomer(this.queryParams).then(response => {
        this.customerList = response.rows
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
        customerName: null,
        phone: null,
        email: null,
        address: null,
        birthday: null,
        gender: null,
        preference: null,
        selectedPreferences: [], // 确保初始化为空数组
        level: null,
        points: null,
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
    /** 获取客户等级标签类型 */
    getLevelTagType(level) {
      const levelMap = {
        1: 'info',
        2: '',
        3: 'warning',
        4: 'danger'
      }
      return levelMap[level] || ''
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加客户信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getCustomer(id).then(response => {
        const data = response.data
        // 将存储的偏好字符串转换为数组
        let selectedPreferences = []
        if (data.preference) {
          try {
            // 如果是JSON数组字符串
            if (data.preference.startsWith('[') && data.preference.endsWith(']')) {
              selectedPreferences = JSON.parse(data.preference);
            } 
            // 如果是JSON对象字符串
            else if (data.preference.startsWith('{') && data.preference.endsWith('}')) {
              const obj = JSON.parse(data.preference);
              selectedPreferences = Object.keys(obj);
            } 
            // 如果是逗号分隔的字符串
            else if (data.preference.includes(',')) {
              selectedPreferences = data.preference.split(',').map(item => item.trim()).filter(item => item);
            } 
            // 如果是单个值
            else {
              selectedPreferences = [data.preference];
            }
          } catch (e) {
            console.error('解析客户偏好数据失败:', e);
            // 解析失败时，尝试按逗号分割
            selectedPreferences = data.preference.split(',').map(item => item.trim()).filter(item => item);
          }
        }
        
        // 确保selectedPreferences是数组类型，并且元素都是字符串类型
        if (!Array.isArray(selectedPreferences)) {
          selectedPreferences = [];
        } else {
          // 确保所有元素都是字符串类型
          selectedPreferences = selectedPreferences.map(item => String(item));
        }
        
        // 创建英文到中文的映射
        const englishToChineseMap = {
          'flowers': '鲜花',
          'plants': '绿植',
          'bouquets': '花束',
          'baskets': '花篮',
          'opening_baskets': '开业花篮',
          'wedding_flowers': '婚庆花艺',
          'business_meetings': '商务会议',
          'holiday_gifts': '节日礼品'
        };
        
        // 将英文偏好转换为中文偏好用于显示
        const displayPreferences = selectedPreferences.map(pref => {
          // 如果已经是中文则直接返回，否则转换为中文
          if (Object.values(englishToChineseMap).includes(pref)) {
            return pref;
          }
          return englishToChineseMap[pref] || pref;
        });
        
        // 重新创建form对象以确保响应式更新
        this.form = {
          id: data.id,
          customerName: data.customerName,
          phone: data.phone,
          email: data.email,
          address: data.address,
          birthday: data.birthday,
          gender: data.gender,
          preference: data.preference,
          selectedPreferences: displayPreferences, // 使用中文标签显示
          level: data.level,
          points: data.points,
          status: data.status,
          createBy: data.createBy,
          createTime: data.createTime,
          updateBy: data.updateBy,
          updateTime: data.updateTime,
          remark: data.remark
        }
        
        this.open = true
        this.title = "修改客户信息"
      })
    },
    /** 详情按钮操作 */
    handleView(row) {
      this.reset()
      const id = row.id || this.ids
      getCustomer(id).then(response => {
        this.viewForm = response.data
        this.openView = true
        this.activeTab = "basic"
        // 初始化推荐记录查询参数
        this.recommendationQueryParams.customerId = id
        this.recommendationQueryParams.pageNum = 1
        // 获取推荐记录
        this.getRecommendations()
      })
    },
    /** 获取客户推荐记录 */
    getRecommendations() {
      if (!this.recommendationQueryParams.customerId) {
        return
      }
      this.recommendationLoading = true
      getCustomerRecommendations(this.recommendationQueryParams.customerId).then(response => {
        this.recommendationList = response.rows
        this.recommendationTotal = response.total
        this.recommendationLoading = false
      }).catch(() => {
        this.recommendationLoading = false
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 创建中文到英文的映射
          const chineseToEnglishMap = {
            '鲜花': 'flowers',
            '绿植': 'plants',
            '花束': 'bouquets',
            '花篮': 'baskets',
            '开业花篮': 'opening_baskets',
            '婚庆花艺': 'wedding_flowers',
            '商务会议': 'business_meetings',
            '节日礼品': 'holiday_gifts'
          };
          
          // 将选中的中文偏好转换为英文标识符并存储为JSON字符串
          if (this.form.selectedPreferences && this.form.selectedPreferences.length > 0) {
            // 将中文标签转换为英文标识符
            const englishPreferences = this.form.selectedPreferences.map(pref => {
              return chineseToEnglishMap[pref] || pref;
            });
            
            this.form.preference = JSON.stringify(englishPreferences);
          } else {
            this.form.preference = null;
          }
          
          if (this.form.id != null) {
            updateCustomer(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCustomer(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除客户信息编号为"' + ids + '"的数据项？').then(function() {
        return delCustomer(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('customer/customer/export', {
        ...this.queryParams
      }, `customer_${new Date().getTime()}.xlsx`)
    },
    /** 解析客户偏好 */
    parsePreferences(preference) {
      try {
        let preferences = [];
        // 如果是JSON字符串，尝试解析
        if (preference && preference.startsWith('[') && preference.endsWith(']')) {
          preferences = JSON.parse(preference);
        } else if (preference && preference.startsWith('{') && preference.endsWith('}')) {
          const obj = JSON.parse(preference);
          preferences = Object.keys(obj);
        } else if (preference) {
          // 如果是逗号分隔的字符串
          preferences = preference.split(',').map(item => item.trim()).filter(item => item);
        }
        
        // 创建英文到中文的映射
        const englishToChineseMap = {
          'flowers': '鲜花',
          'plants': '绿植',
          'bouquets': '花束',
          'baskets': '花篮',
          'opening_baskets': '开业花篮',
          'wedding_flowers': '婚庆花艺',
          'business_meetings': '商务会议',
          'holiday_gifts': '节日礼品'
        };
        
        // 将英文偏好转换为中文标签
        return preferences.map(pref => {
          // 如果已经是中文则直接返回，否则转换为中文
          if (Object.values(englishToChineseMap).includes(pref)) {
            return pref;
          }
          return englishToChineseMap[pref] || pref;
        });
      } catch (e) {
        // 如果解析失败，直接返回原始值
        return preference ? [preference] : [];
      }
    }
  }
}
</script>

<style scoped>
.customer-container {
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
  padding: 15px 0;
  background-color: #fff;
  border-bottom: 1px solid #ebeef5;
}

.toolbar-left {
  display: flex;
  gap: 10px;
}

.toolbar-btn {
  padding: 8px 16px;
  border-radius: 4px;
  font-weight: 500;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
}

.toolbar-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.toolbar-btn:active {
  transform: translateY(0);
}

.add-btn {
  background-color: #409EFF;
  border-color: #409EFF;
  color: white;
}

.add-btn:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.update-btn {
  background-color: #67C23A;
  border-color: #67C23A;
  color: white;
}

.update-btn:hover {
  background-color: #85ce61;
  border-color: #85ce61;
}

.delete-btn {
  background-color: #F56C6C;
  border-color: #F56C6C;
  color: white;
}

.delete-btn:hover {
  background-color: #f78989;
  border-color: #f78989;
}

.export-btn {
  background-color: #E6A23C;
  border-color: #E6A23C;
  color: white;
}

.export-btn:hover {
  background-color: #ebb563;
  border-color: #ebb563;
}

/* 操作按钮样式 */
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

/* Tab页样式 */
::v-deep .el-tabs__item {
  font-weight: 500;
}

::v-deep .el-tabs__item.is-active {
  font-weight: 600;
  color: #409EFF !important;
}
</style>
```
