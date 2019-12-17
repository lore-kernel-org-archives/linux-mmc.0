Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA2BC2D0C0
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CC621D7D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IEOnxz/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLQCwp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:45 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46181 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbfLQCwp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551164; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=CI6IVlVS4tT6rEmE0t64F3K7dLcEuCRxMVil12OQwn0=; b=IEOnxz/YudVKaUaQs8jvy4zlFCh8LSLAYnDlyQ4BJsHxnqt/fxm2Hj2iPAeGSmc67axw/Eaj
 poJgqs8AH8ufRGCDDfzltjKcCHjx1CNR+V6miAr/911ckAiMnRUJcom0oSFE4JjQPqP/aVbm
 b+7XlAbzNPH+JS2pNLf28TejHd4=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842fb.7f73b8035420-smtp-out-n03;
 Tue, 17 Dec 2019 02:52:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 947CCC4479F; Tue, 17 Dec 2019 02:52:43 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E05EAC43383;
        Tue, 17 Dec 2019 02:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E05EAC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sahitya Tummala <stummala@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 6/9] mmc: sdhci-msm: Ignore data timeout error for R1B commands
Date:   Mon, 16 Dec 2019 18:50:39 -0800
Message-Id: <22061d3479b876e8590b966162d6385a47f851b1.1576540908.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

Ignore data timeout error for R1B commands as there will be no
data associated and the busy timeout value for these commands
could be lager than the maximum timeout value that controller
can handle.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 15 +++++++++------
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c04e1ac..0a05d74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2925,12 +2925,6 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * above in sdhci_cmd_irq().
 		 */
 		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
-			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
-				host->data_cmd = NULL;
-				data_cmd->error = -ETIMEDOUT;
-				__sdhci_finish_mrq(host, data_cmd->mrq);
-				return;
-			}
 			if (intmask & SDHCI_INT_DATA_END) {
 				host->data_cmd = NULL;
 				/*
@@ -2944,6 +2938,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				__sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
+			if (host->quirks2 &
+				SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD)
+				return;
+			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
+				host->data_cmd = NULL;
+				data_cmd->error = -ETIMEDOUT;
+				__sdhci_finish_mrq(host, data_cmd->mrq);
+				return;
+			}
 		}
 
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0e..1a88f74 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -482,6 +482,13 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/*
+ * Ignore data timeout error for R1B commands as there will be no
+ * data associated and the busy timeout value for these commands
+ * could be lager than the maximum timeout value that controller
+ * can handle.
+ */
+#define SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD         (1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
