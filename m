Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C54C63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B5161279
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGVDWK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhGVDV5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77BC0617A0;
        Wed, 21 Jul 2021 21:02:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b2so3018906plx.1;
        Wed, 21 Jul 2021 21:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8kiq8rFUXyPUDCLJprquZZA1XIPutuhE48mQtXu7VA=;
        b=oYTUmvQ5Mdq/wu+1IcCbGZu9dEE/K+66FitxZSI5ACGtJMZCxstEEm+qxcX8zesJCR
         6t07eN0Xh/3tEuBIJMYIya1N6uE3QeBJAZsXtUoA9jfSSL40Ayb8WzyZW1Ly0iGtf8KL
         FFAQT4qKMydvock92rbducKFYU/zOdlI4psweQcjV9qnqRDhZvifPMOBVFGUJRg3LOhQ
         l9yEbGQZ3C6tULXaNNpQTgKd6k1dV3wRKgxApnglzoJKhBbfhSSY5HGsTzz8Dtqs24WT
         4q4LFM4SDCyfysm1xvJUYhVxo+35nVafNSdyoJOIJNGUHI3ez1LjC9kI7uNvhiAp52H0
         KQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8kiq8rFUXyPUDCLJprquZZA1XIPutuhE48mQtXu7VA=;
        b=gVft/xZ31DJ0pfRMx/u4TSpRlk6rjjqaqjyZPMChSfa+yKGKyrDUyYO0L1LJ+u3aUl
         NUidTfriBuuNixNlhgNBwRXVg+KhdBwE8hVyGM2Jp4oezs1TEVMcqwvbeXj4Yj8S5cvq
         yoZHAumMHYzk28o7wbSBFrFiKgm31o/SsLNe0GkxaWtXcy4FXSMUGaFDcPuFme4Z0o+p
         4gEqPq2V6FUfrWcXCKPQeIoHOSj0iq13tHbBnXA92uJjiiCFUkBziX49YFCQP4c/16tu
         PRbyIDEGIm4JEqlrDMYpyS49nztlWI19Jbwn8aRDK9g22BwRXuBGSas8+WaWLp9J/kTX
         zdow==
X-Gm-Message-State: AOAM530NucxkN/gPvtDUayJE7sHdHliRVllD30btqyl580YRH9illeRE
        H+BvMcKXUKrC+i30jMMsA1k=
X-Google-Smtp-Source: ABdhPJyOwl0mC7XO/OIDKRabI1c9uYeVm+Dv4BDxECclEVkUm+e0OVXz3wizqePJphwiYBtZp4pGHg==
X-Received: by 2002:a63:d14c:: with SMTP id c12mr38883392pgj.412.1626926550241;
        Wed, 21 Jul 2021 21:02:30 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:30 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 20/29] mmc: sdhci-uhs2: add request() and others
Date:   Thu, 22 Jul 2021 12:01:15 +0800
Message-Id: <20210722040124.7573-20-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a sdhci version of mmc's request operation.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 529 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  93 +++---
 drivers/mmc/host/sdhci.h      |  21 ++
 3 files changed, 610 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index d8afb99a9918..36e52553977a 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/mmc/mmc.h>

 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -394,6 +395,27 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
 	return 0;
 }

+/* TODO: move them to a header */
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+static inline void sdhci_led_activate(struct sdhci_host *host)
+{
+}
+
+static inline void sdhci_led_deactivate(struct sdhci_host *host)
+{
+}
+#else
+static inline void sdhci_led_activate(struct sdhci_host *host)
+{
+	__sdhci_led_activate(host);
+}
+
+static inline void sdhci_led_deactivate(struct sdhci_host *host)
+{
+	__sdhci_led_deactivate(host);
+}
+#endif
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -523,6 +545,512 @@ static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
 	return err;
 }

