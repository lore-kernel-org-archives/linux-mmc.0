From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not define
Date: Tue, 20 Jul 2010 12:07:58 +0530
Message-ID: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sukumar Ghorai <s-ghorai@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

    Issue if power_saving option passed from board file and CONFIG_PM not define.
    This is because hosts refer to wrong operation table and that try to power save.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Madhusudhan Chikkature <madhu.cr@ti.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 Tested on omap3, omap4430 ES2.0

 drivers/mmc/host/omap_hsmmc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..f84eed0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2015,9 +2015,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
 
+#ifdef CONFIG_PM
 	if (mmc_slot(host).power_saving)
 		mmc->ops	= &omap_hsmmc_ps_ops;
 	else
+#endif
 		mmc->ops	= &omap_hsmmc_ops;
 
 	/*
