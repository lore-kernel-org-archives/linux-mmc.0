Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD1C2D0C2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD302053B
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXH9pXQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfL3Lja (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:39:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40629 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfL3Lj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 06:39:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so18131900pfh.7;
        Mon, 30 Dec 2019 03:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9wT++w2if1fwLVZA3XWmfSTfJx0t3wI16JAOEfDvNQ=;
        b=iXH9pXQgbPwT6mWzd/rPRRq0Mm1yhWvCninDys7C1ea6kru61Xb80qKgR2ww9PGi4m
         lZoJ4UuBO9/a/IWYGl64T+EijVfExcGxNSTOGGNL6tgXp0miwU72m00FQYdrjJegisrz
         qRuzCS3uimvSVkW+tbHGYKOQ9r72AQv7E3nRZM2nRsViIQkyExrJHA+hfQ4IYB7J8WaN
         iCAWASsKLuE8WaV8f8/5erYQoZc3MVH7bonZkut7ppBievlyURIc2SwHnGTYMx5q7Kf0
         k9JTYeFfXHYckIZWXX17z4HCWFR7kqvvAlx/OTEGSbGsbvwBqkdsFhQPBGSqnQRkwW5m
         FDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9wT++w2if1fwLVZA3XWmfSTfJx0t3wI16JAOEfDvNQ=;
        b=ASBtLnH9+p/hAN18tigL3F+3TFrV4jOmsDXzp2A16czd0iK+RlV57gZCzBHnKR/uHM
         1r4AvFssvpqL2iJAjAWWh5LN+775EJ/ex69o2BvSKJtL4rhbsSjH0ESNJ0+KJ5EH1xp/
         LjY2DcCVBncR2tkBmjjY57zATr2wCHkGVI7OXJUJQ6QUOy/nASCVRutOg+QYQU00jLoD
         Gpx8hNhjSbflgq3dPNvo3RxeBQySnhVw3vwFm2zsimoW21yPRKVqXR/EHCXKyS+AeoFy
         iKhV+kjZ1hM3qE7SZgAX4XcN6ClRkYA02wfF9Fy+UUhO3n2uI1cmWiRk5k7EEl3DDv2x
         LGdw==
X-Gm-Message-State: APjAAAXHwTVJZml5HUo5QRm+146wZFwudnAEMH+X5+22NW+stmqsE15Z
        AI1TD5FxbA/pKoZO77vScd8=
X-Google-Smtp-Source: APXvYqxVl2tg/Ia0LTfKM35YPsCQYfBfqWHgTr8C2TgoEVH42y3pk1tXpoMhVYrMOttvfZUcPoAd1g==
X-Received: by 2002:a63:1853:: with SMTP id 19mr69208293pgy.170.1577705966519;
        Mon, 30 Dec 2019 03:39:26 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id o184sm47447689pgo.62.2019.12.30.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 03:39:25 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC,PATCH 3/6] mmc: host: Add UHS-II support in host layer
Date:   Mon, 30 Dec 2019 19:39:37 +0800
Message-Id: <20191230113937.38046-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add UHS-II support in host layer

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/Makefile                  |   1 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 276 ++++++--
 drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
 drivers/mmc/host/sdhci-of-at91.c           |   6 +-
 drivers/mmc/host/sdhci-omap.c              |   2 +-
 drivers/mmc/host/sdhci-pci-core.c          |   4 +-
 drivers/mmc/host/sdhci-pxav3.c             |   4 +-
 drivers/mmc/host/sdhci-uhs2.c              | 751 +++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h              |  34 +
 drivers/mmc/host/sdhci-xenon.c             |   4 +-
 drivers/mmc/host/sdhci.h                   | 284 +++++++-
 drivers/mmc/host/sdhci_am654.c             |   4 +-
 include/linux/mmc/uhs2.h                   | 270 ++++++++
 13 files changed, 1582 insertions(+), 62 deletions(-)
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 11c4598e91d9..54fa6511dd48 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+sdhci-y				+= sdhci-core.o sdhci-uhs2.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci-core.c
similarity index 94%
rename from drivers/mmc/host/sdhci.c
rename to drivers/mmc/host/sdhci-core.c
index b056400e34b1..8f396d1de208 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci-core.c
@@ -30,8 +30,12 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
+#include <linux/pci.h>
 
 #include "sdhci.h"
+#include "sdhci-uhs2.h"
+#include "sdhci-pci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -46,10 +50,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_finish_data(struct sdhci_host *);
-
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
@@ -109,6 +109,29 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
+		SDHCI_DUMP("==================== UHS2 ==================\n");
+		SDHCI_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			   sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+		SDHCI_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_COMMAND),
+			   sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+		SDHCI_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			   sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+		SDHCI_DUMP("Dev Int Code:  0x%08x\n",
+			   sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+		SDHCI_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			   sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+		SDHCI_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
+		SDHCI_DUMP("ErrSigEn:  0x%08x\n",
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
+	}
+
 	SDHCI_DUMP("============================================\n");
 }
 EXPORT_SYMBOL_GPL(sdhci_dumpregs);
