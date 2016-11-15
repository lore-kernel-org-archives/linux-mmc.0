From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 2/2] MMC: davinci: request gpios using gpio descriptors
Date: Tue, 15 Nov 2016 17:28:22 +0100
Message-ID: <20161115162822.25791-3-ahaslam@baylibre.com>
References: <20161115162822.25791-1-ahaslam@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37416 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbcKOQ21 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 11:28:27 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so9659691wmt.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2016 08:28:27 -0800 (PST)
In-Reply-To: <20161115162822.25791-1-ahaslam@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, nsekhar@ti.com, khilman@baylibre.com, david@lechnology.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

Request card detect and write protect gpios using the provided API
by mmc core.

If a gpio is provided for card detect, we don't need to poll.
So only use polling when a gpio is not provided.

Once all pdata users register the gpios using gpio descriptors,
we could remove the platform callbacks.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/mmc/host/davinci_mmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 619e50e..36b5af8 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1167,6 +1167,7 @@ static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 	struct platform_device *pdev = to_platform_device(mmc->parent);
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
 	struct mmc_davinci_host *host;
+	int ret;
 
 	if (!pdata)
 		return -EINVAL;
@@ -1184,7 +1185,6 @@ static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 	if (pdata && (pdata->wires == 8))
 		mmc->caps |= (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
 
-	mmc->caps |= MMC_CAP_NEEDS_POLL;
 	mmc->f_min = 312500;
 	mmc->f_max = 25000000;
 	if (pdata && pdata->max_freq)
@@ -1192,6 +1192,17 @@ static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 	if (pdata && pdata->caps)
 		mmc->caps |= pdata->caps;
 
+	/* Register a cd gpio, if there is not one, enable polling */
+	ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	else if (ret)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
+	ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
 	return 0;
 }
 
-- 
2.10.1

