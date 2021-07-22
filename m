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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3710C63799
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3338608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGVDWL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGVDWA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4804C0617A4;
        Wed, 21 Jul 2021 21:02:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p9so4336497pjl.3;
        Wed, 21 Jul 2021 21:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFFpAwt1nYpMrpAEp6H8PERqKttQGMnFGGlR8JKGTsc=;
        b=lF8WQU+z7JVvryJee6LsiXH4JcfLUGDIQyLmpqEcrMSGgk+yJg1vBOVRHNoLPun8LC
         pQoJt+Rjs78ihYD5TkY+FfzZjX39iGTepY9EG5nYD0B5DUlpG9lW4A/D+eYFdt1EC2SV
         kI8EzoiYyGrUnTX/9JlyEn8b6zhbGCiuf4ViXyEHblUJfDWL5C96xRAHVKUlx+Yjt4Cu
         NUrkhMBIc6EfmERcvvk0nKDoXQefWqt0WG+F9IF0nSpNE/OJu2XxSnauucDUL3L1BcZI
         A4KGtYAOHQRN8krjy3T4UCU64IlSBR6b+J87YtV5BIqjl/mHDmI7NNV6SyKtQhJqc6ad
         v5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFFpAwt1nYpMrpAEp6H8PERqKttQGMnFGGlR8JKGTsc=;
        b=F/+qGglqBzqhp7VC74ouEE97Dk4hB8u8waa8v3kWC/2i3g0Left2W0LvwN8vOvGpEo
         Pk4hr6grjk6lHxRYIllzdvv2vY57W5/cB1IucfIydV+2fwxIDlqkl7J7d8fv2WOtgQ07
         N/4lMeU1zWpmi5enBCySHZODXBNLQHLwtwgeiA0dwvWHQ7xcsU6GRP1KCv5nHHBmcu44
         jGU5QPTUWB4iPKGq6EccXbIE4eu7f6VgF/hSEItf2lFuMjdI5gR3J6pyjrZ1FgA+98cx
         c5x8uM+Pwzs7ixBiqWDCd6B5yMyJpuBuPVFmSZcA3UFAc90QEia1ImghqtWbzHwAz1ng
         dBSQ==
X-Gm-Message-State: AOAM5304IFp51xFN/hDJuU9n1zcF/s55kp51/UvaLk/xquvhYYYrd/nO
        3CQ6yYwLbNgI24zXIt+Wd3I=
X-Google-Smtp-Source: ABdhPJwWcY+c7GBZAEXDRyRASU8yesCBBWVegC8ZCgFeddWst3ejfqAtCWK51TyPcW85XEY4M1AwQw==
X-Received: by 2002:a65:6894:: with SMTP id e20mr39018825pgt.350.1626926552167;
        Wed, 21 Jul 2021 21:02:32 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:31 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 21/29] mmc: sdhci-uhs2: add irq() and others
Date:   Thu, 22 Jul 2021 12:01:16 +0800
Message-Id: <20210722040124.7573-21-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a UHS-II version of sdhci's request() operation.
It handles UHS-II related command interrupts and errors.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 247 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   3 +
 drivers/mmc/host/sdhci.c      |  96 ++++++++++++-
 drivers/mmc/host/sdhci.h      |   6 +
 4 files changed, 347 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 36e52553977a..d50134e912f3 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -11,6 +11,7 @@
  */

 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mmc/mmc.h>
@@ -670,6 +671,12 @@ static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
 						   struct mmc_command *cmd)
 {
 }
+
+static inline struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
+							  struct mmc_data *data)
+{
+	return NULL;
+}
 #endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */

 static void sdhci_uhs2_finish_data(struct sdhci_host *host)
@@ -1051,6 +1058,246 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
 	}
 }