+static bool sdhci_uhs2_send_command(struct sdhci_host *host,
+				    struct mmc_command *cmd);
+static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
+				     struct mmc_command *cmd,
+				     unsigned long flags);
+
+void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	unsigned long flags;
+	bool present;
+
+	/* FIXME: check more flags? */
+	if (!host->mmc->flags & MMC_UHS2_SUPPORT) {
+		sdhci_request(mmc, mrq);
+		return;
+	}
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_led_activate(host);
+
+	if (sdhci_present_error(host, mrq->cmd, present))
+		goto out_finish;
+
+	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
+
+	if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
+		goto out_finish;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return;
+
+out_finish:
+	sdhci_finish_mrq(host, mrq);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_request);
+
+int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!host->mmc->flags & MMC_UHS2_SUPPORT)
+		return sdhci_request_atomic(mmc, mrq);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_present_error(host, mrq->cmd, true)) {
+		sdhci_finish_mrq(host, mrq);
+		goto out_finish;
+	}
+
+	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
+
+	/*
+	 * The HSQ may send a command in interrupt context without polling
+	 * the busy signaling, which means we should return BUSY if controller
+	 * has not released inhibit bits to allow HSQ trying to send request
+	 * again in non-atomic context. So we should not finish this request
+	 * here.
+	 */
+	if (!sdhci_uhs2_send_command(host, cmd))
+		ret = -EBUSY;
+	else
+		sdhci_led_activate(host);
+
+out_finish:
+	spin_unlock_irqrestore(&host->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
+
+/*****************************************************************************\
+ *                                                                           *
+ * Core functions                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_uhs2_prepare_data(struct sdhci_host *host,
+				    struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);
+
+	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
+	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
+}
+
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+static void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
+						 struct mmc_command *cmd)
+{
+	if (!sdhci_external_dma_setup(host, cmd)) {
+		__sdhci_external_dma_prepare_data(host, cmd);
+	} else {
+		sdhci_external_dma_release(host);
+		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_uhs2_prepare_data(host, cmd);
+	}
+}
+#else
+static inline void sdhci_uhs2_external_dma_prepare_data(struct sdhci_host *host,
+							struct mmc_command *cmd)
+{
+	/* This should never happen */
+	WARN_ON_ONCE(1);
+}
+
+static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+						   struct mmc_command *cmd)
+{
+}
+#endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */
+
+static void sdhci_uhs2_finish_data(struct sdhci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host);
+
+	/*
+	 *  FIXME: Is this condition needed?
+	    if (host->mmc->flags & MMC_UHS2_INITIALIZED)
+	 */
+	__sdhci_finish_mrq(host, data->mrq);
+}
+
+static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host,
+					 struct mmc_command *cmd)
+{
+	u16 mode;
+	struct mmc_data *data = cmd->data;
+	u16 arg;
+
+	if (!data) {
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
+			else
+				/* send status mode */
+				if (cmd->opcode == MMC_SEND_STATUS)
+					mode = 0;
+		}
+
+		if (IS_ENABLED(CONFIG_MMC_DEBUG))
+			DBG("UHS2 no data trans mode is 0x%x.\n", mode);
+
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
+	if (IS_ENABLED(CONFIG_MMC_DEBUG))
+		DBG("UHS2 trans mode is 0x%x.\n", mode);
+}
+
+static void __sdhci_uhs2_send_command(struct sdhci_host *host,
+				      struct mmc_command *cmd)
+{
+	int i, j;
+	int cmd_reg;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		if (!cmd->uhs2_cmd) {
+			pr_err("%s: fatal error, no uhs2_cmd!\n",
+			       mmc_hostname(host->mmc));
+			return;
+		}
+	}
+
+	i = 0;
+	sdhci_writel(host,
+		     ((u32)cmd->uhs2_cmd->arg << 16) |
+				(u32)cmd->uhs2_cmd->header,
+		     SDHCI_UHS2_CMD_PACKET + i);
+	i += 4;
+
+	/*
+	 * Per spec, playload (config) should be MSB before sending out.
+	 * But we don't need convert here because had set payload as
+	 * MSB when preparing config read/write commands.
+	 */
+	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
+		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j),
+			     SDHCI_UHS2_CMD_PACKET + i);
+		i += 4;
+	}
+
+	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
+		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
+
+	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
+		DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
+		for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
+			DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
+			    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
+	}
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
+	    ((((cmd->uhs2_cmd->arg & 0xF) << 8) |
+	     ((cmd->uhs2_cmd->arg >> 8) & 0xFF)) ==
+				UHS2_DEV_CMD_GO_DORMANT_STATE))
+		cmd_reg |= SDHCI_UHS2_COMMAND_DORMANT;
+
+	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
+
+	sdhci_writew(host, cmd_reg, SDHCI_UHS2_COMMAND);
+}
+
+static bool sdhci_uhs2_send_command(struct sdhci_host *host,
+				    struct mmc_command *cmd)
+{
+	int flags;
+	u32 mask;
+	unsigned long timeout;
+
+	/* FIXME: Is this check necessary? */
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return sdhci_send_command(host, cmd);
+
+	WARN_ON(host->cmd);
+
+	/* Initially, a command has no error */
+	cmd->error = 0;
+
+	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
+	    cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd->flags |= MMC_RSP_BUSY;
+
+	mask = SDHCI_CMD_INHIBIT;
+	if (sdhci_data_line_cmd(cmd))
+		mask |= SDHCI_DATA_INHIBIT;
+
+	/* We shouldn't wait for data inihibit for stop commands, even
+	   though they might use busy signaling */
+	if (cmd->mrq->data && (cmd == cmd->mrq->data->stop))
+		mask &= ~SDHCI_DATA_INHIBIT;
+
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
+		return false;
+
+	host->cmd = cmd;
+	host->data_timeout = 0;
+	if (sdhci_data_line_cmd(cmd)) {
+		WARN_ON(host->data_cmd);
+		host->data_cmd = cmd;
+		__sdhci_uhs2_set_timeout(host);
+	}
+
+	if (cmd->data) {
+		if (host->use_external_dma)
+			sdhci_uhs2_external_dma_prepare_data(host, cmd);
+		else
+			sdhci_uhs2_prepare_data(host, cmd);
+	}
+
+	sdhci_uhs2_set_transfer_mode(host, cmd);
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		WARN_ONCE(1, "Unsupported response type!\n");
+		/*
+		 * This does not happen in practice because 136-bit response
+		 * commands never have busy waiting, so rather than complicate
+		 * the error path, just remove busy waiting and continue.
+		 */
+		cmd->flags &= ~MMC_RSP_BUSY;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	/* CMD19 is special in that the Data Present Select should be set */
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+		flags |= SDHCI_CMD_DATA;
+
+	timeout = jiffies;
+	if (host->data_timeout)
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else if (!cmd->data && cmd->busy_timeout > 9000)
+		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, cmd->mrq, timeout);
+
+	if (host->use_external_dma)
+		sdhci_external_dma_pre_transfer(host, cmd);
+
+	__sdhci_uhs2_send_command(host, cmd);
+
+	return true;
+}
+
+static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
+				     struct mmc_command *cmd,
+				     unsigned long flags)
+	__releases(host->lock)
+	__acquires(host->lock)
+{
+	struct mmc_command *deferred_cmd = host->deferred_cmd;
+	int timeout = 10; /* Approx. 10 ms */
+	bool present;
+
+	while (!sdhci_uhs2_send_command(host, cmd)) {
+		if (!timeout--) {
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			cmd->error = -EIO;
+			return false;
+		}
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		usleep_range(1000, 1250);
+
+		present = host->mmc->ops->get_cd(host->mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* A deferred command might disappear, handle that */
+		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
+			return true;
+
+		if (sdhci_present_error(host, cmd, present))
+			return false;
+	}
+
+	if (cmd == host->deferred_cmd)
+		host->deferred_cmd = NULL;
+
+	return true;
+}
+
+static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u8 resp;
+	u8 ecode;
+	bool bReadA0 = 0;
+	int i;
+
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
+		if (resp & UHS2_RES_NACK_MASK) {
+			ecode = (resp >> UHS2_RES_ECODE_POS) &
+				UHS2_RES_ECODE_MASK;
+			pr_err("%s: NACK is got, ECODE=0x%x.\n",
+			       mmc_hostname(host->mmc), ecode);
+		}
+		bReadA0 = 1;
+	}
+
+	if (cmd->uhs2_resp &&
+	    cmd->uhs2_resp_len && cmd->uhs2_resp_len <= 20) {
+		/* Get whole response of some native CCMD, like
+		 * DEVICE_INIT, ENUMERATE.
+		 */
+		for (i = 0; i < cmd->uhs2_resp_len; i++)
+			cmd->uhs2_resp[i] =
+				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
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
+			cmd->resp[i / 4 - 1] =
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i) << 24) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 1)
+					<< 16) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 2)
+					<< 8) |
+				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
+		}
+	}
+}
+
+static void sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	/* FIXME: Is this check necessary? */
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT)) {
+		sdhci_finish_command(host);
+		return;
+	}
+
+	__sdhci_uhs2_finish_command(host);
+
+	host->cmd = NULL;
+
+	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
+		mmc_command_done(host->mmc, cmd->mrq);
+
+	/*
+	 * The host can send and interrupt when the busy state has
+	 * ended, allowing us to wait without wasting CPU cycles.
+	 * The busy signal uses DAT0 so this is similar to waiting
+	 * for data to complete.
+	 *
+	 * Note: The 1.0 specification is a bit ambiguous about this
+	 *       feature so there might be some problems with older
+	 *       controllers.
+	 */
+	if (cmd->flags & MMC_RSP_BUSY) {
+		if (cmd->data) {
+			DBG("Cannot wait for busy signal when also doing a data transfer");
+		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+			   cmd == host->data_cmd) {
+			/* Command complete before busy is ended */
+			return;
+		}
+	}
+
+	/* Finished CMD23, now send actual command. */
+	if (cmd == cmd->mrq->sbc) {
+		if (!sdhci_uhs2_send_command(host, cmd->mrq->cmd)) {
+			WARN_ON(host->deferred_cmd);
+			host->deferred_cmd = cmd->mrq->cmd;
+		}
+	} else {
+
+		/* Processed actual command. */
+		if (host->data && host->data_early)
+			sdhci_uhs2_finish_data(host);
+
+		if (!cmd->data)
+			__sdhci_finish_mrq(host, cmd->mrq);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -691,6 +1219,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
+	host->mmc_host_ops.request = sdhci_uhs2_request;

 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d60a1fdd1385..731a60c4b131 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;

-static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
-
 void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
@@ -147,10 +145,13 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);

