Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48543C43381
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AAD64F69
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhCDAAS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:18 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:64266 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhCCL2i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 06:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1614770913; x=1646306913;
  h=from:to:cc:subject:date:message-id;
  bh=YhmKslpzi+cHH3vU8pK14563hq3M1o4bf8szMh+VDvE=;
  b=cJ0SlEuGThFCyfhmB2G6RzPWRIjYX3DrfVgsbM0snkVatNHu9ytss6ss
   M6rrgN4Uv4hnTlF9vvFkvTqeEkiLHOEppU1BdqxdUvu5y1UVGDbGE/grt
   XCkqRtkc3boKkdHx6hQQuB7KwyaqRF4t0cyKqwRc0Aq5VLlKeXDzcasSY
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 03 Mar 2021 00:32:40 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Mar 2021 00:32:38 -0800
X-QCInternal: smtphost
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Mar 2021 14:02:15 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 4ED122147B; Wed,  3 Mar 2021 14:02:14 +0530 (IST)
From:   Pradeep P V K <pragalla@qti.qualcomm.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <pragalla@codeaurora.org>
Subject: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
Date:   Wed,  3 Mar 2021 14:02:11 +0530
Message-Id: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Pradeep P V K <pragalla@codeaurora.org>

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

Changes since V1:
- Added an empty line and fixed the comment style.
- Retained the Acked-by signoff.

Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 60 +++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 646823d..130fd2d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	}
 
 	/*
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
+		 * Spec says we should do both at the same time, but Ricoh
+		 * controllers do not like that.
+		 */
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+		host->pending_reset = false;
+	}
+
+	/*
 	 * Always unmap the data buffers if they were mapped by
 	 * sdhci_prepare_data() whenever we finish with a request.
 	 * This avoids leaking DMA mappings on error.
@@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
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

