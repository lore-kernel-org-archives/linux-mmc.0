From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/5] mmc: omap_hsmmc: Fix pbias_disable for omap4
Date: Mon, 21 Oct 2013 00:25:18 +0530
Message-ID: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

pbias_disable is set to protect the mmc pbias i/o cells in DT boot
by preventing voltage switch. Currently pbias_disable is enabled only
for omap3 and not for omap4 due to reg_offset difference of 0x100.
Enable pbias_disable for omap4+ too by using res->start
which does not include the reg_offset.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7d2d929..84a1140 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1876,7 +1876,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	omap_hsmmc_context_save(host);
 
 	/* This can be removed once we support PBIAS with DT */
-	if (host->dev->of_node && host->mapbase == 0x4809c000)
+	if (host->dev->of_node && res->start == 0x4809c000)
 		host->pbias_disable = 1;
 
 	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
-- 
1.7.5.4

