From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: fix max value of clkd
Date: Fri, 21 Sep 2012 20:51:12 +0530
Message-ID: <1348240872-16068-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56841 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756254Ab2IUPVX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Sep 2012 11:21:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

clock divisor can take a max value of 1023
update code as per TRM so that card init can be handled with
higher IP clock frequencies from which clock to the card is
derived.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d9af5f1..073b9ff 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -75,6 +75,7 @@
 #define ICE			0x1
 #define ICS			0x2
 #define CEN			(1 << 2)
+#define CLKD_MAX		0x3FF
 #define CLKD_MASK		0x0000FFC0
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
@@ -478,8 +479,8 @@ static u16 calc_divisor(struct omap_hsmmc_host *host, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		dsor = DIV_ROUND_UP(clk_get_rate(host->fclk), ios->clock);
-		if (dsor > 250)
-			dsor = 250;
+		if (dsor > CLKD_MAX)
+			dsor = CLKD_MAX;
 	}
 
 	return dsor;
-- 
1.7.5.4

