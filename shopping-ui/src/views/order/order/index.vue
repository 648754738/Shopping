<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="订单编号" prop="orderNo">
        <el-input
          v-model="queryParams.orderNo"
          placeholder="请输入订单编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="客户名称" prop="customerName">
        <el-input
          v-model="queryParams.customerName"
          placeholder="请输入客户名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['order:order:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['order:order:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['order:order:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['order:order:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="orderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单编号" align="center" prop="orderNo" />
      <el-table-column label="收货人姓名" align="center" prop="receiverName" />
      <el-table-column label="订单类型" align="center" prop="orderType">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.orderType === 1">普通订单</el-tag>
          <el-tag v-else type="warning">预定订单</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="订单金额" align="center" prop="orderAmount" />
      <el-table-column label="实际支付金额" align="center" prop="actualAmount" />
      <el-table-column label="订单状态" align="center" prop="orderStatus">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.orderStatus === 1" type="info">待付款</el-tag>
          <el-tag v-else-if="scope.row.orderStatus === 2" type="primary">已付款</el-tag>
          <el-tag v-else-if="scope.row.orderStatus === 3" type="warning">已发货</el-tag>
          <el-tag v-else-if="scope.row.orderStatus === 4" type="success">已完成</el-tag>
          <el-tag v-else-if="scope.row.orderStatus === 5" type="danger">已取消</el-tag>
          <el-tag v-else>未知</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="支付方式" align="center" prop="paymentMethod">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.order_pay_method" :value="scope.row.paymentMethod"/>
        </template>
      </el-table-column>
      <el-table-column label="收货人电话" align="center" prop="receiverPhone" />
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
            v-hasPermi="['order:order:edit']"
            class="edit-link"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            @click="handleDelete(scope.row)"
            v-hasPermi="['order:order:remove']"
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

    <!-- 添加或修改订单管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" append-to-body width="60%">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="订单编号" prop="orderNo">
              <el-input v-model="form.orderNo" placeholder="自动生成" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户" prop="customerId">
              <el-select v-model="form.customerId" placeholder="请选择客户" style="width: 100%" filterable>
                <el-option
                  v-for="customer in customerList"
                  :key="customer.id"
                  :label="customer.customerName"
                  :value="customer.id">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row>
          <el-col :span="12">
            <el-form-item label="订单类型" prop="orderType">
              <el-select v-model="form.orderType" placeholder="请选择订单类型" style="width: 100%">
                <el-option label="普通订单" :value="1"></el-option>
                <el-option label="预定订单" :value="2"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="订单状态" prop="orderStatus">
              <el-select v-model="form.orderStatus" placeholder="请选择订单状态" style="width: 100%">
                <el-option label="待付款" :value="1"></el-option>
                <el-option label="已付款" :value="2"></el-option>
                <el-option label="已发货" :value="3"></el-option>
                <el-option label="已完成" :value="4"></el-option>
                <el-option label="已取消" :value="5"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row>
          <el-col :span="12">
            <el-form-item label="订单金额" prop="orderAmount">
              <el-input v-model="form.orderAmount" placeholder="请输入订单金额" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优惠金额" prop="discountAmount">
              <el-input v-model="form.discountAmount" placeholder="请输入优惠金额" type="number" />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row>
          <el-col :span="12">
            <el-form-item label="实际支付金额" prop="actualAmount">
              <el-input v-model="form.actualAmount" placeholder="请输入实际支付金额" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="支付方式" prop="paymentMethod">
              <el-select v-model="form.paymentMethod" placeholder="请选择支付方式" style="width: 100%">
                <el-option
                  v-for="dict in dict.type.order_pay_method"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row>
          <el-col :span="12">
            <el-form-item label="收货人姓名" prop="receiverName">
              <el-input v-model="form.receiverName" placeholder="请输入收货人姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="收货人电话" prop="receiverPhone">
              <el-input v-model="form.receiverPhone" placeholder="请输入收货人电话" />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-form-item label="收货地址" prop="receiverAddress">
          <el-input v-model="form.receiverAddress" placeholder="请输入收货地址" />
        </el-form-item>
        
        <el-row>
          <el-col :span="12">
            <el-form-item label="发货时间" prop="deliveryTime">
              <el-date-picker clearable
                              v-model="form.deliveryTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择发货时间"
                              style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="收货时间" prop="receiveTime">
              <el-date-picker clearable
                              v-model="form.receiveTime"
                              type="date"
                              value-format="yyyy-MM-dd"
                              placeholder="请选择收货时间"
                              style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOrder, getOrder, delOrder, addOrder, updateOrder } from "@/api/order/order"
