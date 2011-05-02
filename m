From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 1/7] mmc: msm_sdcc: handle the platform gpio_data not present case
Date: Mon,  2 May 2011 18:03:33 +0530
Message-ID: <1304339613-7458-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Subhash Jadavani <subhashj@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

If platform gpio_data is not present then don't do any
gpio configuration.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index a4c865a..d06539d 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -939,7 +939,7 @@ static void msmsdcc_setup_gpio(struct msmsdcc_host *host, bool enable)
 	struct msm_mmc_gpio_data *curr;
 	int i, rc = 0;
 
-	if (!host->plat->gpio_data && host->gpio_config_status == enable)
+	if (!host->plat->gpio_data || host->gpio_config_status == enable)
 		return;
 
 	curr = host->plat->gpio_data;
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
