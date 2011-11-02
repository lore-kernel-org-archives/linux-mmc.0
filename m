From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap_hsmmc: Fix build for hsmmc
Date: Wed, 2 Nov 2011 10:06:19 -0700
Message-ID: <20111102170619.GJ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Commit a3c76eb9d4a1e68a69dd880cf0bcb8a52418b993 (mmc: replace
printk with appropriate display macro) does not compile:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_protect_card':
drivers/mmc/host/omap_hsmmc.c:1273: error: 'pr_info' undeclared (first use in this function)
drivers/mmc/host/omap_hsmmc.c:1273: error: (Each undeclared identifier is reported only once
drivers/mmc/host/omap_hsmmc.c:1273: error: for each function it appears in.)
drivers/mmc/host/omap_hsmmc.c:1273: error: expected ';' before string constant
drivers/mmc/host/omap_hsmmc.c:1275: error: expected statement before ')' token
distcc[15197] ERROR: compile drivers/mmc/host/omap_hsmmc.c on localhost failed

Cc: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info"%s: cover is open, "
+			pr_info("%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
