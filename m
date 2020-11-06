Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A6C4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79ACD2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgTwpq9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKFC3F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKFC3C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:29:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C5C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:29:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h6so2781497pgk.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kH5STjBeLdf8ptead91jO0RSvMUvWWn9CAy36KbAZ/o=;
        b=VgTwpq9j5GwA79NsQZqOp7mqsgqC+XHqYVAGPvh05Ht0gXeA9J2oSspMuJaqM1VMfv
         6Fjba32hULIq3q27IoxPpQ+ikNGY/QYxwXgqnbF0Gop+ufBZOzX72J61pTUIZ3zXZyiP
         SlAeqQYkNNkJj0i6b5loQjV/c9nBuhZu/j+G4swJH91UmmT4yy/DZRStu7KrErYJ8hes
         he7wJwrxqbPCuER7RCre5PnPtJ/oPI6I4qF6tBBN56RuqhFUt24xyiQkZMWNESbf6ajd
         eEXewg71bMyWEQ9MV1qhkyJvBoU5Z5dT/KC2/0jhDEY84WSJMLuitRVw0P1WBBTATjNN
         9mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kH5STjBeLdf8ptead91jO0RSvMUvWWn9CAy36KbAZ/o=;
        b=bqiDUDnGF6rjoJua2nVBrAZcnawSpKHmgs9Q3eZYnlUuuI8G0lFuB5HCL9+X+Uy+HR
         dFADLvcRSNY0rwZ4mSUHggGEqgoU1WOVtYmElyq9C5+MoDwyl7AFGCRch6LKdA+Op7Uy
         w5M19gkF+LOKXY2oDGpPpnX6t9eNDEXqxJyDlM2sLWtQteMlxEV9X6sUMydjbIFV46db
         uR/1EjmL7UZlHc6/8hLkd/zZGKlYv1cLLwNrAHOTvBwutbdU9up5r3cAzNS/OUYvIpvO
         RG3LLkmMI/+/5oU29b6150JyMufJMPgjrD2Gy+sI5TVe4+KttYh1/hM5KZp54MGLURSh
         eHLw==
X-Gm-Message-State: AOAM532xOlK6/37tKWVSLyQOhMUdJLHn5SvllygAXqCO0mZa4LP11ySy
        pj6dkdn7+dpCK3VqP9HftKB6jw==
X-Google-Smtp-Source: ABdhPJwZ9RBsctwLpHheHTSwd0oLblQXj38iYV454Zg1KEmy5epLMVsS3bOkLb0V9MMyQO0vvZTjVQ==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr5027205pgi.337.1604629741902;
        Thu, 05 Nov 2020 18:29:01 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:01 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 21/27] mmc: sdhci-uhs2: add irq() and others
Date:   Fri,  6 Nov 2020 11:27:20 +0900
Message-Id: <20201106022726.19831-22-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
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
 drivers/mmc/host/sdhci.c      | 112 ++++++++-------
 drivers/mmc/host/sdhci.h      |   6 +
 4 files changed, 319 insertions(+), 49 deletions(-)

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
index a9f5449bddcc..e2dfc7767bcf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1215,11 +1215,12 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
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
@@ -1466,7 +1467,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
-static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
@@ -1474,8 +1475,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
+EXPORT_SYMBOL_GPL(sdhci_needs_reset);
 
-static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	int i;
 
@@ -1495,6 +1497,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 
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
@@ -3067,48 +3119,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			sdhci_set_mrq_done(host, mrq);
 		}
 
-		if (data && data->host_cookie == COOKIE_MAPPED) {
-			if (host->bounce_buffer) {
-				/*
-				 * On reads, copy the bounced data into the
-				 * sglist
-				 */
-				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
-					unsigned int length = data->bytes_xfered;
-
-					if (length > host->bounce_buffer_size) {
-						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
-						       mmc_hostname(host->mmc),
-						       host->bounce_buffer_size,
-						       data->bytes_xfered);
-						/* Cap it down and continue */
-						length = host->bounce_buffer_size;
-					}
-					dma_sync_single_for_cpu(
-						host->mmc->parent,
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						DMA_FROM_DEVICE);
-					sg_copy_from_buffer(data->sg,
-						data->sg_len,
-						host->bounce_buffer,
-						length);
-				} else {
-					/* No copying, just switch ownership */
-					dma_sync_single_for_cpu(
-						host->mmc->parent,
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						mmc_get_dma_dir(data));
-				}
-			} else {
-				/* Unmap the raw data */
-				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,
-					     mmc_get_dma_dir(data));
-			}
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
+		sdhci_request_done_dma(host, mrq);
 	}
 
 	/*
@@ -3132,8 +3143,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		/* Spec says we should do both at the same time, but Ricoh
-		   controllers do not like that. */
+		/*
+		 * Spec says we should do both at the same time, but
+		 * Ricoh controllers do not like that.
+		 */
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
@@ -3151,6 +3164,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
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
2.28.0