@@ -187,13 +210,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(host->mmc->parent);
 }
 
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(host->mmc->parent);
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
 
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
@@ -1011,6 +1035,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 
 		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+
+		if (host->mmc->flags & MMC_UHS2_SUPPORT)
+			sdhci_uhs2_set_timeout(host);
 	}
 }
 
@@ -1122,21 +1149,29 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
-	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
-		     SDHCI_BLOCK_SIZE);
-
-	/*
-	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
-	 * can be supported, in that case 16-bit block count register must be 0.
-	 */
-	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
-	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
-		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
-			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
-		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	if (host->mmc->flags & MMC_UHS2_SUPPORT &&
+	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
+		sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
 	} else {
-		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+		/* Set the DMA boundary value and block size */
+		sdhci_writew(host,
+			     SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
+			     SDHCI_BLOCK_SIZE);
+
+		/*
+		 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit
+		 * Block Count can be supported, in that case 16-bit block
+		 * count register must be 0.
+		 */
+		if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+		    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+			if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+				sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+			sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+		} else {
+			sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+		}
 	}
 }
 
@@ -1190,6 +1225,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
+	if (host->mmc->flags & MMC_UHS2_SUPPORT) {
+		sdhci_uhs2_set_transfer_mode(host, cmd);
+		return;
+	}
+
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
@@ -1272,14 +1312,15 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 		sdhci_led_deactivate(host);
 }
 
-static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	__sdhci_finish_mrq(host, mrq);
 
 	queue_work(host->complete_wq, &host->complete_work);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
 
-static void sdhci_finish_data(struct sdhci_host *host)
+void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1313,6 +1354,11 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
 
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		__sdhci_finish_mrq(host, data->mrq);
+		return;
+	}
+
 	/*
 	 * Need to send CMD12 if -
 	 * a) open-ended multiblock transfer (no CMD23)
@@ -1337,6 +1383,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		__sdhci_finish_mrq(host, data->mrq);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_data);
 
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
@@ -1386,8 +1433,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_prepare_data(host, cmd);
 
-	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
-
 	sdhci_set_transfer_mode(host, cmd);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
@@ -1426,6 +1471,12 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
+	if (host->mmc->flags &  MMC_UHS2_SUPPORT) {
+		sdhci_uhs2_send_command(host, cmd);
+		return;
+	}
+	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -1453,10 +1504,13 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
+	int uhs2_flag = 0;
 
-	host->cmd = NULL;
-
-	if (cmd->flags & MMC_RSP_PRESENT) {
+	if (host->mmc->flags & MMC_UHS2_SUPPORT) {
+		sdhci_uhs2_finish_command(host);
+		uhs2_flag = 1;
+	} else if (cmd->flags & MMC_RSP_PRESENT) {
+		host->cmd = NULL;
 		if (cmd->flags & MMC_RSP_136) {
 			sdhci_read_rsp_136(host, cmd);
 		} else {
@@ -1464,6 +1518,9 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
+	if (!uhs2_flag)
+		host->cmd = NULL;
+
 	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
 		mmc_command_done(host->mmc, cmd->mrq);
 
@@ -1483,6 +1540,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
 			   cmd == host->data_cmd) {
 			/* Command complete before busy is ended */
+			host->cmd = NULL;
 			return;
 		}
 	}
@@ -1499,6 +1557,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		if (!cmd->data)
 			__sdhci_finish_mrq(host, cmd->mrq);
 	}
+
+	host->cmd = NULL;
 }
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
@@ -1526,6 +1586,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_UHS2:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -1697,12 +1760,16 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
 static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
-				unsigned short vdd)
+				unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 
 	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 
+	if (mmc->caps & MMC_CAP_UHS2 &&
+		!IS_ERR(mmc->supply.vmmc2))
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, vdd2);
+
 	if (mode != MMC_POWER_OFF)
 		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
 	else
@@ -1710,7 +1777,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 }
 
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd)
+			   unsigned short vdd, unsigned short vdd2)
 {
 	u8 pwr = 0;
 
@@ -1741,6 +1808,20 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 		}
 	}
 
+	if (mode != MMC_POWER_OFF) {
+		if (vdd2 != (unsigned short)-1) {
+			switch (1 << vdd2) {
+			case MMC_VDD2_165_195:
+				pwr |= SDHCI_VDD2_POWER_180;
+				break;
+			default:
+				WARN(1, "%s: Invalid vdd2 %#x\n",
+				     mmc_hostname(host->mmc), vdd2);
+				break;
+			}
+		}
+	}
+
 	if (host->pwr == pwr)
 		return;
 
@@ -1767,8 +1848,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
 		pwr |= SDHCI_POWER_ON;
+		if (vdd2 != (unsigned short)-1)
+			pwr |= SDHCI_VDD2_POWER_ON;
 
