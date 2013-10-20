From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 4/5] mmc: omap_hsmmc: correct max value of clkd
Date: Mon, 21 Oct 2013 00:25:21 +0530
Message-ID: <1382295322-18995-4-git-send-email-balajitk@ti.com>
References: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55461 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3JTSzj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 14:55:39 -0400
In-Reply-To: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

clock divisor can take a max value of 1023.
Update code so that card init can be handled at f_min even at
higher IP clock frequencies from which clock to the card is
derived.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9f74a57..60db34d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -75,6 +75,7 @@
 #define ICE			0x1
 #define ICS			0x2
 #define CEN			(1 << 2)
+#define CLKD_MAX		0x3FF		/* max clock divisor: 1023 */
 #define CLKD_MASK		0x0000FFC0
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
@@ -497,8 +498,8 @@ static u16 calc_divisor(struct omap_hsmmc_host *host, struct mmc_ios *ios)
 
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

