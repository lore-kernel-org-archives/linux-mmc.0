From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 30/30] ARM: OMAP: RX51: set MMC capabilities and power-saving flag
Date: Wed, 09 Sep 2009 15:00:18 +0300
Message-ID: <20090909120018.12833.74601.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>
List-Id: linux-mmc@vger.kernel.org

>From 165355201788f4efc00c37774070d8b9960e9b70 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 10 Jul 2009 10:32:44 +0300
Subject: [PATCH] ARM: OMAP: RX51: set MMC capabilities and power-saving flag

Specify MMC capabilities and set the power-saving flag
for RX51.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 56d931a..4ce5a76 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 
 #include <mach/mcspi.h>
 #include <mach/mux.h>
@@ -102,6 +103,7 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
 	},
 	{
 		.name		= "internal",
@@ -109,6 +111,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nonremovable	= true,
+		.power_saving	= true,
 	},
 	{}	/* Terminator */
 };
-- 
1.5.6.3