+/*****************************************************************************\
+ *                                                                           *
+ * Request done                                                              *
+ *                                                                           *
+\*****************************************************************************/
+
+static bool sdhci_uhs2_request_done(struct sdhci_host *host)
+{
+	unsigned long flags;
+	struct mmc_request *mrq;
+	int i;
+
+	/* FIXME: UHS2_INITIALIZED, instead? */
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return sdhci_request_done(host);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq)
+			break;
+	}
+
+	if (!mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return true;
+	}
+
+	/*
+	 * Always unmap the data buffers if they were mapped by
+	 * sdhci_prepare_data() whenever we finish with a request.
+	 * This avoids leaking DMA mappings on error.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA) {
+		struct mmc_data *data = mrq->data;
+
+		if (host->use_external_dma && data &&
+		    (mrq->cmd->error || data->error)) {
+			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
+
+			host->mrqs_done[i] = NULL;
+			spin_unlock_irqrestore(&host->lock, flags);
+			dmaengine_terminate_sync(chan);
+			spin_lock_irqsave(&host->lock, flags);
+			sdhci_set_mrq_done(host, mrq);
+		}
+
+		sdhci_request_done_dma(host, mrq);
+	}
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
+		/* Some controllers need this kick or reset won't work here */
+		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
+			/* This is to force an update */
+			host->ops->set_clock(host, host->clock);
+
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		host->pending_reset = false;
+	}
+
+	host->mrqs_done[i] = NULL;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
+
+	return false;
+}
+
+static void sdhci_uhs2_complete_work(struct work_struct *work)
+{
+	struct sdhci_host *host = container_of(work, struct sdhci_host,
+					       complete_work);
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
+	    mmc_hostname(host->mmc), uhs2mask);
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK) {
+		if (!host->cmd) {
+			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
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
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT) {
+			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			host->data->error = -ETIMEDOUT;
+		} else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_ADMA) {
+			pr_err("%s: ADMA error = 0x %x\n",
+			       mmc_hostname(host->mmc),
+			       sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else {
+			host->data->error = -EILSEQ;
+		}
+	}
+
+	if (host->data && host->data->error)
+		sdhci_uhs2_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+}
+
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
+{
+	u32 mask = intmask, uhs2mask;
+
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
+		goto out;
+
+	/*
+	 * TODO: We should mask Normal Error Interrupt Status Register
+	 * in UHS-2 mode so that we don't have to care SD mode errors.
+	 */
+	if (intmask & SDHCI_INT_ERROR) {
+		uhs2mask = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS);
+		if (!(uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK))
+			goto cmd_irq;
+
+		/* Clear error interrupts */
+		sdhci_writel(host, uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK,
+			     SDHCI_UHS2_ERR_INT_STATUS);
+
+		/* Handle error interrupts */
+		__sdhci_uhs2_irq(host, uhs2mask);
+
+		/* Caller, shdci_irq(), doesn't have to care UHS-2 errors */
+		intmask &= ~SDHCI_INT_ERROR;
+		mask &= SDHCI_INT_ERROR;
+	}
+
+cmd_irq:
+	/*
+	 * TODO: Cleanup
+	 * INT_RESPONSE is enough instead of INT_CMD_MASK, assuming that
+	 * INT_ERROR and INT_CMD_MASK won't happen at the same time.
+	 */
+	if (intmask & SDHCI_INT_CMD_MASK) {
+		/* Clear command interrupt */
+                sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
+			     SDHCI_INT_STATUS);
+
+		/* Handle command interrupt */
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_uhs2_finish_command(host);
+
+		/* Caller, shdci_irq(), doesn't have to care UHS-2 command */
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		mask &= SDHCI_INT_CMD_MASK;
+	}
+
+	/* Clear already-handled interrupts. */
+	sdhci_writel(host, mask, SDHCI_INT_STATUS);
+
+out:
+	return intmask;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct mmc_command *cmd;
+	unsigned long flags;
+	u32 isr;
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	isr = host->thread_isr;
+	host->thread_isr = 0;
+
+	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc->ops->card_event(mmc);
+		mmc_detect_change(mmc, msecs_to_jiffies(200));
+	}
+
+	return IRQ_HANDLED;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index c1ff4ac1ab7a..b74af641d00e 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -215,5 +215,8 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);

 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 731a60c4b131..4a2046c22319 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1214,11 +1214,12 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
 	return ret;
 }

-static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
-						   struct mmc_data *data)
+struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
+					    struct mmc_data *data)
 {
 	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
 }
+EXPORT_SYMBOL_GPL(sdhci_external_dma_channel);

 int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
 {
@@ -1467,7 +1468,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }

-static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
@@ -1475,8 +1476,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
+EXPORT_SYMBOL_GPL(sdhci_needs_reset);

-static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	int i;

@@ -1496,6 +1498,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)

 	WARN_ON(i >= SDHCI_MAX_MRQS);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);

 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -3029,7 +3032,56 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/

-static bool sdhci_request_done(struct sdhci_host *host)
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (data && data->host_cookie == COOKIE_MAPPED) {
+		if (host->bounce_buffer) {
+			/*
+			 * On reads, copy the bounced data into the
+			 * sglist
+			 */
+			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+				unsigned int length = data->bytes_xfered;
+
+				if (length > host->bounce_buffer_size) {
+					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
+					       mmc_hostname(host->mmc),
+					       host->bounce_buffer_size,
+					       data->bytes_xfered);
+					/* Cap it down and continue */
+					length = host->bounce_buffer_size;
+				}
+				dma_sync_single_for_cpu(
+					host->mmc->parent,
+					host->bounce_addr,
+					host->bounce_buffer_size,
+					DMA_FROM_DEVICE);
+				sg_copy_from_buffer(data->sg,
+					data->sg_len,
+					host->bounce_buffer,
+					length);
+			} else {
+				/* No copying, just switch ownership */
+				dma_sync_single_for_cpu(
+					host->mmc->parent,
+					host->bounce_addr,
+					host->bounce_buffer_size,
+					mmc_get_dma_dir(data));
+			}
+		} else {
+			/* Unmap the raw data */
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,
+				     mmc_get_dma_dir(data));
+		}
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
+
+bool sdhci_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
 	struct mmc_request *mrq;
@@ -3140,6 +3192,39 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			}
 			data->host_cookie = COOKIE_UNMAPPED;
 		}
+
+		sdhci_request_done_dma(host, mrq);
+	}
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
+		/* Some controllers need this kick or reset won't work here */
+		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
+			/* This is to force an update */
+			host->ops->set_clock(host, host->clock);
+
+		/*
+		 * Spec says we should do both at the same time, but
+		 * Ricoh controllers do not like that.
+		 */
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+		host->pending_reset = false;
 	}

 	host->mrqs_done[i] = NULL;
@@ -3153,6 +3238,7 @@ static bool sdhci_request_done(struct sdhci_host *host)

 	return false;
 }
+EXPORT_SYMBOL_GPL(sdhci_request_done);

 static void sdhci_complete_work(struct work_struct *work)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6eeb74741da3..74572b54ec47 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -845,8 +845,12 @@ void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
                                        struct mmc_command *cmd);
 void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
                                      struct mmc_command *cmd);
+struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
+                                            struct mmc_data *data);
 #endif
 bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_data_common(struct sdhci_host *host);
@@ -878,6 +882,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
+bool sdhci_request_done(struct sdhci_host *host);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);

--
2.32.0

