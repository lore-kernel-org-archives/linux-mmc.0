From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 3/6] OMAP4: hwmod data: enable HSMMC
Date: Fri, 25 Feb 2011 00:56:51 +0530
Message-ID: <1298575614-9388-4-git-send-email-kishore.kadiyala@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43356 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab1BXTTU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 14:19:20 -0500
In-Reply-To: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

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

