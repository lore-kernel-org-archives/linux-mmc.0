Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B4C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8592078B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4kGwKJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJLKM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLKM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:10:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF24C08C5CE;
        Fri, 10 Jul 2020 04:10:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so2400011pfc.6;
        Fri, 10 Jul 2020 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoXphThq6G2JWBwLp5RLDjsZp2uZzGStShxeoA6seBE=;
        b=K4kGwKJn223tYrkGCMY8U3TsgdkXXZZ64nkoF+2xjEnUKoqGWUSptgxTIz7OC5ooP9
         dmQAwQXwAD5wD2fGjpISCdv8qeNYP85K/82LfxZMBxC5eNkpXbWbm/igE8GXUSGCX4RL
         B13v8f1Eoai4HR7h5qcH76IWQvvMekPJvaeEhqqnx1B/Uq9x1/WDYS/K4oHnttYFd2SP
         K/4ZblY1u9i9fjVhYe5E2xEl0Dq8x34eA2bUOk2rAoIpO9nSuwebT/PaLU5fU3KlxEYX
         myptCxQiC4Eg72Wyzw/F67Y4PMl8SmpJxk+pomkcxu6a0jLaiX0hy48ACHD/Qf47HzxZ
         InCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoXphThq6G2JWBwLp5RLDjsZp2uZzGStShxeoA6seBE=;
        b=qRQ3yeZarV+wjpm4cMROa1zt79Q3DAu/1cEiDep66WNOO1mv+tksi2xwkCFMWtwJLL
         CK6aDvVOU4Oe4r3wfx0fQJsk52gGTeRgkz3D3QJZ4OcgBgVEivzVaTfDmvQDrzxhc0mg
         AT55ei2ZBGOJgx9Q05Tb53auR85tzRKQ6J8K0Bbm0YqRC4+cNaAQwQaBpQGdciJej+Fo
         0FIJmSWSUO8CB5/9cBljGkZoM7oQyPBABaJmedB7IVpLkJRWQSaSOSiSnHN6mv1YNLUa
         /LU7foHoT6JrXOak2gTDULX8hSgWyuHflj0bONGThcq/lbyYB7cB8THhfCPgi3wn8YA+
         7JnQ==
X-Gm-Message-State: AOAM530qloUahKC07XzuGc4JRc7h0G++CHkhEHYFWzp1aGF7Vw1Zpy2o
        1OD1cWcRFY2ASgdp75E5d6A=
X-Google-Smtp-Source: ABdhPJyseJm7HX+hSqhMnBvBKgj5eO87JpHUC6nK9w8DLYSBIzTdNBMrhlbJaKqhN+r+QWktY3sVIQ==
X-Received: by 2002:a62:75c8:: with SMTP id q191mr53142041pfc.321.1594379411383;
        Fri, 10 Jul 2020 04:10:11 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id u19sm6306680pfk.98.2020.07.10.04.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:10:11 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for additional operations
Date:   Fri, 10 Jul 2020 19:10:54 +0800
Message-Id: <20200710111054.29562-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

In this commit, UHS-II related operations will be called via a function
pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
a kernel module.
This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
and when the UHS-II module is loaded. Otherwise, all the functions
stay void.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aaf41954511a..5511649946b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -32,8 +32,12 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/uhs2.h>
+#include <linux/pci.h>
 
 #include "sdhci.h"
+#include "sdhci-uhs2.h"
+#include "sdhci-pci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -45,6 +49,11 @@
 
 #define MAX_TUNING_LOOP 40
 
+#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
+struct sdhci_uhs2_ops sdhci_uhs2_ops;
+EXPORT_SYMBOL_GPL(sdhci_uhs2_ops);
+#endif
+
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
@@ -1041,8 +1050,11 @@ EXPORT_SYMBOL_GPL(sdhci_set_data_timeout_irq);
 
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
+	u8 count;
+
 	bool too_big = false;
-	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
+
+	count = sdhci_calc_timeout(host, cmd, &too_big);
 
 	if (too_big &&
 	    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
@@ -1053,6 +1065,11 @@ void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc->flags & MMC_UHS2_SUPPORT &&
+	    sdhci_uhs2_ops.set_timeout)
+		sdhci_uhs2_ops.set_timeout(host);
 }
 EXPORT_SYMBOL_GPL(__sdhci_set_timeout);
 
@@ -1191,7 +1208,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
-	sdhci_set_block_info(host, data);
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc->flags & MMC_UHS2_SUPPORT &&
+	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
+		sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
+	} else {
+		sdhci_set_block_info(host, data);
+	}
 }
 
 #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
