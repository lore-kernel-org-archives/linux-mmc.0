From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 4/10] omap: Reconnect hsmmc context loss count
Date: Sun, 17 Jan 2010 03:33:22 +0200
Message-ID: <20100117013322.17308.19569.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58001 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab0AQBdf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:33:35 -0500
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

>From 3c112c3bb8c8457283862468574be9b0c18dc27e Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 10:06:58 +0200
Subject: [PATCH] omap: Reconnect hsmmc context loss count

Call the PM context-loss count function, now that there
is a prototype for it.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 90bf8ce..2a88f49 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -16,6 +16,7 @@
 #include <mach/hardware.h>
 #include <plat/control.h>
 #include <plat/mmc.h>
+#include <plat/omap-pm.h>
 
 #include "hsmmc.h"
 
@@ -34,8 +35,7 @@ static struct hsmmc_controller {
 
 static int hsmmc_get_context_loss(struct device *dev)
 {
-	/* FIXME: PM DPS not implemented yet */
-	return 0;
+	return omap_pm_get_dev_context_loss_count(dev);
 }
 
 #else
-- 
1.6.0.4