+		sdhci_writeb(host, pwr&0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
 
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_on(host);
@@ -1784,12 +1870,12 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
 
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
+		     unsigned short vdd, unsigned short vdd2)
 {
 	if (IS_ERR(host->mmc->supply.vmmc))
-		sdhci_set_power_noreg(host, mode, vdd);
+		sdhci_set_power_noreg(host, mode, vdd, vdd2);
 	else
-		sdhci_set_power_reg(host, mode, vdd);
+		sdhci_set_power_reg(host, mode, vdd, vdd2);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_power);
 
@@ -1890,6 +1976,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u8 ctrl;
+	u16 ctrl_2;
 
 	if (ios->power_mode == MMC_POWER_UNDEFINED)
 		return;
@@ -1898,6 +1985,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    ios->power_mode == MMC_POWER_OFF)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (host->mmc->caps & MMC_CAP_UHS2 &&
+		    !IS_ERR(mmc->supply.vmmc2) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
 		return;
 	}
 
@@ -1916,6 +2007,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
+		if (ios->timing == MMC_TIMING_UHS2)
+			host->timing = ios->timing;
+
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -1933,9 +2027,19 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	if (host->ops->set_power)
-		host->ops->set_power(host, ios->power_mode, ios->vdd);
+		host->ops->set_power(host, ios->power_mode, ios->vdd, -1);
 	else
-		sdhci_set_power(host, ios->power_mode, ios->vdd);
+		sdhci_set_power(host, ios->power_mode, ios->vdd, -1);
+
+	/* 4.0 host support */
+	if (host->version >= SDHCI_SPEC_400) {
+		/* UHS2 Support */
+		if (host->mmc->flags & MMC_UHS2_SUPPORT &&
+		    host->mmc->caps & MMC_CAP_UHS2) {
+			sdhci_uhs2_do_set_ios(host, ios);
+			return;
+		}
+	}
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
@@ -1960,7 +2064,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	if (host->version >= SDHCI_SPEC_300) {
-		u16 clk, ctrl_2;
+		u16 clk;
 
 		if (!host->preset_enabled) {
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
@@ -2172,8 +2276,12 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	/*
 	 * Signal Voltage Switching is only applicable for Host Controllers
 	 * v3.00 and above.
+	 * But for UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage siwtch required.
 	 */
-	if (host->version < SDHCI_SPEC_300)
+	if (host->version < SDHCI_SPEC_300 ||
+	    (host->version >= SDHCI_SPEC_400 &&
+	    host->flags & SDHCI_USE_UHS2))
 		return 0;
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -2502,7 +2610,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2530,6 +2638,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
@@ -2602,6 +2711,64 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static int sdhci_uhs2_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = sdhci_uhs2_do_detect_init(host);
+
+	return ret;
+}
+
+static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = sdhci_uhs2_do_set_reg(host, act);
+
+	return ret;
+}
+
+void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_disable_clk);
+
+void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ktime_t timeout;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_enable_clk);
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -2617,6 +2784,10 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.uhs2_detect_init	= sdhci_uhs2_detect_init,
+	.uhs2_set_reg		= sdhci_uhs2_set_reg,
+	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
+	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
 };
 
 /*****************************************************************************\
@@ -2717,11 +2888,16 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		/* Spec says we should do both at the same time, but Ricoh
-		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-
+		if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+			sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		} else {
+			/*
+			 * Spec says we should do both at the same time, but
+			 * Ricoh controllers do not like that.
+			 */
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
+		}
 		host->pending_reset = false;
 	}
 
@@ -3073,6 +3249,11 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 				  SDHCI_INT_BUS_POWER);
 		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
+		if (intmask & SDHCI_INT_ERROR &&
+		    host->mmc->flags & MMC_UHS2_SUPPORT) {
+			sdhci_uhs2_irq(host);
+		}
+
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 				      SDHCI_CARD_PRESENT;
@@ -3758,6 +3939,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 		       mmc_hostname(mmc), host->version);
 	}
 
+	if ((host->version >= SDHCI_SPEC_400) &&
+	    (host->caps1 & SDHCI_SUPPORT_UHS2) &&
+	    host->v4_mode) {
+		mmc->caps |= MMC_CAP_UHS2;
+		mmc->flags |= MMC_UHS2_SUPPORT;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
@@ -4236,6 +4424,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 		/* This may alter mmc->*_blk_* parameters */
 		sdhci_allocate_bounce_buffer(host);
 
+	if (host->version >= SDHCI_SPEC_400)
+		sdhci_uhs2_add_host(host, host->caps1);
+
 	return 0;
 
 unreg:
@@ -4320,6 +4511,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 unled:
 	sdhci_led_unregister(host);
 unirq:
+	sdhci_uhs2_remove_host(host, 0);
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
@@ -4377,6 +4569,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	sdhci_led_unregister(host);
 
+	sdhci_uhs2_remove_host(host, dead);
+
 	if (!dead)
 		sdhci_do_reset(host, SDHCI_RESET_ALL);
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 7023cbec4017..72f2ed144f4f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -286,14 +286,14 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 }
 
 static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
