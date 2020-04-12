Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB638C2BB86
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F81E20575
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgDLJEo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:04:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:20973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLJEo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Apr 2020 05:04:44 -0400
IronPort-SDR: Iwy+id4MxoJ9kzoJq/nS+6AycLLfh0ICyEZhc9p57IgaC2R3/ofl34EbQDvT6qNIO4btRDd83p
 FL+kmjKPFADg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 02:04:44 -0700
IronPort-SDR: gRtjE8uSOj/wdKO+cNHTX+QUcqs9/OdA8q45gLovBtG1/2PJk4fMFGwIhISVo7FZ5cV0ZEcI24
 aoXUiQaJaS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="362835168"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 02:04:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 4/5] mmc: sdhci: Tidy sdhci_request() a bit
Date:   Sun, 12 Apr 2020 12:03:48 +0300
Message-Id: <20200412090349.1607-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
References: <20200412090349.1607-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In preparation for further changes, tidy sdhci_request() a bit.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 27be2152553f..b9ddc8edffe2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1659,6 +1659,17 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 
+static bool sdhci_present_error(struct sdhci_host *host,
+				struct mmc_command *cmd, bool present)
+{
+	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
+		cmd->error = -ENOMEDIUM;
+		return true;
+	}
+
+	return false;
+}
+
 static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int i, reg;
@@ -2048,11 +2059,10 @@ EXPORT_SYMBOL_GPL(sdhci_set_power_and_bus_voltage);
 
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-	struct sdhci_host *host;
-	int present;
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
 	unsigned long flags;
-
-	host = mmc_priv(mmc);
+	bool present;
 
 	/* Firstly check card presence */
 	present = mmc->ops->get_cd(mmc);
@@ -2061,16 +2071,19 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	sdhci_led_activate(host);
 
-	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
-		mrq->cmd->error = -ENOMEDIUM;
-		sdhci_finish_mrq(host, mrq);
-	} else {
-		if (sdhci_manual_cmd23(host, mrq))
-			sdhci_send_command(host, mrq->sbc);
-		else
-			sdhci_send_command(host, mrq->cmd);
-	}
+	if (sdhci_present_error(host, mrq->cmd, present))
+		goto out_finish;
+
+	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
+
+	sdhci_send_command(host, cmd);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return;
 
+out_finish:
+	sdhci_finish_mrq(host, mrq);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 EXPORT_SYMBOL_GPL(sdhci_request);
-- 
2.17.1

