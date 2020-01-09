Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C160EC32771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C741206ED
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5747YHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgAIJN6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:13:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36886 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgAIJN6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:13:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so2935140pga.4;
        Thu, 09 Jan 2020 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lf8Al5jx4WypIpadexATGVi282uCLwWtCF9c64cXv90=;
        b=H5747YHM1pLN5ZY/NSIbRIMf2Lrye9ylfoN00DuibnCuQBB94Ps0D7KG1qgBqs9cnU
         WjFYbXqpVoALGdQwPIaGJjmxAXQf82e8EBtMH3LbZ3HNw6F+jBaRIosFAys5ndTweAB8
         PT6pwujvM6xVb8gjMjHp/v+WpYYCqGWQBb9Sl7A1+WcLKxD25BbOgH86V4LcBr2Slj4c
         kNEVzN5dqAZM2FAbWW5T6w4UQ3dcjvbxMsUywgxAhYAvtSl88GOxlgAvNSgmoyHDmMhL
         VnlABw1/oUhghpSM+JRQ73ksQuDmtxpoqz5jas/qBwB2eGd6hAFA0cl53eNonLQUZNCj
         6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lf8Al5jx4WypIpadexATGVi282uCLwWtCF9c64cXv90=;
        b=rcLbm/DthtQA3nGnfHSOcmcNXRx2IFHtgdwZ2Y46H1vWggpGq1mzAEqqKYkJWreB6n
         MkEZK9oVI97h2TnAdIYztUFIFmBN1plmswrhFQJ3Nt+zlvL4Th2RCPoOHqbj1nEXmyYN
         8PcvQt6EvGeuGxDyP5euuRf7ekXyHrlGAMFi7a3zMEKkfeMtcpPMHatvjjhB5w1MjEiz
         1zED7MQQCFS0k7n4sWemPBqPtLlhrYdPUyltO2UDXPH6QDT2zLprpnevzepQX06eTjGQ
         vA7YDc4MAPFdFbF+/sKOPqDO/3sqHqgwEK42jmqUlRH7ItX8cRwrtaSREh31QrVCU+XE
         6H3w==
X-Gm-Message-State: APjAAAXFLfHxTQGuzFJYD5ugUWxNmNGU5UgQtiZrQxzpyn2pNnGyGyRb
        i7d6LbsgIF+xoMX/AxanYqjqtO3S
X-Google-Smtp-Source: APXvYqwItd3GXVBCWDO3eXm6bNnl0fc3ZKzWjeydNzaSVIbcA9OEpvfZsCn1jEpdB8J8MxWTdb31iw==
X-Received: by 2002:a65:49ca:: with SMTP id t10mr10410522pgs.37.1578561236421;
        Thu, 09 Jan 2020 01:13:56 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x11sm6558297pfn.53.2020.01.09.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:13:55 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 2/6] mmc: core: Add UHS-II support in core layer
Date:   Thu,  9 Jan 2020 17:14:19 +0800
Message-Id: <e5dd700df4c52700ecb0002a1da985944eeb409d.1578560282.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560282.git.benchuanggli@gmail.com>
References: <cover.1578560282.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add UHS-II support in core layer

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/core/Makefile    |   3 +-
 drivers/mmc/core/block.c     |   7 +-
 drivers/mmc/core/bus.c       |   5 +-
 drivers/mmc/core/core.c      |  65 ++-
 drivers/mmc/core/core.h      |   3 +-
 drivers/mmc/core/regulator.c |  14 +
 drivers/mmc/core/sd.c        |  27 +-
 drivers/mmc/core/sd_ops.c    |  12 +
 drivers/mmc/core/uhs2.c      | 992 +++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h      |  23 +
 10 files changed, 1139 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 95ffe008ebdf..ddfda7a234cb 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,7 +8,8 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   slot-gpio.o regulator.o
