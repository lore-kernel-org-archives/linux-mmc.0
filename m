From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 7/7] mmc: msm_sdcc: Handle dma resource not present case
Date: Tue, 26 Apr 2011 11:04:26 +0530
Message-ID: <1303796066-6784-7-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-1-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Subhash Jadavani <subhashj@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

If DMA resource is not available then SDCC driver
should atleast work in PIO data transfer mode.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 36fded7..a7d7b5e 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1233,9 +1233,13 @@ msmsdcc_probe(struct platform_device *pdev)
 	/*
 	 * Setup DMA
 	 */
-	ret = msmsdcc_init_dma(host);
-	if (ret)
-		goto ioremap_free;
+	if (host->dmares) {
+		ret = msmsdcc_init_dma(host);
+		if (ret)
+			goto ioremap_free;
+	} else {
+		host->dma.channel = -1;
+	}
 
 	/* Get our clocks */
 	host->pclk = clk_get(&pdev->dev, "sdc_pclk");
@@ -1379,8 +1383,9 @@ msmsdcc_probe(struct platform_device *pdev)
  pclk_put:
 	clk_put(host->pclk);
 dma_free:
-	dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
-				host->dma.nc, host->dma.nc_busaddr);
+	if (host->dmares)
+		dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
+					host->dma.nc, host->dma.nc_busaddr);
 ioremap_free:
 	tasklet_kill(&host->dma_tlet);
 	iounmap(host->base);
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
