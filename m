From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/1] mmc: omap_hsmmc: remove warning message for debounce clock
Date: Thu, 25 Oct 2012 21:28:35 +0530
Message-ID: <1351180715-26761-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

MMC debounce clock is applicable only for omap2430, warning message gets
printed when enable fails for debounce clock. Remove the get debounce clock
failure message as it is noisy for other platforms.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 54bfd0c..9a4ef4d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1816,7 +1816,6 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	 * MMC can still work without debounce clock.
 	 */
 	if (IS_ERR(host->dbclk)) {
-		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clk\n");
 		host->dbclk = NULL;
 	} else if (clk_prepare_enable(host->dbclk) != 0) {
 		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
-- 
1.7.5.4

