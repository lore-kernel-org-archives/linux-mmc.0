From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 7/9] mmc: meson-gx: reduce bounce buffer size
Date: Tue, 7 Feb 2017 22:35:02 +0100
Message-ID: <104a768e-fee3-0643-fed9-b4362b2366a1@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36404 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932558AbdBGVpg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:45:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so30815366wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:45:36 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

A bounce buffer of 512K isn't needed as the max request size is
511 * 512 byte.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c9f25171..4feb8971 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -782,7 +782,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
 
 	/* data bounce buffer */
-	host->bounce_buf_size = SZ_512K;
+	host->bounce_buf_size = mmc->max_req_size;
 	host->bounce_buf =
 		dma_alloc_coherent(host->dev, host->bounce_buf_size,
 				   &host->bounce_dma_addr, GFP_KERNEL);
-- 
2.11.0


