From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 2/3] mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value for CMD6
Date: Mon, 30 Jan 2017 15:41:57 +0530
Message-ID: <1485771118-13748-3-git-send-email-rk@ti.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:19213 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdA3KJy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 05:09:54 -0500
In-Reply-To: <1485771118-13748-1-git-send-email-rk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, peter.ujfalusi@ti.com, nsekhar@ti.com, tony@atomide.com, afenkart@gmail.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kishon@ti.com, rk@ti.com

From: Kishon Vijay Abraham I <kishon@ti.com>

commit e2bf08d643a244ccb ("omap_hsmmc: set a large data timeout for
commands with busy signal") sets an arbitrary timeout value (100ms) for
commands like CMD6 (MMC SWITCH). However extended CSD register defined
in the eMMC standard has a field for GENERIC_CMD6_TIME which indicates
the default maximum timeout for a SWITCH command.
Use busy_timeout of cmd structure (populated with GENERIC_CMD6_TIME
in the case of SWITCH command) to program the data timeout value in
omap_hsmmc driver.
SWITCH command to turn the cache on took more than 100ms to complete
with MICRON eMMC card present in AM572x IDK REV 1.3A resulting in
timeout and failed enumeration. It is fixed here by programming the
timeout with the value advertised in GENERIC_CMD6_TIME.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0ee5650..51ca3d7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1527,16 +1527,24 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
 omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 {
 	int ret;
+	unsigned int timeout;
+
 	host->data = req->data;
 
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
-		/*
-		 * Set an arbitrary 100ms data timeout for commands with
-		 * busy signal.
-		 */
-		if (req->cmd->flags & MMC_RSP_BUSY)
-			set_data_timeout(host, 100000000U, 0);
+		if (req->cmd->flags & MMC_RSP_BUSY) {
+			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+
+			/*
+			 * Set an arbitrary 100ms data timeout for commands with
+			 * busy signal and no indication of busy_timeout.
+			 */
+			if (!timeout)
+				timeout = 100000000U;
+
+			set_data_timeout(host, timeout, 0);
+		}
 		return 0;
 	}
 
-- 
1.9.1

