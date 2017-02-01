From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 7/9] mmc: meson-gx: reduce bounce buffer size
Date: Wed, 1 Feb 2017 07:49:18 +0100
Message-ID: <90d34a64-bd3e-dcf2-4c36-5ef4e2ac8666@gmail.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33539 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGty (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 01:49:54 -0500
Received: by mail-wj0-f195.google.com with SMTP id le4so2744555wjb.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 22:49:53 -0800 (PST)
In-Reply-To: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

A bounce buffer of 512K isn't needed as the max request size is
511 * 512 byte.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
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