import { listCustomer } from "@/api/customer/customer"

export default {
  name: "Order",
  dicts: ['order_pay_method'],
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
      // 订单管理表格数据
      orderList: [],
      // 客户列表
      customerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        orderNo: null,
        customerName: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        customerId: [
          { required: true, message: "客户不能为空", trigger: "change" }
        ],
        orderType: [
          { required: true, message: "订单类型不能为空", trigger: "change" }
        ],
        orderAmount: [
          { required: true, message: "订单金额不能为空", trigger: "blur" }
        ],
        actualAmount: [
          { required: true, message: "实际支付金额不能为空", trigger: "blur" }
        ],
        orderStatus: [
          { required: true, message: "订单状态不能为空", trigger: "change" }
        ],
        paymentMethod: [
          { required: true, message: "支付方式不能为空", trigger: "change" }
        ],
        receiverName: [
          { required: true, message: "收货人姓名不能为空", trigger: "blur" }
        ],
        receiverPhone: [
          { required: true, message: "收货人电话不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.getCustomerList()
  },
  methods: {
    /** 查询订单管理列表 */
    getList() {
      this.loading = true
      listOrder(this.queryParams).then(response => {
        this.orderList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 获取客户列表 */
    getCustomerList() {
      // 使用与客户管理页面相同的查询参数
      const queryParams = {
        pageNum: 1,
        pageSize: 1000  // 获取足够多的客户数据
      };
      
      console.log("开始获取客户列表数据，查询参数:", queryParams);
      return listCustomer(queryParams).then(response => {
        console.log("客户列表API响应:", response);
        // 根据不同的响应格式处理数据，与客户管理页面保持一致
        if (response.rows && Array.isArray(response.rows)) {
          this.customerList = response.rows;
        } else if (response.data && Array.isArray(response.data)) {
          this.customerList = response.data;
        } else if (Array.isArray(response)) {
          this.customerList = response;
        } else {
          this.customerList = [];
        }
        console.log("处理后的客户列表:", this.customerList);
        return Promise.resolve(this.customerList);
      }).catch(error => {
        console.error("获取客户列表失败:", error);
        this.$modal.msgError("获取客户列表失败: " + (error.message || error));
        this.customerList = []; // 确保在出错时设置为空数组
        return Promise.reject(error);
      });
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
        orderNo: null,
        customerId: null,
        orderType: null,
        orderAmount: null,
        discountAmount: null,
        actualAmount: null,
        orderStatus: null,
        paymentMethod: null,
        receiverName: null,
        receiverPhone: null,
        receiverAddress: null,
        deliveryTime: null,
        receiveTime: null,
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
      this.reset();
      this.open = true;
      this.title = "添加订单管理";
      // 确保每次打开对话框时都获取最新的客户列表
      this.getCustomerList().then(() => {
        console.log("新增订单对话框 - 客户列表加载成功");
      }).catch((error) => {
        console.error("新增订单对话框 - 获取客户列表失败:", error);
        // 即使获取客户列表失败，也继续打开对话框
        console.warn("获取客户列表失败，但继续打开添加订单对话框");
      });
    },
    /** 详情按钮操作 */
    handleView(row) {
      this.$router.push(`/order/order/detail/${row.id}`)
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids;
      // 先获取客户列表，再获取订单详情
      this.getCustomerList().then(() => {
        console.log("修改订单对话框 - 客户列表加载成功");
        return getOrder(id);
      }).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改订单管理";
      }).catch(error => {
        console.error("修改订单对话框 - 操作失败:", error);
        // 如果获取客户列表失败，仍然尝试获取订单详情
        getOrder(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改订单管理";
        }).catch(error => {
          console.error("获取订单详情失败:", error);
          this.$modal.msgError("获取订单详情失败");
        });
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateOrder(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            // 新增时订单号自动生成，不需要手动填写
            if (!this.form.orderNo || this.form.orderNo.trim() === '') {
              delete this.form.orderNo;
            }
            addOrder(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除订单管理编号为"' + ids + '"的数据项？').then(function() {
        return delOrder(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('order/order/export', {
        ...this.queryParams
      }, `order_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
/* 详情链接样式 */
.view-link {
  color: #67C23A; /* 绿色 */
}

/* 修改链接样式 */
.edit-link {
  color: #409EFF; /* 蓝色 */
}

/* 删除链接样式 */
.delete-link {
  color: #F56C6C; /* 红色 */
}

/* 悬停效果 */
.view-link:hover, .edit-link:hover, .delete-link:hover {
  opacity: 0.8;
  font-weight: 600;
}
</style>