+				   slot-gpio.o regulator.o \
+				   uhs2.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 95b41c0891d0..c5f6bfd05d49 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -56,6 +56,7 @@
 #include "mmc_ops.h"
 #include "quirks.h"
 #include "sd_ops.h"
+#include "uhs2.h"
 
 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
@@ -1551,6 +1552,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool do_multi;
+
+	do_multi = (card->host->flags & MMC_UHS2_INITIALIZED) ? true : false;
 
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
@@ -1561,7 +1565,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	if (brq->data.blocks > 1 || do_rel_wr) {
+	if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
 		/* SPI multiblock writes terminate using a special
 		 * token, not a STOP_TRANSMISSION request.
 		 */
@@ -1574,6 +1578,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.stop = NULL;
 		readcmd = MMC_READ_SINGLE_BLOCK;
 		writecmd = MMC_WRITE_BLOCK;
+		brq->cmd.uhs2_tmode0_flag = 1;
 	}
 	brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
 
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 74de3f2dda38..c1cd1079c186 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -336,8 +336,9 @@ int mmc_add_card(struct mmc_card *card)
 	} else {
 		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
+			mmc_card_uhs2(card) ? "ultra high speed 2 " :
+			(mmc_card_uhs(card) ? "ultra high speed 1 " :
+			(mmc_card_hs(card) ? "high speed " : "")),
 			mmc_card_hs400(card) ? "HS400 " :
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5eb0a1c..8f64dbaea5e6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
@@ -41,6 +42,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -51,6 +53,7 @@
 #define SD_DISCARD_TIMEOUT_MS	(250)
 
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
+static const unsigned int uhs2_freqs[] = { 52000000, 26000000 };
 
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
@@ -329,6 +332,11 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	if ((host->flags & MMC_UHS2_SUPPORT) &&
+	    (host->flags & MMC_UHS2_INITIALIZED) &&
+	    (mrq->cmd->uhs2_cmd == NULL))
+		uhs2_prepare_sd_cmd(host, mrq);
+
 	return 0;
 }
 
@@ -433,6 +441,14 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 		__mmc_start_request(host, mrq);
 	}
 
+	if (cmd && cmd->uhs2_cmd) {
+		pr_debug("%s: %s free uhs2_cmd!\n",
+			mmc_hostname(host), __func__);
+		kfree(cmd->uhs2_cmd->payload);
+		kfree(cmd->uhs2_cmd);
+		cmd->uhs2_cmd = NULL;
+	}
+
 	mmc_retune_release(host);
 }
 EXPORT_SYMBOL(mmc_wait_for_req_done);
@@ -897,7 +913,7 @@ EXPORT_SYMBOL(mmc_put_card);
  * Internal function that does the actual ios call to the host driver,
  * optionally printing some debug output.
  */
-static inline void mmc_set_ios(struct mmc_host *host)
+void mmc_set_ios(struct mmc_host *host)
 {
 	struct mmc_ios *ios = &host->ios;
 
@@ -909,14 +925,17 @@ static inline void mmc_set_ios(struct mmc_host *host)
 
 	host->ops->set_ios(host, ios);
 }
+EXPORT_SYMBOL(mmc_set_ios);
 
 /*
  * Control chip select pin on a host.
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
@@ -1332,6 +1351,11 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
+	if (host->flags & MMC_UHS2_SUPPORT) {
+		uhs2_power_up(host);
+		return;
+	}
+
 	mmc_pwrseq_pre_power_on(host);
 
 	host->ios.vdd = fls(ocr) - 1;
@@ -2194,9 +2218,11 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		if (!mmc_attach_sdio(host))
 			return 0;
 
-	if (!(host->caps2 & MMC_CAP2_NO_SD))
-		if (!mmc_attach_sd(host))
+	if (!(host->caps2 & MMC_CAP2_NO_SD)) {
+		/* set false for SD card */
+		if (!mmc_attach_sd(host, false))
 			return 0;
+	}
 
 	if (!(host->caps2 & MMC_CAP2_NO_MMC))
 		if (!mmc_attach_mmc(host))
