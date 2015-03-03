From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 1/6] mmc: omap_hsmmc: remove unused fields from struct omap_hsmmc_host
Date: Tue,  3 Mar 2015 13:28:13 +0100
Message-ID: <1425385698-6588-2-git-send-email-afenkart@gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

addon to: 09108968b7b72b6083a3bfc8f8259a74ed57255e
    mmc: omap_hsmmc: remove prepare/complete system suspend support

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8d87e08..2276d58 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -222,10 +222,6 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
-	/* To handle board related suspend/resume functionality for MMC */
-	int (*suspend)(struct device *dev);
-	int (*resume)(struct device *dev);
-
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
 	 * possible return values:
-- 
2.1.4

