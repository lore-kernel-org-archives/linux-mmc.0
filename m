From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 01/18] mmc: meson-gx: set segment host parameters
Date: Tue, 14 Feb 2017 21:05:47 +0100
Message-ID: <e336daec-55fc-e524-9949-b8de7d68b9ef@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754618AbdBNUHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so5209035wmv.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:44 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Setting the segment parameters boosted the read performance from
13 MB/s to 32 MB/s in my case.
Default for segment size is only 4k (PAGE_SIZE).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5a959783..1ad66f84 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -118,6 +118,7 @@
 #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define MUX_CLK_NUM_PARENTS 2
+#define MESON_MMC_MAX_SEGS 512
 
 struct meson_host {
 	struct	device		*dev;
@@ -789,8 +790,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	mmc->max_segs = MESON_MMC_MAX_SEGS;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
+	mmc->max_seg_size = mmc->max_req_size;
 
 	/* data bounce buffer */
 	host->bounce_buf_size = mmc->max_req_size;
-- 
2.11.1