+		     unsigned short vdd, unsigned short vdd2)
 {
 	if (!IS_ERR(host->mmc->supply.vmmc)) {
 		struct mmc_host *mmc = host->mmc;
 
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 	}
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 }
 
 static const struct sdhci_ops sdhci_arasan_ops = {
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 0ae986c42bc8..1c7933fa05b6 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -96,14 +96,14 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
  * an external regulator.
  */
 static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
+		     unsigned short vdd, unsigned short vdd2)
 {
 	if (!IS_ERR(host->mmc->supply.vmmc)) {
 		struct mmc_host *mmc = host->mmc;
 
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 	}
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 }
 
 static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
@@ -358,7 +358,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 
 	/* HS200 is broken at this moment */
-	host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 083e7e053c95..3b59c20e5f58 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -671,7 +671,7 @@ static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 
 static void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
-			  unsigned short vdd)
+			  unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index eaffa85bc728..8ca8b953a83d 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -628,12 +628,12 @@ static int bxt_get_cd(struct mmc_host *mmc)
 #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
 
 static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
-				  unsigned short vdd)
+				  unsigned short vdd, unsigned short vdd2)
 {
 	int cntr;
 	u8 reg;
 
-	sdhci_set_power(host, mode, vdd);
+	sdhci_set_power(host, mode, vdd, -1);
 
 	if (mode == MMC_POWER_OFF)
 		return;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e55037ceda73..457e9425339a 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -298,12 +298,12 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
-			    unsigned short vdd)
+			    unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = host->pwr;
 
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 
 	if (host->pwr == pwr)
 		return;
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
new file mode 100644
index 000000000000..49bda02dd305
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -0,0 +1,751 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
+ *  Interface driver
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/mmc/mmc.h>
+
+#include "sdhci.h"
+#include "sdhci-uhs2.h"
+
+#define DRIVER_NAME "sdhci_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear,
+					u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
+
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	unsigned long timeout;
+
+	if (!(host->mmc->caps & MMC_CAP_UHS2))
+		return;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
+		host->clock = 0;
+		/* Reset-all turns off SD Bus Power */
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	}
+
+	/* Wait max 100 ms */
+	timeout = 10000;
+
+	/* hw clears the bit when it's done */
+	while (sdhci_readw(host, SDHCI_UHS2_SW_RESET) & mask) {
+		if (timeout == 0) {
+			pr_err("%s: %s: Reset 0x%x never completed.\n",
+				__func__, mmc_hostname(host->mmc), (int)mask);
+			pr_err("%s: clean reset bit\n",
+				mmc_hostname(host->mmc));
+			sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+			return;
+		}
+		timeout--;
+		udelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	u8 count;
+	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
+
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
+		*cmd_res = 0xE;
+		*dead_lock = 0xE;
+		return 0xE;
+	}
+
+	/* timeout in us */
+	cmd_res_timeout = 5 * 1000;
+	dead_lock_timeout = 1 * 1000 * 1000;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+			mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+			mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
+void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
+	struct mmc_command *cmd)
+{
+	u16 mode;
+	struct mmc_data *data = cmd->data;
+	u16 arg;
+
+	if (data == NULL) {
+		/* clear Auto CMD settings for no data CMDs */
+		arg = cmd->uhs2_cmd->arg;
+		if ((((arg & 0xF) << 8) | ((arg >> 8) & 0xFF)) ==
+		       UHS2_DEV_CMD_TRANS_ABORT) {
+			mode =  0;
+		} else {
+			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
+			if (cmd->opcode == MMC_STOP_TRANSMISSION ||
+			    cmd->opcode == MMC_ERASE)
+				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
+			else {
+				/* send status mode */
+				if (cmd->opcode == MMC_SEND_STATUS)
+					mode = 0;
+			}
+		}
+#ifdef CONFIG_MMC_DEBUG
+		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
+#endif
+		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+		return;
+	}
+
+	WARN_ON(!host->data);
+
+	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
+	if (data->flags & MMC_DATA_WRITE)
+		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
+
+	if (data->blocks == 1 &&
+	    data->blksz != 512 &&
+	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+	    cmd->opcode != MMC_WRITE_BLOCK) {
+		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
+		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
+	}
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		mode |= SDHCI_UHS2_TRNS_DMA;
+
+	if ((host->mmc->flags & MMC_UHS2_2L_HD) && !cmd->uhs2_tmode0_flag)
+		mode |= SDHCI_UHS2_TRNS_2L_HD;
+
+	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+
+#ifdef CONFIG_MMC_DEBUG
+	DBG("UHS2 trans mode is 0x%x.\n", mode);
+#endif
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_transfer_mode);
+
+void sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int i, j;
+	int cmd_reg;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		if (cmd->uhs2_cmd == NULL) {
+			pr_err("%s: fatal error, no uhs2_cmd!\n",
+				mmc_hostname(host->mmc));
+			BUG();
+			return;
+		}
+	}
+
+	i = 0;
+	sdhci_writel(host,
+		((u32)cmd->uhs2_cmd->arg << 16) | (u32)cmd->uhs2_cmd->header,
+		SDHCI_UHS2_CMD_PACKET + i);
+	i += 4;
+
+	/*
+	 * Per spec, playload (config) should be MSB before sending out.
+	 * But we don't need convert here because had set payload as
+	 * MSB when preparing config read/write commands.
+	 */
+	for (j = 0; j < cmd->uhs2_cmd->payload_len/sizeof(u32); j++) {
+		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j),
+			     SDHCI_UHS2_CMD_PACKET + i);
+		i += 4;
+	}
+
+	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
+		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET+i);
+
+#ifdef CONFIG_MMC_DEBUG
+	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
+	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
+		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
+			sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
+#endif
+
+	cmd_reg = cmd->uhs2_cmd->packet_len <<
+		SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT;
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		cmd_reg |= SDHCI_UHS2_COMMAND_DATA;
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd_reg |= SDHCI_UHS2_COMMAND_CMD12;
+
+	/* UHS2 Native ABORT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
+	    ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) == UHS2_DEV_CMD_TRANS_ABORT))
+		cmd_reg |= SDHCI_UHS2_COMMAND_TRNS_ABORT;
+
+	/* UHS2 Native DORMANT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+		((((cmd->uhs2_cmd->arg & 0xF) << 8) |
+		((cmd->uhs2_cmd->arg >> 8) & 0xFF)) ==
+		UHS2_DEV_CMD_GO_DORMANT_STATE))
+		cmd_reg |= SDHCI_UHS2_COMMAND_DORMANT;
+
+	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
+
+	sdhci_writew(host, cmd_reg, SDHCI_UHS2_COMMAND);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_send_command);
+
+void sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	int i;
+	bool bReadA0 = 0;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		u8 resp;
+		u8 ecode;
+
+		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
+		if (resp & UHS2_RES_NACK_MASK) {
+			ecode = (resp >> UHS2_RES_ECODE_POS) &
+				UHS2_RES_ECODE_MASK;
+			pr_err("%s: NACK is got, ECODE=0x%x.\n",
+				mmc_hostname(host->mmc), ecode);
+		}
+		bReadA0 = 1;
+	}
+
+	if (host->cmd->uhs2_resp &&
+	    host->cmd->uhs2_resp_len &&
+	    host->cmd->uhs2_resp_len <= 20) {
+		/* Get whole response of some native CCMD, like
+		 * DEVICE_INIT, ENUMERATE.
+		 */
+		for (i = 0; i < host->cmd->uhs2_resp_len; i++)
+			host->cmd->uhs2_resp[i] = sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i);
+	} else {
+		/* Get SD CMD response and Payload for some read
+		 * CCMD, like INQUIRY_CFG.
+		 */
+		/* Per spec (p136), payload field is divided into
+		 * a unit of DWORD and transmission order within
+		 * a DWORD is big endian.
+		 */
+		if (!bReadA0)
+			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
+		for (i = 4; i < 20; i += 4) {
+			host->cmd->resp[i/4-1] = (sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i) << 24) |
+					(sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 1) << 16) |
+					(sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 2) << 8) |
+					sdhci_readb(host,
+				SDHCI_UHS2_RESPONSE + i + 3);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_finish_command);
+
+void sdhci_uhs2_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
+{
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+
+	/* change to use calculate value */
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+
+	sdhci_uhs2_clear_set_irqs(host,
+				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT|
+				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT,
+				  0);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+	sdhci_uhs2_clear_set_irqs(host, 0,
+				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT|
+				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT);
+
+	/* UHS2 timing */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->timing == MMC_TIMING_UHS2)
+		ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	/* Set VDD2 */
+	ios->vdd = fls(host->mmc->ocr_avail) - 1;
+	ios->vdd2 = fls(host->mmc->ocr_avail_uhs2) - 1;
+
+	sdhci_set_power(host, ios->power_mode, ios->vdd, ios->vdd2);
+	udelay(100);
+
+	host->timing = ios->timing;
+	sdhci_set_clock(host, host->clock);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_set_ios);
+
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	int timeout = 100;
+
+	udelay(200); /* wait for 200us before check */
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IF_DETECT)) {
+		if (timeout == 0) {
+			pr_warn("%s: not detect UHS2 interface in 200us.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+			SDHCI_UHS2_ERR_INT_STATUS_MASK);
+
+	timeout = 150;
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_LANE_SYNC)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 Lane sync fail in 150ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initializaed.\n",
+		mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * TODO: may add corresponding members in sdhci_host to
+	 * keep these caps.
+	 */
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
+			mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
+	caps_phy = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host,
+		caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
+
+	/* Geneneral Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
+	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
+			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
+	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
+			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
+	mmc->uhs2_caps.addr64 =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
+		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
+	mmc->uhs2_caps.n_lss_sync =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
+	mmc->uhs2_caps.n_lss_dir =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev =
+		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
+	mmc->uhs2_caps.maxblk_len =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
+	mmc->uhs2_caps.n_data_gap =
+		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+int sdhci_uhs2_do_detect_init(struct sdhci_host *host)
+{
+	unsigned long flags;
+	int ret = -EIO;
+
+	DBG("%s: begin UHS2 init.\n", __func__);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n",
+				mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n",
+				mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+			SDHCI_UHS2_ERR_INT_STATUS_MASK);
+	/*
+	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
+	 * by SDHCI_UHS2_SW_RESET_SD
+	 */
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	ret = 0;
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_detect_init);
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
+	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
+
+	/* Set Gen Settings */
+	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
+		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
+		(host->mmc->uhs2_caps.n_lss_sync_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
+	if (host->mmc->flags & MMC_UHS2_SPEED_B)
+		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = (host->mmc->uhs2_caps.max_retry_set <<
+			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
+		(host->mmc->uhs2_caps.n_fcu_set <<
+			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
+		     sdhci_uhs2_tran_set_1_reg);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	int timeout = 100;
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IN_DORMANT_STATE)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+	return 0;
+}
+
+int sdhci_uhs2_do_set_reg(struct sdhci_host *host, enum uhs2_act act)
+{
+	unsigned long flags;
+	int err = 0;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+
+	DBG("Begin sdhci_uhs2_set_reg, act %d.\n", act);
+	spin_lock_irqsave(&host->lock, flags);
+
+	switch (act) {
+	case SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case ENABLE_INT:
+		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case DISABLE_INT:
+		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case SET_SPEED_B:
+		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
+			     sdhci_uhs2_phy_set_reg);
+		break;
+	case CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	default:
+		pr_err("%s: input action %d is wrong!\n",
+			mmc_hostname(host->mmc), act);
+		err = -EIO;
+		break;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return err;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_do_set_reg);
+
+void sdhci_uhs2_irq(struct sdhci_host *host)
+{
+	u32 uhs2mask;
+	struct mmc_command *cmd = host->cmd;
+
+	uhs2mask = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS);
+	DBG("*** %s got UHS2 interrupt: 0x%08x\n",
+		mmc_hostname(host->mmc), uhs2mask);
+
+	sdhci_writel(host, uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK,
+		SDHCI_UHS2_ERR_INT_STATUS);
+
+	if (!(uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK))
+		return;
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK) {
+		if (!host->cmd) {
+			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
+				mmc_hostname(host->mmc),
+				(unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		host->cmd->error = -EILSEQ;
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+	}
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK) {
+		if (!host->data) {
+			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
+				mmc_hostname(host->mmc),
+				(unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT) {
+			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
+				mmc_hostname(host->mmc),
+				(unsigned int)uhs2mask);
+			host->data->error = -ETIMEDOUT;
+		} else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_ADMA) {
+			pr_err("%s: ADMA error = 0x %x\n",
+				mmc_hostname(host->mmc),
+				sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else
+			host->data->error = -EILSEQ;
+	}
+
+	if (host->data && host->data->error)
+		sdhci_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+int sdhci_uhs2_add_host(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	if (host->version < SDHCI_SPEC_400)
+		return 0;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2) {
+		mmc->caps |= MMC_CAP_UHS2;
+		mmc->flags |= MMC_UHS2_SUPPORT;
+	}
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_SUPPORT_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr/1000;  /* convert to mA */
+			curr = curr/SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr,
+				SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (caps1 & SDHCI_SUPPORT_VDD2_180) {
+		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
+		/*
+		 * UHS2 doesn't require this. Only UHS-I bus needs to set
+		 * max current.
+		 */
+		mmc->max_current_180_vdd2 = (max_current_caps2 &
+					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
+					SDHCI_MAX_CURRENT_MULTIPLIER;
+	} else {
+		mmc->caps &= ~MMC_CAP_UHS2;
+		mmc->flags &= ~MMC_UHS2_SUPPORT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!(host->mmc) || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_SIG_EN);
+	host->mmc->flags &= ~MMC_UHS2_SUPPORT;
+	host->mmc->flags &= ~MMC_UHS2_INITIALIZED;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 000000000000..1a17c81a3533
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
+ *  Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers and I/O accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/uhs2.h>
+
+extern void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+extern void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
+					struct mmc_command *cmd);
+extern void sdhci_uhs2_send_command(struct sdhci_host *host,
+					struct mmc_command *cmd);
+extern void sdhci_uhs2_finish_command(struct sdhci_host *host);
+extern void sdhci_uhs2_do_set_ios(struct sdhci_host *host,
+					struct mmc_ios *ios);
+extern int sdhci_uhs2_do_detect_init(struct sdhci_host *host);
+extern int sdhci_uhs2_do_set_reg(struct sdhci_host *host, enum uhs2_act act);
+extern void sdhci_uhs2_irq(struct sdhci_host *host);
+extern int sdhci_uhs2_add_host(struct sdhci_host *host, u32 caps1);
+extern void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
+extern void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear,
+					u32 set);
+extern void sdhci_uhs2_set_timeout(struct sdhci_host *host);
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 1dea1ba66f7b..328860cf2bc3 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -214,12 +214,12 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
 }
 
 static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
