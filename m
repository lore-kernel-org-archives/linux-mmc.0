From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 2/7] mmc: msm_sdcc: Handle error cases in probe
Date: Mon,  2 May 2011 18:06:05 +0530
Message-ID: <1304339765-7508-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-2-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:62951 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab1EBMgY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2011 08:36:24 -0400
In-Reply-To: <1303796066-6784-2-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index d06539d..66ef5c3 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1206,7 +1206,7 @@ msmsdcc_probe(struct platform_device *pdev)
 	host->base = ioremap(memres->start, PAGE_SIZE);
 	if (!host->base) {
 		ret = -ENOMEM;
-		goto out;
+		goto host_free;
 	}
 
 	host->cmd_irqres = cmd_irqres;
@@ -1221,13 +1221,15 @@ msmsdcc_probe(struct platform_device *pdev)
 	/*
 	 * Setup DMA
 	 */
-	msmsdcc_init_dma(host);
+	ret = msmsdcc_init_dma(host);
+	if (ret)
+		goto ioremap_free;
 
 	/* Get our clocks */
 	host->pclk = clk_get(&pdev->dev, "sdc_pclk");
 	if (IS_ERR(host->pclk)) {
 		ret = PTR_ERR(host->pclk);
-		goto host_free;
+		goto dma_free;
 	}
 
 	host->clk = clk_get(&pdev->dev, "sdc_clk");
@@ -1368,6 +1370,12 @@ msmsdcc_probe(struct platform_device *pdev)
 	clk_put(host->clk);
  pclk_put:
 	clk_put(host->pclk);
+dma_free:
+	dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
+				host->dma.nc, host->dma.nc_busaddr);
+ioremap_free:
+	tasklet_kill(&host->dma_tlet);
+	iounmap(host->base);
  host_free:
 	mmc_free_host(mmc);
  out:
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
