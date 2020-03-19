Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A56AC4332E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037AC20753
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/B8JAwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgCSKzV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:55:21 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50808 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSKzU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 06:55:20 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so869918pjb.0;
        Thu, 19 Mar 2020 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yPu+Tsh1vDBZEMyMTwJs45J9Q+S4JNSfOUTW+nfLI0I=;
        b=V/B8JAwYgx2pDyQwqdGWZmIy+yLQe2pXcMPuFZWaPvnj3upkP9Csx1S+tqr/tdvfSV
         0DfQ6Ryhq3FNaHjN2chEFpasaEgwSsQPc4ALSfhPuhvXYALZyERShtEQ7IagBXZC1zwh
         NJxONjJJuNOvgn9hl/6OKA7ndQlrvANLieBn2Uc/YUP2bQPmFsMqY1gp7SSsKjFcy7ax
         FC/eqad6WxN2B1iyDruttTOdjJcy5gRw6Z4QNn19qxKimhCRwdwBlD2B8/1hVDPShu9h
         pbToXBkOa1XXLgqTCVQyV8Cad9ieDSRGhwecaMptaZ/fQyU8Ll/RXCf6TWf+XrOyzbre
         Kalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yPu+Tsh1vDBZEMyMTwJs45J9Q+S4JNSfOUTW+nfLI0I=;
        b=l99v11SqHFvfmvkzhjz8A+UBdkh9jYy+4/+7qOmSBDB54bhM3Jc8hIwYE9IE0024rI
         4131MA00JhkOmmGUCKcTiuwFYn/yOmm6HuzESJLcZKfJ7uOlMtWx9asgnH0E8U9JTWsq
         VJC0YyDqERDe8VEzg4iW9jCXwiDcXXY3WSgzQuSXPlf3lFviRH7U8zthGmw/KIYEVaOF
         GAxRJCzjCbMwec/nlzi2rRB8qFiUnANln+EzIgVi5Rf9Pb9gGzzA6L+6y4TjZlSqavUe
         hTS+w5x+Gm4Vu6ffTR4iVu01rriwxx25qzkdkq3Ku4lIYGYBS7dYiAFFC4y/pVX3xmKM
         kfXw==
X-Gm-Message-State: ANhLgQ0NB1VWIZ3pl1x/KxiKKQ3ULUipzl5rmdg8yoppb+2AcLJU6j36
        wojl1OgOqPPujmsTa8C9sw8=
X-Google-Smtp-Source: ADFU+vuZlkT0wvI3GWKvr/tjlaWpJZv+n3i9HlYNHUBN0BRxpQi5a4UBmK71smj1CmKtrOAlVpNICQ==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr3221589pji.126.1584615319129;
        Thu, 19 Mar 2020 03:55:19 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f6sm2209949pfk.99.2020.03.19.03.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 03:55:18 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] mmc: host: sdhci: Implement the request_atomic() API
Date:   Thu, 19 Mar 2020 18:54:20 +0800
Message-Id: <485c1fc03e31007bf1464e94693569509c41d366.1584615043.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() ops for the sdhci driver to process
one request in the atomic context if the card is nonremovable.

Moreover, add a boolean parameter for sdhci_send_command() function
to indicate if need poll the inhibit bits, which can avoid
time-consuming polling in interrupt context by returning BUSY if
we met this unusual case through request_atomic() API.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 65 +++++++++++++++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h |  4 ++-
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9c37451..8f4b985 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1538,14 +1538,15 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		} else {
 			/* Avoid triggering warning in sdhci_send_command() */
 			host->cmd = NULL;
-			sdhci_send_command(host, data->stop);
+			sdhci_send_command(host, data->stop, true);
 		}
 	} else {
 		__sdhci_finish_mrq(host, data->mrq);
 	}
 }
 
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+int sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd,
+		       bool polling)
 {
 	int flags;
 	u32 mask;
@@ -1573,13 +1574,26 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mask &= ~SDHCI_DATA_INHIBIT;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
+		if (!polling) {
+			pr_err("%s: Controller has not released inhibit bit(s), try again.\n",
+			       mmc_hostname(host->mmc));
+
+			/*
+			 * HSQ may send a command in interrupt context without
+			 * polling the busy signaling, which means we should
+			 * return BUSY if controller has not released inhibit
+			 * bits to allow HSQ trying to send request again in
+			 * non-atomic context. so we should not finish this
+			 * request here.
+			 */
+			return -EBUSY;
+		} else if (timeout == 0) {
 			pr_err("%s: Controller never released inhibit bit(s).\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			sdhci_finish_mrq(host, cmd->mrq);
-			return;
+			return -EIO;
 		}
 		timeout--;
 		mdelay(1);
@@ -1609,7 +1623,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			mmc_hostname(host->mmc));
 		cmd->error = -EINVAL;
 		sdhci_finish_mrq(host, cmd->mrq);
-		return;
+		return -EINVAL;
 	}
 
 	if (!(cmd->flags & MMC_RSP_PRESENT))
@@ -1644,6 +1658,8 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
@@ -1706,7 +1722,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	/* Finished CMD23, now send actual command. */
 	if (cmd == cmd->mrq->sbc) {
-		sdhci_send_command(host, cmd->mrq->cmd);
+		sdhci_send_command(host, cmd->mrq->cmd, true);
 	} else {
 
 		/* Processed actual command. */
@@ -2016,16 +2032,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
  *                                                                           *
 \*****************************************************************************/
 
-void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+static int sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
+				int present, bool polling)
 {
-	struct sdhci_host *host;
-	int present;
+	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
-
-	host = mmc_priv(mmc);
-
-	/* Firstly check card presence */
-	present = mmc->ops->get_cd(mmc);
+	int ret;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2033,15 +2045,34 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
+		ret = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
 	} else {
 		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
-			sdhci_send_command(host, mrq->sbc);
+			ret = sdhci_send_command(host, mrq->sbc, polling);
 		else
-			sdhci_send_command(host, mrq->cmd);
+			ret = sdhci_send_command(host, mrq->cmd, polling);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	return ret;
+}
+
+int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	return sdhci_start_request(mmc, mrq, 1, false);
+}
+EXPORT_SYMBOL_GPL(sdhci_request_atomic);
+
+void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	int present;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	sdhci_start_request(mmc, mrq, present, true);
 }
 EXPORT_SYMBOL_GPL(sdhci_request);
 
@@ -2581,7 +2612,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
-	sdhci_send_command(host, &cmd);
+	sdhci_send_command(host, &cmd, true);
 
 	host->cmd = NULL;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cac2d97..73e15c5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -759,7 +759,8 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 int __sdhci_add_host(struct sdhci_host *host);
 int sdhci_add_host(struct sdhci_host *host);
 void sdhci_remove_host(struct sdhci_host *host, int dead);
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
+int sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd,
+		       bool polling);
 
 static inline void sdhci_read_caps(struct sdhci_host *host)
 {
@@ -775,6 +776,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1

