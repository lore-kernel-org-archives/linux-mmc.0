From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 7/9] mmc: meson-gx: reduce bounce buffer size
Date: Tue, 31 Jan 2017 21:58:50 +0100
Message-ID: <0ba066dc-1713-61c9-81a3-541cabec9780@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34863 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdAaVIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:08:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so944285wmu.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:08:03 -0800 (PST)
In-Reply-To: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

A bounce buffer of 512K isn't needed as the max request size is
511 * 512 byte.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 883263c5..48ce4ba4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -785,7 +785,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
 
 	/* data bounce buffer */
-	host->bounce_buf_size = SZ_512K;
+	host->bounce_buf_size = mmc->max_req_size;
 	host->bounce_buf =
 		dma_alloc_coherent(host->dev, host->bounce_buf_size,
 				   &host->bounce_dma_addr, GFP_KERNEL);
-- 
2.11.0


