From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v3 3/5] OMAP4: hwmod data: enable HSMMC
Date: Wed, 23 Feb 2011 23:17:09 +0530
Message-ID: <1298483231-29622-4-git-send-email-kishore.kadiyala@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41847 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683Ab1BWRjr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Feb 2011 12:39:47 -0500
In-Reply-To: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Enabling hsmmc hwmod for OMAP4

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
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

