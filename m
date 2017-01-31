From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 6/9] mmc: meson-gx: set max block count and request size
Date: Tue, 31 Jan 2017 21:58:40 +0100
Message-ID: <092dee0d-1115-7f0f-90da-60b92e0bf5c3@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35922 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAaVJA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:09:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so945500wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:08:59 -0800 (PST)
In-Reply-To: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

So far max_blk_count isn't set what results in a default of value 8
to be used (PAGE_SIZE / block size).

Block length field has 9 bits, so set max_blk_count to 2^9-1 = 511.
In addition set max_req_size because max_blk_count is also limited
by max_req_size / block_size.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
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


