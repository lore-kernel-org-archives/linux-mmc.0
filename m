From: Hongtao Wu <wuht06@gmail.com>
Subject: [RFC PATCH v3 1/3] mmc: sprd: Add MMC host driver for Spreadtrum SoC
Date: Sat, 15 Aug 2015 00:55:51 +0800
Message-ID: <1439571353-30165-2-git-send-email-wuht06@gmail.com>
References: <y>
 <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com
Cc: Orson.Zhai@spreadtrum.com, Chunyan.Zhang@spreadtrum.com, Jason.Wu@spreadtrum.com
List-Id: linux-mmc@vger.kernel.org

the Spreadtrum MMC host driver is used to supply EMMC, SD, and
SDIO types of memory cards

Signed-off-by: Billows Wu(WuHongtao) <wuht06@gmail.com>
---
 drivers/mmc/host/Kconfig               |    6 +
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sprd_sdhost.c         | 1202 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sprd_sdhost.h         |  615 ++++++++++++++++
 drivers/mmc/host/sprd_sdhost_debugfs.c |  212 ++++++
 drivers/mmc/host/sprd_sdhost_debugfs.h |   27 +
 6 files changed, 2063 insertions(+)
 create mode 100644 drivers/mmc/host/sprd_sdhost.c
 create mode 100644 drivers/mmc/host/sprd_sdhost.h
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.c
 create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fd9a58e..c43d938 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -264,6 +264,12 @@ config MMC_SDHCI_SPEAR

 	  If you have a controller with this interface, say Y or M here.

+config SPRD_MMC_SDHOST
+	tristate "Spreadtrum SDIO host Controller support"
+	help
+	  This selects the SDIO Host Controller in spreadtrum platform
+
+	  If you have a controller with this interface, say Y or M here.
 	  If unsure, say N.

 config MMC_SDHCI_S3C_DMA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e928d61..e00227f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
+obj-$(CONFIG_SPRD_MMC_SDHOST)		+= sprd_sdhost.o sprd_sdhost_debugfs.o

 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sprd_sdhost.c b/drivers/mmc/host/sprd_sdhost.c
