From: akpm@linux-foundation.org
Subject: [patch 073/232] ARM: OMAP: RX51: set MMC capabilities and power-saving flag
Date: Tue, 22 Sep 2009 16:45:05 -0700
Message-ID: <200909222345.n8MNj5dr013593@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58001 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753493AbZIVXpn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Adrian Hunter <adrian.hunter@nokia.com>

Specify MMC capabilities and set the power-saving flag for RX51.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN arch/arm/mach-omap2/board-rx51-peripherals.c~arm-omap-rx51-set-mmc-capabilities-and-power-saving-flag arch/arm/mach-omap2/board-rx51-peripherals.c
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c~arm-omap-rx51-set-mmc-capabilities-and-power-saving-flag
+++ a/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 
 #include <mach/mcspi.h>
 #include <mach/mux.h>
@@ -102,6 +103,7 @@ static struct twl4030_hsmmc_info mmc[] =
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
 	},
 	{
 		.name		= "internal",
@@ -109,6 +111,8 @@ static struct twl4030_hsmmc_info mmc[] =
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nonremovable	= true,
+		.power_saving	= true,
 	},
 	{}	/* Terminator */
 };
_