-static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+bool sdhci_data_line_cmd(struct mmc_command *cmd)
 {
 	return cmd->data || cmd->flags & MMC_RSP_BUSY;
 }
+EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
+
+/* TODO: move this as an inline function to a header */

 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
@@ -362,7 +363,7 @@ static void sdhci_reinit(struct sdhci_host *host)
 		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }

-static void __sdhci_led_activate(struct sdhci_host *host)
+void __sdhci_led_activate(struct sdhci_host *host)
 {
 	u8 ctrl;

@@ -373,8 +374,9 @@ static void __sdhci_led_activate(struct sdhci_host *host)
 	ctrl |= SDHCI_CTRL_LED;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
+EXPORT_SYMBOL_GPL(__sdhci_led_activate);

-static void __sdhci_led_deactivate(struct sdhci_host *host)
+void __sdhci_led_deactivate(struct sdhci_host *host)
 {
 	u8 ctrl;

@@ -385,6 +387,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
 	ctrl &= ~SDHCI_CTRL_LED;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
+EXPORT_SYMBOL_GPL(__sdhci_led_deactivate);

 #if IS_REACHABLE(CONFIG_LEDS_CLASS)
 static void sdhci_led_control(struct led_classdev *led,
@@ -463,14 +466,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)

 #endif

-static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
-			    unsigned long timeout)
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+		     unsigned long timeout)
 {
 	if (sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
 }
+EXPORT_SYMBOL_GPL(sdhci_mod_timer);

 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -1042,8 +1046,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		__sdhci_set_timeout(host, cmd);
 }