new file mode 100644
index 0000000..95639a3
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost.c
@@ -0,0 +1,1202 @@
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
+	u32 ocr_avail;
+	u32 caps;
+	u32 caps2;
+	u32 pm_caps;
+	u32 base_clk;
+	u32 signal_default_voltage;
+};
+
+struct sdhost_caps_data caps_info_map[] = {
+	{
+		.name = "sd",
+		.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
+		.caps = SDHOST_CAPS,
+		.caps2 = MMC_CAP2_HC_ERASE_SZ,
+		.signal_default_voltage = 3000000,
+	},
+	{
+		.name = "wifi",
+		.ocr_avail = MMC_VDD_165_195 | MMC_VDD_29_30 |
+			MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
+		.caps = SDHOST_CAPS | MMC_CAP_POWER_OFF_CARD |
+			MMC_CAP_UHS_SDR12,
+	},
+	{
+		.name = "emmc",
+		.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
+		.caps = SDHOST_CAPS |
+			MMC_CAP_8_BIT_DATA | MMC_CAP_UHS_SDR12 |
+			MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_DDR50 |
+			MMC_CAP_MMC_HIGHSPEED,
+		.signal_default_voltage = 1800000,
+	}
+};
+
+#ifdef CONFIG_PM_RUNTIME
+static void _pm_runtime_setting(struct platform_device *pdev,
+				struct sdhost_host *host);
+#else
+static void _pm_runtime_setting(struct platform_device *pdev,
+				struct sdhost_host *host)
+{
+}
+#endif
+
+static void _reset_ios(struct sdhost_host *host)
+{
+	_sdhost_disable_all_int(host);
+
+	host->ios.clock = 0;
+	host->ios.vdd = 0;
+	host->ios.power_mode = MMC_POWER_OFF;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
+
+	_sdhost_reset(host, _RST_ALL);
+	_sdhost_set_delay(host, host->write_delay,
+			  host->read_pos_delay, host->read_neg_delay);
+}
+
+static int __local_pm_suspend(struct sdhost_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	_sdhost_disable_all_int(host);
+	_sdhost_all_clk_off(host);
+	/* wake lock */
+	spin_unlock_irqrestore(&host->lock, flags);
+	clk_disable(host->clk);
+	clk_unprepare(host->clk);
+	synchronize_irq(host->irq);
+
+	return 0;
+}
+
+static int __local_pm_resume(struct sdhost_host *host)
+{
+	unsigned long flags;
+
+	clk_prepare(host->clk);
+	clk_enable(host->clk);
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->ios.clock) {
+		_sdhost_sd_clk_off(host);
+		_sdhost_clk_set_and_on(host,
+				       _sdhost_calc_div(host->base_clk,
+							host->ios.clock));
+		_sdhost_sd_clk_on(host);
+	}
+	_sdhost_set_delay(host, host->write_delay,
+			  host->read_pos_delay, host->read_neg_delay);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static void _pm_runtime_setting(struct platform_device *pdev,
+				struct sdhost_host *host)
+{
+	pm_runtime_set_active(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, true);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+}
+#endif
+
+static int _runtime_get(struct sdhost_host *host)
+{
+	return pm_runtime_get_sync(host->mmc->parent);
+}
+
+static int _runtime_put(struct sdhost_host *host)
+{
+	pm_runtime_mark_last_busy(host->mmc->parent);
+	return pm_runtime_put_autosuspend(host->mmc->parent);
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static int _runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	return __local_pm_suspend(host);
+}
+
+static int _runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	return __local_pm_resume(host);
+}
+
+static int _runtime_idle(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int _pm_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+	    container_of(dev, struct platform_device, dev);
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+
+	_runtime_get(host);
+	host->mmc->pm_flags = host->mmc->pm_caps;
+
+	return __local_pm_suspend(host);
+}
+
+static int _pm_resume(struct device *dev)
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
+	_runtime_put(host);
+
+	return 0;
+}
+#endif
+
+static void __get_rsp(struct sdhost_host *host)
+{
+	u32 i, offset;
+	unsigned int flags = host->cmd->flags;
+	u32 *resp = host->cmd->resp;
+
+	if (!(flags & MMC_RSP_PRESENT))
+		return;
+
+	if (flags & MMC_RSP_136) {
+		/* CRC is stripped so we need to do some shifting. */
+		for (i = 0, offset = 12; i < 3; i++, offset -= 4) {
+			resp[i] =
+			    _sdhost_readl(host,
+					  SDHOST_32_RESPONSE + offset) << 8;
+			resp[i] |=
+			    _sdhost_readb(host,
+					  SDHOST_32_RESPONSE + offset - 1);
+		}
+		resp[3] = _sdhost_readl(host, SDHOST_32_RESPONSE) << 8;
+	} else {
+		resp[0] = _sdhost_readl(host, SDHOST_32_RESPONSE);
+	}
+}
+
+static void _send_cmd(struct sdhost_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+	int sg_cnt;
+	u32 flag = 0;
+	u16 rsp_type = 0;
+	int if_has_data = 0;
+	int if_mult = 0;
+	int if_read = 0;
+	int if_dma = 0;
+	u16 auto_cmd = __ACMD_DIS;
+
+	pr_debug("%s(%s)  CMD%d, arg 0x%x, flag 0x%x\n", __func__,
+	       host->device_name, cmd->opcode, cmd->arg, cmd->flags);
+	if (cmd->data)
+		pr_debug("%s(%s) block size %d, cnt %d\n", __func__,
+		       host->device_name, cmd->data->blksz, cmd->data->blocks);
+
+	_sdhost_disable_all_int(host);
+
+	if (MMC_ERASE == cmd->opcode) {
+		/* if it is erase command , it's busy time will long,
+		 * so we set long timeout value here.
+		 */
+		mod_timer(&host->timer, jiffies +
+			msecs_to_jiffies(host->mmc->max_busy_timeout + 1000));
+		_sdhost_writeb(host->ioaddr,
+			__DATA_TIMEOUT_MAX_VAL, SDHOST_8_TIMEOUT);
+	} else {
+		mod_timer(&host->timer,
+			jiffies + (SDHOST_MAX_TIMEOUT + 1) * HZ);
+		_sdhost_writeb(host, host->data_timeout_val, SDHOST_8_TIMEOUT);
+	}
+
+	host->cmd = cmd;
+	if (data) {
+		/* set data param */
+		WARN_ON((data->blksz * data->blocks > 524288) ||
+			(data->blksz > host->mmc->max_blk_size) ||
+			(data->blocks > 65535));
+
+		data->bytes_xfered = 0;
+
+		if_has_data = 1;
+		if_read = (data->flags & MMC_DATA_READ);
+		if_mult = (mmc_op_multi(cmd->opcode) || data->blocks > 1);
+		if (if_read && !if_mult)
+			flag = _DATA_FILTER_RD_SIGLE;
+		else if (if_read && if_mult)
+			flag = _DATA_FILTER_RD_MULTI;
+		else if (!if_read && !if_mult)
+			flag = _DATA_FILTER_WR_SIGLE;
+		else
+			flag = _DATA_FILTER_WR_MULT;
+
+		if (!host->auto_cmd_mode)
+			flag |= _INT_ERR_ACMD;
+
+		if_dma = 1;
+		auto_cmd = host->auto_cmd_mode;
+		_sdhost_set_blk_size(host, data->blksz);
+
+		sg_cnt = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				    (data->flags & MMC_DATA_READ) ?
+				    DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		if (1 == sg_cnt) {
+			_sdhost_set_dma(host, __SDMA_MOD);
+			_sdhost_set_16_blk_cnt(host, data->blocks);
+			_sdhost_writel(host, sg_dma_address(data->sg),
+				       SDHOST_32_SYS_ADDR);
+		} else {
+			flag |= _INT_ERR_ADMA;
+			_sdhost_set_dma(host, __32ADMA_MOD);
+			_sdhost_set_32_blk_cnt(host, data->blocks);
+			_sdhost_writel(host, sg_dma_address(data->sg),
+				       SDHOST_32_SYS_ADDR);
+		}
+	}
+
+	_sdhost_writel(host, cmd->arg, SDHOST_32_ARG);
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
+	case MMC_RSP_R4:
+		rsp_type = _RSP3_4;
+		flag |= _CMD_FILTER_R1_R4_R5_R6_R7;
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1 & ~MMC_RSP_CRC:
+		rsp_type = _RSP1_5_6_7;
+		flag |= _CMD_FILTER_R1_R4_R5_R6_R7;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	host->int_filter = flag;
+	_sdhost_enable_int(host, flag);
+	pr_debug("sdhost %s CMD%d rsp:0x%x intflag:0x%x\n"
+	       "if_mult:0x%x if_read:0x%x auto_cmd:0x%x if_dma:0x%x\n",
+	       host->device_name, cmd->opcode, mmc_resp_type(cmd),
+	       flag, if_mult, if_read, auto_cmd, if_dma);
+
+	_sdhost_set_trans_and_cmd(host, if_mult, if_read, auto_cmd, if_mult,
+				  if_dma, cmd->opcode, if_has_data, rsp_type);
+}
+
+static irqreturn_t _irq(int irq, void *param)
+{
+	u32 intmask;
+	struct sdhost_host *host = (struct sdhost_host *)param;
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data;
+
+	spin_lock(&host->lock);
+	/* maybe _timeout() run in one core and _irq() run in
+	 * another core, this will panic if access cmd->data
+	 */
+	if ((!mrq) || (!cmd)) {
+		spin_unlock(&host->lock);
+		return IRQ_NONE;
+	}
+	data = cmd->data;
+
+	intmask = _sdhost_readl(host, SDHOST_32_INT_ST);
+	if (!intmask) {
+		spin_unlock(&host->lock);
+		return IRQ_NONE;
+	}
+	pr_debug("%s(%s) CMD%d, intmask 0x%x, filter = 0x%x\n", __func__,
+	       host->device_name, cmd->opcode, intmask, host->int_filter);
+
+	/* sometimes an undesired interrupt will happen, so we must clear
+     * this unused interrupt.
+     */
+	_sdhost_clear_int(host, intmask);
+	/* just care about the interrupt that we want */
+	intmask &= host->int_filter;
+
+	while (intmask) {
+		if (_INT_FILTER_ERR & intmask) {
+			/* some error happened in command */
+			if (_INT_FILTER_ERR_CMD & intmask) {
+				if (_INT_ERR_CMD_TIMEOUT & intmask)
+					cmd->error = -ETIMEDOUT;
+				else
+					cmd->error = -EILSEQ;
+			}
+			/* some error happened in data token or command
+			 * with R1B
+			 */
+			if (_INT_FILTER_ERR_DATA & intmask) {
+				if (data) {
+					/* current error is happened in data
+					 * token
+					 */
+					if (_INT_ERR_DATA_TIMEOUT & intmask)
+						data->error = -ETIMEDOUT;
+					else
+						data->error = -EILSEQ;
+				} else {
+					/* current error is happend in response
+					 * with busy
+					 */
+					if (_INT_ERR_DATA_TIMEOUT & intmask)
+						cmd->error = -ETIMEDOUT;
+					else
+						cmd->error = -EILSEQ;
+				}
+			}
+			if (_INT_ERR_ACMD & intmask) {
+				/* Auto cmd12 and cmd23 error is belong to data
+				 * token error
+				 */
+				data->error = -EILSEQ;
+			}
+			if (_INT_ERR_ADMA & intmask)
+				data->error = -EIO;
+
+			pr_debug("sdhost %s int 0x%x\n", host->device_name,
+				 intmask);
+			dump_sdio_reg(host);
+			_sdhost_disable_all_int(host);
+			/* if current error happened in data token,
+			 * we send cmd12 to stop it
+			 */
+			if ((mrq->cmd == cmd) && (mrq->stop)) {
+				_sdhost_reset(host, _RST_CMD | _RST_DATA);
+				_send_cmd(host, mrq->stop);
+			} else {
+				/* request finish with error, so reset it and
+				 * stop the request
+				 */
+				_sdhost_reset(host, _RST_CMD | _RST_DATA);
+				tasklet_schedule(&host->finish_tasklet);
+			}
+			goto out;
+		} else {
+			/* delete irq that wanted in filter */
+			host->int_filter &= ~(_INT_FILTER_NORMAL & intmask);
+			if (_INT_DMA_END & intmask) {
+				_sdhost_writel(host,
+					_sdhost_readl(host, SDHOST_32_SYS_ADDR),
+					SDHOST_32_SYS_ADDR);
+			}
+			if (_INT_CMD_END & intmask) {
+				cmd->error = 0;
+				__get_rsp(host);
+			}
+			if (_INT_TRAN_END & intmask) {
+				if (data) {
+					dma_unmap_sg(mmc_dev(host->mmc),
+						data->sg, data->sg_len,
+						(data->flags & MMC_DATA_READ) ?
+						DMA_FROM_DEVICE :
+						DMA_TO_DEVICE);
+					data->error = 0;
+					data->bytes_xfered =
+					data->blksz * data->blocks;
+				} else {
+					/* R1B also can produce transferComplete
+					 * interrupt
+					 */
+					cmd->error = 0;
+				}
+			}
+			if (!(_INT_FILTER_NORMAL & host->int_filter)) {
+				/* current cmd finished */
+				_sdhost_disable_all_int(host);
+				if (mrq->sbc == cmd) {
+					_send_cmd(host, mrq->cmd);
+				} else if ((mrq->cmd == host->cmd)
+					   && (mrq->stop)) {
+					_send_cmd(host, mrq->stop);
+				} else {
+					/* finish with success and stop the
+					 * request
+					 */
+					tasklet_schedule(&host->finish_tasklet);
+					goto out;
+				}
+			}
+		}
+
+		intmask = _sdhost_readl(host, SDHOST_32_INT_ST);
+		_sdhost_clear_int(host, intmask);
+		intmask &= host->int_filter;
+	};
+
+out:
+	spin_unlock(&host->lock);
+	return IRQ_HANDLED;
+}
+
+static void _tasklet(unsigned long param)
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
+static void _timeout(unsigned long data)
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
+		_sdhost_disable_all_int(host);
+		_sdhost_reset(host, _RST_CMD | _RST_DATA);
+		tasklet_schedule(&host->finish_tasklet);
+	}
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void sdhost_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
+	pr_debug("%s(%s) CMD%d request %d %d %d\n",
+		__func__, host->device_name, mrq->cmd->opcode,
+	       !!mrq->sbc, !!mrq->cmd, !!mrq->stop);
+	host->auto_cmd_mode = __ACMD_DIS;
+	if (!mrq->sbc && mrq->stop && SDHOST_FLAG_ENABLE_ACMD12) {
+		host->auto_cmd_mode = __ACMD12;
+		mrq->data->stop = NULL;
+		mrq->stop = NULL;
+	}
+
+	/* 3 send cmd list */
+	if ((mrq->sbc) && SDHOST_FLAG_ENABLE_ACMD23) {
+		host->auto_cmd_mode = __ACMD23;
+		mrq->data->stop = NULL;
+		mrq->stop = NULL;
+		_send_cmd(host, mrq->cmd);
+	} else if (mrq->sbc) {
+		mrq->data->stop = NULL;
+		mrq->stop = NULL;
+		_send_cmd(host, mrq->sbc);
+	} else {
+		_send_cmd(host, mrq->cmd);
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void _signal_voltage_on_off(struct sdhost_host *host, u32 on_off)
+{
+	if (!host->mmc->supply.vqmmc) {
+		pr_debug("%s(%s) there is no signal voltage!\n",
+			 __func__, host->device_name);
+		return;
+	}
+
+	if (on_off && (!host->sdio_1_8v_signal_enabled)) {
+		if (!regulator_enable(host->mmc->supply.vqmmc) &&
+		    regulator_is_enabled(host->mmc->supply.vqmmc)) {
+			host->sdio_1_8v_signal_enabled = true;
+			pr_debug("%s(%s) signal voltage enable success!\n",
+				 __func__, host->device_name);
+		} else
+			pr_debug("%s(%s) signal voltage enable fail!\n",
+				 __func__, host->device_name);
+
+	} else if (!on_off && host->sdio_1_8v_signal_enabled) {
+		if (!regulator_disable(host->mmc->supply.vqmmc) &&
+		    !regulator_is_enabled(host->mmc->supply.vqmmc)) {
+			host->sdio_1_8v_signal_enabled = false;
+			pr_debug("%s(%s) signal voltage disable success!\n",
+				 __func__, host->device_name);
+		} else
+			pr_debug("%s(%s) signal voltage disable fail\n",
+				 __func__, host->device_name);
+	}
+}
+
+/*
+ * 1 This votage is always poweron
+ * 2 initial votage is 2.7v~3.6v
+ * 3 It can be reconfig to 1.7v~1.95v
+ */
+static int sdhost_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int err;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!mmc->supply.vqmmc) {
+		/* there are no 1.8v signal votage. */
+		spin_unlock_irqrestore(&host->lock, flags);
+		_runtime_put(host);
+		err = 0;
+		pr_debug("sdhost %s There is no signalling voltage\n",
+			 host->device_name);
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
+	if (err)
+		WARN(err, "Switching to signalling voltage  failed\n");
+
+	return err;
+}
+
+static void sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
+
+	if (0 == ios->clock) {
+		_sdhost_all_clk_off(host);
+		host->ios.clock = 0;
+	} else if (ios->clock != host->ios.clock) {
+		u32 div;
+
+		div = _sdhost_calc_div(host->base_clk, ios->clock);
+		_sdhost_sd_clk_off(host);
+		_sdhost_clk_set_and_on(host, div);
+		_sdhost_sd_clk_on(host);
+		host->ios.clock = ios->clock;
+		host->data_timeout_val =
+		    _sdhost_calc_timeout(host->base_clk, SDHOST_MAX_TIMEOUT);
+		mmc->max_busy_timeout = (1 << 30) / (ios->clock / 1000);
+	}
+
+	if (ios->power_mode != host->ios.power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			spin_unlock_irqrestore(&host->lock, flags);
+			_signal_voltage_on_off(host, 0);
+			if (mmc->supply.vmmc)
+				mmc_regulator_set_ocr(host->mmc,
+						mmc->supply.vmmc, 0);
+			spin_lock_irqsave(&host->lock, flags);
+			_reset_ios(host);
+			host->ios.power_mode = ios->power_mode;
+			break;
+		case MMC_POWER_ON:
+		case MMC_POWER_UP:
+			spin_unlock_irqrestore(&host->lock, flags);
+			if (mmc->supply.vmmc)
+				mmc_regulator_set_ocr(host->mmc,
+						      mmc->supply.vmmc,
+						      ios->vdd);
+			_signal_voltage_on_off(host, 1);
+			spin_lock_irqsave(&host->lock, flags);
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
+		spin_unlock_irqrestore(&host->lock, flags);
+		if (mmc->supply.vmmc) {
+			pr_info("sdhost %s 3.0 %d!\n",
+				host->device_name, ios->vdd);
+			mmc_regulator_set_ocr(host->mmc,
+					      mmc->supply.vmmc, ios->vdd);
+		}
+		spin_lock_irqsave(&host->lock, flags);
+		host->ios.vdd = ios->vdd;
+	}
+
+	if (ios->bus_width != host->ios.bus_width) {
+		_sdhost_set_buswidth(host, ios->bus_width);
+		host->ios.bus_width = ios->bus_width;
+	}
+
+	if (ios->timing != host->ios.timing) {
+		/* 1 first close SD clock */
+		_sdhost_sd_clk_off(host);
+		/* 2 set timing mode */
+		switch (ios->timing) {	/* timing specification used */
+		case MMC_TIMING_LEGACY:
+			/* basic clock mode */
+			_sdhost_set_uhs_mode(host, __TIMING_MODE_SDR12);
+			break;
+		case MMC_TIMING_MMC_HS:
+		case MMC_TIMING_SD_HS:
+			_sdhost_set_uhs_mode(host, __TIMING_MODE_SDR12);
+			break;
+		case MMC_TIMING_UHS_SDR12:
+		case MMC_TIMING_UHS_SDR25:
+		case MMC_TIMING_UHS_SDR50:
+		case MMC_TIMING_UHS_SDR104:
+		case MMC_TIMING_UHS_DDR50:
+		case MMC_TIMING_MMC_HS200:
+			_sdhost_set_uhs_mode(host, ios->timing -
+					     MMC_TIMING_UHS_SDR12 +
+					     __TIMING_MODE_SDR12);
+			break;
+		default:
+			break;
+		}
+		/* 3 open SD clock */
+		_sdhost_sd_clk_on(host);
+		host->ios.timing = ios->timing;
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+}
+
+static int sdhost_get_ro(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+	/* read & write */
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+	return 0;
+}
+
+static int sdhost_get_cd(struct mmc_host *mmc)
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
+static int sdhost_card_busy(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 present_state;
+
+	_runtime_get(host);
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* Check whether DAT[3:0] is 0000 */
+	present_state = _sdhost_readl(host, SDHOST_32_PRES_STATE);
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+	_runtime_put(host);
+
+	return !(present_state & _DATA_LVL_MASK);
+}
+
+static void sdhost_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhost_host *host = mmc_priv(mmc);
+
+	_runtime_get(host);
+
+	/* close LDO and open LDO again. */
+	_signal_voltage_on_off(host, 0);
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc,
+				      host->ios.vdd);
+
+	_signal_voltage_on_off(host, 1);
+	mmiowb();
+	_runtime_put(host);
+}
+
+static const struct mmc_host_ops sdhost_ops = {
+	.request = sdhost_request,
+	.set_ios = sdhost_set_ios,
+	.get_ro = sdhost_get_ro,
+	.get_cd = sdhost_get_cd,
+	.start_signal_voltage_switch = sdhost_set_vqmmc,
+	.card_busy = sdhost_card_busy,
+	.hw_reset = sdhost_hw_reset,
+};
+
+static int get_caps_info(struct sdhost_host *host)
+{
+	struct sdhost_caps_data *pdata = NULL;
+	int index;
+	int ret;
+
+	for (index = 0; index < sizeof(caps_info_map) /
+		sizeof(struct sdhost_caps_data); index++) {
+		if (strcmp(host->device_name, caps_info_map[index].name) == 0) {
+			pdata = &caps_info_map[index];
+			break;
+		}
+	}
+
+	host->ocr_avail = pdata->ocr_avail;
+	host->caps = pdata->caps;
+	host->caps2 = pdata->caps2;
+	host->pm_caps = pdata->pm_caps;
+	host->signal_default_voltage = pdata->signal_default_voltage;
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		pr_err("parse sprd %s controller fail\n", host->device_name);
+
+	return ret;
+}
+
+static int _get_dt_resource(struct platform_device *pdev,
+			       struct sdhost_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 sdhost_delay[3];
+	int ret = 0;
+
+	host->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!host->res)
+		return -ENOENT;
+
+	host->ioaddr = devm_ioremap_resource(&pdev->dev, host->res);
+	if (IS_ERR(host->ioaddr)) {
+		ret = PTR_ERR(host->ioaddr);
+		dev_err(&pdev->dev, "can not map iomem: %d\n", ret);
+		goto err;
+	}
+
+	host->mapbase = host->res->start;
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		ret = host->irq;
+		goto err;
+	}
+
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(host->clk)) {
+		ret = PTR_ERR(host->clk);
+		dev_err(&pdev->dev, "can not get clock: %d\n", ret);
+		goto err;
+	}
+
+	host->base_clk = clk_get_rate(host->clk);
+
+	ret = of_property_read_string(np, "sprd,name", &host->device_name);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can not read the property of sprd name\n");
+		goto err;
+	}
+
+	ret = get_caps_info(host);
+	if (ret)
+		goto err;
+
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
+		dev_err(&pdev->dev,
+			"can not read the property of sprd delay\n");
+
+	return 0;
+
+err:
+	dev_err(&pdev->dev, "sprd_sdhost get basic resource fail\n");
+	return ret;
+}
+
+static int _get_ext_resource(struct sdhost_host *host)
+{
+	int err;
+	struct mmc_host *mmc = host->mmc;
+
+	host->dma_mask = DMA_BIT_MASK(64);
+	host->data_timeout_val = 0;
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
+					       host->signal_default_voltage,
+					       host->signal_default_voltage);
+		regulator_set_voltage(mmc->supply.vqmmc,
+				      host->signal_default_voltage,
+				      host->signal_default_voltage);
+	}
+	host->mmc = mmc;
+
+	/* 2 clock */
+	clk_prepare_enable(host->clk);
+
+	/* 3 reset sdio */
+	_reset_ios(host);
+	err = devm_request_irq(&host->pdev->dev, host->irq, _irq,
+			       IRQF_SHARED, mmc_hostname(host->mmc), host);
+	if (err) {
+		pr_err("%s: can not request irq\n", host->device_name);
+		goto err_clk_disable;
+	}
+
+	tasklet_init(&host->finish_tasklet, _tasklet, (unsigned long)host);
+	/* 4 init timer */
+	setup_timer(&host->timer, _timeout, (unsigned long)host);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(host->clk);
+	return err;
+}
+
+static void _set_mmc_struct(struct sdhost_host *host, struct mmc_host *mmc)
+{
+	mmc = host->mmc;
+	mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
+	mmc->ops = &sdhost_ops;
+	mmc->f_max = host->base_clk;
+	mmc->f_min = (unsigned int)(host->base_clk / __CLK_MAX_DIV);
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
+	pr_info("%s(%s): ocr avail = 0x%x\n"
+		"base clock = %u, pm_caps = 0x%x\n"
+		"caps: 0x%x, caps2: 0x%x\n",
+		__func__, host->device_name, mmc->ocr_avail,
+		host->base_clk, host->pm_caps, mmc->caps, mmc->caps2);
+}
+
+static int sdhost_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct sdhost_host *host;
+	int ret;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	/* globe resource */
+	mmc = mmc_alloc_host(sizeof(struct sdhost_host), &pdev->dev);
+	if (!mmc) {
+		dev_err(&pdev->dev, "no memory for mmc host\n");
+		return -ENOMEM;
+	}
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->pdev = pdev;
+	spin_lock_init(&host->lock);
+	platform_set_drvdata(pdev, host);
+
+	/* get basic resource from device tree */
+	ret = _get_dt_resource(pdev, host);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to get basic resource: %d\n", ret);
+		goto err_free_host;
+	}
+
+	ret = _get_ext_resource(host);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to get external resource: %d\n", ret);
+		goto err_free_host;
+	}
+
+	_set_mmc_struct(host, mmc);
+	_pm_runtime_setting(pdev, host);
+
+	/* add host */
+	mmiowb();
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add mmc host: %d\n", ret);
+		goto err_free_host;
+	}
+
+	if (-1 != host->detect_gpio) {
+		mmc->caps &= ~MMC_CAP_NONREMOVABLE;
+		mmc_gpio_request_cd(mmc, host->detect_gpio, 0);
+	}
+
+	sdhost_add_debugfs(host);
+
+	dev_info(&pdev->dev,
+		"Spreadtrum %s[%s] host controller at 0x%08lx irq %d\n",
+		host->device_name, mmc_hostname(mmc),
+		host->mapbase, host->irq);
+
+	return 0;
+
+err_free_host:
+	mmc_free_host(mmc);
+	return ret;
+}
+
+static int sdhost_remove(struct platform_device *pdev)
+{
+	struct sdhost_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+
+	if (-1 != host->detect_gpio)
+		mmc_gpio_free_cd(mmc);
+
+	mmc_remove_host(mmc);
+	clk_disable_unprepare(host->clk);
+	free_irq(host->irq, host);
+	release_mem_region(host->res->start, resource_size(host->res));
+	mmc_free_host(mmc);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sdhost_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(_pm_suspend, _pm_resume)
+	    SET_RUNTIME_PM_OPS(_runtime_suspend,
+			       _runtime_resume, _runtime_idle)
+};
+
+static const struct of_device_id sdhost_of_match[] = {
+	{.compatible = "sprd,sdhost-3.0"},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, sdhost_of_match);
+
+static struct platform_driver sdhost_driver = {
+	.probe = sdhost_probe,
+	.remove = sdhost_remove,
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
index 0000000..d5cc438
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost.h
@@ -0,0 +1,615 @@
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
+	struct resource *res;
+	void __iomem *ioaddr;
+	int irq;
+	const char *device_name;
+	struct platform_device *pdev;
+	unsigned long mapbase;
+
+	int detect_gpio;
+	u32 ocr_avail;
+	u32 base_clk;
+	u32 caps;
+	u32 caps2;
+	u32 pm_caps;
+	u32 write_delay;
+	u32 read_pos_delay;
+	u32 read_neg_delay;
+
+	/* --extern resource getted by base resource-- */
+	uint64_t dma_mask;
+	u8 data_timeout_val;
+	u32 signal_default_voltage;
+	bool sdio_1_8v_signal_enabled;
+	struct clk *clk;
+	struct tasklet_struct finish_tasklet;
+	struct timer_list timer;
+
+	/* --runtime param-- */
+	u32 int_filter;
+	struct mmc_ios ios;
+	struct mmc_request *mrq;	/* Current request */
+	struct mmc_command *cmd;	/* Current command */
+	u16 auto_cmd_mode;
+
+	/*--debugfs-- */
+	struct dentry *debugfs_root;
+};
+
+/* Controller flag */
+#define SDHOST_FLAG_ENABLE_ACMD12	0
+#define SDHOST_FLAG_ENABLE_ACMD23	0
+#define SDHOST_FLAG_USE_ADMA		1
+#define SDHOST_MAX_TIMEOUT          3
+
+/* Controller registers */
+#ifdef SPRD_SDHOST_4_BYTE_ALIGNE
+static inline void __local_writeb(u8 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	u32 addr;
+	u32 value;
+	u32 ofst;
+
+	ofst = (reg & 0x3) << 3;
+	addr = reg & (~((u32) (0x3)));
+	value = readl_relaxed((host->ioaddr + addr));
+	value &= (~(((u32) ((u8) (-1))) << ofst));
+	value |= (((u32) val) << ofst);
+	writel_relaxed(value, (host->ioaddr + addr));
+}
+
+static inline void __local_writew(u16 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	u32 addr;
+	u32 value;
+	u32 ofst;
+
+	ofst = (reg & 0x3) << 3;
+	addr = reg & (~((u32) (0x3)));
+	value = readl_relaxed(host->ioaddr + addr);
+	value &= (~(((u32) ((u16) (-1))) << ofst));
+	value |= (((u32) val) << ofst);
+	writel_relaxed(value, (host->ioaddr + addr));
+}
+
+static inline void __local_writel(u32 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	writel_relaxed(val, (host->ioaddr + reg));
+}
+
+static inline u8 __local_readb(struct sdhost_host *host, u32 reg)
+{
+	u32 addr;
+	u32 value;
+	u32 ofst;
+
+	ofst = (reg & 0x3) << 3;
+	addr = reg & (~((u32) (0x3)));
+	value = readl_relaxed(host->ioaddr + addr);
+	return ((u8) (value >> ofst));
+
+}
+
+static inline u16 __local_readw(struct sdhost_host *host, u32 reg)
+{
+	u32 addr;
+	u32 value;
+	u32 ofst;
+
+	ofst = (reg & 0x3) << 3;
+	addr = reg & (~((u32) (0x3)));
+	value = readl_relaxed(host->ioaddr + addr);
+
+	return ((u16) (value >> ofst));
+
+}
+
+static inline u32 __local_readl(struct sdhsot_host *host, u32 reg)
+{
+	return readl_relaxed(host->ioaddr + reg);
+}
+
+#else
+static inline void __local_writeb(u8 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	writeb_relaxed(val, host->ioaddr + reg);
+}
+
+static inline void __local_writew(u16 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	writew_relaxed(val, host->ioaddr + reg);
+}
+
+static inline void __local_writel(u32 val, struct sdhost_host *host,
+				  u32 reg)
+{
+	writel_relaxed(val, host->ioaddr + reg);
+}
+
+static inline u8 __local_readb(struct sdhost_host *host, u32 reg)
+{
+	return readb_relaxed(host->ioaddr + reg);
+}
+
+static inline u16 __local_readw(struct sdhost_host *host, u32 reg)
+{
+	return readw_relaxed(host->ioaddr + reg);
+}
+
+static inline u32 __local_readl(struct sdhost_host *host, u32 reg)
+{
+	return readl_relaxed(host->ioaddr + reg);
+}
+#endif
+
+static inline void _sdhost_writeb(struct sdhost_host *host, u8 val,
+				  int reg)
+{
+	__local_writeb(val, host, reg);
+}
+
+static inline void _sdhost_writew(struct sdhost_host *host, u16 val,
+				  int reg)
+{
+	__local_writew(val, host, reg);
+}
+
+static inline void _sdhost_writel(struct sdhost_host *host, u32 val,
+				  int reg)
+{
+	__local_writel(val, host, reg);
+}
+
+static inline u8 _sdhost_readb(struct sdhost_host *host, int reg)
+{
+	return __local_readb(host, reg);
+}
+
+static inline u16 _sdhost_readw(struct sdhost_host *host, int reg)
+{
+	return __local_readw(host, reg);
+}
+
+static inline u32 _sdhost_readl(struct sdhost_host *host, int reg)
+{
+	return __local_readl(host, reg);
+}
+
+#define SDHOST_32_SYS_ADDR	0x00
+/* used in cmd23 with ADMA in sdio 3.0 */
+#define SDHOST_32_BLK_CNT	0x00
+#define SDHOST_16_BLK_CNT	0x06
+
+static inline void _sdhost_set_16_blk_cnt(struct sdhost_host *host,
+					  u32 blk_cnt)
+{
+	__local_writew((blk_cnt & 0xFFFF), host, SDHOST_16_BLK_CNT);
+}
+
+static inline void _sdhost_set_32_blk_cnt(struct sdhost_host *host,
+					  u32 blk_cnt)
+{
+	__local_writel((blk_cnt & 0xFFFFFFFF), host, SDHOST_32_BLK_CNT);
+}
+
+#define SDHOST_16_BLK_SIZE	0x04
+
+static inline void _sdhost_set_blk_size(struct sdhost_host *host,
+					u32 blk_size)
+{
+	__local_writew((blk_size & 0xFFF) | 0x7000, host, SDHOST_16_BLK_SIZE);
+}
+
+#define SDHOST_32_ARG			0x08
+#define SDHOST_16_TR_MODE		0x0C
+#define __ACMD_DIS	0x00
+#define __ACMD12	0x01
+#define __ACMD23	0x02
+
+static inline void _sdhost_set_trans_mode(struct sdhost_host *host,
+					  u16 if_mult, u16 if_read,
+					  u16 auto_cmd,
+					  u16 if_blk_cnt, u16 if_dma)
+{
+	__local_writew((((if_mult ? 1 : 0) << 5) |
+			((if_read ? 1 : 0) << 4) |
+			(auto_cmd << 2) |
+			((if_blk_cnt ? 1 : 0) << 1) |
+			((if_dma ? 1 : 0) << 0)), host, SDHOST_16_TR_MODE);
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
+#define _RSP1_5_6_7 \
+	(_CMD_INDEX_CHK | _CMD_CRC_CHK | _CMD_RSP_48)
+#define _RSP2 \
+	(_CMD_CRC_CHK | _CMD_RSP_136)
+#define _RSP3_4 \
+	_CMD_RSP_48
+#define _RSP1B_5B \
+	(_CMD_INDEX_CHK | _CMD_CRC_CHK | _CMD_RSP_48_BUSY)
+
+static inline void _sdhost_set_cmd(struct sdhost_host *host, u16 cmd,
+				   int if_has_data, u16 rsp_type)
+{
+	__local_writew(((cmd << 8) |
+			((if_has_data ? 1 : 0) << 5) |
+			(rsp_type)), host, SDHOST_16_CMD);
+}
+
+#define SDHOST_32_TR_MODE_AND_CMD		0x0C
+
+static inline void _sdhost_set_trans_and_cmd(struct sdhost_host *host,
+					     int if_mult, int if_read,
+					     u16 auto_cmd, int if_blk_cnt,
+					     int if_dma, u32 cmd,
+					     int if_has_data, u32 rsp_type)
+{
+	__local_writel((((if_mult ? 1 : 0) << 5) |
+			((if_read ? 1 : 0) << 4) |
+			(((u32) auto_cmd) << 2) |
+			((if_blk_cnt ? 1 : 0) << 1) |
+			((if_dma ? 1 : 0) << 0) |
+			(((u32) cmd) << 24) |
+			((if_has_data ? 1 : 0) << 21) |
+			(rsp_type << 16)),
+		       host, SDHOST_32_TR_MODE_AND_CMD);
+}
+
+#define SDHOST_32_RESPONSE	0x10
+#define SDHOST_32_PRES_STATE	0x24
+#define  _DATA_LVL_MASK		0x00F00000
+
+#define SDHOST_8_HOST_CTRL	0x28
+#define __8_BIT_MOD	0x20
+#define __4_BIT_MOD	0x02
+#define __1_BIT_MOD	0x00
+#define __SDMA_MOD		0x00
+#define __32ADMA_MOD	0x10
+#define __64ADMA_MOD	0x18
+#define __HISPD_MOD		0x04
+
+static inline void _sdhost_set_buswidth(struct sdhost_host *host,
+					u32 buswidth)
+{
+	u8 ctrl = 0;
+
+	ctrl = __local_readb(host, SDHOST_8_HOST_CTRL);
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
+		WARN_ON(1);
+		break;
+	}
+	__local_writeb(ctrl, host, SDHOST_8_HOST_CTRL);
+}
+
+static inline void _sdhost_set_dma(struct sdhost_host *host, u8 dma_mode)
+{
+	u8 ctrl = 0;
+
+	ctrl = __local_readb(host, SDHOST_8_HOST_CTRL);
+	ctrl &= (~(__SDMA_MOD | __32ADMA_MOD | __64ADMA_MOD));
+	ctrl |= dma_mode;
+	__local_writeb(ctrl, host, SDHOST_8_HOST_CTRL);
+}
+
+static inline void _sdhost_enable_hispd(struct sdhost_host *host)
+{
+	u8 ctrl = 0;
+
+	ctrl = __local_readb(host, SDHOST_8_HOST_CTRL);
+	ctrl |= __HISPD_MOD;
+	__local_writeb(ctrl, host, SDHOST_8_HOST_CTRL);
+}
+
+#define SDHOST_8_PWR_CTRL       0x29    /* not used */
+#define SDHOST_8_BLK_GAP		0x2A	/* not used */
+#define SDHOST_8_WACKUP_CTRL	0x2B	/* not used */
+
+#define SDHOST_16_CLK_CTRL	0x2C
+#define __CLK_IN_EN		0x0001
+#define __CLK_IN_STABLE	0x0002
+#define __CLK_SD			0x0004
+#define __CLK_MAX_DIV		2046
+
+static inline void _sdhost_all_clk_off(struct sdhost_host *host)
+{
+	__local_writew(0, host, SDHOST_16_CLK_CTRL);
+}
+
+static inline void _sdhost_sd_clk_off(struct sdhost_host *host)
+{
+	u16 ctrl = 0;
+
+	ctrl = __local_readw(host, SDHOST_16_CLK_CTRL);
+	ctrl &= (~__CLK_SD);
+	__local_writew(ctrl, host, SDHOST_16_CLK_CTRL);
+}
+
+static inline void _sdhost_sd_clk_on(struct sdhost_host *host)
+{
+	u16 ctrl = 0;
+
+	ctrl = __local_readw(host, SDHOST_16_CLK_CTRL);
+	ctrl |= __CLK_SD;
+	__local_writew(ctrl, host, SDHOST_16_CLK_CTRL);
+}
+
+static inline u32 _sdhost_calc_div(u32 base_clk, u32 clk)
+{
+	u32 div;
+
+	if (base_clk <= clk)
+		return 0;
+
+	div = (u32) (base_clk / clk);
+	div = (div >> 1);
+	if (div)
+		div--;
+	if ((base_clk / ((div + 1) << 1)) > clk)
+		div++;
+	if (__CLK_MAX_DIV < div)
+		div = __CLK_MAX_DIV;
+
+	return div;
+}
+
+static inline void _sdhost_clk_set_and_on(struct sdhost_host *host,
+					  u32 div)
+{
+	u16 ctrl = 0;
+	unsigned long timeout;
+
+	__local_writew(0, host, SDHOST_16_CLK_CTRL);
+	ctrl |= (u16) (((div & 0x300) >> 2) | ((div & 0xFF) << 8));
+	ctrl |= __CLK_IN_EN;
+	__local_writew(ctrl, host, SDHOST_16_CLK_CTRL);
+
+	/* wait max 20 ms*/
+	timeout = 100;
+	while (!(__CLK_IN_STABLE & __local_readw(host, SDHOST_16_CLK_CTRL))) {
+		if (timeout == 0) {
+			pr_err("must check! %s clock set and on fail\n",
+				host->device_name);
+			return;
+		}
+
+		timeout--;
+		mdelay(1);
+	}
+}
+
+#define SDHOST_8_TIMEOUT		0x2E
+#define __DATA_TIMEOUT_MAX_VAL		0xe
+
+static inline u8 _sdhost_calc_timeout(unsigned int clock,
+					   u8 timeout_value)
+{
+	unsigned target_timeout, current_timeout;
+	u8 count;
+
+	count = 0;
+	current_timeout = 1 << 16;
+	target_timeout = timeout_value * clock;
+
+	while (target_timeout > current_timeout) {
+		count++;
+		current_timeout <<= 1;
+	}
+	count--;
+	if (count >= 0xF)
+		count = 0xE;
+	return count;
+}
+
+#define SDHOST_8_RST	0x2F
+#define  _RST_ALL	0x01
+#define  _RST_CMD	0x02
+#define  _RST_DATA	0x04
+#define  _RST_EMMC	0x08	/* spredtrum define it byself */
+
+static inline void _sdhost_reset(struct sdhost_host *host, u8 mask)
+{
+	unsigned long timeout;
+
+	__local_writeb((_RST_EMMC | mask), host, SDHOST_8_RST);
+
+	/* wait max 100 ms*/
+	timeout = 100;
+	while (__local_readb(host, SDHOST_8_RST) & mask) {
+		if (timeout == 0) {
+			pr_err("must check! reset %s fail\n",
+				host->device_name);
+			return;
+		}
+
+		timeout--;
+		mdelay(1);
+	}
+}
+
+/* spredtrum define it byself */
+static inline void _sdhost_reset_emmc(struct sdhost_host *host)
+{
+	__local_writeb(0, host, SDHOST_8_RST);
+	mdelay(2);
+	__local_writeb(_RST_EMMC, host, SDHOST_8_RST);
+}
+
+#define SDHOST_32_INT_ST		0x30
+#define SDHOST_32_INT_ST_EN		0x34
+#define SDHOST_32_INT_SIG_EN	0x38
+#define _INT_CMD_END			0x00000001
+#define _INT_TRAN_END			0x00000002
+#define _INT_DMA_END			0x00000008
+#define _INT_WR_RDY				0x00000010	/* not used */
+#define _INT_RD_RDY				0x00000020	/* not used */
+#define _INT_ERR				0x00008000
+#define _INT_ERR_CMD_TIMEOUT	0x00010000
+#define _INT_ERR_CMD_CRC		0x00020000
+#define _INT_ERR_CMD_END		0x00040000
+#define _INT_ERR_CMD_INDEX		0x00080000
+#define _INT_ERR_DATA_TIMEOUT	0x00100000
+#define _INT_ERR_DATA_CRC		0x00200000
+#define _INT_ERR_DATA_END		0x00400000
+#define _INT_ERR_CUR_LIMIT		0x00800000
+#define _INT_ERR_ACMD			0x01000000
+#define _INT_ERR_ADMA			0x02000000
+
+/* used in irq */
+#define _INT_FILTER_ERR_CMD \
+	(_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+	_INT_ERR_CMD_END | _INT_ERR_CMD_INDEX)
+#define _INT_FILTER_ERR_DATA \
+	(_INT_ERR_DATA_TIMEOUT | _INT_ERR_DATA_CRC | \
+	_INT_ERR_DATA_END)
+#define _INT_FILTER_ERR \
+	(_INT_ERR | _INT_FILTER_ERR_CMD | \
+	_INT_FILTER_ERR_DATA | _INT_ERR_ACMD | \
+	_INT_ERR_ADMA)
+#define _INT_FILTER_NORMAL \
+	(_INT_CMD_END | _INT_TRAN_END)
+
+/* used for setting */
+#define _DATA_FILTER_RD_SIGLE \
+	(_INT_TRAN_END | _INT_DMA_END | \
+	_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+	_INT_ERR_DATA_CRC | _INT_ERR_DATA_END)
+#define _DATA_FILTER_RD_MULTI \
+	(_INT_TRAN_END | _INT_DMA_END | _INT_ERR | \
+	_INT_ERR_DATA_TIMEOUT | _INT_ERR_DATA_CRC | \
+	_INT_ERR_DATA_END)
+#define _DATA_FILTER_WR_SIGLE \
+	(_INT_TRAN_END | _INT_DMA_END | \
+	_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+	_INT_ERR_DATA_CRC)
+#define _DATA_FILTER_WR_MULT \
+	(_INT_TRAN_END | _INT_DMA_END | \
+	_INT_ERR | _INT_ERR_DATA_TIMEOUT | \
+	_INT_ERR_DATA_CRC)
+#define _CMD_FILTER_R0 \
+	_INT_CMD_END
+#define _CMD_FILTER_R2 \
+	(_INT_CMD_END | _INT_ERR | \
+	_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+	_INT_ERR_CMD_END)
+#define _CMD_FILTER_R3 \
+	(_INT_CMD_END | _INT_ERR | \
+	_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_END)
+#define _CMD_FILTER_R1_R4_R5_R6_R7 \
+	(_INT_CMD_END | _INT_ERR | \
+	_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+	_INT_ERR_CMD_END | _INT_ERR_CMD_INDEX)
+#define _CMD_FILTER_R1B \
+	(_INT_CMD_END | _INT_ERR | \
+	_INT_ERR_CMD_TIMEOUT | _INT_ERR_CMD_CRC | \
+	_INT_ERR_CMD_END | _INT_ERR_CMD_INDEX | \
+	_INT_TRAN_END | _INT_ERR_DATA_TIMEOUT)
+
+static inline void _sdhost_disable_all_int(struct sdhost_host *host)
+{
+	__local_writel(0x0, host, SDHOST_32_INT_SIG_EN);
+	__local_writel(0x0, host, SDHOST_32_INT_ST_EN);
+	__local_writel(0xFFFFFFFF, host, SDHOST_32_INT_ST);
+}
+
+static inline void _sdhost_enable_int(struct sdhost_host *host, u32 mask)
+{
+	__local_writel(mask, host, SDHOST_32_INT_ST_EN);
+	__local_writel(mask, host, SDHOST_32_INT_SIG_EN);
+}
+
+static inline void _sdhost_clear_int(struct sdhost_host *host, u32 mask)
+{
+	__local_writel(mask, host, SDHOST_32_INT_ST);
+}
+
+#define SDHOST_16_ACMD_ERR		0x3C
+
+#define SDHOST_16_HOST_CTRL_2	0x3E
+#define __TIMING_MODE_SDR12		0x0000
+#define __TIMING_MODE_SDR25		0x0001
+#define __TIMING_MODE_SDR50		0x0002
+#define __TIMING_MODE_SDR104	0x0003
+#define __TIMING_MODE_DDR50		0x0004
+#define __TIMING_MODE_SDR200	0x0005
+
+static inline void _sdhost_set_uhs_mode(struct sdhost_host *host, u16 mode)
+{
+	__local_writew(mode, host, SDHOST_16_HOST_CTRL_2);
+}
+
+#define SDHOST_MAX_CUR	1020
+
+/* the following register is defined by spreadtrum self.
+ * It is not standard register of SDIO
+ * */
+static inline void _sdhost_set_delay(struct sdhost_host *host,
+				     u32 write_delay,
+				     u32 read_pos_delay,
+				     u32 read_neg_delay)
+{
+	__local_writel(write_delay, host, 0x80);
+	__local_writel(read_pos_delay, host, 0x84);
+	__local_writel(read_neg_delay, host, 0x88);
+}
+
+#endif /* __SDHOST_H_ */
diff --git a/drivers/mmc/host/sprd_sdhost_debugfs.c b/drivers/mmc/host/sprd_sdhost_debugfs.c
new file mode 100644
index 0000000..29b7f58
--- /dev/null
+++ b/drivers/mmc/host/sprd_sdhost_debugfs.c
@@ -0,0 +1,212 @@
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
+			_sdhost_set_delay(host, \
+				host->write_delay, \
+				host->read_pos_delay, \
+				host->read_neg_delay);\
+		} \
+		return 0;\
+	} \
+	DEFINE_SIMPLE_ATTRIBUTE(sdhost_##PARAM_NAME##_fops,\
+					sdhost_##PARAM_NAME##_get,\
+					sdhost_##PARAM_NAME##_set,\
+					"%llu\n")
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
+	pr_info("+++++++++++ REGISTER DUMP (%s) ++++++++++\n",
+		host->device_name);
+
+	for (i = 0; i < 0x09; i++) {
+		pr_info("0x%08x | 0x%08x | 0x%08x | 0x%08x\n\r",
+		       _sdhost_readl(host, 0 + (i << 4)),
+		       _sdhost_readl(host, 4 + (i << 4)),
+		       _sdhost_readl(host, 8 + (i << 4)),
+		       _sdhost_readl(host, 12 + (i << 4))
+		    );
+	}
+
+	pr_info("----------------------------------------\n");
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