@@ -1439,6 +1463,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc->flags & MMC_UHS2_SUPPORT) {
+		if (sdhci_uhs2_ops.set_transfer_mode)
+			sdhci_uhs2_ops.set_transfer_mode(host, cmd);
+		return;
+	}
+
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
@@ -1570,6 +1601,12 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		__sdhci_finish_mrq(host, data->mrq);
+		return;
+	}
+
 	/*
 	 * Need to send CMD12 if -
 	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
@@ -1654,7 +1691,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			sdhci_prepare_data(host, cmd);
 	}
 
-	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
+	if (!IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
+		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
 	sdhci_set_transfer_mode(host, cmd);
 
@@ -1699,6 +1737,17 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->use_external_dma)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    (host->mmc->flags & MMC_UHS2_SUPPORT)) {
+		if (sdhci_uhs2_ops.send_command)
+			sdhci_uhs2_ops.send_command(host, cmd);
+
+		return true;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
+		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 
 	return true;
@@ -1780,13 +1829,20 @@ static void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
 
-	host->cmd = NULL;
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc->flags & MMC_UHS2_SUPPORT) {
+		if (sdhci_uhs2_ops.finish_command)
+			sdhci_uhs2_ops.finish_command(host);
+	} else {
+		host->cmd = NULL;
 
-	if (cmd->flags & MMC_RSP_PRESENT) {
-		if (cmd->flags & MMC_RSP_136) {
-			sdhci_read_rsp_136(host, cmd);
-		} else {
-			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
+		if (cmd->flags & MMC_RSP_PRESENT) {
+			if (cmd->flags & MMC_RSP_136) {
+				sdhci_read_rsp_136(host, cmd);
+			} else {
+				cmd->resp[0] = sdhci_readl(host,
+							   SDHCI_RESPONSE);
+			}
 		}
 	}
 
@@ -1809,6 +1865,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
 			   cmd == host->data_cmd) {
 			/* Command complete before busy is ended */
+			host->cmd = NULL;
 			return;
 		}
 	}
@@ -1828,6 +1885,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		if (!cmd->data)
 			__sdhci_finish_mrq(host, cmd->mrq);
 	}
+
+	host->cmd = NULL;
 }
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
@@ -1855,6 +1914,11 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
+	case MMC_TIMING_UHS2:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
+#endif
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -2095,7 +2159,6 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
 		pwr |= SDHCI_POWER_ON;
-
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
@@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u8 ctrl;
+	u16 ctrl_2;
 
 	if (ios->power_mode == MMC_POWER_UNDEFINED)
 		return;
@@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
+		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		    ios->timing == MMC_TIMING_UHS2)
+			host->timing = ios->timing;
+
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_set_power(host, ios->power_mode, ios->vdd);
 
+	/* 4.0 host support */
+	if (host->version >= SDHCI_SPEC_400) {
+		/* UHS2 Support */
+		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		    host->mmc->flags & MMC_UHS2_SUPPORT &&
+		    host->mmc->caps & MMC_CAP_UHS2) {
+			if (sdhci_uhs2_ops.do_set_ios)
+				sdhci_uhs2_ops.do_set_ios(host, ios);
+			return;
+		}
+	}
+
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
@@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	if (host->version >= SDHCI_SPEC_300) {
-		u16 clk, ctrl_2;
+		u16 clk;
 
 		if (!host->preset_enabled) {
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
@@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		/* Spec says we should do both at the same time, but Ricoh
-		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-
+		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		    host->mmc->flags & MMC_UHS2_INITIALIZED) {
+			if (sdhci_uhs2_ops.reset)
+				sdhci_uhs2_ops.reset(host,
+						     SDHCI_UHS2_SW_RESET_SD);
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
 
@@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 				  SDHCI_INT_BUS_POWER);
 		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
+		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		    intmask & SDHCI_INT_ERROR &&
+		    host->mmc->flags & MMC_UHS2_SUPPORT) {
+			if (sdhci_uhs2_ops.irq)
+				sdhci_uhs2_ops.irq(host);
+		}
+
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 				      SDHCI_CARD_PRESENT;
@@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		/* This may alter mmc->*_blk_* parameters */
 		sdhci_allocate_bounce_buffer(host);
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->version >= SDHCI_SPEC_400 &&
+	    sdhci_uhs2_ops.add_host) {
+		ret = sdhci_uhs2_ops.add_host(host, host->caps1);
+		if (ret)
+			goto unreg;
+	}
+
 	return 0;
 
 unreg:
@@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
+	/* FIXME: Do we have to do some cleanup for UHS2 here? */
+
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
 
@@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
 		mmc->cqe_ops = NULL;
 	}
 
+	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
+		/* host doesn't want to enable UHS2 support */
+		mmc->caps &= ~MMC_CAP_UHS2;
+		mmc->flags &= ~MMC_UHS2_SUPPORT;
+
+		/* FIXME: Do we have to do some cleanup here? */
+	}
+
 	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
 	if (!host->complete_wq)
 		return -ENOMEM;
@@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
 unled:
 	sdhci_led_unregister(host);
 unirq:
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    sdhci_uhs2_ops.remove_host)
+		sdhci_uhs2_ops.remove_host(host, 0);
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
@@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	sdhci_led_unregister(host);
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    sdhci_uhs2_ops.remove_host)
+		sdhci_uhs2_ops.remove_host(host, dead);
+
 	if (!dead)
 		sdhci_do_reset(host, SDHCI_RESET_ALL);
 
-- 
2.27.0