@@ -2278,6 +2304,7 @@ void mmc_rescan(struct work_struct *work)
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
 	int i;
+	int err;
 
 	if (host->rescan_disable)
 		return;
@@ -2329,6 +2356,28 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}
 
+	if (host->caps & MMC_CAP_UHS2) {
+		/*
+		 * Start to try UHS-II initialization from 52MHz to 26MHz
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
@@ -2350,7 +2399,11 @@ void mmc_start_host(struct mmc_host *host)
 
 	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
 		mmc_claim_host(host);
-		mmc_power_up(host, host->ocr_avail);
+
+		/* Power up here will make UHS2 init ugly. */
+		if (!(host->caps & MMC_CAP_UHS2))
+			mmc_power_up(host, host->ocr_avail);
+
 		mmc_release_host(host);
 	}
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 575ac0257af2..1fb10c341b43 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -76,7 +76,7 @@ int _mmc_detect_card_removed(struct mmc_host *host);
 int mmc_detect_card_removed(struct mmc_host *host);
 
 int mmc_attach_mmc(struct mmc_host *host);
-int mmc_attach_sd(struct mmc_host *host);
+int mmc_attach_sd(struct mmc_host *host, bool flag_uhs2);
 int mmc_attach_sdio(struct mmc_host *host);
 
 /* Module parameters */
@@ -124,6 +124,7 @@ int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
 void mmc_release_host(struct mmc_host *host);
 void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
 void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
+void mmc_set_ios(struct mmc_host *host);
 
 /**
  *	mmc_claim_host - exclusively claim a host
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index b6febbcf8978..f9a643f653fe 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -236,6 +236,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vmmc2 = devm_regulator_get_optional(dev, "vmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -255,6 +256,19 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vmmc2)) {
+		if (PTR_ERR(mmc->supply.vmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vmmc2 regulator found\n");
+	} else {
+		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
+		if (ret > 0)
+			mmc->ocr_avail_uhs2 = ret;
+		else
+			dev_warn(dev, "Failed getting UHS2 OCR mask: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff5f5d6..b079f3f164fe 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -877,6 +877,19 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		err = mmc_read_switch(card);
 		if (err)
 			return err;
+		if (host->flags & MMC_UHS2_INITIALIZED) {
+			u8 status[64];
+			/*
+			 * send CMD6 to set Maximum Power Consumption
+			 * to get better performance
+			 */
+			err = mmc_sd_switch(card, 0, 3,
+					SD_SET_CURRENT_LIMIT_1000, status);
+			if (!err) {
+				err = mmc_sd_switch(card, 1, 3,
+					SD_SET_CURRENT_LIMIT_1000, status);
+			}
+		}
 	}
 
 	/*
@@ -1019,6 +1032,11 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
+	/* For UHS2, skip the UHS-I initialization. */
+	if ((host->flags & MMC_UHS2_SUPPORT) &&
+	    (host->flags & MMC_UHS2_INITIALIZED))
+		goto done;
+
 	/*
 	 * If the card has not been power cycled, it may still be using 1.8V
 	 * signaling. Detect that situation and try to initialize a UHS-I (1.8V)
@@ -1266,7 +1284,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 /*
  * Starting point for SD card init.
  */
