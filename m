From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 07/10] mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
Date: Mon,  7 May 2012 22:43:09 +0800
Message-ID: <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756955Ab2EGOnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:55 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:55 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

It has wp_gpio copied in struct mxs_mmc_host from platform_data,
so that the use of platform_data can be limited in probe function,
which will ease the device tree probe.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index e905721..66f792a 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -160,21 +160,17 @@ struct mxs_mmc_host {
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
+	int				wp_gpio;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
-	struct mxs_mmc_platform_data *pdata =
-		mmc_dev(host->mmc)->platform_data;
 
-	if (!pdata)
-		return -EFAULT;
-
-	if (!gpio_is_valid(pdata->wp_gpio))
+	if (!gpio_is_valid(host->wp_gpio))
 		return -EINVAL;
 
-	return gpio_get_value(pdata->wp_gpio);
+	return gpio_get_value(host->wp_gpio);
 }
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -758,6 +754,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 		if (pdata->flags & SLOTF_4_BIT_CAPABLE)
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
+		host->wp_gpio = pdata->wp_gpio;
 	}
 
 	mmc->f_min = 400000;
-- 
1.7.5.4

