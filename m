From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 6/9] mmc: meson-gx: set max block count and request size
Date: Tue, 7 Feb 2017 22:34:58 +0100
Message-ID: <64508f4b-39eb-7c45-50bf-013cbfb0561b@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32843 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbdBGVp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:45:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so30655731wmv.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:45:28 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

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
v3:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4c622ad2..c9f25171 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -778,6 +778,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
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


