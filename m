From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 3/7] mmc: msm_sdcc: Enable SDC host->clk only after setting the rate.
Date: Mon,  2 May 2011 18:07:01 +0530
Message-ID: <1304339821-8421-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-3-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-3-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>, Murali Palnati <palnatim@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

For clocks that support rates which can be set (most clocks other
than _pclk AHB clocks), a rate must be set using clk_set_rate()
before the clock is enabled for the first time with clk_enable().
Subsequent calls to clk_enable() need not be preceded with the
clk_set_rate() calls unless we wish to change the clock rate that
is set previously.

SDC host->clk is currently enabled without setting the clock rate
even once. This patch fixes this, by ensuring that the clock rate
for this clock is first set before enabling the clock.

Signed-off-by: Murali Palnati <palnatim@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 66ef5c3..3446cdd 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1238,17 +1238,17 @@ msmsdcc_probe(struct platform_device *pdev)
 		goto pclk_put;
 	}
 
-	/* Enable clocks */
-	ret = msmsdcc_enable_clocks(host);
-	if (ret)
-		goto clk_put;
-
 	ret = clk_set_rate(host->clk, msmsdcc_fmin);
 	if (ret) {
 		pr_err("%s: Clock rate set failed (%d)\n", __func__, ret);
-		goto clk_disable;
+		goto clk_put;
 	}
 
+	/* Enable clocks */
+	ret = msmsdcc_enable_clocks(host);
+	if (ret)
+		goto clk_put;
+
 	host->pclk_rate = clk_get_rate(host->pclk);
 	host->clk_rate = clk_get_rate(host->clk);
 
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
