Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE47C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Feb 2021 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0808E64EBB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Feb 2021 10:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBXKyy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 05:54:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37894 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhBXKyT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 05:54:19 -0500
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2021 02:53:36 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 24 Feb 2021 02:53:34 -0800
X-QCInternal: smtphost
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Feb 2021 16:23:11 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 11D8F2147E; Wed, 24 Feb 2021 16:23:10 +0530 (IST)
From:   Pradeep P V K <pragalla@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <pragalla@codeaurora.org>
Subject: [PATCH V1] mmc: sdhci: Check for reset prior to DMA address unmap
Date:   Wed, 24 Feb 2021 16:23:05 +0530
Message-Id: <1614163985-38914-1-git-send-email-pragalla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For data read commands, SDHC may initiate data transfers even before it
completely process the command response. In case command itself fails,
driver un-maps the memory associated with data transfer but this memory
can still be accessed by SDHC for the already initiated data transfer.
This scenario can lead to un-mapped memory access error.

To avoid this scenario, reset SDHC (when command fails) prior to
un-mapping memory. Resetting SDHC ensures that all in-flight data
transfers are either aborted or completed. So we don't run into this
scenario.

Swap the reset, un-map steps sequence in sdhci_request_done().

Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 646823d..e78d84c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2996,6 +2996,35 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		spin_unlock_irqrestore(&host->lock, flags);
 		return true;
 	}
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
+		/* Spec says we should do both at the same time, but Ricoh
+		 * controllers do not like that.
+		 */
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+		host->pending_reset = false;
+	}
 
 	/*
 	 * Always unmap the data buffers if they were mapped by
@@ -3060,35 +3089,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		}
 	}
 
-	/*
-	 * The controller needs a reset of internal state machines
-	 * upon error conditions.
-	 */
-	if (sdhci_needs_reset(host, mrq)) {
-		/*
-		 * Do not finish until command and data lines are available for
-		 * reset. Note there can only be one other mrq, so it cannot
-		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
-		 * would both be null.
-		 */
-		if (host->cmd || host->data_cmd) {
-			spin_unlock_irqrestore(&host->lock, flags);
-			return true;
-		}
-
-		/* Some controllers need this kick or reset won't work here */
-		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
-			/* This is to force an update */
-			host->ops->set_clock(host, host->clock);
-
-		/* Spec says we should do both at the same time, but Ricoh
-		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-
-		host->pending_reset = false;
-	}
-
 	host->mrqs_done[i] = NULL;
 
 	spin_unlock_irqrestore(&host->lock, flags);
-- 
2.7.4

