<template>
  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>订单详情</span>
        <el-button style="float: right; margin-left: 10px;" type="primary" @click="handleBack">返回</el-button>
        <el-button 
          v-if="orderInfo.orderStatus === 1" 
          style="float: right; margin-left: 10px;" 
          type="success" 
          @click="handlePaymentSuccess"
        >
          支付成功
        </el-button>
        <el-button 
          v-if="orderInfo.orderStatus === 4" 
          style="float: right; margin-left: 10px;" 
          type="success" 
          @click="handleOrderCompletion"
        >
          订单完成
        </el-button>
        <el-button 
          v-if="canUpdateStatus" 
          style="float: right;" 
          type="success" 
          @click="handleUpdateStatus"
        >
          更新状态
        </el-button>
      </div>
      
      <!-- 订单状态流程 -->
      <el-steps :active="currentStep" finish-status="success" simple>
        <el-step title="待付款" icon="el-icon-shopping-cart-full"></el-step>
        <el-step title="已付款" icon="el-icon-bank-card"></el-step>
        <el-step title="已发货" icon="el-icon-truck"></el-step>
        <el-step title="已完成" icon="el-icon-circle-check"></el-step>
        <el-step title="已取消" icon="el-icon-circle-close"></el-step>
      </el-steps>
      
      <el-divider></el-divider>
      
      <!-- 订单基本信息 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-descriptions title="订单信息" :column="1" border>
            <el-descriptions-item label="订单编号">{{ orderInfo.orderNo }}</el-descriptions-item>
            <el-descriptions-item label="订单类型">
              <el-tag v-if="orderInfo.orderType === 1">普通订单</el-tag>
              <el-tag v-else>预定订单</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="订单状态">
              <el-tag :type="getStatusType(orderInfo.orderStatus)">
                {{ getOrderStatusText(orderInfo.orderStatus) }}
              </el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="支付方式">
              <dict-tag :options="dict.type.order_pay_method" :value="orderInfo.paymentMethod"/>
            </el-descriptions-item>
            <el-descriptions-item label="订单金额">¥{{ orderInfo.orderAmount }}</el-descriptions-item>
            <el-descriptions-item label="优惠金额">¥{{ orderInfo.discountAmount }}</el-descriptions-item>
            <el-descriptions-item label="实际支付">¥{{ orderInfo.actualAmount }}</el-descriptions-item>
            <el-descriptions-item label="创建时间">{{ parseTime(orderInfo.createTime) }}</el-descriptions-item>
            <el-descriptions-item label="更新时间">{{ parseTime(orderInfo.updateTime) }}</el-descriptions-item>
          </el-descriptions>
        </el-col>
        
        <el-col :span="12">
          <el-descriptions title="客户信息" :column="1" border>
            <el-descriptions-item label="客户姓名">{{ customerInfo.customerName }}</el-descriptions-item>
            <el-descriptions-item label="联系电话">{{ customerInfo.phone }}</el-descriptions-item>
            <el-descriptions-item label="邮箱">{{ customerInfo.email }}</el-descriptions-item>
            <el-descriptions-item label="地址">{{ customerInfo.address }}</el-descriptions-item>
          </el-descriptions>
          
          <el-descriptions title="收货信息" :column="1" border style="margin-top: 20px;">
            <el-descriptions-item label="收货人">{{ orderInfo.receiverName }}</el-descriptions-item>
            <el-descriptions-item label="联系电话">{{ orderInfo.receiverPhone }}</el-descriptions-item>
            <el-descriptions-item label="收货地址">{{ orderInfo.receiverAddress }}</el-descriptions-item>
            <el-descriptions-item label="发货时间">{{ parseTime(orderInfo.deliveryTime) }}</el-descriptions-item>
            <el-descriptions-item label="收货时间">{{ parseTime(orderInfo.receiveTime) }}</el-descriptions-item>
          </el-descriptions>
          
          <!-- 二维码显示 -->
          <el-card class="qr-code-card" v-if="orderInfo.qrCodeUrl">
            <div slot="header" class="clearfix">
              <span>订单二维码</span>
            </div>
            <div class="qr-code-container">
              <img :src="getFullImageUrl(orderInfo.qrCodeUrl)" alt="订单二维码" class="qr-code-image" />
              <p class="qr-code-text">请出示此二维码用于核销订单</p>
            </div>
          </el-card>
        </el-col>
      </el-row>
      
      <!-- 订单明细 -->
      <el-divider content-position="center">订单明细</el-divider>
      <el-table :data="orderDetailList" border>
        <el-table-column label="商品名称" align="center" prop="flowerInfo.flowerName" />
        <el-table-column label="单价" align="center" prop="unitPrice">
          <template slot-scope="scope">¥{{ scope.row.unitPrice }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center" prop="quantity" />
        <el-table-column label="小计" align="center" prop="totalPrice">
          <template slot-scope="scope">¥{{ scope.row.totalPrice }}</template>
        </el-table-column>
      </el-table>
      
      <!-- 操作记录 -->
      <el-divider content-position="center">操作记录</el-divider>
      <el-timeline>
        <el-timeline-item
          v-for="(activity, index) in statusActivities"
          :key="index"
          :timestamp="activity.timestamp"
          :type="activity.type"
        >
          {{ activity.content }}
        </el-timeline-item>
      </el-timeline>
    </el-card>
    
    <!-- 状态更新对话框 -->
    <el-dialog title="更新订单状态" :visible.sync="updateStatusOpen" width="500px" append-to-body>
      <el-form ref="statusForm" :model="statusForm" :rules="statusRules" label-width="100px">
        <el-form-item label="当前状态">
          <el-tag :type="getStatusType(orderInfo.orderStatus)">
            {{ getOrderStatusText(orderInfo.orderStatus) }}
          </el-tag>
        </el-form-item>
        <el-form-item label="目标状态" prop="targetStatus">
          <el-select v-model="statusForm.targetStatus" placeholder="请选择目标状态" style="width: 100%">
            <el-option
              v-for="item in nextStatusOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="操作说明" prop="remark">
          <el-input v-model="statusForm.remark" type="textarea" placeholder="请输入操作说明" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancelStatusUpdate">取 消</el-button>
        <el-button type="primary" @click="submitStatusUpdate">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getOrder, updateOrder, handleOrderPaymentSuccess, handleOrderCompletion } from "@/api/order/order"
