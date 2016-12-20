From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 2/4] mmc: mmc: Add change to set controller to HS400 frequency in enhanced strobe
Date: Tue, 20 Dec 2016 11:23:17 +0530
Message-ID: <1482213199-29152-3-git-send-email-riteshh@codeaurora.org>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Currently mmc_select_hs400es is not setting the desired frequency
before sending switch command. This makes CMD13 to timeout on
some controllers.
Thus add a change to set the desired HS400 frequency
in mmc_select_hs400es when the timing is switched to HS400.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9..eb69497 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1329,6 +1329,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 
 	/* Set host controller to HS400 timing and frequency */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
+	mmc_set_bus_speed(card);
 
 	/* Controller enable enhanced strobe function */
 	host->ios.enhanced_strobe = true;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
