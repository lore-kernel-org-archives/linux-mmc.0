From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 6/9] mmc: meson-gx: set max block count and request size
Date: Wed, 1 Feb 2017 07:49:07 +0100
Message-ID: <aa425902-457d-2cd8-bc2a-4bac6938f076@gmail.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35251 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGtx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 01:49:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so3591960wmu.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 22:49:52 -0800 (PST)
In-Reply-To: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

So far max_blk_count isn't set what results in a default of value 8
to be used (PAGE_SIZE / block size).

Block length field has 9 bits, so set max_blk_count to 2^9-1 = 511.
In addition set max_req_size because max_blk_count is also limited
by max_req_size / block_size.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added reviewed-by, tested-by, acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 0fba23d2..883263c5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -781,6 +781,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
+	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
+
 	/* data bounce buffer */
 	host->bounce_buf_size = SZ_512K;
 	host->bounce_buf =
-- 
2.11.0



