From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Wed, 1 Jul 2015 15:12:54 +0800
Message-ID: <1435734774-10993-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sprd-mmc-rfc>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <sprd-mmc-rfc>
Sender: linux-kernel-owner@vger.kernel.org
To: hris@printf.net, ulf.hansson@linaro.org, lee.jones@linaro.org, shawn.guo@linaro.org
Cc: grant.likely@linaro.org, robh+dt@kernel.org, arnd@arndb.de, billows.wu@spreadtrum.com, wei.qiao@spreadtrum.com, baolin.wang@spreadtrum.com, ning.yang@spreadtrum.com, orson.zhai@spreadtrum.com, jason.wu@spreadtrum.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Billows Wu <billows.wu@spreadtrum.com>

The Spreadtrum MMC host driver is used to support EMMC, SD, and
SDIO types of memory cards.

Signed-off-by: Billows Wu <billows.wu@spreadtrum.com>
Reviewed-by: Orson Zhai <orson.zhai@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/mmc/host/sprd_sdhost.c         | 1270 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sprd_sdhost.h         |  507 +++++++++++++
 drivers/mmc/host/sprd_sdhost_debugfs.c |  213 ++++++
 drivers/mmc/host/sprd_sdhost_debugfs.h |   27 +
 6 files changed, 2027 insertions(+)
 create mode 100644 drivers/mmc/host/sprd_sdhost.c
 create mode 100644 drivers/mmc/host/sprd_sdhost.h
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.c
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.h