-		unsigned short vdd)
+		unsigned short vdd, unsigned short vdd2)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = host->pwr;
 
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 
 	if (host->pwr == pwr)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0eaef5f..48176e9556b7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -42,8 +42,28 @@
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
+/*
+ * Defined in Host Version 4.10.
+ * 1 - R5 (SDIO)
+ * 0 - R1 (Memory)
+ */
+#define  SDHCI_TRNS_RES_TYPE		0x40
+#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
+#define  SDHCI_TRNS_RES_INT_DIS		0x0100
+
+
 #define SDHCI_COMMAND		0x0E
 #define  SDHCI_CMD_RESP_MASK	0x03
+
+/*
+ * Host Version 4.10 adds this bit to distinguish a main command or
+ * sub command.
+ * CMD53(SDIO) - main command
+ * CMD52(SDIO) - sub command which doesn't have data block or doesn't
+ * indicate busy.
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
+
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -59,11 +79,19 @@
 
 #define SDHCI_RESPONSE		0x10
 
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8
+
 #define SDHCI_BUFFER		0x20
 
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+
+#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
+
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -79,6 +107,13 @@
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
 #define  SDHCI_CMD_LVL		0x01000000
 
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
+
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
@@ -99,6 +134,11 @@
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
 
+/* VDD2 - UHS2 */
+#define  SDHCI_VDD2_POWER_ON		0x10
+#define  SDHCI_VDD2_POWER_180		0xA0
+#define  SDHCI_VDD2_POWER_120		0x80
+
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
 #define SDHCI_WAKE_UP_CONTROL	0x2B
