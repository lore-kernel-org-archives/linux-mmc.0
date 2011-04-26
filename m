From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 6/7] mmc: msm_sdcc: Change initialization order of busclk_timer in probe
Date: Tue, 26 Apr 2011 11:04:25 +0530
Message-ID: <1303796066-6784-6-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:22619 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1DZFfr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 01:35:47 -0400
In-Reply-To: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>

Intialize busclk_timer before it is accessed in probe.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 782e4cc..36fded7 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1209,6 +1209,10 @@ msmsdcc_probe(struct platform_device *pdev)
 	host->plat = plat;
 	host->mmc = mmc;
 	host->curr.cmd = NULL;
+	init_timer(&host->busclk_timer);
+	host->busclk_timer.data = (unsigned long) host;
+	host->busclk_timer.function = msmsdcc_busclk_expired;
+
 
 	host->cmdpoll = 1;
 
@@ -1326,10 +1330,6 @@ msmsdcc_probe(struct platform_device *pdev)
 		host->eject = !host->oldstat;
 	}
 
-	init_timer(&host->busclk_timer);
-	host->busclk_timer.data = (unsigned long) host;
-	host->busclk_timer.function = msmsdcc_busclk_expired;
-
 	ret = request_irq(cmd_irqres->start, msmsdcc_irq, IRQF_SHARED,
 			  DRIVER_NAME " (cmd)", host);
 	if (ret)
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
