From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 2/3] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not
     set
Date: Mon, 30 Aug 2010 23:18:43 +0530 (IST)
Message-ID: <23536.10.24.255.18.1283190523.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Cc: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a49f285..ac8541c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -240,8 +240,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)

 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;

+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
+		return;
+	}
+	pdata = dev->platform_data;
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }

-- 
1.7.0.4