-int mmc_attach_sd(struct mmc_host *host)
+int mmc_attach_sd(struct mmc_host *host, bool flag_uhs2)
 {
 	int err;
 	u32 ocr, rocr;
@@ -1300,6 +1318,13 @@ int mmc_attach_sd(struct mmc_host *host)
 
 	rocr = mmc_select_voltage(host, ocr);
 
+	/*
+	 * Some cards have zero value of rocr in UHS-II mode. Assign host's ocr
+	 * value to rocr.
+	 */
+	if (flag_uhs2 && !rocr)
+		rocr = host->ocr_avail;
+
 	/*
 	 * Can we support the voltage(s) of the card(s)?
 	 */
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..9dc296356928 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -26,6 +26,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	if (WARN_ON(card && card->host != host))
 		return -EINVAL;
 
+	/* UHS2 packet has APP bit so only set APP_CMD flag here.
+	 * Will set the APP bit when assembling UHS2 packet.
+	 */
+	if (host->flags &  MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		host->flags |= MMC_UHS2_APP_CMD;
+		return 0;
+	}
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
@@ -235,6 +244,7 @@ int mmc_app_send_scr(struct mmc_card *card)
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -282,6 +292,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
@@ -323,6 +334,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	cmd.opcode = SD_APP_SD_STATUS;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
new file mode 100644
index 000000000000..43ea155ccc59
--- /dev/null
+++ b/drivers/mmc/core/uhs2.c
@@ -0,0 +1,992 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/core/uhs2.c - UHS-II driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+
+#include <asm/byteorder.h>
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
+ * Payload, uhs2_cmd are all allocated which should be freed when
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
+	if (cmd == NULL)
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
+	pr_debug("%s: uhs2_cmd: header=0x%x arg=0x%x\n",
+		__func__, uhs2_cmd->header, uhs2_cmd->arg);
+	pr_debug("%s:           payload_len=%d packet_len=%d resp_len=%d\n",
+		__func__, uhs2_cmd->payload_len, uhs2_cmd->packet_len,
+		cmd->uhs2_resp_len);
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
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
+
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC  &&
+	     !cmd->uhs2_tmode0_flag) {
+		payload = kzalloc(2*sizeof(u32), GFP_KERNEL);
+		if (!payload)
+			return -ENOMEM;
+		plen = 8 / sizeof(u32);
+
+		if (host->flags & MMC_UHS2_2L_HD)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->data->blksz != 512 &&
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
+	pr_debug("%s: %s: sd_cmd->arg = 0x%x, payload[0]= 0x%x.\n",
+		 mmc_hostname(host), __func__, cmd->arg, payload[0]);
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
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_DEVICE_INIT >> 8);
+
+	/* need this for some cards */
+	cmd.busy_timeout = 1000;
+
+	for (cnt = 0; cnt < 30; cnt++) {
+		payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+		if (!payload)
+			return -ENOMEM;
+		payload[0] = ((dap & 0xF) << 12) |
+			(cf << 11) |
+			((gd & 0xF) << 4) |
+			(gap & 0xF);
+
+		err = uhs2_cmd_assemble(&cmd, header, arg, payload, plen,
+					resp, resp_len);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		DBG("Begin DEVICE_INIT, header=0x%x, arg=0x%x, payload=0x%x.\n",
+		    header, arg, payload[0]);
+
+		DBG("Sending DEVICE_INIT. Count = %d\n", cnt);
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
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
+			       mmc_hostname(host));
+			return -EIO;
+		}
+
+		if (resp[5] & 0x8) {
+			DBG("CF is set, device is initialized!\n");
+			host->group_desc = gd;
+			break;
+		}
+		gap1 = resp[4] & 0x0F;
+		if (gap == gap1)
+			gd++;
+	}
+	if (cnt == 30) {
+		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
+		       mmc_hostname(host));
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
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD |
+		 host->uhs2_dev_prop.node_id;
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
+	u32 nTry;
+	u32 *payload;
+	u8 nMinDataGap;
+	u8 plen = 1;
+	int err;
+	u8 resp[5] = {0};
+	u8 resp_len = 5;
+	/*
+	 * must long enough for RECV_SW_DIR == 2;
+	 * need lss_dir at least 4 for GL9755 device
+	 * max compitable gLssDir = 0
+	 */
+	u32 gLssDir = 0;
+
+	DBG("SET_COMMON_CFG: write Generic Settings.\n");
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD|host->uhs2_dev_prop.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
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
+		nMinDataGap = 1;
+	} else {
+		/* Only support 2L-FD so far */
+		host->flags &= ~MMC_UHS2_2L_HD;
+		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		host->uhs2_dev_prop.n_lanes_set =
+				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+		nMinDataGap = 3;
+	}
+
+	plen = 2;
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	payload[0] = host->uhs2_dev_prop.n_lanes_set <<
+		     UHS2_DEV_CONFIG_N_LANES_POS;
+	payload[1] = 0;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x\n", header, arg);
+	DBG("UHS2 write Generic Settings %08x %08x\n",
+		payload[0], payload[1]);
+	DBG("flags=%08x dev_prop.n_lanes_set=%x host_caps.n_lanes_set=%x\n",
+		host->flags,
+		host->uhs2_dev_prop.n_lanes_set,
+		host->uhs2_caps.n_lanes_set);
+
+	/*
+	 * There is no payload because per spec, there should be
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
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_PHY_SET >> 8);
+
+	for (nTry = 0; nTry < 2; nTry++) {
+		plen = 2;
+		payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+
+		if (host->uhs2_caps.speed_range ==
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
+			host->flags |= MMC_UHS2_SPEED_B;
+			host->uhs2_dev_prop.speed_range_set =
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
+			DBG("set dev_prop.speed_range_set to SPEED_B\n");
+		} else {
+			host->uhs2_dev_prop.speed_range_set =
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
+			host->flags &= ~MMC_UHS2_SPEED_B;
+			DBG("set dev_prop.speed_range_set to SPEED_A\n");
+		}
+
+		payload[0] = host->uhs2_dev_prop.speed_range_set <<
+				UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+
+		host->uhs2_dev_prop.n_lss_sync_set =
+			(min(host->uhs2_dev_prop.n_lss_sync,
+			host->uhs2_caps.n_lss_sync) >> 2) &
+			UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+		host->uhs2_caps.n_lss_sync_set =
+			host->uhs2_dev_prop.n_lss_sync_set;
+
+		if (nTry) {
+			host->uhs2_dev_prop.n_lss_dir_set =
+				(max(host->uhs2_dev_prop.n_lss_dir,
+				host->uhs2_caps.n_lss_dir) >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			host->uhs2_caps.n_lss_dir_set =
+				host->uhs2_dev_prop.n_lss_dir_set;
+			payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
+				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+				host->uhs2_dev_prop.n_lss_sync_set;
+		} else {
+			host->uhs2_caps.n_lss_dir_set =
+				(host->uhs2_dev_prop.n_lss_dir >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			host->uhs2_dev_prop.n_lss_dir_set =
+				((host->uhs2_caps.n_lss_dir >> 3) + 1) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+		}
+
+		if (!gLssDir) {
+			host->uhs2_dev_prop.n_lss_dir_set = 0;
+		} else {
+			host->uhs2_dev_prop.n_lss_dir_set =
+				max((u8)gLssDir,
+				host->uhs2_dev_prop.n_lss_dir_set);
+		}
+
+		payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
+				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+				host->uhs2_dev_prop.n_lss_sync_set;
+		payload[0] = cpu_to_be32(payload[0]);
+		payload[1] = cpu_to_be32(payload[1]);
+
+		DBG("UHS2 SET PHY Settings  %08x %08x\n",
+			payload[0], payload[1]);
+		DBG("host->flags=%08x dev_prop.speed_range_set=%x\n",
+				host->flags,
+				host->uhs2_dev_prop.speed_range_set);
+		DBG("dev_prop.n_lss_sync_set=%x host_caps.n_lss_sync_set=%x\n",
+				host->uhs2_dev_prop.n_lss_sync_set,
+				host->uhs2_caps.n_lss_sync_set);
+		DBG("dev_prop.n_lss_dir_set=%x host_caps.n_lss_dir_set=%x\n",
+				host->uhs2_dev_prop.n_lss_dir_set,
+				host->uhs2_caps.n_lss_dir_set);
+
+		DBG("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n",
+				header, arg);
+		DBG("\t\tpayload[0]=0x%x payload[1]=0x%x\n",
+				payload[0], payload[1]);
+
+		resp_len = 4;
+		memset(resp, 0, sizeof(resp));
+
+		err = uhs2_cmd_assemble(&cmd, header, arg,
+					payload, plen, resp, resp_len);
+
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD assembling err = 0x%x!\n",
+				mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+				mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (!(resp[2]&0x80))
+			break;
+
+		DBG("%s: %s: UHS2 SET PHY Settings fail, res= 0x%x!\n",
+			mmc_hostname(host), __func__,  resp[2]);
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
+		max(nMinDataGap, host->uhs2_dev_prop.n_data_gap);
+
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
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n", header, arg);
+	DBG("\t\tpayload[0]=0x%x payload[1]=0x%x\n", payload[0], payload[1]);
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
+	DBG("SET_COMMON_CFG: Set Config Completion.\n");
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	plen = 2;
+	payload = kcalloc(plen, sizeof(u32), GFP_KERNEL);
+	payload[0] = 0;
+	payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	DBG("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
+		header, arg, payload[0]);
+	resp_len = 5;
+	memset(resp, 0, sizeof(resp));
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
+	/* Disable Normal INT */
+	if (host->ops->uhs2_set_reg(host, DISABLE_INT)) {
+		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
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
+	host->ops->uhs2_disable_clk(host);
+
+	return 0;
+}
+
+static int uhs2_change_speed(struct mmc_host *host)
+{
+	int err;
+
+	/* Change Speed Range */
+	if (host->ops->uhs2_set_reg(host, SET_SPEED_B)) {
+		pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	err = uhs2_go_dormant(host, false);
+	if (err) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* restore sd clock */
+	mdelay(5);
+	host->ops->uhs2_enable_clk(host);
+
+	/* Enable Normal INT */
+	if (host->ops->uhs2_set_reg(host, ENABLE_INT)) {
+		pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+
+	if (host->ops->uhs2_detect_init(host)) {
+		pr_err("%s: %s: uhs2_detect_init() fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int mmc_uhs2_try_frequency(struct mmc_host *host, unsigned int freq)
+{
+	int err = -EIO;
+
+	host->flags |= MMC_UHS2_SUPPORT;
+	host->f_init = freq;
+
+	pr_debug("%s: %s: trying to init card at %u Hz\n",
+		 mmc_hostname(host), __func__, host->f_init);
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
+	host->flags |= MMC_UHS2_INITIALIZED;
+
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	/* On market, only can some SD cards support UHS-II so only call SD
+	 * attach process here.
+	 */
+	err = mmc_attach_sd(host, true);
+
+	if (!err)
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
+
+int uhs2_abort_trans(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	u16 header = 0, arg = 0;
+	int err;
+	u8 resp[10] = {0};
+	u8 resp_len = 4;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
+		host->uhs2_dev_prop.node_id;
+
+	arg = ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		(UHS2_DEV_CMD_TRANS_ABORT >> 8);
+
+	err = uhs2_cmd_assemble(&cmd, header, arg, NULL, 0,
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
+	pr_warn("%s: Abort Tran response is: ", mmc_hostname(host));
+	for (i = 0; i < 0x4; i++)
+		pr_warn("%s: %02x\n", __func__, resp[i]);
+	pr_warn("\n");
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uhs2_abort_trans);
diff --git a/drivers/mmc/core/uhs2.h b/drivers/mmc/core/uhs2.h
new file mode 100644
index 000000000000..60fecf25db0a
--- /dev/null
+++ b/drivers/mmc/core/uhs2.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  driver/mmc/core/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
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
+extern int mmc_uhs2_try_frequency(struct mmc_host *host, unsigned int freq);
+extern int uhs2_abort_trans(struct mmc_host *host);
+
+#endif /* MMC_UHS2_H */
-- 
2.24.1