-static void sdhci_initialize_data(struct sdhci_host *host,
-				  struct mmc_data *data)
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	WARN_ON(host->data);

@@ -1056,6 +1059,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
 }
+EXPORT_SYMBOL_GPL(sdhci_initialize_data);

 static inline void sdhci_set_block_info(struct sdhci_host *host,
 					struct mmc_data *data)
@@ -1078,12 +1082,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
 	}
 }

-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = cmd->data;
-
-	sdhci_initialize_data(host, data);
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		struct scatterlist *sg;
 		unsigned int length_mask, offset_mask;
@@ -1168,6 +1168,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}

 	sdhci_set_transfer_irqs(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);

 	sdhci_set_block_info(host, data);
 }
@@ -1210,8 +1220,7 @@ static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
 	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
 }

-static int sdhci_external_dma_setup(struct sdhci_host *host,
-				    struct mmc_command *cmd)
+int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int ret, i;
 	enum dma_transfer_direction dir;
@@ -1263,8 +1272,9 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,

 	return ret;
 }
+EXPORT_SYMBOL_GPL(sdhci_external_dma_setup);

-static void sdhci_external_dma_release(struct sdhci_host *host)
+void sdhci_external_dma_release(struct sdhci_host *host)
 {
 	if (host->tx_chan) {
 		dma_release_channel(host->tx_chan);
@@ -1278,9 +1288,10 @@ static void sdhci_external_dma_release(struct sdhci_host *host)

 	sdhci_switch_external_dma(host, false);
 }
+EXPORT_SYMBOL_GPL(sdhci_external_dma_release);

-static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
-					      struct mmc_command *cmd)
+void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
+				       struct mmc_command *cmd)
 {
 	struct mmc_data *data = cmd->data;

@@ -1291,6 +1302,7 @@ static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,

 	sdhci_set_block_info(host, data);
 }