@@ -109,7 +149,7 @@
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
 #define  SDHCI_DIVIDER_HI_SHIFT	6
-#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK		0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
@@ -138,6 +178,10 @@
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
 #define  SDHCI_INT_RETUNE	0x00001000
+
+/* Host Version 4.10 */
+#define  SDHCI_INT_FX_EVENT	0x00002000
+
 #define  SDHCI_INT_CQE		0x00004000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
@@ -151,6 +195,9 @@
 #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
+
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
@@ -177,6 +224,9 @@
 #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
 #define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
+/* Host Version 4.10 */
+#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
+
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
 #define   SDHCI_CTRL_UHS_SDR12		0x0000
@@ -185,6 +235,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -193,9 +244,12 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
 #define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
+#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -218,10 +272,12 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -233,11 +289,14 @@
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
+#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_CAPABILITIES_1	0x44
 
 #define SDHCI_MAX_CURRENT		0x48
+#define SDHCI_MAX_CURRENT_1		0x4C
 #define  SDHCI_MAX_CURRENT_LIMIT	0xFF
 #define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
 #define  SDHCI_MAX_CURRENT_330_SHIFT	0
@@ -245,12 +304,18 @@
 #define  SDHCI_MAX_CURRENT_300_SHIFT	8
 #define  SDHCI_MAX_CURRENT_180_MASK	0xFF0000
 #define  SDHCI_MAX_CURRENT_180_SHIFT	16