import { listOrderDetail } from "@/api/order/orderDetail"
import { getCustomer } from "@/api/order/customer"
import { getFlower } from "@/api/order/flower"

export default {
  name: "OrderDetail",
  dicts: ['order_pay_method'],
  data() {
    return {
      // 订单ID
      orderId: null,
      // 订单信息
      orderInfo: {},
      // 客户信息
      customerInfo: {},
      // 订单明细列表
      orderDetailList: [],
      // 状态更新对话框
      updateStatusOpen: false,
      // 状态表单
      statusForm: {
        targetStatus: null,
        remark: null
      },
      // 状态表单校验
      statusRules: {
        targetStatus: [
          { required: true, message: "请选择目标状态", trigger: "change" }
        ]
      },
      // 状态活动记录
      statusActivities: []
    }
  },
  computed: {
    // 当前步骤
    currentStep() {
      const status = this.orderInfo.orderStatus
      // 订单状态 1-待付款 2-已付款 3-已发货 4-已完成 5-已取消
      if (status === 1) return 0
      if (status === 2) return 1
      if (status === 3) return 2
      if (status === 4) return 3
      if (status === 5) return 4
      return 0
    },
    // 是否可以更新状态
    canUpdateStatus() {
      // 只有未完成和未取消的订单才能更新状态
      return this.orderInfo.orderStatus && this.orderInfo.orderStatus !== 4 && this.orderInfo.orderStatus !== 5
    },
    // 下一步可选状态
    nextStatusOptions() {
      const currentStatus = this.orderInfo.orderStatus
      const options = []
      
      // 根据当前状态确定可选的下一步状态
      switch (currentStatus) {
        case 1: // 待付款
          options.push({ value: 2, label: '已付款' })
          options.push({ value: 5, label: '已取消' })
          break
        case 2: // 已付款
          options.push({ value: 3, label: '已发货' })
          options.push({ value: 5, label: '已取消' })
          break
        case 3: // 已发货
          options.push({ value: 4, label: '已完成' })
          break
        case 4: // 已完成
          // 已完成状态不能再更新
          break
        case 5: // 已取消
          // 已取消状态不能再更新
          break
      }
      
      return options
    }
  },
  created() {
    const orderId = this.$route.params && this.$route.params.id
    if (orderId) {
      this.orderId = orderId
      this.getOrderInfo(orderId)
      this.getOrderDetails(orderId)
    }
  },
  methods: {
    /** 获取订单信息 */
    getOrderInfo(orderId) {
      getOrder(orderId).then(response => {
        this.orderInfo = response.data
        // 获取客户信息
        if (this.orderInfo.customerId) {
          getCustomer(this.orderInfo.customerId).then(customerResponse => {
            this.customerInfo = customerResponse.data
          })
        }
        this.generateStatusActivities()
      })
    },
    /** 获取订单明细 */
    getOrderDetails(orderId) {
      listOrderDetail({ orderId: orderId }).then(response => {
        this.orderDetailList = response.rows
        // 为每个订单明细添加鲜花信息
        this.orderDetailList.forEach(detail => {
          if (detail.flowerId) {
            getFlower(detail.flowerId).then(flowerResponse => {
              this.$set(detail, 'flowerInfo', flowerResponse.data)
            })
          }
        })
      })
    },
    /** 生成状态活动记录 */
    generateStatusActivities() {
      this.statusActivities = []
      
      // 添加创建订单记录
      if (this.orderInfo.createTime) {
        this.statusActivities.push({
          content: '创建订单',
          timestamp: this.parseTime(this.orderInfo.createTime),
          type: 'primary'
        })
      }
      
      // 根据订单状态添加相应记录
      const status = this.orderInfo.orderStatus
      if (status >= 2) {
        this.statusActivities.push({
          content: '订单付款',
          timestamp: '2023-09-01 10:30:00', // 示例时间
          type: 'success'
        })
      }
      if (status >= 3) {
        this.statusActivities.push({
          content: '订单发货',
          timestamp: this.parseTime(this.orderInfo.deliveryTime),
          type: 'success'
        })
      }
      if (status >= 4) {
        this.statusActivities.push({
          content: '订单完成',
          timestamp: this.parseTime(this.orderInfo.receiveTime),
          type: 'success'
        })
      }
      if (status === 5) {
        this.statusActivities.push({
          content: '订单取消',
          timestamp: '2023-09-01 15:30:00', // 示例时间
          type: 'warning'
        })
      }
    },
    /** 获取订单状态文本 */
    getOrderStatusText(status) {
      const statusMap = {
        1: '待付款',
        2: '已付款',
        3: '已发货',
        4: '已完成',
        5: '已取消'
      }
      return statusMap[status] || '未知状态'
    },
    /** 获取订单状态类型 */
    getStatusType(status) {
      const typeMap = {
        1: 'info',    // 待付款
        2: 'primary', // 已付款
        3: 'warning', // 已发货
        4: 'success', // 已完成
        5: 'danger'   // 已取消
      }
      return typeMap[status] || 'info'
    },
    /** 返回 */
    handleBack() {
      this.$router.go(-1)
    },
    /** 更新状态按钮操作 */
    handleUpdateStatus() {
      this.updateStatusOpen = true
      this.statusForm = {
        targetStatus: null,
        remark: null
      }
    },
    /** 取消状态更新 */
    cancelStatusUpdate() {
      this.updateStatusOpen = false
      this.$refs.statusForm.resetFields()
    },
    /** 提交状态更新 */
    submitStatusUpdate() {
      this.$refs.statusForm.validate(valid => {
        if (valid) {
          const updateData = {
            id: this.orderId,
            orderStatus: this.statusForm.targetStatus,
            remark: this.statusForm.remark
          }
          
          updateOrder(updateData).then(response => {
            this.$modal.msgSuccess("状态更新成功")
            this.updateStatusOpen = false
            // 重新获取订单信息
            this.getOrderInfo(this.orderId)
          })
        }
      })
    },
    
    /** 获取完整图片URL */
    getFullImageUrl(url) {
      if (!url) return '';
      // 如果已经是完整URL，直接返回
      if (url.startsWith('http')) {
        return url;
      }
      // 如果是相对路径，拼接完整URL
      if (url.startsWith('/')) {
        return process.env.VUE_APP_BASE_API + url;
      }
      // 其他情况直接返回
      return url;
    },
    
    /** 处理订单支付成功 */
    handlePaymentSuccess() {
      this.$modal.confirm('是否确认处理订单支付成功？').then(() => {
        return handleOrderPaymentSuccess(this.orderId)
      }).then(() => {
        this.$modal.msgSuccess("处理订单支付成功")
        // 重新获取订单信息
        this.getOrderInfo(this.orderId)
      }).catch(() => {})
    },
    
    /** 处理订单完成 */
    handleOrderCompletion() {
      this.$modal.confirm('是否确认处理订单完成？').then(() => {
        return handleOrderCompletion(this.orderId)
      }).then(() => {
        this.$modal.msgSuccess("处理订单完成成功")
        // 重新获取订单信息
        this.getOrderInfo(this.orderId)
      }).catch(() => {})
    }

  }
}
</script>

<style scoped>
.app-container {
  padding: 20px;
}
