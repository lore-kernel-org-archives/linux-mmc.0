From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v4 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is
     not set
Date: Fri, 24 Sep 2010 22:43:30 +0530 (IST)
Message-ID: <9493.10.24.255.18.1285348410.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39827 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab0IXRON (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 13:14:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, akpm@linux-foundation.org, b-cousson@ti.com, madhu.cr@ti.com, adrian.hunter@nokia.com

From: Benoit Cousson <b-cousson@ti.com>

Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Cc: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a49f285..7978a79 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -240,8 +240,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)

 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;

+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed %s\n", __func__);
+		return;
+	}
+	pdata = dev->platform_data;
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }

-- 
1.7.0.4

