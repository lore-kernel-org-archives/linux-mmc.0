From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 4/4] omap4: hsmmc: enable ADMA for MMC1 & MMC2
Date: Tue, 18 Jan 2011 22:56:31 +0530
Message-ID: <1295371591-13610-5-git-send-email-kishore.kadiyala@ti.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Enable ADMA support for MMC1 & MMC2 controller on omap4 by updating
"features" of struct omap_mmc_platform_data.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Reviewed-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 34272e4..2ac7271 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -307,8 +307,17 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		else
 			mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
-		if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
-			mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+		/*
+		 * OMAP4: MMC1 & MMC2 controllers support ADMA.
+		 * Default works with SDMA.
+		 * For ADMA support, update respective BIT in features.
+		 */
+		if (cpu_is_omap44xx()) {
+			mmc->slots[0].features |= HSMMC_HAS_ADMA_SUPPORT;
+			if (omap_rev() > OMAP4430_REV_ES1_0)
+				mmc->slots[0].features |=
+						HSMMC_HAS_UPDATED_RESET;
+		}
 
 		switch (c->mmc) {
 		case 1:
-- 
1.7.1

