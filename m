From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 06/10] mmc: mxs-mmc: have dma_channel than dma_res in mxs_mmc_host
Date: Mon,  7 May 2012 22:43:08 +0800
Message-ID: <1336401793-13753-7-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab2EGOnr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:47 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:47 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

It replaces dma_res with dma_channel in struct mxs_mmc_host, so that
the device tree support will be a little easier, since dma channel
can not be retrieved from "struct resource *dma_res".

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 1a8ba314..e905721 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -146,7 +146,7 @@ struct mxs_mmc_host {
 	struct mmc_data			*data;
 
 	void __iomem			*base;
-	struct resource			*dma_res;
+	int				dma_channel;
 	struct clk			*clk;
 	unsigned int			clk_rate;
 
@@ -668,7 +668,7 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
 	if (!mxs_dma_is_apbh(chan))
 		return false;
 
-	if (chan->chan_id != host->dma_res->start)
+	if (chan->chan_id != host->dma_channel)
 		return false;
 
 	chan->private = &host->dma_data;
@@ -719,7 +719,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	host->devid = pdev->id_entry->driver_data;
 	host->mmc = mmc;
-	host->dma_res = dmares;
+	host->dma_channel = dmares->start;
 	host->sdio_irq_en = 0;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-- 
1.7.5.4

