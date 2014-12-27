From: Yi Sun <yi.y.sun@intel.com>
Subject: [RFC 1/2] mmc: core: support UHS-II in core stack.
Date: Sat, 27 Dec 2014 17:27:58 +0800
Message-ID: <1419672479-30852-2-git-send-email-yi.y.sun@intel.com>
References: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60967 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbaL0JfU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Dec 2014 04:35:20 -0500
In-Reply-To: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: yi.y.sun@intel.com

This patch adds the UHS-II support in core layer. This is a RFC patch for
community review.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
---
 drivers/mmc/core/Makefile |    3 +-
 drivers/mmc/core/bus.c    |    5 +-
 drivers/mmc/core/core.c   |   89 ++++-
 drivers/mmc/core/sd.c     |   15 +
 drivers/mmc/core/sd_ops.c |   12 +
 drivers/mmc/core/uhs2.c   |  908 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h   |   26 ++
 include/linux/mmc/core.h  |    6 +
 include/linux/mmc/host.h  |   27 ++
 include/linux/mmc/uhs2.h  |  274 ++++++++++++++
 10 files changed, 1356 insertions(+), 9 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 38ed210..c0be0cb 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,6 +7,7 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   quirks.o slot-gpio.o
+				   quirks.o slot-gpio.o \
+				   uhs2.o
 
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 86d2711..6565754 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -308,8 +308,9 @@ int mmc_add_card(struct mmc_card *card)
 	} else {
 		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
+			mmc_card_uhs2(card) ? "ultra high speed 2 " :
+			(mmc_card_uhs(card) ? "ultra high speed 1" :
+			(mmc_card_hs(card) ? "high speed " : "")),
 			mmc_card_hs400(card) ? "HS400 " :
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr52(card) ? "DDR " : "",
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9584bff..8a62063 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -5,6 +5,7 @@
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
  *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
+ *  UHS2 support Copyright (C) 2014 Intel Corp, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -35,11 +36,13 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
 
 #include "core.h"
 #include "bus.h"
 #include "host.h"
 #include "sdio_bus.h"
+#include "uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -56,6 +59,7 @@
 
 static struct workqueue_struct *workqueue;
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
+static const unsigned uhs2_freqs[] = { 52000000, 26000000 };
 
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
@@ -248,6 +252,12 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
+
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED)
+		if (mrq->cmd->uhs2_cmd == NULL)
+			uhs2_prepare_sd_cmd(host, mrq);
+
 	mmc_host_clk_hold(host);
 	led_trigger_event(host->led, LED_FULL);
 	host->ops->request(host, mrq);
@@ -385,7 +395,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 				      struct mmc_request *mrq,
 				      struct mmc_async_req *next_req)
 {
-	struct mmc_command *cmd;
+	struct mmc_command *cmd = mrq->cmd;
 	struct mmc_context_info *context_info = &host->context_info;
 	int err;
 	unsigned long flags;
@@ -400,7 +410,6 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 		if (context_info->is_done_rcv) {
 			context_info->is_done_rcv = false;
 			context_info->is_new_req = false;
-			cmd = mrq->cmd;
 
 			if (!cmd->error || !cmd->retries ||
 			    mmc_card_removed(host->card)) {
@@ -424,6 +433,16 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 			}
 		}
 	}
+
+	if (cmd && cmd->uhs2_cmd) {
+#ifdef CONFIG_MMC_DEBUG
+		pr_info("%s: %s free uhs2_cmd!\n",
+			mmc_hostname(host), __func__);
+#endif
+		kfree(cmd->uhs2_cmd->payload);
+		kfree(cmd->uhs2_cmd);
+		cmd->uhs2_cmd = NULL;
+	}
 	return err;
 }
 
@@ -464,6 +483,16 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		cmd->error = 0;
 		host->ops->request(host, mrq);
 	}
+
+	if (cmd && cmd->uhs2_cmd) {
+#ifdef CONFIG_MMC_DEBUG
+		pr_info("%s: %s free uhs2_cmd!\n",
+			mmc_hostname(host), __func__);
+#endif
+		kfree(cmd->uhs2_cmd->payload);
+		kfree(cmd->uhs2_cmd);
+		cmd->uhs2_cmd = NULL;
+	}
 }
 
 /**
@@ -974,7 +1003,7 @@ EXPORT_SYMBOL(mmc_put_card);
  * Internal function that does the actual ios call to the host driver,
  * optionally printing some debug output.
  */
-static inline void mmc_set_ios(struct mmc_host *host)
+void mmc_set_ios(struct mmc_host *host)
 {
 	struct mmc_ios *ios = &host->ios;
 
@@ -988,6 +1017,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		mmc_set_ungated(host);
 	host->ops->set_ios(host, ios);
 }
+EXPORT_SYMBOL(mmc_set_ios);
 
 /*
  * Control chip select pin on a host.
@@ -1361,6 +1391,23 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_info(dev, "No vqmmc regulator found\n");
 	}
 
+	if (!(mmc->caps & MMC_CAP_UHS2))
+		return 0;
+
+	mmc->supply.vmmc2 = devm_regulator_get_optional(dev, "vmmc2");
+	if (IS_ERR(mmc->supply.vmmc2)) {
+		if (PTR_ERR(mmc->supply.vmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "No vmmc2 regulator found\n");
+	} else {
+		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
+		if (ret > 0)
+			mmc->ocr_avail_uhs2 = ret;
+		else
+			dev_warn(dev, "Failed getting UHS2 OCR mask: %d\n",
+					ret);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
@@ -1553,6 +1600,11 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
+	if (host->flags & MMC_UHS2_SUPPORT) {
+		uhs2_power_up(host);
+		return;
+	}
+
 	mmc_host_clk_hold(host);
 
 	host->ios.vdd = fls(ocr) - 1;
@@ -2287,7 +2339,9 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 	}
 
 	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
+	/* TODO: need verify this for UHS2. */
+	if (!host->flags & MMC_UHS2_SUPPORT)
+		mmc_set_initial_state(host);
 
 	mmc_host_clk_release(host);
 