-#define   SDHCI_MAX_CURRENT_MULTIPLIER	4
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	0x0000000FF /* UHS2 */
+#define  SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
+#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
 #define SDHCI_SET_INT_ERROR	0x52
+/* Host Version 4.10 */
+#define SDHCI_SET_INT_TUNING_ERROR	0x0400
+#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
 
 #define SDHCI_ADMA_ERROR	0x54
 
@@ -267,6 +332,11 @@
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+
+/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
+
 #define SDHCI_PRESET_DRV_MASK  0xC000
 #define SDHCI_PRESET_DRV_SHIFT  14
 #define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
@@ -274,6 +344,195 @@
 #define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
 #define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
+/* UHS-II */
+#define SDHCI_UHS2_BLOCK_SIZE	0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
+	(((dma & 0x7) << 12) | (blksz & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT	0x84
+
+#define SDHCI_UHS2_CMD_PACKET	0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
+
+#define SDHCI_UHS2_TRANS_MODE	0x9C
+#define  SDHCI_UHS2_TRNS_DMA		0x0001
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	0x0002
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	0x0010
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	0x0020
+#define  SDHCI_UHS2_TRNS_RES_R5		0x0040
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	0x0080
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS	0x0100
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY	0x4000
+#define  SDHCI_UHS2_TRNS_2L_HD		0x8000
+
+#define SDHCI_UHS2_COMMAND	0x9E
+#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
+#define  SDHCI_UHS2_COMMAND_DATA	0x0020
+#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
+#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
+#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	0x1F00
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
+
+#define SDHCI_UHS2_RESPONSE	0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
+
+#define SDHCI_UHS2_MSG_SELECT	0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
+
+#define SDHCI_UHS2_MSG		0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
+
+#define SDHCI_UHS2_DEV_SELECT	0xBE
+#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	0x0F
+#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	0x80
+
+#define SDHCI_UHS2_DEV_INT_CODE	0xBF
+
+#define SDHCI_UHS2_SW_RESET	0xC0
+#define SDHCI_UHS2_SW_RESET_FULL	0x0001
+#define SDHCI_UHS2_SW_RESET_SD		0x0002
+
+#define SDHCI_UHS2_TIMER_CTRL	0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
+
+#define SDHCI_UHS2_ERR_INT_STATUS	0xC4
+#define SDHCI_UHS2_ERR_INT_STATUS_EN	0xC8
+#define SDHCI_UHS2_ERR_INT_SIG_EN	0xCC
+#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	0x00000001
+#define SDHCI_UHS2_ERR_INT_STATUS_RES		0x00000002
+#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	0x00000004
+#define SDHCI_UHS2_ERR_INT_STATUS_CRC		0x00000008
+#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		0x00000010
+#define SDHCI_UHS2_ERR_INT_STATUS_TID		0x00000020
+#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	0x00000080
+#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		0x00000100
+#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		0x00008000
+#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	0x00010000
+#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	0x00020000
+#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	0x08000000
+#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+/* CRC Error occurs during a packet receiving */
+#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SET_PTR	0xE0
+#define   SDHCI_UHS2_GEN_SET_POWER_LOW	0x0001
+#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
+#define   SDHCI_UHS2_GEN_SET_2L_FD_HD	0x0
+#define   SDHCI_UHS2_GEN_SET_2D1U_FD	0x2
+#define   SDHCI_UHS2_GEN_SET_1D2U_FD	0x3
+#define   SDHCI_UHS2_GEN_SET_2D2U_FD	0x4
+
+#define   SDHCI_UHS2_PHY_SET_SPEED_POS	6
+#define   SDHCI_UHS2_PHY_SET_HIBER_EN	0x00008000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
+
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	0x0000FF00
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS	8
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	0x00030000
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
+
+#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
+#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	0x0000000F
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	0x000000F0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	(gap * 360)
+#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	0x00003F00
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
+#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
+#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	0x00004000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		0x00008000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	0x00030000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		0x003C0000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	0x00C00000
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
+#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK	0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK	0x000000C0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT	6
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A	0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B	1
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	0x000F0000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	0x00F00000
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	0x0000003F
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		0x0000FF00
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	0x00070000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	0xFFF00000
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
+
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	0x000000FF
+
+#define SDHCI_UHS2_TEST_PTR	0xE4
+#define  SDHCI_UHS2_TEST_ERR_HEADER	0x00000001
+#define  SDHCI_UHS2_TEST_ERR_RES	0x00000002
+#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	0x00000004
+#define  SDHCI_UHS2_TEST_ERR_CRC	0x00000008
+#define  SDHCI_UHS2_TEST_ERR_FRAME	0x00000010
+#define  SDHCI_UHS2_TEST_ERR_TID	0x00000020
+#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	0x00000080
+#define  SDHCI_UHS2_TEST_ERR_EBUSY	0x00000100
+#define  SDHCI_UHS2_TEST_ERR_ADMA	0x00008000
+#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	0x00010000
+#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	0x00020000
+#define  SDHCI_UHS2_TEST_ERR_VENDOR	0x08000000
+
+#define SDHCI_UHS2_EMBED_CTRL	0xE6
+#define SDHCI_UHS2_VENDOR	0xE8
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -517,6 +776,7 @@ struct sdhci_host {
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
 #define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
 #define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_UHS2          (1<<17) /* Support UHS2 */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -618,7 +878,7 @@ struct sdhci_ops {
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
-			     unsigned short vdd);
+			     unsigned short vdd, unsigned short vdd2);
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
@@ -757,10 +1017,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
-void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd);
-void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
@@ -780,6 +1036,20 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
 #endif
 