+EXPORT_SYMBOL(__sdhci_external_dma_prepare_data);

 static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
 					    struct mmc_command *cmd)
@@ -1305,8 +1317,8 @@ static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
 	}
 }

-static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
-					    struct mmc_command *cmd)
+void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+				     struct mmc_command *cmd)
 {
 	struct dma_chan *chan;

@@ -1317,6 +1329,7 @@ static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
 	if (chan)
 		dma_async_issue_pending(chan);
 }
+EXPORT_SYMBOL_GPL(sdhci_external_dma_pre_transfer);

 #else

@@ -1368,11 +1381,11 @@ static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
 	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
 }

-static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
-				      struct mmc_request *mrq)
+bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
 }
+EXPORT_SYMBOL_GPL(sdhci_manual_cmd23);

 static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
 					 struct mmc_command *cmd,
@@ -1484,7 +1497,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 }

-static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	if (host->cmd && host->cmd->mrq == mrq)
 		host->cmd = NULL;
@@ -1508,15 +1521,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	if (!sdhci_has_requests(host))
 		sdhci_led_deactivate(host);
 }
+EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);

-static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	__sdhci_finish_mrq(host, mrq);

 	queue_work(host->complete_wq, &host->complete_work);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_mrq);

-static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+void __sdhci_finish_data_common(struct sdhci_host *host)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1549,6 +1564,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 		data->bytes_xfered = 0;
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
+}
+EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
+
+static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host);

 	/*
 	 * Need to send CMD12 if -
@@ -1587,12 +1610,13 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 	}
 }

-static void sdhci_finish_data(struct sdhci_host *host)
+void sdhci_finish_data(struct sdhci_host *host)
 {
 	__sdhci_finish_data(host, false);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_data);

-static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
 	u32 mask;
@@ -1634,8 +1658,6 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			sdhci_prepare_data(host, cmd);
 	}

-	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
-
 	sdhci_set_transfer_mode(host, cmd);

 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
@@ -1679,13 +1701,16 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->use_external_dma)
 		sdhci_external_dma_pre_transfer(host, cmd);

+	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);

 	return true;
 }
+EXPORT_SYMBOL_GPL(sdhci_send_command);

-static bool sdhci_present_error(struct sdhci_host *host,
-				struct mmc_command *cmd, bool present)
+bool sdhci_present_error(struct sdhci_host *host,
+			 struct mmc_command *cmd, bool present)
 {
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		cmd->error = -ENOMEDIUM;
@@ -1694,6 +1719,7 @@ static bool sdhci_present_error(struct sdhci_host *host,

 	return false;
 }
+EXPORT_SYMBOL_GPL(sdhci_present_error);

 static bool sdhci_send_command_retry(struct sdhci_host *host,
 				     struct mmc_command *cmd,
@@ -1756,7 +1782,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }

-static void sdhci_finish_command(struct sdhci_host *host)
+void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;

@@ -1809,6 +1835,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 			__sdhci_finish_mrq(host, cmd->mrq);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_command);

 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e84ebddb20d8..6eeb74741da3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -831,8 +831,29 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }

+bool sdhci_data_line_cmd(struct mmc_command *cmd);
 void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+                     unsigned long timeout);
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_external_dma_release(struct sdhci_host *host);
+void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
+                                       struct mmc_command *cmd);
+void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+                                     struct mmc_command *cmd);
+#endif
+bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void __sdhci_finish_data_common(struct sdhci_host *host);
+bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_finish_command(struct sdhci_host *host);
+bool sdhci_present_error(struct sdhci_host *host,
+                         struct mmc_command *cmd, bool present);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
--
2.32.0

