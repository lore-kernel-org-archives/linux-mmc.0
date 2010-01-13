From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 3/8] OMAP: reconnect hsmmc context loss count
Date: Wed, 13 Jan 2010 13:40:33 +0200
Message-ID: <20100113114033.7615.13060.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

>From 840e68745248b4d302429380aa5b1ea944c13024 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 10:06:58 +0200
Subject: [PATCH] OMAP: reconnect hsmmc context loss count

Call the PM context-loss count function, now that there
is a prototype for it.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1d5f2f0..76a1f6c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <mach/hardware.h>
 #include <plat/mmc.h>
+#include <plat/omap-pm.h>
 
 #include "hsmmc.h"
 
@@ -29,8 +30,7 @@ static struct hsmmc_controller {
 
 static int hsmmc_get_context_loss(struct device *dev)
 {
-	/* FIXME: PM DPS not implemented yet */
-	return 0;
+	return omap_pm_get_dev_context_loss_count(dev);
 }
 
 #else
-- 
1.6.0.4

