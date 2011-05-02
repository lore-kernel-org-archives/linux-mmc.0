From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 6/7] mmc: msm_sdcc: Change initialization order of busclk_timer in probe
Date: Mon,  2 May 2011 18:10:01 +0530
Message-ID: <1304340001-8720-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-6-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-6-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Intialize busclk_timer before it is accessed in probe.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 908524b..1fe4102 100644
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
