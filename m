From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/7] mmc: msm_sdcc: handle the platform gpio_data not present case
Date: Tue, 26 Apr 2011 11:04:20 +0530
Message-ID: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6175 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1DZFfJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 01:35:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Subhash Jadavani <subhashj@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>

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
