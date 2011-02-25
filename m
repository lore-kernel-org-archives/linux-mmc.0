From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v5 4/8] OMAP4: hwmod data: enable HSMMC
Date: Fri, 25 Feb 2011 22:39:39 +0530
Message-ID: <1298653783-26410-5-git-send-email-kishore.kadiyala@ti.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Enabling hsmmc hwmod for OMAP4

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by: Benoit Cousson<b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..dd39e75 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5077,11 +5077,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_mcspi4_hwmod,
 
 	/* mmc class */
-/*	&omap44xx_mmc1_hwmod, */
-/*	&omap44xx_mmc2_hwmod, */
-/*	&omap44xx_mmc3_hwmod, */
-/*	&omap44xx_mmc4_hwmod, */
-/*	&omap44xx_mmc5_hwmod, */
+	&omap44xx_mmc1_hwmod,
+	&omap44xx_mmc2_hwmod,
+	&omap44xx_mmc3_hwmod,
+	&omap44xx_mmc4_hwmod,
+	&omap44xx_mmc5_hwmod,
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
-- 
1.7.1