@@ -2416,6 +2470,7 @@ void mmc_rescan(struct work_struct *work)
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
 	int i;
+	int err;
 
 	if (host->trigger_card_event && host->ops->card_event) {
 		host->ops->card_event(host);
@@ -2470,6 +2525,27 @@ void mmc_rescan(struct work_struct *work)
 	}
 
 	mmc_claim_host(host);
+	if (host->caps & MMC_CAP_UHS2) {
+		/* Start to try UHS-II initialization from 52MHz to 26MHz
+		 * (RCLK range) per spec.
+		 */
+		for (i = 0; i < ARRAY_SIZE(uhs2_freqs); i++) {
+			err = mmc_uhs2_try_frequency(host,
+				max(uhs2_freqs[i], host->f_min));
+			if (!err) {
+				mmc_release_host(host);
+				goto out;
+			} else if (err == UHS2_PHY_INIT_ERR)
+				/* UHS2 IF detect or Lane Sync error.
+				 * Try legacy interface.
+				 */
+				break;
+
+			if (uhs2_freqs[i] <= host->f_min)
+				break;
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
 			break;
@@ -2485,12 +2561,12 @@ void mmc_rescan(struct work_struct *work)
 
 void mmc_start_host(struct mmc_host *host)
 {
-	host->f_init = max(freqs[0], host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 	if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
 		mmc_power_off(host);
-	else
+	/* Power up here will make UHS2 init ugly. */
+	else if (!(host->caps & MMC_CAP_UHS2))
 		mmc_power_up(host, host->ocr_avail);
 	mmc_gpiod_request_cd_irq(host);
 	_mmc_detect_change(host, 0, false);
@@ -2573,6 +2649,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 		return -EINVAL;
 	}
 
+	/* TODO: for UHS2, may execute UHS2 init process again. */
 	mmc_power_up(host, host->card->ocr);
 	ret = host->bus_ops->power_restore(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d90a6de..d2000be 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -969,6 +969,14 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
+	/* For UHS2, skip the UHS-I initialization. */
+	/* TODO: shall we send CMD6 to set Maximum Power Consumption
+	 * to get better performance?
+	 */
+	if ((host->flags & MMC_UHS2_SUPPORT) &&
+	    (host->flags & MMC_UHS2_INITIALIZED))
+		goto uhs2_done;
+
 	/* Initialization sequence for UHS-I cards */
 	if (rocr & SD_ROCR_S18A) {
 		err = mmc_sd_init_uhs_card(card);
@@ -1002,6 +1010,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+uhs2_done:
 	host->card = card;
 	return 0;
 
@@ -1118,6 +1127,9 @@ static int _mmc_sd_resume(struct mmc_host *host)
 	if (!mmc_card_suspended(host->card))
 		goto out;
 
+	/* TODO: for UHS2, may need UHS2 init process to be executed
+	 * again (DEVICE_INIT/ENUMERATE/CONFIG, etc).
+	 */
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
@@ -1185,6 +1197,9 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 	int ret;
 
 	mmc_claim_host(host);
+	/* TODO: for UHS2, may need UHS2 init process to be executed
+	 * again (DEVICE_INIT/ENUMERATE/CONFIG, etc).
+	 */
 	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 48d0c93..fb2158f 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -30,6 +30,18 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	BUG_ON(!host);
 	BUG_ON(card && (card->host != host));
 
+	/* UHS2 packet has APP bit so only set APP_CMD flag here.
+	 * Will set the APP bit when assembling UHS2 packet.
+	 */
+	if (host->flags &  MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+#ifdef CONFIG_MMC_DEBUG
+		pr_info("%s: it is app cmd, skip it!\n", mmc_hostname(host));
+#endif
+		host->flags |= MMC_UHS2_APP_CMD;
+		return 0;
+	}
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
new file mode 100644
index 0000000..86a1dfa
--- /dev/null
+++ b/drivers/mmc/core/uhs2.c
@@ -0,0 +1,908 @@
+/*
+ *  linux/drivers/mmc/core/uhs2.c
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
+
+#include "uhs2.h"
+#include "mmc_ops.h"
+#include "sd_ops.h"
+#include "core.h"
+
+#define DBG(f, x...) \
+	pr_warn("[%s()]: " f, __func__, ## x)
+
+/*
+ * TODO: payload, uhs2_cmd are all allocated which should be freed when
+ * response is got.
+ * resp is inputted outside which should be a variable created by caller
+ * so caller should handle it. For SD command, there is no uhs2_resp and
+ * response should be stored in resp of mmc_command.
+ */
+int uhs2_cmd_assemble(struct mmc_command *cmd, u16 header, u16 arg,
+			u32 *payload, u8 plen, u8 *resp, u8 resp_len)
+{
+	struct uhs2_command *uhs2_cmd;
+
+	if (cmd == NULL || payload == NULL || resp == NULL)
+		return -EIO;
+
+	uhs2_cmd = kzalloc(sizeof(struct uhs2_command),
+						GFP_KERNEL);
+	if (!uhs2_cmd) {
+		kfree(payload);
+		return -ENOMEM;
+	}
+
+	uhs2_cmd->header = header;
+	uhs2_cmd->arg = arg;
+	uhs2_cmd->payload = payload;
+	uhs2_cmd->payload_len = plen * sizeof(u32);
+	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
+
+	cmd->uhs2_cmd = uhs2_cmd;
+	cmd->uhs2_resp = resp;
+	cmd->uhs2_resp_len = resp_len;
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: uhs2_cmd->header = 0x%x, uhs2_cmd->arg = 0x%x,"
+		" uhs2_cmd->payload_len = %d, uhs2_cmd->packet_len = %d,"
+		" resp_len = %d.\n",
+		__func__, uhs2_cmd->header,
+		uhs2_cmd->arg, uhs2_cmd->payload_len, uhs2_cmd->packet_len,
+		cmd->uhs2_resp_len);
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uhs2_cmd_assemble);
+
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 0;
+	int err = 0;
+
+	cmd = mrq->cmd;
+	header = host->uhs2_dev_prop.node_id;
+	if (cmd->flags & MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+	DBG("header = 0x%x.\n", header);
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
+
+	if (cmd->flags & MMC_CMD_ADTC) {
+		/* TODO: do not understand. It may relates with ADMA3. */
+		if (cmd->data->blocks > 1) {
+			payload = kzalloc(4*sizeof(u32), GFP_KERNEL);
+			if (!payload)
+				return -ENOMEM;
+			payload[2] = 0;
+			payload[3] = 0;
+			plen = 8 / sizeof(u32);
+		} else {
+			payload = kzalloc(2*sizeof(u32), GFP_KERNEL);
+			if (!payload)
+				return -ENOMEM;
+			plen = 8 / sizeof(u32);
+		}
+
+		if (host->flags & MMC_UHS2_2L_HD)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+		    cmd->opcode != MMC_WRITE_BLOCK) {
+			arg |= UHS2_DCMD_TLUM_BYTE_MODE;
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blksz);
+		} else {
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blocks);
+		}
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			arg &= ~(UHS2_DCMD_LM_TLEN_EXIST |
+				UHS2_DCMD_TLUM_BYTE_MODE |
+				UHS2_NATIVE_DCMD_DAM_IO);
+			payload[1] = 0;
+			plen = 4 / sizeof(u32);
+		}
+	} else {
+		payload = kzalloc(1 * sizeof(u32), GFP_KERNEL);
+		if (!payload)
+			return -ENOMEM;
+		plen = 4 / sizeof(u32);
+	}
+
+	payload[0] = uhs2_dcmd_convert_msb(cmd->arg);
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: sd_cmd->arg = 0x%x, payload[0]= 0x%x.\n",
+		 mmc_hostname(host), __func__, cmd->arg, payload[0]);
+#endif
+
+	err = uhs2_cmd_assemble(cmd, header, arg, payload, plen,
+				NULL, 0);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(uhs2_prepare_sd_cmd);
+
+/*
+ * Apply power to the UHS2 stack.  This is a two-stage process.
+ * First, we enable power to the card without the clock running.
+ * We then wait a bit for the power to stabilise.  Finally,
+ * enable the bus drivers and clock to the card.
+ *
+ * We must _NOT_ enable the clock prior to power stablising.
+ *
+ * If a host does all the power sequencing itself, ignore the
+ * initial MMC_POWER_UP stage.
+ */
+void uhs2_power_up(struct mmc_host *host)
+{
+	if (host->ios.power_mode == MMC_POWER_ON)
+		return;
+
+	DBG("Enter!\n");
+	mmc_host_clk_hold(host);
+
+	host->ios.vdd = fls(host->ocr_avail) - 1;
+	host->ios.vdd2 = fls(host->ocr_avail_uhs2) - 1;
+	if (mmc_host_is_spi(host))
+		host->ios.chip_select = MMC_CS_HIGH;
+	else
+		host->ios.chip_select = MMC_CS_DONTCARE;
+	host->ios.clock = host->f_init;
+	host->ios.timing = MMC_TIMING_UHS2;
+	host->ios.power_mode = MMC_POWER_ON;
+	mmc_set_ios(host);
+
+	/*
+	 * This delay should be sufficient to allow the power supply
+	 * to reach the minimum voltage.
+	 */
+	mmc_delay(10);
+
+	mmc_host_clk_release(host);
+}
+EXPORT_SYMBOL_GPL(uhs2_power_up);
+
+static int uhs2_dev_init(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	u32 cnt;
+	u32 dap, gap, gap1;
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 1;
+	u8 gd = 0, cf = 1;
+	u8 resp[6] = {0};
+	u8 resp_len = 6;
+	int err;
+
+	dap = host->uhs2_caps.dap;
+	gap = host->uhs2_caps.gap;
+	DBG("dap = 0x%x, gap = 0x%x.\n", dap, gap);
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_DEVICE_INIT >> 8);
+
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+	payload[0] = ((dap & 0xF) << 12) |
+		  (cf << 11) |
+		  ((gd & 0xF) << 4) |
+		  (gap & 0xF);
+
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+			resp, resp_len);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("Begin DEVICE_INIT, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		header, arg, payload[0]);
+	for (cnt = 0; cnt < 30; cnt++) {
+		DBG("Sending DEVICE_INIT. Count = %d\n", cnt);
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+				mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+#ifdef CONFIG_MMC_DEBUG
+		int i;
+
+		pr_warn("%s: DEVICE_INIT response is: ", mmc_hostname(host));
+		for (i = 0; i < resp_len; i++)
+			pr_warn("0x%x ", resp[i]);
+		pr_warn("\n");
+#endif
+
+		if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
+			pr_err("%s: DEVICE_INIT response is wrong!\n",
+				mmc_hostname(host));
+			return -EIO;
+		}
+
+		if (resp[5] & 0x8) {
+			DBG("CF is set, device is initialized!\n");
+			host->group_desc = gd;
+		} else {
+			gap1 = resp[4] & 0x0F;
+			if (gap == gap1)
+				gd++;
+		}
+	}
+	if (30 == cnt) {
+		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
+			mmc_hostname(host));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int uhs2_enum(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 1;
+	u8 id_f = 0xF, id_l = 0x0;
+	u8 resp[8] = {0};
+	u8 resp_len = 8;
+	int err;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_ENUMERATE >> 8);
+
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+	payload[0] = (id_f << 4) | id_l;
+
+	DBG("Begin ENUMERATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		header, arg, payload[0]);
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				resp, resp_len);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+#ifdef CONFIG_MMC_DEBUG
+	int i;
+
+	pr_warn("%s: ENUMERATE response is: ", mmc_hostname(host));
+	for (i = 0; i < resp_len; i++)
+		pr_warn("0x%x ", resp[i]);
+	pr_warn("\n");
+#endif
+
+	if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
+		pr_err("%s: ENUMERATE response is wrong!\n",
+			mmc_hostname(host));
+		return -EIO;
+	}
+
+	/* TODO: shall I keep id_f or id_l as device node id?
+	 * For P2P connection, I think id_f is ok.
+	 */
+	id_f = (resp[4] >> 4) & 0xF;
+	id_l = resp[4] & 0xF;
+	DBG("id_f = %d, id_l = %d.\n", id_f, id_l);
+	DBG("Enumerate Cmd Completed. No. of Devices connected = %d\n",
+		id_l - id_f + 1);
+	host->uhs2_dev_prop.node_id = id_f;
+
+	return 0;
+}
+
+static int uhs2_config_read(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	u16 header = 0, arg = 0;
+	u32 cap;
+	int err;
+
+	DBG("INQUIRY_CFG: read Generic Caps.\n");
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CONFIG_GEN_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+		header, arg);
+	/* There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	err = uhs2_cmd_assemble(&cmd, header, arg, NULL, 0,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+#ifdef CONFIG_MMC_DEBUG
+	int i;
+
+	pr_warn("%s: INQUIRY_CFG generic response is: ", mmc_hostname(host));
+	for (i = 0; i < 2; i++)
+		pr_warn("0x%x ", cmd.resp[i]);
+	pr_warn("\n");
+#endif
+
+	cap = cmd.resp[0];
+	DBG("Device Generic Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_lanes = (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
+					UHS2_DEV_CONFIG_N_LANES_MASK;
+	host->uhs2_dev_prop.dadr_len = (cap >> UHS2_DEV_CONFIG_DADR_POS) &
+					UHS2_DEV_CONFIG_DADR_MASK;
+	host->uhs2_dev_prop.app_type = (cap >> UHS2_DEV_CONFIG_APP_POS) &
+					UHS2_DEV_CONFIG_APP_MASK;
+
+	DBG("INQUIRY_CFG: read PHY Caps.\n");
+	arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_PHY_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+		header, arg);
+	err = uhs2_cmd_assemble(&cmd, header, arg, NULL, 0,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_warn("%s: INQUIRY_CFG PHY response is: ", mmc_hostname(host));
+	for (i = 0; i < 2; i++)
+		pr_warn("0x%x ", cmd.resp[i]);
+	pr_warn("\n");
+#endif
+
+	cap = cmd.resp[0];
+	DBG("Device PHY Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.phy_minor_rev = cap &
+					UHS2_DEV_CONFIG_PHY_MINOR_MASK;
+	host->uhs2_dev_prop.phy_major_rev = (cap >>
+					UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
+					UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
+	host->uhs2_dev_prop.can_hibernate = (cap >>
+					UHS2_DEV_CONFIG_CAN_HIBER_POS) &
+					UHS2_DEV_CONFIG_CAN_HIBER_MASK;
+
+	cap = cmd.resp[1];
+	DBG("Device PHY Caps (32-63) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_lss_sync = cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	host->uhs2_dev_prop.n_lss_dir = (cap >>
+					UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
+					UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	if (host->uhs2_dev_prop.n_lss_sync == 0)
+		host->uhs2_dev_prop.n_lss_sync = 16 << 2;
+	else
+		host->uhs2_dev_prop.n_lss_sync <<= 2;
+
+	if (host->uhs2_dev_prop.n_lss_dir == 0)
+		host->uhs2_dev_prop.n_lss_dir = 16 << 3;
+	else
+		host->uhs2_dev_prop.n_lss_dir <<= 3;
+
+	DBG("INQUIRY_CFG: read LINK-TRAN Caps.\n");
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
+
+	DBG("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n",
+		header, arg);
+	err = uhs2_cmd_assemble(&cmd, header, arg, NULL, 0,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_warn("%s: INQUIRY_CFG Link-Tran response is: ", mmc_hostname(host));
+	for (i = 0; i < 2; i++)
+		pr_warn("0x%x ", cmd.resp[i]);
+	pr_warn("\n");
+#endif
+
+	cap = cmd.resp[0];
+	DBG("Device LINK-TRAN Caps (0-31) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.link_minor_rev = cap &
+					UHS2_DEV_CONFIG_LT_MINOR_MASK;
+	host->uhs2_dev_prop.link_major_rev = (cap >>
+					UHS2_DEV_CONFIG_LT_MAJOR_POS) &
+					UHS2_DEV_CONFIG_LT_MAJOR_MASK;
+	host->uhs2_dev_prop.n_fcu = (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
+					UHS2_DEV_CONFIG_N_FCU_MASK;
+	host->uhs2_dev_prop.dev_type = (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
+					UHS2_DEV_CONFIG_DEV_TYPE_MASK;
+	host->uhs2_dev_prop.maxblk_len = (cap >>
+					UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
+					UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
+
+	cap = cmd.resp[1];
+	DBG("Device LINK-TRAN Caps (32-63) is: 0x%x.\n", cap);
+	host->uhs2_dev_prop.n_data_gap = cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
+	if (host->uhs2_dev_prop.n_fcu == 0)
+		host->uhs2_dev_prop.n_fcu = 256;
+
+	return 0;
+}
+
+static int uhs2_config_write(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 1;
+	int err;
+	u8 resp[5] = {0};
+	u8 resp_len = 5;
+
+	BUG_ON(!host->ops->uhs2_set_reg);
+
+	DBG("SET_COMMON_CFG: write Generic Settings.\n");
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	if (host->uhs2_dev_prop.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
+	    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
+		/* Support HD */
+		DBG("Both Host and device support 2L-HD.\n");
+		host->flags |= MMC_UHS2_2L_HD;
+		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		host->uhs2_dev_prop.n_lanes_set =
+				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+	} else {
+		/* Only support 2L-FD so far */
+		host->flags &= ~MMC_UHS2_2L_HD;
+		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		host->uhs2_dev_prop.n_lanes_set =
+				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+	}
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	payload[0] = host->uhs2_dev_prop.n_lanes_set <<
+			UHS2_DEV_CONFIG_N_LANES_POS;
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		header, arg, payload[0]);
+	/* There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("SET_COMMON_CFG: PHY Settings.\n");
+	arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_PHY_SET >> 8);
+
+	plen = 2;
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+
+	if (host->uhs2_caps.speed_range ==
+		UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
+		host->flags |= MMC_UHS2_SPEED_B;
+		host->uhs2_dev_prop.speed_range_set =
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
+	} else {
+		host->uhs2_dev_prop.speed_range_set =
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
+		host->flags &= ~MMC_UHS2_SPEED_B;
+	}
+	payload[0] = host->uhs2_dev_prop.speed_range_set <<
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+
+	host->uhs2_dev_prop.n_lss_sync_set =
+		(min(host->uhs2_dev_prop.n_lss_sync,
+		host->uhs2_caps.n_lss_sync) >> 2) &
+		UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	host->uhs2_caps.n_lss_sync_set = host->uhs2_dev_prop.n_lss_sync_set;
+
+	host->uhs2_dev_prop.n_lss_dir_set =
+		(min(host->uhs2_dev_prop.n_lss_dir,
+		host->uhs2_caps.n_lss_dir) >> 3) &
+		UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	host->uhs2_caps.n_lss_dir_set = host->uhs2_dev_prop.n_lss_dir_set;
+	payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
+			UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+			host->uhs2_dev_prop.n_lss_sync_set;
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload[0]=0x%x,"
+		" payload[1] = 0x%x.\n",
+		header, arg, payload[0], payload[1]);
+
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("SET_COMMON_CFG: LINK-TRAN Settings.\n");
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
+
+	plen = 2;
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+
+	if (host->uhs2_dev_prop.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
+		host->uhs2_dev_prop.maxblk_len_set =
+			UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
+	else
+		host->uhs2_dev_prop.maxblk_len_set =
+			min(host->uhs2_dev_prop.maxblk_len,
+			host->uhs2_caps.maxblk_len);
+	host->uhs2_caps.maxblk_len_set = host->uhs2_dev_prop.maxblk_len_set;
+
+	host->uhs2_dev_prop.n_fcu_set =
+		min(host->uhs2_dev_prop.n_fcu,
+		host->uhs2_caps.n_fcu);
+	host->uhs2_caps.n_fcu_set = host->uhs2_dev_prop.n_fcu_set;
+
+	host->uhs2_dev_prop.n_data_gap_set =
+		min(host->uhs2_caps.n_data_gap,
+		host->uhs2_dev_prop.n_data_gap);
+	host->uhs2_caps.n_data_gap_set = host->uhs2_dev_prop.n_data_gap_set;
+
+	host->uhs2_caps.max_retry_set = 3;
+	host->uhs2_dev_prop.max_retry_set = host->uhs2_caps.max_retry_set;
+
+	payload[0] = (host->uhs2_dev_prop.maxblk_len_set <<
+			UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
+			(host->uhs2_dev_prop.max_retry_set <<
+			UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
+			(host->uhs2_dev_prop.n_fcu_set <<
+			UHS2_DEV_CONFIG_N_FCU_POS);
+	payload[1] = host->uhs2_dev_prop.n_data_gap_set;
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload[0] = 0x%x,"
+		" payload[1] = 0x%x.\n",
+		header, arg, payload[0], payload[1]);
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	DBG("SET_COMMON_CFG: Set Config Completion.\n");
+	arg = (((UHS2_DEV_CONFIG_GEN_SET + 1) & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		((UHS2_DEV_CONFIG_GEN_SET + 1) >> 8);
+
+	plen = 1;
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	payload[0] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
+		header, arg, payload[0]);
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				resp, resp_len);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if ((resp[4] & 0x80) != 0x80) {
+		pr_err("%s: %s: Config Complete is not set!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	/* Set host Config Setting registers */
+	if (host->ops->uhs2_set_reg(host, SET_CONFIG)) {
+		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int uhs2_go_dormant(struct mmc_host *host, bool hibernate)
+{
+	struct mmc_command cmd = {0};
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 1;
+	int err;
+
+	BUG_ON(!host->ops->uhs2_set_reg);
+
+	/* Disable Normal INT */
+	if (host->ops->uhs2_set_reg(host, DISABLE_INT)) {
+		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	/* TODO: shall I use host->uhs2_dev_prop.node_id here? */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
+		host->uhs2_dev_prop.node_id;
+
+	arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
+
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+	if (hibernate)
+		payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
+
+	DBG("Begin GO_DORMANT_STATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		header, arg, payload[0]);
+	err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+				NULL, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Check Dormant State in Present */
+	if (host->ops->uhs2_set_reg(host, CHECK_DORMANT)) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	host->ios.clock = 0;
+	if (hibernate)
+		host->ios.vdd = -1;
+	mmc_set_ios(host);
+
+	return 0;
+}
+
+static int uhs2_change_speed(struct mmc_host *host)
+{
+	int err;
+
+	BUG_ON(!host->ops->uhs2_detect_init);
+	BUG_ON(!host->ops->uhs2_set_reg);
+
+	err = uhs2_go_dormant(host, false);
+	if (err) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Enable Normal INT */
+	if (host->ops->uhs2_set_reg(host, ENABLE_INT)) {
+		pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	/* Change Speed Range */
+	if (host->ops->uhs2_set_reg(host, SET_SPEED_B)) {
+		pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	/* TODO: if I set clock in sdhci_uhs2_interface_detect(), I should
+	 * remove below codes.
+	 */
+	host->ios.clock = UHS2_RCLK_MAX;
+	mmc_set_ios(host);
+
+	if (host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: %s: uhs2_detect_init() fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	DBG("Change to Speed Range B succeeds.\n");
+	return 0;
+}
+
+int mmc_uhs2_try_frequency(struct mmc_host *host, unsigned freq)
+{
+	int err = -EIO;
+
+	BUG_ON(!host->ops->uhs2_detect_init);
+	BUG_ON(!host->ops->uhs2_set_reg);
+
+	host->flags |= MMC_UHS2_SUPPORT;
+	host->f_init = freq;
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: trying to init card at %u Hz\n",
+		 mmc_hostname(host), __func__, host->f_init);
+#endif
+
+	uhs2_power_up(host);
+	if (host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
+		err = UHS2_PHY_INIT_ERR;
+		goto init_fail;
+	}
+
+	if (uhs2_dev_init(host)) {
+		pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_enum(host)) {
+		pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_config_read(host)) {
+		pr_err("%s: UHS2 INQUIRY_CONFIG fail!\n", mmc_hostname(host));
+		goto init_fail;
+	}
+
+	if (uhs2_config_write(host)) {
+		pr_err("%s: UHS2 SET_COMMON_CONFIG fail!\n",
+			mmc_hostname(host));
+		goto init_fail;
+	}
+
+	mmc_delay(10);
+
+	/* Change to Speed Range B if it is supported */
+	if (host->flags & MMC_UHS2_SPEED_B)
+		if (uhs2_change_speed(host)) {
+			pr_err("%s: UHS2 uhs2_change_speed() fail!\n",
+				mmc_hostname(host));
+			goto init_fail;
+		}
+
+
+	host->flags |= MMC_UHS2_INITIALIZED;
+
+	mmc_go_idle(host);
+
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	/* On market, only can some SD cards support UHS-II so only call SD
+	 * attach process here.
+	 */
+	if (!mmc_attach_sd(host))
+		return 0;
+
+init_fail:
+	mmc_power_off(host);
+	if (host->flags & MMC_UHS2_INITIALIZED)
+		host->flags &= ~MMC_UHS2_INITIALIZED;
+	host->flags &= ~MMC_UHS2_SUPPORT;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_uhs2_try_frequency);
diff --git a/drivers/mmc/core/uhs2.h b/drivers/mmc/core/uhs2.h
new file mode 100644
index 0000000..6f21370
--- /dev/null
+++ b/drivers/mmc/core/uhs2.h
@@ -0,0 +1,26 @@
+/*
+ *  driver/mmc/core/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+#ifndef MMC_UHS2_H
+#define MMC_UHS2_H
+
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+
+#define UHS2_PHY_INIT_ERR	1
+
+extern int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq);
+extern void uhs2_power_up(struct mmc_host *host);
+extern int mmc_uhs2_try_frequency(struct mmc_host *host, unsigned freq);
+
+#endif /* MMC_UHS2_H */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index cb2b040..1eba129 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/mmc/uhs2.h>
 
 struct request;
 struct mmc_data;
@@ -101,6 +102,9 @@ struct mmc_command {
 
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
+	struct uhs2_command	*uhs2_cmd;	/* UHS2 command */
+	u8			*uhs2_resp;	/* UHS2 native cmd resp */
+	u8			uhs2_resp_len;	/* UHS2 native cmd resp len */
 };
 
 struct mmc_data {
@@ -198,6 +202,8 @@ extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+extern void mmc_set_ios(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9f32270..a79e2aa 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -19,10 +19,12 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/pm.h>
+#include <linux/mmc/uhs2.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
 	unsigned short	vdd;
+	unsigned short	vdd2;
 
 /* vdd stores the bit number of the selected voltage range from below. */
 
@@ -63,6 +65,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_DDR52	8
 #define MMC_TIMING_MMC_HS200	9
 #define MMC_TIMING_MMC_HS400	10
+#define MMC_TIMING_UHS2		11
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -147,6 +150,9 @@ struct mmc_host_ops {
 	 */
 	int	(*multi_io_quirk)(struct mmc_card *card,
 				  unsigned int direction, int blk_size);
+	/* UHS2 interfaces */
+	int	(*uhs2_detect_init)(struct mmc_host *host);
+	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 };
 
 struct mmc_card;
@@ -200,6 +206,7 @@ struct regulator;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };
 
@@ -215,10 +222,12 @@ struct mmc_host {
 	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
+	u32			ocr_avail_uhs2;	/* UHS2-specific OCR */
 	struct notifier_block	pm_notify;
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
+	u32			max_current_180_vdd2;
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
@@ -237,6 +246,7 @@ struct mmc_host {
 #define MMC_VDD_33_34		0x00200000	/* VDD voltage 3.3 ~ 3.4 */
 #define MMC_VDD_34_35		0x00400000	/* VDD voltage 3.4 ~ 3.5 */
 #define MMC_VDD_35_36		0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_VDD2_165_195	0x00000080	/* VDD2 voltage 1.65 - 1.95 */
 
 	u32			caps;		/* Host capabilities */
 
@@ -266,6 +276,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_UHS2		(1 << 26)	/* Host supports UHS2 mode */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
@@ -294,6 +305,17 @@ struct mmc_host {
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
+	struct uhs2_host_caps	uhs2_caps;	/* UHS2 host capabilities */
+	struct uhs2_card_prop	uhs2_dev_prop;	/* UHS2 device properties */
+	u32			group_desc;	/* UHS2 property */
+	int			flags;
+#define MMC_UHS2_SUPPORT	(1 << 0)
+#define MMC_UHS2_INITIALIZED	(1 << 1)
+#define MMC_UHS2_2L_HD		(1 << 2)
+#define MMC_UHS2_APP_CMD	(1 << 3)
+#define MMC_UHS2_SPEED_B	(1 << 4)
+#define MMC_SUPPORT_ADMA3	(1 << 5)
+
 #ifdef CONFIG_MMC_CLKGATE
 	int			clk_requests;	/* internal reference counter */
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
@@ -519,4 +541,9 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
 	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_card *card)
+{
+	return (card->host->flags & MMC_UHS2_SUPPORT) &&
+		(card->host->flags & MMC_UHS2_INITIALIZED);
+}
 #endif /* LINUX_MMC_HOST_H */
diff --git a/include/linux/mmc/uhs2.h b/include/linux/mmc/uhs2.h
new file mode 100644
index 0000000..b0e805e
--- /dev/null
+++ b/include/linux/mmc/uhs2.h
@@ -0,0 +1,274 @@
+/*
+ *  linux/drivers/mmc/host/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+#ifndef LINUX_MMC_UHS2_H
+#define LINUX_MMC_UHS2_H
+
+struct mmc_request;
+
+/* LINK Layer definition */
+/* UHS2 Header */
+#define UHS2_NATIVE_PACKET_POS	7
+#define UHS2_NATIVE_PACKET	(1 << UHS2_NATIVE_PACKET_POS)
+
+#define UHS2_PACKET_TYPE_POS	4
+#define UHS2_PACKET_TYPE_CCMD	(0 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DCMD	(1 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_RES	(2 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DATA	(3 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_MSG	(7 << UHS2_PACKET_TYPE_POS)
+
+#define UHS2_DEST_ID_MASK	0x0F
+#define UHS2_DEST_ID		0x1
+
+#define UHS2_SRC_ID_POS		12
+#define UHS2_SRC_ID_MASK	0xF000
+
+#define UHS2_TRANS_ID_POS	8
+#define UHS2_TRANS_ID_MASK	0x0700
+
+/* UHS2 MSG */
+#define UHS2_MSG_CTG_POS	5
+#define UHS2_MSG_CTG_LMSG	0x00
+#define UHS2_MSG_CTG_INT	0x60
+#define UHS2_MSG_CTG_AMSG	0x80
+
+#define UHS2_MSG_CTG_FCREQ	0x00
+#define UHS2_MSG_CTG_FCRDY	0x01
+#define UHS2_MSG_CTG_STAT	0x02
+
+#define UHS2_MSG_CODE_POS			8
+#define UHS2_MSG_CODE_FC_UNRECOVER_ERR		0x8
+#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR	0x8
+#define UHS2_MSG_CODE_STAT_RECOVER_ERR		0x1
+
+/* TRANS Layer definition */
+
+/* Native packets*/
+#define UHS2_NATIVE_CMD_RW_POS	7
+#define UHS2_NATIVE_CMD_WRITE	(1 << UHS2_NATIVE_CMD_RW_POS)
+#define UHS2_NATIVE_CMD_READ	(0 << UHS2_NATIVE_CMD_RW_POS)
+
+#define UHS2_NATIVE_CMD_PLEN_POS	4
+#define UHS2_NATIVE_CMD_PLEN_4B		(1 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_8B		(2 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_16B	(3 << UHS2_NATIVE_CMD_PLEN_POS)
+
+#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK	0xF00
+#define UHS2_NATIVE_CCMD_MIOADR_MASK		0x0F
+
+#define UHS2_NATIVE_CCMD_LIOADR_POS		8
+#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK	0x0FF
+
+#define UHS2_DCMD_DM_POS	6
+#define UHS2_DCMD_2L_HD_MODE	(1 << UHS2_DCMD_DM_POS)
+#define UHS2_DCMD_LM_POS	5
+#define UHS2_DCMD_LM_TLEN_EXIST	(1 << UHS2_DCMD_LM_POS)
+#define UHS2_DCMD_TLUM_POS	4
+#define UHS2_DCMD_TLUM_BYTE_MODE	(1 << UHS2_DCMD_TLUM_POS)
+#define UHS2_NATIVE_DCMD_DAM_POS	3
+#define UHS2_NATIVE_DCMD_DAM_IO		(1 << UHS2_NATIVE_DCMD_DAM_POS)
+/*
+ * Per UHS2 spec, DCMD payload should be MSB first. There may be
+ * two types of data be assembled to MSB:
+ * 1. TLEN: Input block size for signle read/write and number of blocks
+ * for multiple read/write to calculate TLEN as MSB first per spec.
+ * 2. SD command argument.
+ */
+static inline u32 uhs2_dcmd_convert_msb(u32 input)
+{
+	u32 ret = 0;
+
+	ret = ((input & 0xFF) << 24) |
+		(((input >> 8) & 0xFF) << 16) |
+		(((input >> 16) & 0xFF) << 8) |
+		((input >> 24) & 0xFF);
+	return ret;
+}
+
+#define UHS2_RES_NACK_POS	7
+#define UHS2_RES_NACK_MASK	(0x1 << UHS2_RES_NACK_POS)
+
+#define UHS2_RES_ECODE_POS	4
+#define UHS2_RES_ECODE_MASK	0x7
+#define UHS2_RES_ECODE_COND	1
+#define UHS2_RES_ECODE_ARG	2
+#define UHS2_RES_ECODE_GEN	3
+
+/* IOADR of device registers */
+#define UHS2_IOADR_GENERIC_CAPS		0x00
+#define UHS2_IOADR_PHY_CAPS		0x02
+#define UHS2_IOADR_LINK_CAPS		0x04
+#define UHS2_IOADR_RSV_CAPS		0x06
+#define UHS2_IOADR_GENERIC_SETTINGS	0x08
+#define UHS2_IOADR_PHY_SETTINGS		0x0A
+#define UHS2_IOADR_LINK_SETTINGS	0x0C
+#define UHS2_IOADR_PRESET		0x40
+
+/* SD application packets */
+#define UHS2_SD_CMD_INDEX_POS		8
+
+#define UHS2_SD_CMD_APP_POS		14
+#define UHS2_SD_CMD_APP			(1 << UHS2_SD_CMD_APP_POS)
+
+struct uhs2_command {
+	u16	header;
+	u16	arg;
+	u32	*payload;
+	u32	payload_len;
+	u32	packet_len;
+	u8	*resp;
+	u8	resp_len;
+};
+
+struct uhs2_host_caps {
+	u32	dap;
+	u32	gap;
+	u32	maxblk_len;
+	u32	n_fcu;
+	u8	n_lanes;
+	u8	addr64;
+	u8	card_type;
+	u8	phy_rev;
+	u8	speed_range;
+	u8	can_hibernate;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_rev;
+	u8	host_type;
+	u8	n_data_gap;
+
+	u32	maxblk_len_set;
+	u32	n_fcu_set;
+	u8	n_lanes_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	max_retry_set;
+};
+
+struct uhs2_card_prop {
+	u32	node_id;
+	u32	dap;
+	u32	gap;
+	u32	n_fcu;
+	u32	maxblk_len;
+	u8	n_lanes;
+	u8	dadr_len;
+	u8	app_type;
+	u8	phy_minor_rev;
+	u8	phy_major_rev;
+	u8	can_hibernate;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_minor_rev;
+	u8	link_major_rev;
+	u8	dev_type;
+	u8	n_data_gap;
+
+	u32	n_fcu_set;
+	u32	maxblk_len_set;
+	u8	n_lanes_set;
+	u8	speed_range_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	pwrctrl_mode_set;
+	u8	max_retry_set;
+
+	u8	cfg_complete;
+};
+
+enum uhs2_act {
+	SET_CONFIG,
+	ENABLE_INT,
+	DISABLE_INT,
+	SET_SPEED_B,
+	CHECK_DORMANT,
+};
+
+/* UHS-II Device Registers */
+#define UHS2_DEV_CONFIG_REG	0x000
+
+/* General Caps and Settings registers */
+#define  UHS2_DEV_CONFIG_GEN_CAPS	(UHS2_DEV_CONFIG_REG + 0x000)
+#define   UHS2_DEV_CONFIG_N_LANES_POS	8
+#define   UHS2_DEV_CONFIG_N_LANES_MASK	0x3F
+#define   UHS2_DEV_CONFIG_2L_HD_FD	0x1
+#define   UHS2_DEV_CONFIG_2D1U_FD	0x2
+#define   UHS2_DEV_CONFIG_1D2U_FD	0x4
+#define   UHS2_DEV_CONFIG_2D2U_FD	0x8
+#define   UHS2_DEV_CONFIG_DADR_POS	14
+#define   UHS2_DEV_CONFIG_DADR_MASK	0x1
+#define   UHS2_DEV_CONFIG_APP_POS	16
+#define   UHS2_DEV_CONFIG_APP_MASK	0xFF
+#define   UHS2_DEV_CONFIG_APP_SD_MEM	0x1
+
+#define  UHS2_DEV_CONFIG_GEN_SET	(UHS2_DEV_CONFIG_REG + 0x008)
+#define   UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD	0x0
+#define   UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE	(0x1 << 31)
+
+/* PHY Caps and Settings registers */
+#define  UHS2_DEV_CONFIG_PHY_CAPS	(UHS2_DEV_CONFIG_REG + 0x002)
+#define   UHS2_DEV_CONFIG_PHY_MINOR_MASK	0xF
+#define   UHS2_DEV_CONFIG_PHY_MAJOR_POS		4
+#define   UHS2_DEV_CONFIG_PHY_MAJOR_MASK	0x3
+#define   UHS2_DEV_CONFIG_CAN_HIBER_POS		15
+#define   UHS2_DEV_CONFIG_CAN_HIBER_MASK	0x1
+#define  UHS2_DEV_CONFIG_PHY_CAPS1	(UHS2_DEV_CONFIG_REG + 0x003)
+#define   UHS2_DEV_CONFIG_N_LSS_SYN_MASK	0xF
+#define   UHS2_DEV_CONFIG_N_LSS_DIR_POS		4
+#define   UHS2_DEV_CONFIG_N_LSS_DIR_MASK	0xF
+
+#define  UHS2_DEV_CONFIG_PHY_SET	(UHS2_DEV_CONFIG_REG + 0x00A)
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_POS	6
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_A	0x0
+#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_B	0x1
+
+/* LINK-TRAN Caps and Settins registers */
+#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS	(UHS2_DEV_CONFIG_REG + 0x004)
+#define   UHS2_DEV_CONFIG_LT_MINOR_MASK		0xF
+#define   UHS2_DEV_CONFIG_LT_MAJOR_POS		4
+#define   UHS2_DEV_CONFIG_LT_MAJOR_MASK		0x3
+#define   UHS2_DEV_CONFIG_N_FCU_POS		8
+#define   UHS2_DEV_CONFIG_N_FCU_MASK		0xFF
+#define   UHS2_DEV_CONFIG_DEV_TYPE_POS		16
+#define   UHS2_DEV_CONFIG_DEV_TYPE_MASK		0x7
+#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_POS	20
+#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK	0xFFF
+#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS1	(UHS2_DEV_CONFIG_REG + 0x005)
+#define   UHS2_DEV_CONFIG_N_DATA_GAP_MASK	0xFF
+
+#define  UHS2_DEV_CONFIG_LINK_TRAN_SET	(UHS2_DEV_CONFIG_REG + 0x00C)
+#define   UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN	0x200
+#define   UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS	16
+
+/* Preset register */
+#define  UHS2_DEV_CONFIG_PRESET		(UHS2_DEV_CONFIG_REG + 0x040)
+
+#define UHS2_DEV_INT_REG	0x100
+
+#define UHS2_DEV_STATUS_REG	0x180
+
+#define UHS2_DEV_CMD_REG	0x200
+#define  UHS2_DEV_CMD_FULL_RESET	(UHS2_DEV_CMD_REG + 0x000)
+#define  UHS2_DEV_CMD_GO_DORMANT_STATE	(UHS2_DEV_CMD_REG + 0x001)
+#define   UHS2_DEV_CMD_DORMANT_HIBER	(0x1 << 7)
+#define  UHS2_DEV_CMD_DEVICE_INIT	(UHS2_DEV_CMD_REG + 0x002)
+#define  UHS2_DEV_CMD_ENUMERATE		(UHS2_DEV_CMD_REG + 0x003)
+#define  UHS2_DEV_CMD_TRANS_ABORT	(UHS2_DEV_CMD_REG + 0x004)
+
+#define UHS2_RCLK_MAX	52000000
+#define UHS2_RCLK_MIN	26000000
+
+#endif /* LINUX_MMC_UHS2_H */
-- 
1.7.9.5