diff --git a/drivers/mmc/host/sprd_sdhost.c b/drivers/mmc/host/sprd_sdhost.c
new file mode 100644
index 0000000..e7a66e8
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost.c
@@ -0,0 +1,1270 @@
+/*
+ * linux/drivers/mmc/host/sprd_sdhost.c - Secure Digital Host Controller
+ * Interface driver
+ *
+ * Copyright (C) 2015 Spreadtrum corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+
+#include "sprd_sdhost.h"
+#include "sprd_sdhost_debugfs.h"
+
+#define DRIVER_NAME "sdhost"
+#define SDHOST_CAPS \
+		(MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | \
+		MMC_CAP_ERASE |	 MMC_CAP_UHS_SDR50 | \
+		MMC_CAP_CMD23 | MMC_CAP_HW_RESET)
+
+struct sdhost_caps_data {
+	char *name;
+	uint32_t ocr_avail;
+	uint32_t caps;
+	uint32_t caps2;
+	uint32_t pm_caps;
+	/* TODO: we will obtain these values from regulator and clock
+	 * phandles after LDO and clock function is OK
+	 */
+	uint32_t base_clk;
+	uint32_t signal_default_voltage;
+};
+
+struct sdhost_caps_data sd_caps_info = {
+	.name = "sd",
+	.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
+	.caps = SDHOST_CAPS,
+	.caps2 = MMC_CAP2_HC_ERASE_SZ,
+	.pm_caps = MMC_PM_WAKE_SDIO_IRQ,
+	.base_clk = 192000000,
+	.signal_default_voltage = 3000000,
+};
+
+struct sdhost_caps_data wifi_caps_info = {
+	.name = "wifi",
+	.ocr_avail = MMC_VDD_165_195 | MMC_VDD_29_30 |
+	    MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps = SDHOST_CAPS | MMC_CAP_POWER_OFF_CARD | MMC_CAP_UHS_SDR12,
+	.pm_caps = MMC_PM_KEEP_POWER | MMC_PM_IGNORE_PM_NOTIFY,
+	.base_clk = 76000000,
+};
+
+struct sdhost_caps_data emmc_caps_info = {
+	.name = "emmc",
+	.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
+	.caps = SDHOST_CAPS |
+	    MMC_CAP_8_BIT_DATA | MMC_CAP_UHS_SDR12 |
+	    MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_DDR50 | MMC_CAP_MMC_HIGHSPEED,
+	.caps2 = MMC_CAP2_FULL_PWR_CYCLE | MMC_CAP2_HC_ERASE_SZ,
+	.pm_caps = MMC_PM_WAKE_SDIO_IRQ,
+	.base_clk = 192000000,
+	.signal_default_voltage = 1800000,
+};
+
+const struct of_device_id sdhost_of_match[] = {
+	{.compatible = "sprd,sd-sdhost-3.0", .data = &sd_caps_info,},
+	{.compatible = "sprd,wifi-sdhost-3.0", .data = &wifi_caps_info,},
+	{.compatible = "sprd,emmc-sdhost-3.0",  .data = &emmc_caps_info,},
+	{ /* sentinel */ }
+};
+
+void _reset_ios(struct sdhost_host *host)
+{
+	_sdhost_disable_all_int(host->ioaddr);
+
+	host->ios.clock = 0;
+	host->ios.vdd = 0;
+	/* host->ios.bus_mode    = MMC_BUSMODE_OPENDRAIN; */
+	/* host->ios.chip_select = MMC_CS_DONTCARE; */
+	host->ios.power_mode = MMC_POWER_OFF;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
+	/*host->ios.drv_type    = MMC_SET_DRIVER_TYPE_B; */
+
+	_sdhost_reset(host->ioaddr, _RST_ALL);
+	_sdhost_set_delay(host->ioaddr, host->write_delay,
+			  host->read_pos_delay, host->read_neg_delay);
+}
+
+int __local_pm_suspend(struct sdhost_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	_sdhost_disable_all_int(host->ioaddr);
+	_sdhost_all_clk_off(host->ioaddr);
+	clk_disable(host->clk);
+	/* wake lock */
+	spin_unlock_irqrestore(&host->lock, flags);
+	clk_unprepare(host->clk);
+	synchronize_irq(host->irq);
+
+	return 0;
+}
+
+int __local_pm_resume(struct sdhost_host *host)
+{
+	unsigned long flags;
+
+	clk_prepare(host->clk);
+	spin_lock_irqsave(&host->lock, flags);
+	clk_enable(host->clk);
+	if (host->ios.clock) {
+		_sdhost_sd_clk_off(host->ioaddr);
+		_sdhost_clk_set_and_on(host->ioaddr,
+				       _sdhost_calc_div(host->base_clk,
+							host->ios.clock));
+		_sdhost_sd_clk_on(host->ioaddr);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+void pm_runtime_setting(struct platform_device *pdev, struct sdhost_host *host)
+{
+	pm_runtime_set_active(&pdev->dev);
+#ifdef CONFIG_PM_RUNTIME
+	pm_suspend_ignore_children(&pdev->dev, true);
+#endif
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+}
+
+int _runtime_get(struct sdhost_host *host)
+{
+	return pm_runtime_get_sync(host->mmc->parent);
+}
+
+int _runtime_put(struct sdhost_host *host)
+{
+	pm_runtime_mark_last_busy(host->mmc->parent);
+	return pm_runtime_put_autosuspend(host->mmc->parent);
+}
+
+int _runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	return __local_pm_suspend(host);
+}
+
+int _runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	return __local_pm_resume(host);
+}
+
+int _runtime_idle(struct device *dev)
+{
+	return 0;
+}
+
+int _pm_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	_runtime_get(host);
+
+	host->mmc->pm_flags = host->mmc->pm_caps;
+
+	pr_debug("%s(%s):\n"
+		 "sdhost clock = %d\n"
+		 "sdhost vdd = %d\n"
+		 "sdhost bus_mode = %d\n"
+		 "sdhost chip_select = %d\n"
+		 "sdhost power_mode = %d\n"
+		 "sdhost bus_width = %d\n"
+		 "sdhost timing = %d\n"
+		 "sdhost signal_voltage = %d\n"
+		 "sdhost drv_type = %d\n",
+		 __func__, host->device_name,
+		 host->ios.clock,
+		 host->ios.vdd,
+		 host->ios.bus_mode,
+		 host->ios.chip_select,
+		 host->ios.power_mode,
+		 host->ios.bus_width,
+		 host->ios.timing,
+		 host->ios.signal_voltage, host->ios.drv_type);
+
+	return __local_pm_suspend(host);
+}
+
+int _pm_resume(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+	struct mmc_ios ios;
+
+	__local_pm_resume(host);
+
+	ios = host->mmc->ios;
+	_reset_ios(host);
+	host->mmc->ops->set_ios(host->mmc, &ios);
+
+	pr_debug("%s(%s):\n"
+		 "sdhost clock = %d\n"
+		 "sdhost vdd = %d\n"
+		 "sdhost bus_mode = %d\n"
+		 "sdhost chip_select = %d\n"
+		 "sdhost power_mode = %d\n"
+		 "sdhost bus_width = %d\n"
+		 "sdhost timing = %d\n"
+		 "sdhost signal_voltage = %d\n"
+		 "sdhost drv_type = %d\n",
+		 __func__, host->device_name,
+		 host->ios.clock,
+		 host->ios.vdd,
+		 host->ios.bus_mode,
+		 host->ios.chip_select,
+		 host->ios.power_mode,
+		 host->ios.bus_width,
+		 host->ios.timing,
+		 host->ios.signal_voltage, host->ios.drv_type);
+
+	_runtime_put(host);
+
+	return 0;
+}
+
+void __get_rsp(struct sdhost_host *host)
+{
+	u32 i, offset;
+	unsigned int flags = host->cmd->flags;
+	u32 *resp = host->cmd->resp;
+	void __iomem *addr = host->ioaddr;
+
+	if (!(flags & MMC_RSP_PRESENT))
+		return;
+
+	if (flags & MMC_RSP_136) {
+		/* CRC is stripped so we need to do some shifting. */
+		for (i = 0, offset = 12; i < 3; i++, offset -= 4) {
+			resp[i] =
+			    _sdhost_readl(addr, SDHOST_32_RESP + offset) << 8;
+			resp[i] |=
+			    _sdhost_readb(addr, SDHOST_32_RESP + offset - 1);
+		}
+		resp[3] = _sdhost_readl(addr, SDHOST_32_RESP) << 8;
+	} else {
+		resp[0] = _sdhost_readl(addr, SDHOST_32_RESP);
+	}
+}
+
+void _send_cmd(struct sdhost_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+	int sg_cnt;
+	u32 flag = 0;
+	u16 rsp_type = 0;
+	int if_has_data = 0;
+	int if_multi = 0;
+	int if_rd = 0;
+	int if_dma = 0;
+	uint16_t auto_cmd = __ACMD_DIS;
+
+	pr_debug("sdhost %s cmd %d, arg 0x%x, flag 0x%x\n",
+		 host->device_name, cmd->opcode, cmd->arg, cmd->flags);
+	if (cmd->data)
+		pr_debug("sdhost %s block size %d, cnt %d\n",
+			 host->device_name, cmd->data->blksz,
+			 cmd->data->blocks);
+
+	_sdhost_disable_all_int(host->ioaddr);
+
+	if (38 == cmd->opcode) {
+		/* if it is erase command , it's busy time will long,
+		 * so we set long timeout value here.
+		 */
+		mod_timer(&host->timer, jiffies + 10 * HZ);
+		_sdhost_writeb(host->ioaddr, __TIMEOUT_MAX_VAL,
+			       SDHOST_8_TIMEOUT);
+	} else {
+		mod_timer(&host->timer, jiffies + 3 * HZ);
+		_sdhost_writeb(host->ioaddr, host->data_time_out_val,
+			       SDHOST_8_TIMEOUT);
+	}
+
+	host->cmd = cmd;
+	if (data) {
+		/* set data param */
+		WARN_ON((data->blksz * data->blocks > 524288) ||
+		       (data->blksz > host->mmc->max_blk_size) ||
+		       (data->blocks > 65535));
+
+		data->bytes_xfered = 0;
+
+		if_has_data = 1;
+		if_rd = (data->flags & MMC_DATA_READ);
+		if_multi = (mmc_op_multi(cmd->opcode) || data->blocks > 1);
+		if (if_rd && !if_multi)
+			flag = _DATA_FILTER_RD_SIGLE;
+		else if (if_rd && if_multi)
+			flag = _DATA_FILTER_RD_MULTI;
+		else if (!if_rd && !if_multi)
+			flag = _DATA_FILTER_WR_SIGLE;
+		else
+			flag = _DATA_FILTER_WR_MULT;
+
+		if (!host->auto_cmd_mode)
+			flag |= _INT_ERR_ACMD;
+
+		if_dma = 1;
+		auto_cmd = host->auto_cmd_mode;
+		_sdhost_set_blk_size(host->ioaddr, data->blksz);
+
+		sg_cnt = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				    (data->flags & MMC_DATA_READ) ?
+				    DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		if (1 == sg_cnt) {
+			_sdhost_set_dma(host->ioaddr, __SDMA_MOD);
+			_sdhost_set_16_blk_cnt(host->ioaddr, data->blocks);
+			_sdhost_writel(host->ioaddr, sg_dma_address(data->sg),
+				       SDHOST_32_SYS_ADDR);
+		} else {
+			WARN_ON(1);
+			flag |= _INT_ERR_ADMA;
+			_sdhost_set_dma(host->ioaddr, __32_ADMA_MOD);
+			_sdhost_set_32_blk_cnt(host->ioaddr, data->blocks);
+			_sdhost_writel(host->ioaddr, sg_dma_address(data->sg),
+				       SDHOST_32_SYS_ADDR);
+		}
+	} else {
+		/* _sdhost_set_trans_mode(host->ioaddr,
+		 * 0, 0, __ACMD_DIS, 0, 0);
+		 */
+	}
+
+	_sdhost_writel(host->ioaddr, cmd->arg, SDHOST_32_ARG);
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_R1B:
+		rsp_type = _RSP1B_5B;
+		flag |= _CMD_FILTER_R1B;
+		break;
+	case MMC_RSP_NONE:
+		rsp_type = _RSP0;
+		flag |= _CMD_FILTER_R0;
+		break;
+	case MMC_RSP_R2:
+		rsp_type = _RSP2;
+		flag |= _CMD_FILTER_R2;
+		break;
+
+	case MMC_RSP_R4:
+		rsp_type = _RSP3_4;
+		flag |= _CMD_FILTER_R1_R4_R5_R6_R7;
+		break;
+
+	case MMC_RSP_R1:
+	case MMC_RSP_R1 & ~MMC_RSP_CRC:
+		rsp_type = _RSP1_5_6_7;
+		flag |= _CMD_FILTER_R1_R4_R5_R6_R7;
+		break;
+
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	host->int_filter = flag;
+	_sdhost_enable_int(host->ioaddr, flag);
+	pr_debug("sdhost %s cmd:%d rsp:%d intflag:0x%x\n"
+		 "if_multi:0x%x if_rd:0x%x auto_cmd:0x%x if_dma:0x%x\n",
+		 host->device_name, cmd->opcode, mmc_resp_type(cmd),
+		 flag, if_multi, if_rd, auto_cmd, if_dma);
+	_sdhost_set_trans_and_cmd(host->ioaddr, if_multi, if_rd, auto_cmd,
+		if_multi, if_dma, cmd->opcode, if_has_data, rsp_type);
+}
+
+void _cmd_irq(struct sdhost_host *host, u32 intmask)
+{
+	if (0 == intmask) {
+		WARN_ON(1);
+		return;
+	}
+
+	if (!host->cmd) {
+		pr_err("%s: got command interrupt 0x%08x even though no command operation was in process\n",
+		     host->device_name, (unsigned)intmask);
+		return;
+	}
+
+	if (_INT_ERR_CMD_TIMEOUT & intmask)
+		host->cmd->error = -ETIMEDOUT;
+	else if ((_INT_ERR_CMD_CRC | _INT_ERR_CMD_END |
+		  _INT_ERR_CMD_INDEX) & intmask)
+		host->cmd->error = -EILSEQ;
+}
+
+void _data_irq(struct sdhost_host *host, u32 intmask)
+{
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data = cmd->data;
+
+	if (data) {
+		/* current error is happened in data token */
+		if (_INT_ERR_DATA_TIMEOUT & intmask)
+			data->error = -ETIMEDOUT;
+		else
+			data->error = -EILSEQ;
+	} else {
+		/* current error is happend in response with busy */
+		if (_INT_ERR_DATA_TIMEOUT & intmask)
+			cmd->error = -ETIMEDOUT;
+		else
+			cmd->error = -EILSEQ;
+	}
+}
+
+void _trans_end_irq(struct sdhost_host *host, u32 intmask)
+{
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data = cmd->data;
+
+	if (data) {
+		dma_unmap_sg(mmc_dev(host->mmc),
+			     data->sg, data->sg_len,
+			     (data->flags & MMC_DATA_READ) ?
+			     DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		data->error = 0;
+		data->bytes_xfered = data->blksz * data->blocks;
+	} else {
+		/* R1B also can produce transferComplete interrupt */
+		cmd->error = 0;
+	}
+}
+
+int _err_irq_handle(struct sdhost_host *host, u32 intmask)
+{
+	int ret = 1;
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data = cmd->data;
+
+	/* some error happened in command */
+	_cmd_irq(host, intmask & _INT_FILTER_ERR);
+	if (_INT_FILTER_ERR_DATA & intmask)
+		/* some error happened in data token or command with R1B */
+		_data_irq(host, intmask);
+
+	if (_INT_ERR_ACMD & intmask)
+		/* Auto cmd12 and cmd23 error is belong to data token error */
+		data->error = -EILSEQ;
+
+	if (_INT_ERR_ADMA & intmask)
+		data->error = -EIO;
+
+	/* for debug */
+	pr_debug("sdhost %s int 0x%x\n", host->device_name, intmask);
+	dump_sdio_reg(host);
+	_sdhost_disable_all_int(host->ioaddr);
+
+	/* if current error happened in data token we send cmd12 to stop it*/
+	if ((mrq->cmd == cmd) && (mrq->stop)) {
+		_sdhost_reset(host->ioaddr,
+			_RST_CMD | _RST_DATA);
+		_send_cmd(host, mrq->stop);
+	} else {
+		/* request finish with error, so reset it
+		 * and stop the request
+		 */
+		_sdhost_reset(host->ioaddr,
+			_RST_CMD | _RST_DATA);
+		tasklet_schedule(&host->finish_tasklet);
+	}
+
+	return ret;
+}
+
+int _normal_irq_handle(struct sdhost_host *host, u32 intmask)
+{
+	int ret = 0;
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd;
+
+	/* delete irq that wanted in filter */
+	/* _sdhost_clear_int(host->ioaddr,
+	 *_INT_FILTER_NORMAL & intmask);
+	 */
+	host->int_filter &= ~(_INT_FILTER_NORMAL & intmask);
+	if (_INT_DMA_END & intmask)
+		_sdhost_writel(host->ioaddr,
+			_sdhost_readl(host->ioaddr,
+				SDHOST_32_SYS_ADDR),
+				SDHOST_32_SYS_ADDR);
+
+	if (_INT_CMD_END & intmask) {
+		cmd->error = 0;
+		__get_rsp(host);
+	}
+	if (_INT_TRAN_END & intmask)
+		_trans_end_irq(host, intmask);
+	if (!(_INT_FILTER_NORMAL & host->int_filter)) {
+		/* current cmd finished */
+		_sdhost_disable_all_int(host->ioaddr);
+		_sdhost_reset(host->ioaddr,
+			_RST_CMD | _RST_DATA);
+		if (mrq->sbc == cmd) {
+			_send_cmd(host, mrq->cmd);
+		} else if ((mrq->cmd == host->cmd)
+			&& (mrq->stop)) {
+				_send_cmd(host, mrq->stop);
+		} else {
+			/* finish with success and stop the
+			 * request
+			 */
+			tasklet_schedule(&host->finish_tasklet);
+			ret = 1;
+		}
+	}
+
+	return ret;
+}
+
+irqreturn_t _irq_func(int irq, void *param)
+{
+	u32 intmask;
+	struct sdhost_host *host = (struct sdhost_host *)param;
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data;
+
+	spin_lock(&host->lock);
+	/* maybe _timeout_func run in one core and _irq_func run in
+	 * another core, this will panic if access cmd->data
+	 */
+	if ((!mrq) || (!cmd)) {
+		spin_unlock(&host->lock);
+		return IRQ_NONE;
+	}
+	data = cmd->data;
+
+	intmask = _sdhost_readl(host->ioaddr, SDHOST_32_INT_STATUS);
+	if (!intmask) {
+		spin_unlock(&host->lock);
+		return IRQ_NONE;
+	}
+	pr_debug("sdhost %s int 0x%x\n", host->device_name, intmask);
+
+	/* disable unused interrupt */
+	_sdhost_clear_int(host->ioaddr, intmask);
+	/* just care about the interrupt that we want */
+	intmask &= host->int_filter;
+
+	while (intmask) {
+		int ret;
+
+		if (_INT_FILTER_ERR & intmask) {
+			ret = _err_irq_handle(host, intmask);
+			if (ret)
+				goto out;
+		} else {
+			ret = _normal_irq_handle(host, intmask);
+			if (ret)
+				goto out;
+		}
+
+		intmask = _sdhost_readl(host->ioaddr, SDHOST_32_INT_STATUS);
+		_sdhost_clear_int(host->ioaddr, intmask);
+		intmask &= host->int_filter;
+	};
+
+out:
+	spin_unlock(&host->lock);
+	return IRQ_HANDLED;
+}
+
+void _tasklet_func(unsigned long param)
+{
+	struct sdhost_host *host = (struct sdhost_host *)param;
+	unsigned long flags;
+	struct mmc_request *mrq;
+
+	del_timer(&host->timer);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (!host->mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+	mrq = host->mrq;
+	host->mrq = NULL;
+	host->cmd = NULL;
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	pr_debug("sdhost %s cmd %d data %d\n",
+		 host->device_name, mrq->cmd->error,
+		 ((!!mrq->cmd->data) ? mrq->cmd->data->error : 0));
+	mmc_request_done(host->mmc, mrq);
+	_runtime_put(host);
+}
+
+void _timeout_func(unsigned long data)
+{
+	struct sdhost_host *host = (struct sdhost_host *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->mrq) {
+		pr_info("sdhost %s Timeout waiting for hardware interrupt!\n",
+			host->device_name);
+		dump_sdio_reg(host);
+		if (host->cmd->data)
+			host->cmd->data->error = -ETIMEDOUT;
+		else if (host->cmd)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->mrq->cmd->error = -ETIMEDOUT;
+
+		_sdhost_disable_all_int(host->ioaddr);
+		_sdhost_reset(host->ioaddr, _RST_CMD | _RST_DATA);
+		tasklet_schedule(&host->finish_tasklet);
+	}
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+void sdhost_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	host->mrq = mrq;
+	/* 1 find whether card is still in slot */
+	if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE)) {
+		if (!mmc_gpio_get_cd(host->mmc)) {
+			mrq->cmd->error = -ENOMEDIUM;
+			tasklet_schedule(&host->finish_tasklet);
+			mmiowb();
+			spin_unlock_irqrestore(&host->lock, flags);
+			return;
+		}
+		/* else asume sdcard is present */
+	}
+
+	/*
+	 * in our control we can not use auto cmd12 and auto cmd23 together
+	 * so in following program we use auto cmd23 prior to auto cmd12
+	 */
+	pr_debug("sdhost %s request %d %d %d\n",
+		 host->device_name, !!mrq->sbc, !!mrq->cmd, !!mrq->stop);
+	host->auto_cmd_mode = __ACMD_DIS;
+	if (!mrq->sbc && mrq->stop && SDHOST_FLAG_EN_ACMD12) {
+		host->auto_cmd_mode = __ACMD12;
+		mrq->data->stop = NULL;
+		mrq->stop = NULL;
+	}
+
+	/* 3 send cmd list */
+	if ((mrq->sbc) && SDHOST_FLAG_EN_ACMD23) {
+		host->auto_cmd_mode = __ACMD23;
+		_send_cmd(host, mrq->cmd);
+	} else if (mrq->sbc)
+		_send_cmd(host, mrq->sbc);
+	else
+		_send_cmd(host, mrq->cmd);
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+void signal_voltage_on_off(struct sdhost_host *host, uint32_t on_off)
+{
+	if (!host->mmc->supply.vqmmc) {
+		pr_err("%s(%s) there is no signal voltage!\n",
+		       __func__, host->device_name);
+		return;
+	}
+
+	if (on_off && (!host->sdio_1_8v_signal_enabled)) {
+		if (!regulator_enable(host->mmc->supply.vqmmc) &&
+			regulator_is_enabled(host->mmc->supply.vqmmc)) {
+			host->sdio_1_8v_signal_enabled = true;
+			pr_info("%s(%s) signal voltage enable success!\n",
+					__func__, host->device_name);
+		} else
+			pr_err("%s(%s) signal voltage enable fail!\n",
+				__func__, host->device_name);
+
+	} else if (!on_off && host->sdio_1_8v_signal_enabled) {
+		if (!regulator_disable(host->mmc->supply.vqmmc) &&
+			!regulator_is_enabled(host->mmc->supply.vqmmc)) {
+			host->sdio_1_8v_signal_enabled = false;
+			pr_info("%s(%s) signal voltage disable success!\n",
+				__func__, host->device_name);
+		} else
+			pr_err("%s(%s) signal voltage disable fail\n",
+				__func__, host->device_name);
+	}
+}
+
+/*
+ * 1 This votage is always poweron
+ * 2 initial votage is 2.7v~3.6v
+ * 3 It can be reconfig to 1.7v~1.95v
+ */
+int sdhost_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int err;
+
+	pr_debug("%s(%s) vqmmc:\n"
+		 "sdhost clock = %d-->%d\n"
+		 "sdhost vdd = %d-->%d\n"
+		 "sdhost bus_mode = %d-->%d\n"
+		 "sdhost chip_select = %d-->%d\n"
+		 "sdhost power_mode = %d-->%d\n"
+		 "sdhost bus_width = %d-->%d\n"
+		 "sdhost timing = %d-->%d\n"
+		 "sdhost signal_voltage = %d-->%d\n"
+		 "sdhost drv_type = %d-->%d\n",
+		 __func__, host->device_name,
+		 host->ios.clock, ios->clock,
+		 host->ios.vdd, ios->vdd,
+		 host->ios.bus_mode, ios->bus_mode,
+		 host->ios.chip_select, ios->chip_select,
+		 host->ios.power_mode, ios->power_mode,
+		 host->ios.bus_width, ios->bus_width,
+		 host->ios.timing, ios->timing,
+		 host->ios.signal_voltage, ios->signal_voltage,
+		 host->ios.drv_type, ios->drv_type);
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!mmc->supply.vqmmc) {
+		/* there are no 1.8v signal votage. */
+		spin_unlock_irqrestore(&host->lock, flags);
+		_runtime_put(host);
+		/* err = -EINVAL; */
+		err = 0;
+		pr_err("sdhost %s There is no signalling voltage\n",
+		       host->device_name);
+		return err;
+	}
+
+	/* I/O power supply */
+	if (ios->signal_voltage == host->ios.signal_voltage) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		_runtime_put(host);
+		return 0;
+	}
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		err = regulator_set_voltage(mmc->supply.vqmmc,
+					    3000000, 3000000);
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		err = regulator_set_voltage(mmc->supply.vqmmc,
+					    1800000, 1800000);
+		break;
+	case MMC_SIGNAL_VOLTAGE_120:
+		err = regulator_set_voltage(mmc->supply.vqmmc,
+					    1100000, 1300000);
+		break;
+	default:
+		err = -EIO;
+		break;
+	}
+	if (likely(!err))
+		host->ios.signal_voltage = ios->signal_voltage;
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+
+	WARN(err, "Switching to signalling voltage  failed\n");
+	return err;
+}
+
+void sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	pr_debug("%s(%s) ios:\n"
+		 "sdhost clock = %d-->%d\n"
+		 "sdhost vdd = %d-->%d\n"
+		 "sdhost bus_mode = %d-->%d\n"
+		 "sdhost chip_select = %d-->%d\n"
+		 "sdhost power_mode = %d-->%d\n"
+		 "sdhost bus_width = %d-->%d\n"
+		 "sdhost timing = %d-->%d\n"
+		 "sdhost signal_voltage = %d-->%d\n"
+		 "sdhost drv_type = %d-->%d\n",
+		 __func__, host->device_name,
+		 host->ios.clock, ios->clock,
+		 host->ios.vdd, ios->vdd,
+		 host->ios.bus_mode, ios->bus_mode,
+		 host->ios.chip_select, ios->chip_select,
+		 host->ios.power_mode, ios->power_mode,
+		 host->ios.bus_width, ios->bus_width,
+		 host->ios.timing, ios->timing,
+		 host->ios.signal_voltage, ios->signal_voltage,
+		 host->ios.drv_type, ios->drv_type);
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+	dump_sdio_reg(host);
+
+	if (0 == ios->clock) {
+		_sdhost_all_clk_off(host->ioaddr);
+		host->ios.clock = 0;
+	} else if (ios->clock != host->ios.clock) {
+		uint32_t div;
+
+		div = _sdhost_calc_div(host->base_clk, ios->clock);
+		_sdhost_sd_clk_off(host->ioaddr);
+		_sdhost_clk_set_and_on(host->ioaddr, div);
+		_sdhost_sd_clk_on(host->ioaddr);
+		host->ios.clock = ios->clock;
+		host->data_time_out_val =
+			_sdhost_calc_timeout(host->base_clk, div, 3);
+	}
+
+	if (ios->power_mode != host->ios.power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			signal_voltage_on_off(host, 0);
+			if (mmc->supply.vmmc)
+				mmc_regulator_set_ocr(host->mmc,
+					mmc->supply.vmmc, 0);
+			_reset_ios(host);
+			host->ios.power_mode = ios->power_mode;
+			break;
+		case MMC_POWER_ON:
+		case MMC_POWER_UP:
+			if (mmc->supply.vmmc)
+				mmc_regulator_set_ocr(host->mmc,
+					mmc->supply.vmmc, ios->vdd);
+			signal_voltage_on_off(host, 1);
+			host->ios.power_mode = ios->power_mode;
+			host->ios.vdd = ios->vdd;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* flash power voltage select */
+	if (ios->vdd != host->ios.vdd) {
+		if (mmc->supply.vmmc) {
+			pr_info("sdhost %s 3.0 %d!\n",
+				host->device_name, ios->vdd);
+			mmc_regulator_set_ocr(host->mmc,
+					mmc->supply.vmmc, ios->vdd);
+		}
+		host->ios.vdd = ios->vdd;
+	}
+
+	if (ios->bus_width != host->ios.bus_width) {
+		_sdhost_set_buswidth(host->ioaddr, ios->bus_width);
+		host->ios.bus_width = ios->bus_width;
+	}
+
+	if (ios->timing != host->ios.timing) {
+		/* 1 first close SD clock */
+		_sdhost_sd_clk_off(host->ioaddr);
+		/* 2 set timing mode */
+		switch (ios->timing) {	/* timing specification used */
+		case MMC_TIMING_LEGACY:
+			/*basic clock mode */
+			_sdhost_set_uhs_mode(host->ioaddr, __TIMING_MODE_SDR12);
+			break;
+		case MMC_TIMING_MMC_HS:
+		case MMC_TIMING_SD_HS:
+			_sdhost_set_uhs_mode(host->ioaddr, __TIMING_MODE_SDR12);
+			break;
+		case MMC_TIMING_UHS_SDR12:
+		case MMC_TIMING_UHS_SDR25:
+		case MMC_TIMING_UHS_SDR50:
+		case MMC_TIMING_UHS_SDR104:
+		case MMC_TIMING_UHS_DDR50:
+		case MMC_TIMING_MMC_HS200:
+			/* _sdhost_enable_hispd(host->ioaddr); */
+			_sdhost_set_uhs_mode(host->ioaddr, ios->timing -
+				MMC_TIMING_UHS_SDR12 + __TIMING_MODE_SDR12);
+			break;
+		default:
+			break;
+		}
+		/* 3 open SD clock */
+		_sdhost_sd_clk_on(host->ioaddr);
+		host->ios.timing = ios->timing;
+	}
+
+	mdelay(100);
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+}
+
+int sdhost_get_ro(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+	/*read & write */
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+	return 0;
+}
+
+int sdhost_get_cd(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int gpio_cd;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		_runtime_put(host);
+		return 1;
+	}
+
+	gpio_cd = mmc_gpio_get_cd(host->mmc);
+	if (IS_ERR_VALUE(gpio_cd))
+		gpio_cd = 1;
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+	return !!gpio_cd;
+}
+
+int sdhost_card_busy(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 present_state;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* Check whether DAT[3:0] is 0000 */
+	present_state = _sdhost_readl(host->ioaddr, SDHOST_32_PRES_STATE);
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+
+	return !(present_state & _DAT_LVL_MASK);
+}
+
+void sdhost_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* close LDO and open LDO again. */
+	signal_voltage_on_off(host, 0);
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+	mdelay(50);
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc,
+				      host->ios.vdd);
+
+	signal_voltage_on_off(host, 1);
+	mdelay(50);
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+
+}
+
+const struct mmc_host_ops sdhost_ops = {
+	.request = sdhost_request,
+	.set_ios = sdhost_set_ios,
+	.get_ro = sdhost_get_ro,
+	.get_cd = sdhost_get_cd,
+
+	.start_signal_voltage_switch = sdhost_set_vqmmc,
+	.card_busy = sdhost_card_busy,
+	.hw_reset = sdhost_hw_reset,
+};
+
+void get_caps_info(struct sdhost_host *host, struct sdhost_caps_data *pdata)
+{
+	host->device_name = pdata->name;
+	host->ocr_avail = pdata->ocr_avail;
+	host->caps = pdata->caps;
+	host->caps2 = pdata->caps2;
+	host->pm_caps = pdata->pm_caps;
+	host->base_clk = pdata->base_clk;
+	host->signal_default_voltage = pdata->signal_default_voltage;
+}
+
+int get_basic_resource(struct platform_device *pdev, struct sdhost_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	uint32_t sdhost_delay[3];
+	struct sdhost_caps_data *pdata;
+	const struct of_device_id *of_id;
+	int ret;
+
+	of_id = of_match_node(sdhost_of_match, np);
+	if (!of_id) {
+		dev_err(&pdev->dev, "failed to match node\n");
+		return -ENODEV;
+	}
+	pdata = (struct sdhost_caps_data *)of_id->data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	host->ioaddr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	host->mapbase = res->start;
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0)
+		return host->irq;
+
+#if 0
+	host->clk = of_clk_get(np, 0);
+	if (IS_ERR_OR_NULL(host->clk))
+		return PTR_ERR(host->clk);
+
+	host->clk_parent = of_clk_get(np, 1);
+	if (IS_ERR_OR_NULL(host->clk_parent))
+		return PTR_ERR(host->clk_parent);
+#endif
+
+	get_caps_info(host, pdata);
+	host->detect_gpio = of_get_named_gpio(np, "cd-gpios", 0);
+	if (!gpio_is_valid(host->detect_gpio))
+		host->detect_gpio = -1;
+
+	ret = of_property_read_u32_array(np, "sprd,delay", sdhost_delay, 3);
+	if (!ret) {
+		host->write_delay = sdhost_delay[0];
+		host->read_pos_delay = sdhost_delay[1];
+		host->read_neg_delay = sdhost_delay[2];
+	} else
+		dev_err(&pdev->dev, "can not read the property of sprd delay\n");
+
+	return 0;
+}
+
+int get_external_resource(struct sdhost_host *host)
+{
+	int err;
+	struct mmc_host *mmc = host->mmc;
+
+	host->dma_mask = DMA_BIT_MASK(64);
+	host->data_time_out_val = 0;
+
+	/* 1 LDO */
+	mmc_regulator_get_supply(mmc);
+	if (IS_ERR_OR_NULL(mmc->supply.vmmc)) {
+		pr_err("%s(%s): no vmmc regulator found\n",
+		       __func__, host->device_name);
+		mmc->supply.vmmc = NULL;
+	}
+	if (IS_ERR_OR_NULL(mmc->supply.vqmmc)) {
+		pr_err("%s(%s): no vqmmc regulator found\n",
+		       __func__, host->device_name);
+		mmc->supply.vqmmc = NULL;
+	} else {
+		regulator_is_supported_voltage(mmc->supply.vqmmc,
+			host->signal_default_voltage,
+			host->signal_default_voltage);
+		regulator_set_voltage(mmc->supply.vqmmc,
+			host->signal_default_voltage,
+			host->signal_default_voltage);
+	}
+	host->mmc = mmc;
+
+#if 0
+	/* 2 clock */
+	clk_set_parent(host->clk, host->clk_parent);
+	clk_prepare_enable(host->clk);
+#endif
+	/* 3 reset sdio */
+	_reset_ios(host);
+	err = devm_request_irq(&host->pdev->dev, host->irq, _irq_func,
+			       IRQF_SHARED, mmc_hostname(host->mmc), host);
+	if (err)
+		return err;
+	tasklet_init(&host->finish_tasklet, _tasklet_func, (unsigned long)host);
+	/* 4 init timer */
+	setup_timer(&host->timer, _timeout_func, (unsigned long)host);
+
+	return 0;
+}
+
+int set_mmc_struct(struct sdhost_host *host, struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	mmc = host->mmc;
+	mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
+	mmc->ops = &sdhost_ops;
+	mmc->f_max = host->base_clk;
+	mmc->f_min = (unsigned int)(host->base_clk / __CLK_MAX_DIV);
+	mmc->max_busy_timeout = (1 << 27) / (host->base_clk / 1000);
+
+	mmc->caps = host->caps;
+	mmc->caps2 = host->caps2;
+	mmc->pm_caps = host->pm_caps;
+	mmc->pm_flags = host->pm_caps;
+	mmc->ocr_avail = host->ocr_avail;
+	mmc->ocr_avail_sdio = host->ocr_avail;
+	mmc->ocr_avail_sd = host->ocr_avail;
+	mmc->ocr_avail_mmc = host->ocr_avail;
+	mmc->max_current_330 = SDHOST_MAX_CUR;
+	mmc->max_current_300 = SDHOST_MAX_CUR;
+	mmc->max_current_180 = SDHOST_MAX_CUR;
+
+	mmc->max_segs = 1;
+	mmc->max_req_size = 524288;	/* 512k */
+	mmc->max_seg_size = mmc->max_req_size;
+
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = 65535;
+
+	ret = mmc_of_parse(mmc);
+	if (ret) {
+		mmc_free_host(mmc);
+		pr_info("parse sprd %s controller fail\n", host->device_name);
+		return ret;
+	}
+
+	pr_info("%s(%s): ocr avail = 0x%x\n"
+		"base clock = %u, pm_caps = 0x%x\n"
+		"caps: 0x%x, caps2: 0x%x\n",
+		__func__, host->device_name, mmc->ocr_avail,
+		host->base_clk, host->pm_caps, mmc->caps, mmc->caps2);
+
+	return ret;
+}
+
+int sdhost_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct sdhost_host *host;
+	int ret;
+
+	/* globe resource */
+	mmc = mmc_alloc_host(sizeof(struct sdhost_host), &pdev->dev);
+	if (!mmc) {
+		dev_err(&pdev->dev, "no memory for MMC host\n");
+		return -ENOMEM;
+	}
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->pdev = pdev;
+	spin_lock_init(&host->lock);
+	platform_set_drvdata(pdev, host);
+
+	/* get sdio irq and sdio iomem */
+	ret = get_basic_resource(pdev, host);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to get basic resource: %d\n", ret);
+		return ret;
+	}
+
+	ret = get_external_resource(host);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to get external resource: %d\n", ret);
+		return ret;
+	}
+
+	ret = set_mmc_struct(host, mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to set mmc struct: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_setting(pdev, host);
+
+	/*add host */
+	mmiowb();
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add mmc host: %d\n", ret);
+		mmc_free_host(mmc);
+	}
+
+	if (-1 != host->detect_gpio)
+		mmc_gpio_request_cd(mmc, host->detect_gpio, 0);
+
+	sdhost_add_debugfs(host);
+
+	dev_info(&pdev->dev,
+		 "Spreadtrum %s host controller at 0x%08lx irq %d\n",
+		 host->device_name, host->mapbase, host->irq);
+
+	return ret;
+}
+
+void sdhost_shutdown(struct platform_device *pdev)
+{
+}
+
+const struct dev_pm_ops sdhost_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(_pm_suspend, _pm_resume)
+	SET_RUNTIME_PM_OPS(_runtime_suspend,
+			       _runtime_resume, _runtime_idle)
+};
+
+MODULE_DEVICE_TABLE(of, sdhost_of_match);
+
+struct platform_driver sdhost_driver = {
+	.probe = sdhost_probe,
+	.shutdown = sdhost_shutdown,
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .pm = &sdhost_dev_pm_ops,
+		   .name = DRIVER_NAME,
+		   .of_match_table = of_match_ptr(sdhost_of_match),
+		   },
+};
+
+module_platform_driver(sdhost_driver);
+
+MODULE_DESCRIPTION("Spreadtrum sdio host controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sprd_sdhost.h b/drivers/mmc/host/sprd_sdhost.h
new file mode 100644
index 0000000..5778b6d
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost.h
@@ -0,0 +1,507 @@
+/*
+ * linux/drivers/mmc/host/sprd_sdhost.h - Secure Digital Host Controller
+ * Interface driver
+ *
+ * Copyright (C) 2015 Spreadtrum corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+
+#ifndef __SDHOST_H_
+#define __SDHOST_H_
+
+#include <linux/clk.h>
+#include <linux/compiler.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/scatterlist.h>
+#include <linux/types.h>
+
+/* Controller flag */
+#define SDHOST_FLAG_EN_ACMD12	1
+#define SDHOST_FLAG_EN_ACMD23	1
+#define SDHOST_FLAG_USE_ADMA	1
+
+/* Controller registers */
+static inline void _sdhost_writeb(void __iomem *ioadr, uint8_t val, int reg)
+{
+		writeb_relaxed(val, ioadr + reg);
+}
+static inline void _sdhost_writew(void __iomem *ioadr, uint16_t val, int reg)
+{
+		writew_relaxed(val, ioadr + reg);
+}
+static inline void _sdhost_writel(void __iomem *ioadr, uint32_t val, int reg)
+{
+		writel_relaxed(val, ioadr + reg);
+}
+static inline uint8_t _sdhost_readb(void __iomem *ioadr, int reg)
+{
+		return readb_relaxed(ioadr + reg);
+}
+static inline uint16_t _sdhost_readw(void __iomem *ioadr, int reg)
+{
+		return readw_relaxed(ioadr + reg);
+}
+static inline uint32_t _sdhost_readl(void __iomem *ioadr, int reg)
+{
+		return readl_relaxed(ioadr + reg);
+}
+#define SDHOST_32_SYS_ADDR	0x00
+/* used in cmd23 with ADMA in sdio 3.0 */
+#define SDHOST_32_BLK_CNT	0x00
+#define SDHOST_16_BLK_CNT	0x06
+
+static inline void _sdhost_set_16_blk_cnt(void __iomem *ioadr, uint32_t blk_cnt)
+{
+	writew_relaxed((blk_cnt & 0xFFFF), ioadr + SDHOST_16_BLK_CNT);
+}
+
+static inline void _sdhost_set_32_blk_cnt(void __iomem *ioadr, uint32_t blk_cnt)
+{
+	writel_relaxed((blk_cnt & 0xFFFFFFFF), ioadr + SDHOST_32_BLK_CNT);
+}
+
+#define SDHOST_16_BLK_SIZE	0x04
+
+static inline void _sdhost_set_blk_size(void __iomem *ioadr, uint32_t blk_size)
+{
+	writew_relaxed((blk_size & 0xFFF) | 0x7000, ioadr + SDHOST_16_BLK_SIZE);
+}
+
+#define SDHOST_32_ARG			0x08
+#define SDHOST_16_TR_MODE		0x0C
+#define __ACMD_DIS	0x00
+#define __ACMD12	0x01
+#define __ACMD23	0x02
+static inline void _sdhost_set_trans_mode(
+				void __iomem *io_addr, int if_multi,
+				int if_read, uint16_t auto_cmd,
+				int if_blk_cnt, int if_dma)
+{
+	writew_relaxed(
+		(((if_multi ? 1 : 0) << 5) |
+		((if_read ? 1 : 0) << 4) |
+		(((u16)auto_cmd) << 2) |
+		((if_blk_cnt ? 1 : 0) << 1) |
+		((if_dma ? 1 : 0) << 0)) ,
+		io_addr + SDHOST_16_TR_MODE);
+}
+
+#define SDHOST_16_CMD			0x0E
+#define _CMD_INDEX_CHK			0x0010
+#define _CMD_CRC_CHK			0x0008
+#define _CMD_RSP_NONE			0x0000
+#define _CMD_RSP_136			0x0001
+#define _CMD_RSP_48				0x0002
+#define _CMD_RSP_48_BUSY		0x0003
+#define _RSP0			0
+#define _RSP1_5_6_7	\
+		(_CMD_INDEX_CHK | _CMD_CRC_CHK | _CMD_RSP_48)
+#define _RSP2 \
+		(_CMD_CRC_CHK | _CMD_RSP_136)
+#define _RSP3_4	\
+		_CMD_RSP_48
+#define _RSP1B_5B \
+		(_CMD_INDEX_CHK | _CMD_CRC_CHK | _CMD_RSP_48_BUSY)
+
+static inline void _sdhost_set_cmd(
+				void __iomem *ioadr, u32 cmd,
+				int if_has_data, u32 rsp_type)
+{
+	writew_relaxed(
+		((((u16)(cmd)) << 8) |
+		(((if_has_data) ? 1 : 0) << 5) |
+		((u16)(rsp_type))),
+		(ioadr) + SDHOST_16_CMD);
+}
+
+#define SDHOST_32_TR_MODE_AND_CMD		0x0C
+
+static inline void _sdhost_set_trans_and_cmd(
+				void __iomem *ioadr, int if_multi,
+				int if_read, uint16_t auto_cmd,
+				int if_blk_cnt, int if_dma, u32 cmd,
+				int if_has_data, u32 rsp_type)
+{
+	writel_relaxed(
+		((((if_multi) ? 1 : 0) << 5) |
+		(((if_read) ? 1 : 0) << 4) |
+		(((u32)(auto_cmd)) << 2) |
+		(((if_blk_cnt) ? 1 : 0) << 1) |
+		(((if_dma) ? 1 : 0) << 0) |
+		(((u32)(cmd)) << 24) |
+		(((if_has_data) ? 1 : 0) << 21) |
+		(((u32)(rsp_type)) << 16)) ,
+		ioadr + SDHOST_32_TR_MODE_AND_CMD);
+}
+
+#define SDHOST_32_RESP	0x10
+#define SDHOST_32_PRES_STATE	0x24
+#define  _DAT_LVL_MASK		0x00F00000
+#define SDHOST_8_HOST_CTRL	0x28
+#define __8_BIT_MOD		0x20
+#define __4_BIT_MOD		0x02
+#define __1_BIT_MOD	0x00
+#define __SDMA_MOD		0x00
+#define __32_ADMA_MOD	0x10
+#define __64_ADMA_MOD	0x18
+#define __HISPD_MOD		0x04
+
+static inline void _sdhost_set_buswidth(void __iomem *ioadr, uint32_t buswidth)
+{
+	u8 ctrl = 0;
+
+	ctrl = readb_relaxed(ioadr + SDHOST_8_HOST_CTRL);
+	ctrl &= (~(__8_BIT_MOD | __4_BIT_MOD | __1_BIT_MOD));
+	switch (buswidth) {
+	case MMC_BUS_WIDTH_1:
+		ctrl |= __1_BIT_MOD;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl |= __4_BIT_MOD;
+		break;
+	case MMC_BUS_WIDTH_8:
+		ctrl |= __8_BIT_MOD;
+		break;
+	default:
+		BUG_ON(1);
+		break;
+	}
+	writeb_relaxed(ctrl, ioadr + SDHOST_8_HOST_CTRL);
+}
+
+static inline void _sdhost_set_dma(void __iomem *ioadr, u8 dmaMod)
+{
+	u8 ctrl = 0;
+
+	ctrl = readb_relaxed(ioadr + SDHOST_8_HOST_CTRL);
+	ctrl &= (~(__SDMA_MOD | __32_ADMA_MOD | __64_ADMA_MOD));
+	ctrl |= dmaMod;
+	writeb_relaxed(ctrl, ioadr + SDHOST_8_HOST_CTRL);
+}
+
+static inline void _sdhost_enable_hispd(void __iomem *ioadr)
+{
+	u8 ctrl = 0;
+
+	ctrl = readb_relaxed(ioadr + SDHOST_8_HOST_CTRL);
+	ctrl |= __HISPD_MOD;
+	writeb_relaxed(ctrl, ioadr + SDHOST_8_HOST_CTRL);
+}
+
+/*#define SDHOST_8_PWR_CTRL     0x29    */ /* not used */
+#define SDHOST_8_BLK_GAP		0x2A	/* not used */
+#define SDHOST_8_WACKUP_CTRL	0x2B	/* not used */
+#define SDHOST_16_CLOCK_CTRL	0x2C
+#define __CLK_IN_EN		0x0001
+#define __CLK_IN_STABLE	0x0002
+#define __CLK_SD			0x0004
+#define __CLK_MAX_DIV		2046
+
+static inline void _sdhost_all_clk_off(void __iomem *ioadr)
+{
+	writew_relaxed(0, ioadr + SDHOST_16_CLOCK_CTRL);
+}
+
+static inline void _sdhost_sd_clk_off(void __iomem *ioadr)
+{
+	u16 ctrl = 0;
+
+	ctrl = readw_relaxed(ioadr + SDHOST_16_CLOCK_CTRL);
+	ctrl &= (~__CLK_SD);
+	writew_relaxed(ctrl, ioadr + SDHOST_16_CLOCK_CTRL);
+}
+
+static inline void _sdhost_sd_clk_on(void __iomem *ioadr)
+{
+	u16 ctrl = 0;
+
+	ctrl = readw_relaxed(ioadr + SDHOST_16_CLOCK_CTRL);
+	ctrl |= __CLK_SD;
+	writew_relaxed(ctrl, ioadr + SDHOST_16_CLOCK_CTRL);
+}
+
+static inline uint32_t _sdhost_calc_div(uint32_t base_clk, uint32_t clk)
+{
+	uint32_t N;
+
+	if (base_clk <= clk)
+		return 0;
+
+	N = (uint32_t) (base_clk / clk);
+	N = (N >> 1);
+	if (N)
+		N--;
+	if ((base_clk / ((N + 1) << 1)) > clk)
+		N++;
+	if (__CLK_MAX_DIV < N)
+		N = __CLK_MAX_DIV;
+	return N;
+}
+
+static inline void _sdhost_clk_set_and_on(void __iomem *ioadr, uint32_t div)
+{
+	u16 ctrl = 0;
+
+	writew_relaxed(0, ioadr + SDHOST_16_CLOCK_CTRL);
+	ctrl |= (uint16_t) (((div & 0x300) >> 2) | ((div & 0xFF) << 8));
+	ctrl |= __CLK_IN_EN;
+	writew_relaxed(ctrl, ioadr + SDHOST_16_CLOCK_CTRL);
+	while (!(__CLK_IN_STABLE & readw_relaxed(ioadr +
+						SDHOST_16_CLOCK_CTRL)))
+		;
+}
+
+#define SDHOST_8_TIMEOUT		0x2E
+#define __TIMEOUT_MAX_VAL		0xe
+static inline uint8_t _sdhost_calc_timeout(uint32_t base_clk,
+						uint32_t div, uint32_t seconds)
+{
+	uint32_t sd_clk = seconds * (base_clk / ((div + 1) << 1));
+	uint8_t i;
+
+	for (i = 0; i < 15; i++) {
+		if ((((uint32_t) 1) << (16 + i)) > sd_clk) {
+			if (0 != i)
+				i--;
+			break;
+		}
+	}
+	return i;
+}
+
+#define SDHOST_8_RESET			0x2F
+#define  _RST_ALL		0x01
+#define  _RST_CMD		0x02
+#define  _RST_DATA		0x04
+#define  _RST_EMMC		0x08	/*spredtrum define it byself */
+
+static inline void _sdhost_reset(void __iomem *ioadr, uint8_t mask)
+{
+	writeb_relaxed((_RST_EMMC | mask), ioadr + SDHOST_8_RESET);
+	while (_sdhost_readb(ioadr, SDHOST_8_RESET) & mask)
+		;
+}
+
+/* spredtrum define it byself */
+static inline void _sdhost_reset_emmc(void __iomem *ioadr)
+{
+	writeb_relaxed(0, ioadr + SDHOST_8_RESET);
+	mdelay(2);
+	writeb_relaxed(_RST_EMMC, ioadr + SDHOST_8_RESET);
+}
+
+#define SDHOST_32_INT_STATUS		0x30
+#define SDHOST_32_INT_STATUS_EN	0x34
+#define SDHOST_32_INT_SIGNAL_EN	0x38
+#define _INT_CMD_END		0x00000001
+#define _INT_TRAN_END		0x00000002
+#define _INT_DMA_END		0x00000008
+#define _INT_WR_RDY			0x00000010	/*not used */
+#define _INT_RD_RDY			0x00000020	/* not used */
+#define _INT_ERR				0x00008000
+#define _INT_ERR_CMD_TIMEOUT	0x00010000
+#define _INT_ERR_CMD_CRC		0x00020000
+#define _INT_ERR_CMD_END		0x00040000
+#define _INT_ERR_CMD_INDEX	0x00080000
+#define _INT_ERR_DATA_TIMEOUT	0x00100000
+#define _INT_ERR_DATA_CRC		0x00200000
+#define _INT_ERR_DATA_END		0x00400000
+#define _INT_ERR_CUR_LIMIT		0x00800000
+#define _INT_ERR_ACMD			0x01000000
+#define _INT_ERR_ADMA			0x02000000
+
+/* used in irq */
+#define _INT_FILTER_ERR_CMD \
+		(_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+		_INT_ERR_CMD_END | _INT_ERR_CMD_INDEX)
+#define _INT_FILTER_ERR_DATA \
+		(_INT_ERR_DATA_TIMEOUT | _INT_ERR_DATA_CRC | \
+		_INT_ERR_DATA_END)
+#define _INT_FILTER_ERR \
+		(_INT_ERR | _INT_FILTER_ERR_CMD | \
+		_INT_FILTER_ERR_DATA | _INT_ERR_ACMD | \
+		_INT_ERR_ADMA)
+#define _INT_FILTER_NORMAL \
+		(_INT_CMD_END | _INT_TRAN_END)
+
+/* used for setting */
+#define _DATA_FILTER_RD_SIGLE \
+		(_INT_TRAN_END | _INT_DMA_END | \
+		_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+		_INT_ERR_DATA_CRC | _INT_ERR_DATA_END)
+#define _DATA_FILTER_RD_MULTI \
+		(_INT_TRAN_END | _INT_DMA_END | _INT_ERR | \
+		_INT_ERR_DATA_TIMEOUT | _INT_ERR_DATA_CRC | \
+		_INT_ERR_DATA_END)
+#define _DATA_FILTER_WR_SIGLE \
+		(_INT_TRAN_END | _INT_DMA_END | \
+		_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+		_INT_ERR_DATA_CRC)
+#define _DATA_FILTER_WR_MULT \
+		(_INT_TRAN_END | _INT_DMA_END | \
+		_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+		_INT_ERR_DATA_CRC)
+#define _CMD_FILTER_R0 \
+		(_INT_CMD_END)
+#define _CMD_FILTER_R2 \
+		(_INT_CMD_END | _INT_ERR | \
+		_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+		_INT_ERR_CMD_END)
+#define _CMD_FILTER_R3 \
+		(_INT_CMD_END | _INT_ERR | \
+		_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_END)
+#define _CMD_FILTER_R1_R4_R5_R6_R7 \
+		(_INT_CMD_END | _INT_ERR | _INT_ERR_CMD_TIMEOUT | \
+		_INT_ERR_CMD_CRC | _INT_ERR_CMD_END | \
+		_INT_ERR_CMD_INDEX)
+#define _CMD_FILTER_R1B \
+		(_INT_CMD_END | _INT_ERR | \
+		_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+		_INT_ERR_CMD_END | _INT_ERR_CMD_INDEX | \
+		_INT_TRAN_END | _INT_ERR_DATA_TIMEOUT)
+
+
+static inline void _sdhost_disable_all_int(void __iomem *ioadr)
+{
+	writel_relaxed(0x0, ioadr + SDHOST_32_INT_SIGNAL_EN);
+	writel_relaxed(0x0, ioadr + SDHOST_32_INT_STATUS_EN);
+	writel_relaxed(0xFFFFFFFF, ioadr + SDHOST_32_INT_STATUS);
+}
+
+static inline void _sdhost_enable_int(void __iomem *ioadr, u32 mask)
+{
+	writel_relaxed(mask, ioadr + SDHOST_32_INT_STATUS_EN);
+	writel_relaxed(mask, ioadr + SDHOST_32_INT_SIGNAL_EN);
+}
+
+static inline void _sdhost_clear_int(void __iomem *ioadr, u32 mask)
+{
+	writel_relaxed(mask, ioadr + SDHOST_32_INT_STATUS);
+}
+
+#define SDHOST_16_ACMD_ERR		0x3C
+
+#define SDHOST_16_HOST_CTRL_2		0x3E
+#define __TIMING_MODE_SDR12		0x0000
+#define __TIMING_MODE_SDR25		0x0001
+#define __TIMING_MODE_SDR50		0x0002
+#define __TIMING_MODE_SDR104	0x0003
+#define __TIMING_MODE_DDR50	0x0004
+#define __TIMING_MODE_SDR200	0x0005
+
+static inline void _sdhost_set_uhs_mode(void __iomem *ioadr, uint16_t mode)
+{
+	writew_relaxed(mode, ioadr +  SDHOST_16_HOST_CTRL_2);
+}
+
+#define SDHOST_MAX_CUR	1020
+
+/* following register is defined by spreadtrum self.
+ * It is not standard register of SDIO.
+ */
+static inline void _sdhost_set_delay(
+				void __iomem *ioadr, uint32_t write_delay,
+				uint32_t read_pos_delay,
+				uint32_t read_neg_delay)
+{
+	writel_relaxed(write_delay, ioadr + 0x80);
+	writel_relaxed(read_pos_delay, ioadr + 0x84);
+	writel_relaxed(read_neg_delay, ioadr + 0x88);
+}
+
+#define SDHOST_32_CAPS	0x40
+#define  __TIMEOUT_CLK_MASK	0x0000003F
+#define  __TIMEOUT_CLK_SHIFT 0
+#define  __TIMEOUT_CLK_UNIT	0x00000080
+#define  __CLOCK_BASE_MASK	0x00003F00
+#define  __CLOCK_V3_BASE_MASK	0x0000FF00
+#define  __CLOCK_BASE_SHIFT	8
+#define  __MAX_BLOCK_MASK	0x00030000
+#define  __MAX_BLOCK_SHIFT  16
+#define  __CAN_DO_8BIT	0x00040000
+#define  __CAN_DO_ADMA2	0x00080000
+#define  __CAN_DO_ADMA1	0x00100000
+#define  __CAN_DO_HISPD	0x00200000
+#define  __CAN_DO_SDMA	0x00400000
+#define  __CAN_VDD_330	0x01000000
+#define  __CAN_VDD_300	0x02000000
+#define  __CAN_VDD_180	0x04000000
+#define  __CAN_64BIT	0x10000000
+
+#define SDHOST_32_CAPS2	0x44
+#define  __SUPPORT_SDR50	0x00000001
+#define  __SUPPORT_SDR104	0x00000002
+#define  __SUPPORT_DDR50	0x00000004
+#define  __DRIVER_TYPE_A	0x00000010
+#define  __DRIVER_TYPE_C	0x00000020
+#define  __DRIVER_TYPE_D	0x00000040
+#define  __RETUNING_TIMER_COUNT_MASK	0x00000F00
+#define  __RETUNING_TIMER_COUNT_SHIFT	8
+#define  __USE_SDR50_TUNING			0x00002000
+#define  __RETUNING_MODE_MASK		0x0000C000
+#define  __RETUNING_MODE_SHIFT		14
+#define  __CLOCK_MUL_MASK	0x00FF0000
+#define  __CLOCK_MUL_SHIFT	16
+
+
+/**********************************************************\
+ *
+ * Controller block structure
+ *
+\**********************************************************/
+struct sdhost_host {
+	/* --globe resource--- */
+	spinlock_t lock;
+	struct mmc_host *mmc;
+
+	/*--basic resource-- */
+	void __iomem *ioaddr;
+	int irq;
+	const char *device_name;
+	struct platform_device *pdev;
+	unsigned long mapbase;
+
+	int detect_gpio;
+	uint32_t ocr_avail;
+	char *clk_name;
+	char *clk_parent_name;
+	uint32_t base_clk;
+	uint32_t caps;
+	uint32_t caps2;
+	uint32_t pm_caps;
+	uint32_t write_delay;
+	uint32_t read_pos_delay;
+	uint32_t read_neg_delay;
+
+	/* --extern resource getted by base resource-- */
+	uint64_t dma_mask;
+	uint8_t data_time_out_val;
+	uint32_t signal_default_voltage;
+	bool sdio_1_8v_signal_enabled;
+	struct clk *clk;
+	struct clk *clk_parent;
+	struct tasklet_struct finish_tasklet;
+	struct timer_list timer;
+
+	/* --runtime param-- */
+	uint32_t int_filter;
+	struct mmc_ios ios;
+	struct mmc_request *mrq;	/* Current request */
+	struct mmc_command *cmd;	/* Current command */
+	uint16_t auto_cmd_mode;
+
+	/*--debugfs-- */
+	struct dentry *debugfs_root;
+};
+
+#endif /* __SDHOST_H_ */
diff --git a/drivers/mmc/host/sprd_sdhost_debugfs.c b/drivers/mmc/host/sprd_sdhost_debugfs.c
new file mode 100644
index 0000000..bc04aea
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost_debugfs.c
@@ -0,0 +1,213 @@
+/*
+ * linux/drivers/mmc/host/sprd_sdhost_debugfs.c - Secure Digital Host
+ * Controller Interface driver
+ *
+ * Copyright (C) 2015 Spreadtrum corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/mmc/host.h>
+
+#include "sprd_sdhost_debugfs.h"
+
+#define ELEMENT(v) {v, #v}
+#define ELEMENT_NUM	26
+struct {
+	uint32_t bit;
+	char *caps_name;
+} caps_info[3][ELEMENT_NUM] = {
+	{
+		ELEMENT(MMC_CAP_4_BIT_DATA),
+		ELEMENT(MMC_CAP_MMC_HIGHSPEED),
+		ELEMENT(MMC_CAP_SD_HIGHSPEED),
+		ELEMENT(MMC_CAP_SDIO_IRQ),
+		ELEMENT(MMC_CAP_SPI),
+		ELEMENT(MMC_CAP_NEEDS_POLL),
+		ELEMENT(MMC_CAP_8_BIT_DATA),
+		ELEMENT(MMC_CAP_AGGRESSIVE_PM),
+		ELEMENT(MMC_CAP_NONREMOVABLE),
+		ELEMENT(MMC_CAP_WAIT_WHILE_BUSY),
+		ELEMENT(MMC_CAP_ERASE),
+		ELEMENT(MMC_CAP_1_8V_DDR),
+		ELEMENT(MMC_CAP_1_2V_DDR),
+		ELEMENT(MMC_CAP_POWER_OFF_CARD),
+		ELEMENT(MMC_CAP_BUS_WIDTH_TEST),
+		ELEMENT(MMC_CAP_UHS_SDR12),
+		ELEMENT(MMC_CAP_UHS_SDR25),
+		ELEMENT(MMC_CAP_UHS_SDR50),
+		ELEMENT(MMC_CAP_UHS_SDR104),
+		ELEMENT(MMC_CAP_UHS_DDR50),
+		ELEMENT(MMC_CAP_RUNTIME_RESUME),
+		ELEMENT(MMC_CAP_DRIVER_TYPE_A),
+		ELEMENT(MMC_CAP_DRIVER_TYPE_C),
+		ELEMENT(MMC_CAP_DRIVER_TYPE_D),
+		ELEMENT(MMC_CAP_CMD23),
+		ELEMENT(MMC_CAP_HW_RESET)
+	}, {
+		ELEMENT(MMC_CAP2_BOOTPART_NOACC),
+		ELEMENT(MMC_CAP2_FULL_PWR_CYCLE),
+		ELEMENT(MMC_CAP2_HS200_1_8V_SDR),
+		ELEMENT(MMC_CAP2_HS200_1_2V_SDR),
+		ELEMENT(MMC_CAP2_HS200),
+		ELEMENT(MMC_CAP2_HC_ERASE_SZ),
+		ELEMENT(MMC_CAP2_CD_ACTIVE_HIGH),
+		ELEMENT(MMC_CAP2_RO_ACTIVE_HIGH),
+		ELEMENT(MMC_CAP2_PACKED_RD),
+		ELEMENT(MMC_CAP2_PACKED_WR),
+		ELEMENT(MMC_CAP2_PACKED_CMD),
+		ELEMENT(MMC_CAP2_NO_PRESCAN_POWERUP),
+		ELEMENT(MMC_CAP2_HS400_1_8V),
+		ELEMENT(MMC_CAP2_HS400_1_2V),
+		ELEMENT(MMC_CAP2_HS400),
+		ELEMENT(MMC_CAP2_SDIO_IRQ_NOTHREAD)
+	}, {
+		ELEMENT(MMC_PM_KEEP_POWER),
+		ELEMENT(MMC_PM_WAKE_SDIO_IRQ),
+		ELEMENT(MMC_PM_IGNORE_PM_NOTIFY)
+	}
+
+};
+
+static int sdhost_param_show(struct seq_file *s, void *data)
+{
+	struct sdhost_host *host = s->private;
+	uint32_t i;
+
+	seq_printf(s, "\n"
+		   "ioaddr\t= 0x%p\n"
+		   "irq\t= %d\n"
+		   "device_name\t= %s\n"
+		   "detect_gpio\t= %d\n"
+		   "base_clk\t= %d\n"
+		   "write_delay\t= %d\n"
+		   "read_pos_delay\t= %d\n"
+		   "read_neg_delay\t= %d\n",
+		   host->ioaddr, host->irq, host->device_name,
+		   host->detect_gpio, host->base_clk,
+		   host->write_delay, host->read_pos_delay,
+		   host->read_neg_delay);
+	seq_printf(s, "OCR 0x%x\n", host->ocr_avail);
+
+	for (i = 0; i < ELEMENT_NUM; i++) {
+		if ((caps_info[0][i].bit ==
+			(host->caps & caps_info[0][i].bit))
+					&& caps_info[0][i].bit)
+			seq_printf(s, "caps:%s\n", caps_info[0][i].caps_name);
+	}
+	for (i = 0; i < ELEMENT_NUM; i++) {
+		if ((caps_info[1][i].bit ==
+			(host->caps2 & caps_info[1][i].bit))
+						&& caps_info[1][i].bit)
+			seq_printf(s, "caps2:%s\n", caps_info[1][i].caps_name);
+	}
+	for (i = 0; i < ELEMENT_NUM; i++) {
+		if ((caps_info[2][i].bit ==
+				(host->pm_caps & caps_info[2][i].bit))
+							&& caps_info[2][i].bit)
+			seq_printf(s, "pm_caps:%s\n",
+					caps_info[2][i].caps_name);
+	}
+
+	return 0;
+}
+
+static int sdhost_param_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sdhost_param_show, inode->i_private);
+}
+
+static const struct file_operations sdhost_param_fops = {
+	.open = sdhost_param_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+#define SDHOST_ATTR(PARAM_NAME)	\
+	static int sdhost_##PARAM_NAME##_get(void *data, u64 *val)\
+	{ \
+		struct sdhost_host *host = data;\
+		*val = (u64)host->PARAM_NAME;\
+		return 0;\
+	} \
+	static int sdhost_##PARAM_NAME##_set(void *data, u64 val)\
+	{ \
+		struct sdhost_host *host = data;\
+		if (0x7F >= (uint32_t)val) { \
+			host->PARAM_NAME = (uint32_t)val;\
+			_sdhost_set_delay(host->ioaddr, \
+							host->write_delay, \
+							host->read_pos_delay, \
+							host->read_neg_delay);\
+		} \
+		return 0;\
+	} \
+	DEFINE_SIMPLE_ATTRIBUTE(sdhost_##PARAM_NAME##_fops,\
+						sdhost_##PARAM_NAME##_get,\
+						sdhost_##PARAM_NAME##_set,\
+						"%llu\n")
+
+SDHOST_ATTR(write_delay);
+SDHOST_ATTR(read_pos_delay);
+SDHOST_ATTR(read_neg_delay);
+
+void sdhost_add_debugfs(struct sdhost_host *host)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(host->device_name, NULL);
+	if (IS_ERR(root))
+		/* Don't complain -- debugfs just isn't enabled */
+		return;
+	if (!root)
+		return;
+
+	host->debugfs_root = root;
+
+	if (!debugfs_create_file("basic_resource", S_IRUSR, root,
+				(void *)host, &sdhost_param_fops))
+		goto err;
+	if (!debugfs_create_file("write_delay", S_IRUSR | S_IWUSR, root,
+				(void *)host, &sdhost_write_delay_fops))
+		goto err;
+	if (!debugfs_create_file("read_pos_delay", S_IRUSR | S_IWUSR, root,
+				(void *)host, &sdhost_read_pos_delay_fops))
+		goto err;
+	if (!debugfs_create_file("read_neg_delay", S_IRUSR | S_IWUSR, root,
+				(void *)host, &sdhost_read_neg_delay_fops))
+		goto err;
+	return;
+
+err:
+	debugfs_remove_recursive(root);
+	host->debugfs_root = 0;
+}
+
+void dump_sdio_reg(struct sdhost_host *host)
+{
+	unsigned int i;
+
+	if (!host->mmc->card)
+		return;
+
+	pr_info("sdhost" ": =========== REGISTER DUMP (%s)========\n",
+		host->device_name);
+
+	for (i = 0; i < 0x09; i++) {
+		pr_info("sdhost" ": 0x%08x | 0x%08x | 0x%08x | 0x%08x\n\r",
+		       _sdhost_readl(host->ioaddr, 0 + (i << 4)),
+		       _sdhost_readl(host->ioaddr, 4 + (i << 4)),
+		       _sdhost_readl(host->ioaddr, 8 + (i << 4)),
+		       _sdhost_readl(host->ioaddr, 12 + (i << 4))
+		    );
+	}
+
+	pr_info("sdhost" ": ==================================\n");
+	mdelay(100);
+}
diff --git a/drivers/mmc/host/sprd_sdhost_debugfs.h b/drivers/mmc/host/sprd_sdhost_debugfs.h
new file mode 100644
index 0000000..0063e1b
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost_debugfs.h
@@ -0,0 +1,27 @@
+/*
+ * linux/drivers/mmc/host/sprd_sdhost_debugfs.h - Secure Digital Host Controller
+ * Interface driver
+ *
+ * Copyright (C) 2015 Spreadtrum corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+
+#ifndef _SDHOST_DEBUGFS_H_
+#define _SDHOST_DEBUGFS_H_
+
+#include "sprd_sdhost.h"
+
+#ifdef CONFIG_DEBUG_FS
+void sdhost_add_debugfs(struct sdhost_host *host);
+void dump_sdio_reg(struct sdhost_host *host);
+#else
+static inline void sdhost_add_debugfs(struct sdhost_host *host) {}
+static inline void dump_sdio_reg(struct sdhost_host *host) {}
+#endif
+
+#endif
-- 
1.7.9.5
