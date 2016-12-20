From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 3/4] mmc: mmc: enable ios.enhanced_strobe before mmc_set_timing
Date: Tue, 20 Dec 2016 11:23:18 +0530
Message-ID: <1482213199-29152-4-git-send-email-riteshh@codeaurora.org>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbcLTFxu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 00:53:50 -0500
In-Reply-To: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

Some controllers may need to configure few registers based on enhanced
strobe mode while configuring to HS400 timing, thus make
ios.enhanced_strobe to true before mmc_set_timing in mmc_select_hs400es.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/mmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index eb69497..052368e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1327,12 +1327,18 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	/*
+	 * Enable enhanced_strobe in ios, as some controllers
+	 * may need to configure few registers based on enhanced
+	 * strobe while changing HS400 timing.
+	 */
+	host->ios.enhanced_strobe = true;
+
 	/* Set host controller to HS400 timing and frequency */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
 	/* Controller enable enhanced strobe function */
-	host->ios.enhanced_strobe = true;
 	if (host->ops->hs400_enhanced_strobe)
 		host->ops->hs400_enhanced_strobe(host, &host->ios);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

