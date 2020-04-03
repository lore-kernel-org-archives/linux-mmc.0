Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BCAC2BA18
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D032080C
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIvjKv0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgDCHFt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:05:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45033 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbgDCHFs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 03:05:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2347729plr.11;
        Fri, 03 Apr 2020 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cn9rxoHRwqUFpqjcL+3xJuR6J5sQOGtMSKzJdI2DfTs=;
        b=nIvjKv0totLA9J1qANJGWwvGcdvejsYy8TEY43F1hiZbDOJpsH9HSPv1f9yK5fT1rx
         of0szrECg7PW6NWvwmM83BUecPDFvCN/02Z2h1YAN/xi2e6F2VopsoTlXH2HfOCNEBX+
         sHoUSEqjrbeEG4KP9l1b0bsT3DOz1YP3lxzGW1cz/iUlTIMAyp3JzxkYQM9lWV8GztOv
         7cha51bONpjNFeSyxcwsBvqPtFAC2cXjLmtS6/cFU5zTc/eCniUnPrQZhVYrskB+pqFO
         6dgJQLDsCKTza0wyUIsmx6TlfbBAPjvJIURyN3aHOaHvQBUwsC/X72a+MXxe2QJi+r1/
         qZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cn9rxoHRwqUFpqjcL+3xJuR6J5sQOGtMSKzJdI2DfTs=;
        b=A9/STAVSqBKT/nOgvXWpMEENMj1XkAuFPUnjSr+LfgRFksA1C7WyPFiROtlXumeDYe
         D8VU1LeH2AnKreBCg9qSutFFgDH5l482UmC+BfoEdpNOApNVYwwzfMPPDN0cXZ4Q/fSQ
         prqdkfwHvM4i4u2XaRCTlLFLYQ79YblMpD41KNuMboDVvVWSbtb2JZWdV91ZtjzrC+aP
         Vz7mawoXBuMNlJD+P0YVtIVo2UBzjBcS+J5/HHTES3cZkaga2lWmz9ntESGRGHZDn5Zg
         ndW+Jxus224VtZQYYvCkOTC5r+jjyNePIgiLOyjBXRIM+qcShJzLm0x+BplviaQYVRpV
         vP2w==
X-Gm-Message-State: AGi0PuaB750SsgLXXIw+uFGcZDzw12Gz2Mmeje86z804wtS/PLT89QRq
        Dki4Ni0LnXCLRerjMK4yLyvA1JAW
X-Google-Smtp-Source: APiQypIFFOuAoNTKN7ddIsEBetM5he1h/XwWLQuTeUGCcpFVd+XiMAruXCGJZRbWmZnGuuBLg+lBTQ==
X-Received: by 2002:a17:90a:19dc:: with SMTP id 28mr5376736pjj.180.1585897547903;
        Fri, 03 Apr 2020 00:05:47 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u18sm5138701pfl.40.2020.04.03.00.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:05:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] mmc: host: sdhci: Implement the request_atomic() API
Date:   Fri,  3 Apr 2020 15:05:27 +0800
Message-Id: <974ff8409cf7e7759df9eff09368bea3545474d7.1585896945.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
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
index 3f71646..1e67b1a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1539,14 +1539,15 @@ static void sdhci_finish_data(struct sdhci_host *host)
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
@@ -1574,13 +1575,26 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -1610,7 +1624,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			mmc_hostname(host->mmc));
 		cmd->error = -EINVAL;
 		sdhci_finish_mrq(host, cmd->mrq);
-		return;
+		return -EINVAL;
 	}
 
 	if (!(cmd->flags & MMC_RSP_PRESENT))
@@ -1645,6 +1659,8 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
@@ -1707,7 +1723,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	/* Finished CMD23, now send actual command. */
 	if (cmd == cmd->mrq->sbc) {
-		sdhci_send_command(host, cmd->mrq->cmd);
+		sdhci_send_command(host, cmd->mrq->cmd, true);
 	} else {
 
 		/* Processed actual command. */
@@ -2035,16 +2051,12 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
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
 
@@ -2052,15 +2064,34 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
 
@@ -2600,7 +2631,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
-	sdhci_send_command(host, &cmd);
+	sdhci_send_command(host, &cmd, true);
 
 	host->cmd = NULL;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb..f2d255c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -757,7 +757,8 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 int __sdhci_add_host(struct sdhci_host *host);
 int sdhci_add_host(struct sdhci_host *host);
 void sdhci_remove_host(struct sdhci_host *host, int dead);
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
+int sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd,
+		       bool polling);
 
 static inline void sdhci_read_caps(struct sdhci_host *host)
 {
@@ -776,6 +777,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1