+/* sdhci_uhs2.c needed */
+extern void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+extern void sdhci_dumpregs(struct sdhci_host *host);
+extern void sdhci_finish_data(struct sdhci_host *host);
+extern void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			unsigned short vdd, unsigned short vdd2);
+extern void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			unsigned short vdd, unsigned short vdd2);
+extern void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+
+extern void sdhci_uhs2_disable_clk(struct mmc_host *mmc);
+extern void sdhci_uhs2_enable_clk(struct mmc_host *mmc);
+extern void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+
 void sdhci_cqe_enable(struct mmc_host *mmc);
 void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
 bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index bb90757ecace..6d3b11f16a8d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -205,14 +205,14 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 }
 
 static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
-				  unsigned short vdd)
+				  unsigned short vdd, unsigned short vdd2)
 {
 	if (!IS_ERR(host->mmc->supply.vmmc)) {
 		struct mmc_host *mmc = host->mmc;
 
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 	}
-	sdhci_set_power_noreg(host, mode, vdd);
+	sdhci_set_power_noreg(host, mode, vdd, -1);
 }
 
 static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
diff --git a/include/linux/mmc/uhs2.h b/include/linux/mmc/uhs2.h
new file mode 100644
index 000000000000..c61670e3cc06
--- /dev/null
+++ b/include/linux/mmc/uhs2.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/uhs2.h - UHS-II driver
+ *
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
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
2.24.1

