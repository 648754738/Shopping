<template>
  <div class="app-container reservation-container">
    <el-card class="search-card">
      <div slot="header" class="clearfix">
        <span>预定筛选</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="toggleSearch">
          {{ showSearch ? '收起' : '展开' }}筛选
        </el-button>
      </div>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
        <el-form-item label="预定编号" prop="reservationNo">
          <el-input
            v-model="queryParams.reservationNo"
            placeholder="请输入预定编号"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="客户" prop="customerId">
          <el-select v-model="queryParams.customerId" placeholder="请选择客户" clearable filterable>
            <el-option
              v-for="customer in customerList"
              :key="customer.id"
              :label="customer.customerName"
              :value="customer.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="鲜花" prop="flowerId">
          <el-select v-model="queryParams.flowerId" placeholder="请选择鲜花" clearable filterable>
            <el-option
              v-for="flower in flowerList"
              :key="flower.id"
              :label="flower.flowerName"
              :value="flower.id">
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
        <span>预定列表</span>
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
            v-hasPermi="['reservation:reservation:add']"
            class="toolbar-btn add-btn"
          >新增</el-button>
          <el-button
            plain
            type="success"
            icon="el-icon-edit"
            size="small"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['reservation:reservation:edit']"
            class="toolbar-btn update-btn"
          >修改</el-button>
          <el-button
            plain
            type="danger"
            icon="el-icon-delete"
            size="small"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['reservation:reservation:remove']"
            class="toolbar-btn delete-btn"
          >删除</el-button>
          <el-button
            plain
            type="warning"
            icon="el-icon-download"
            size="small"
            @click="handleExport"
            v-hasPermi="['reservation:reservation:export']"
            class="toolbar-btn export-btn"
          >导出</el-button>
        </div>
        <div class="toolbar-right">
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </div>
      </div>

      <el-table 
        v-loading="loading" 
        :data="reservationList" 
        @selection-change="handleSelectionChange"
        border
        highlight-current-row
        style="width: 100%"
        :header-cell-style="{background:'#f5f7fa', color:'#606266'}"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="预定编号" align="center" prop="reservationNo" />
        <el-table-column label="客户" align="center" prop="customerId">
          <template slot-scope="scope">
            <span>{{ getCustomerName(scope.row.customerId) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="鲜花" align="center" prop="flowerId">
          <template slot-scope="scope">
            <span>{{ getFlowerName(scope.row.flowerId) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="预定数量" align="center" prop="quantity" />
        <el-table-column label="单价" align="center" prop="unitPrice" />
        <el-table-column label="总金额" align="center" prop="totalAmount" />
        <el-table-column label="预定日期" align="center" prop="reservationDate" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.reservationDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="配送时间" align="center" prop="deliveryTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.deliveryTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="预定状态" align="center" prop="reservationStatus">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.reservationStatus === 1" type="info">待确认</el-tag>
            <el-tag v-else-if="scope.row.reservationStatus === 2" type="primary">已确认</el-tag>
            <el-tag v-else-if="scope.row.reservationStatus === 3" type="success">已完成</el-tag>
            <el-tag v-else-if="scope.row.reservationStatus === 4" type="danger">已取消</el-tag>
            <el-tag v-else>未知</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="联系人" align="center" prop="contactPerson" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              @click="handleView(scope.row)"
              class="view-link"
            >详情</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['reservation:reservation:edit']"
              class="edit-link"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              @click="handleDelete(scope.row)"
              v-hasPermi="['reservation:reservation:remove']"
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

    <!-- 添加或修改预定管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="预定编号" prop="reservationNo">
              <el-input v-model="form.reservationNo" placeholder="请输入预定编号" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户" prop="customerId">
              <el-select v-model="form.customerId" placeholder="请选择客户" style="width: 100%" filterable @change="handleCustomerChange">
                <el-option
                  v-for="customer in customerList"
                  :key="customer.id"
                  :label="customer.customerName"
                  :value="customer.id">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="鲜花" prop="flowerId">
              <el-select v-model="form.flowerId" placeholder="请选择鲜花" style="width: 100%" filterable @change="handleFlowerChange">
                <el-option
                  v-for="flower in flowerList"
                  :key="flower.id"
                  :label="flower.flowerName"
                  :value="flower.id">
                  <span style="float: left">{{ flower.flowerName }}</span>
                  <span style="float: right; color: #8492a6; font-size: 13px" v-if="getFlowerInventory(flower.id)">
                    库存: {{ getFlowerInventory(flower.id).availableQuantity }}
                    <i v-if="getFlowerInventory(flower.id).needWarning" class="el-icon-warning" style="color: #E6A23C;"></i>
                  </span>
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="预定数量" prop="quantity">
              <el-input-number v-model="form.quantity" controls-position="right" :min="1" :max="getMaxQuantity()" style="width: 100%" @change="calculateTotalAmount" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="单价" prop="unitPrice">
              <el-input-number v-model="form.unitPrice" controls-position="right" :min="0" :precision="2" :step="0.01" style="width: 100%" @change="calculateTotalAmount" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总金额" prop="totalAmount">
              <el-input-number v-model="form.totalAmount" controls-position="right" :min="0" :precision="2" :step="0.01" style="width: 100%" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="预定日期" prop="reservationDate">
              <el-date-picker clearable
                              v-model="form.reservationDate"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择预定日期"
                              :picker-options="reservationDateOptions"
                              style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="配送时间" prop="deliveryTime">
              <el-date-picker clearable
                              v-model="form.deliveryTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择配送时间"
                              :picker-options="deliveryTimeOptions"
                              style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系人" prop="contactPerson">
              <el-input v-model="form.contactPerson" placeholder="请输入联系人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="配送地址" prop="deliveryAddress">
              <el-input v-model="form.deliveryAddress" placeholder="请输入配送地址" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 预定详情对话框 -->
    <el-dialog title="预定详情" :visible.sync="openView" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="预定编号">{{ viewForm.reservationNo }}</el-descriptions-item>
        <el-descriptions-item label="客户">{{ getCustomerName(viewForm.customerId) }}</el-descriptions-item>
        <el-descriptions-item label="鲜花">{{ getFlowerName(viewForm.flowerId) }}</el-descriptions-item>
        <el-descriptions-item label="预定数量">{{ viewForm.quantity }}</el-descriptions-item>
        <el-descriptions-item label="单价">{{ viewForm.unitPrice }}</el-descriptions-item>
        <el-descriptions-item label="总金额">{{ viewForm.totalAmount }}</el-descriptions-item>
        <el-descriptions-item label="预定日期">{{ parseTime(viewForm.reservationDate, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="配送时间">{{ parseTime(viewForm.deliveryTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="预定状态">
          <el-tag v-if="viewForm.reservationStatus === 1" type="info">待确认</el-tag>
          <el-tag v-else-if="viewForm.reservationStatus === 2" type="primary">已确认</el-tag>
          <el-tag v-else-if="viewForm.reservationStatus === 3" type="success">已完成</el-tag>
          <el-tag v-else-if="viewForm.reservationStatus === 4" type="danger">已取消</el-tag>
          <el-tag v-else>未知</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="联系人">{{ viewForm.contactPerson }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ viewForm.contactPhone }}</el-descriptions-item>
        <el-descriptions-item label="配送地址" :span="2">{{ viewForm.deliveryAddress }}</el-descriptions-item>
        <el-descriptions-item label="创建人">{{ viewForm.createBy }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(viewForm.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</el-descriptions-item>
        <el-descriptions-item label="更新人">{{ viewForm.updateBy }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ parseTime(viewForm.updateTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ viewForm.remark }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button 
          v-if="viewForm.reservationStatus === 2" 
          type="success" 
          @click="handlePaymentSuccess(viewForm)"
          v-hasPermi="['reservation:reservation:edit']"
        >支付成功</el-button>
        <el-button @click="openView = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listReservation, getReservation, delReservation, addReservation, updateReservation, getReservationInitData, handleReservationPaymentSuccess } from "@/api/reservation/reservation"
import { listInventory } from "@/api/inventory/inventory"
import { getCustomer } from "@/api/customer/customer"

export default {
  name: "Reservation",
  dicts: ['flower_reservation_status'],
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
      // 预定管理表格数据
      reservationList: [],
      // 客户列表
      customerList: [],
      // 鲜花列表
      flowerList: [],
      // 库存列表
      inventoryList: [],
      // 预定状态选项
      reservationStatusOptions: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示详情弹出层
      openView: false,
      // 预定日期选择器选项
      reservationDateOptions: {
        disabledDate(time) {
          // 禁用今天之前的日期
          return time.getTime() < Date.now() - 8.64e7; // 8.64e7 = 24*60*60*1000
        }
      },
      // 配送时间选择器选项
      deliveryTimeOptions: {
        disabledDate(time) {
          // 禁用今天之前的日期
          return time.getTime() < Date.now() - 8.64e7; // 8.64e7 = 24*60*60*1000
        }
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        reservationNo: null,
        customerId: null,
        flowerId: null,
      },
      // 表单参数
      form: {},
      // 详情表单参数
      viewForm: {},
      // 表单校验
      rules: {
        reservationNo: [
          { required: true, message: "预定编号不能为空", trigger: "blur" }
        ],
        customerId: [
          { required: true, message: "客户不能为空", trigger: "change" }
        ],
        flowerId: [
          { required: true, message: "鲜花不能为空", trigger: "change" }
        ],
        quantity: [
          { required: true, message: "预定数量不能为空", trigger: "blur" }
        ],
        unitPrice: [
          { required: true, message: "单价不能为空", trigger: "blur" }
        ],
        totalAmount: [
          { required: true, message: "总金额不能为空", trigger: "blur" }
        ],
        reservationDate: [
          { required: true, message: "预定日期不能为空", trigger: "blur" }
        ],
        deliveryTime: [
          { required: true, message: "配送时间不能为空", trigger: "blur" }
        ],
        contactPerson: [
          { required: true, message: "联系人不能为空", trigger: "blur" }
        ],
        contactPhone: [
          { required: true, message: "联系电话不能为空", trigger: "blur" }
        ],
        deliveryAddress: [
          { required: true, message: "配送地址不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
    this.getInitData()
    this.getInventoryList()
  },
  methods: {
    /** 查询预定管理列表 */
    getList() {
      this.loading = true
      listReservation(this.queryParams).then(response => {
        this.reservationList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 获取初始化数据 */
    getInitData() {
      getReservationInitData().then(response => {
        this.customerList = response.data.customerList
        this.flowerList = response.data.flowerList
        this.reservationStatusOptions = response.data.reservationStatusOptions
      })
    },
    /** 获取库存列表 */
    getInventoryList() {
      listInventory({}).then(response => {
        this.inventoryList = response.rows
      })
    },
    /** 获取客户名称 */
    getCustomerName(customerId) {
      const customer = this.customerList.find(item => item.id === customerId)
      return customer ? customer.customerName : ''
    },
    /** 获取鲜花名称 */
    getFlowerName(flowerId) {
      const flower = this.flowerList.find(item => item.id === flowerId)
      return flower ? flower.flowerName : ''
    },
    /** 获取鲜花库存 */
    getFlowerInventory(flowerId) {
      return this.inventoryList.find(item => item.flowerId === flowerId)
    },
    /** 获取最大可预定数量 */
    getMaxQuantity() {
      if (this.form.flowerId) {
        const inventory = this.getFlowerInventory(this.form.flowerId)
        return inventory ? inventory.availableQuantity : 9999
      }
      return 9999
    },
    /** 处理客户选择变化 */
    handleCustomerChange(value) {
      // 当客户发生变化时，自动填充联系人、联系电话和地址
      if (value) {
        // 查找选中的客户信息
        const customer = this.customerList.find(item => item.id === value)
        if (customer) {
          // 自动填充联系人、联系电话和地址
          this.form.contactPerson = customer.customerName
          this.form.contactPhone = customer.phone
          this.form.deliveryAddress = customer.address
        }
      }
      
      // 当客户发生变化时，重新计算价格
      this.calculatePrice()
    },
    /** 处理鲜花选择变化 */
    handleFlowerChange(value) {
      // 当鲜花发生变化时，自动填充单价并重新计算总金额
      if (value) {
        const flower = this.flowerList.find(item => item.id === value)
        if (flower && flower.price) {
          this.form.unitPrice = flower.price
        }
      }
      // 当客户和鲜花都选择时，重新计算价格
      this.calculatePrice()
      
      // 可以在这里添加库存预警检查
      const inventory = this.getFlowerInventory(value)
      if (inventory && inventory.needWarning) {
        this.$modal.msgWarning(`库存预警：${this.getFlowerName(value)}库存不足，请及时补货！`)
      }
    },
    /** 计算价格（根据客户等级和鲜花价格自动计算） */
    calculatePrice() {
      if (this.form.flowerId && this.form.customerId) {
        // 获取鲜花信息
        const flower = this.flowerList.find(item => item.id === this.form.flowerId)
        if (flower && flower.price) {
          // 获取客户信息
          const customer = this.customerList.find(item => item.id === this.form.customerId)
          if (customer) {
            // 根据客户等级计算折扣率（与后端保持一致）
            let discountRate = 1.0 // 默认无折扣
            switch (customer.level) {
              case 2: // 银卡
                discountRate = 0.95 // 95折
                break
              case 3: // 金卡
                discountRate = 0.90 // 9折
                break
              case 4: // 钻石
                discountRate = 0.85 // 85折
                break
              default: // 普通客户
                discountRate = 1.0 // 无折扣
                break
            }
            
            // 计算折扣后的单价
            this.form.unitPrice = (flower.price * discountRate).toFixed(2)
          } else {
            // 如果没有找到客户信息，使用原价
            this.form.unitPrice = flower.price
          }
        }
      }
      // 重新计算总金额
      this.calculateTotalAmount()
    },
    /** 计算总金额 */
    calculateTotalAmount() {
      if (this.form.quantity && this.form.unitPrice) {
        this.form.totalAmount = (this.form.quantity * this.form.unitPrice).toFixed(2)
      } else {
        this.form.totalAmount = 0
      }
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
        reservationNo: null,
        customerId: null,
        flowerId: null,
        quantity: null,
        unitPrice: null,
        totalAmount: null,
        reservationDate: null,
        deliveryTime: null,
        reservationStatus: 1, // 默认待确认
        contactPerson: null,
        contactPhone: null,
        deliveryAddress: null,
        qrCodeUrl: null,
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
      // 生成预定编号
      this.form.reservationNo = 'YD' + new Date().getTime()
      this.open = true
      this.title = "添加预定"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getReservation(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改预定"
      })
    },
    /** 详情按钮操作 */
    handleView(row) {
      this.reset()
      const id = row.id || this.ids
      getReservation(id).then(response => {
        this.viewForm = response.data
        this.openView = true
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 检查库存
          const inventory = this.getFlowerInventory(this.form.flowerId)
          if (inventory && this.form.quantity > inventory.availableQuantity) {
            this.$modal.msgError(`库存不足：${this.getFlowerName(this.form.flowerId)}库存只有${inventory.availableQuantity}件，无法预定${this.form.quantity}件`)
            return
          }
          
          if (this.form.id != null) {
            updateReservation(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addReservation(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除预定编号为"' + ids + '"的数据项？').then(function() {
        return delReservation(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('reservation/reservation/export', {
        ...this.queryParams
      }, `reservation_${new Date().getTime()}.xlsx`)
    },
    
    /** 处理预定支付成功 */
    handlePaymentSuccess(row) {
      const id = row.id || this.ids
      this.$modal.confirm('是否确认处理预定支付成功？').then(function() {
        return handleReservationPaymentSuccess(id)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("处理预定支付成功")
      }).catch(() => {})
    }

  }
}
</script>

<style scoped>
.reservation-container {
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
</style>