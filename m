Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30748C2BB85
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0598220575
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDLJEk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:04:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:20973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLJEj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Apr 2020 05:04:39 -0400
IronPort-SDR: GNcQ+urhct/6fBMxL5K0UmWy+6p6DVEhYc+Rxy0uP1WsVi6WmIce+wtHd/xFxRqA3fG6C1SbWt
 igP0X0aeVhiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 02:04:40 -0700
IronPort-SDR: fPiwfDBBxLDCIcmP8kszKGPvzWHe2kZyicc4CcE5c4tklHUPpTIV1IvzPbAR4nQ3Gk8jBW5Pre
 ZcZJ/478KGFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="362835152"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 02:04:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/5] mmc: sdhci: Add helpers for the auto-CMD23 flag
Date:   Sun, 12 Apr 2020 12:03:45 +0300
Message-Id: <20200412090349.1607-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
References: <20200412090349.1607-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add 2 helper functions to make the use of the auto-CMD23 flag more
readable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..07548e5efd1f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1350,13 +1350,25 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+}
+
+static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
+				      struct mmc_request *mrq)
+{
+	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
+}
+
 static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
 					 struct mmc_command *cmd,
 					 u16 *mode)
 {
 	bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
 			 (cmd->opcode != SD_IO_RW_EXTENDED);
-	bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+	bool use_cmd23 = sdhci_auto_cmd23(host, cmd->mrq);
 	u16 ctrl2;
 
 	/*
@@ -1416,7 +1428,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
 		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
 		sdhci_auto_cmd_select(host, cmd, &mode);
-		if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23))
+		if (sdhci_auto_cmd23(host, cmd->mrq))
 			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
 	}
 
@@ -2054,7 +2066,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		mrq->cmd->error = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
 	} else {
-		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
+		if (sdhci_manual_cmd23(host, mrq))
 			sdhci_send_command(host, mrq->sbc);
 		else
 			sdhci_send_command(host, mrq->cmd);
-- 
2.17.1

