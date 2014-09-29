From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 4/9] omap_hsmmc: remove un-ready power_saving field in omap2_hsmmc_info
Date: Mon, 29 Sep 2014 11:32:54 +0200
Message-ID: <1411983179-28677-5-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45181 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbaI2JdP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:33:15 -0400
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

these fields are never read, probably an unimplemented feature
or superseded by pm_runtime

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ddfc8df..0a8ac84 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -500,7 +500,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
-		.power_saving	= true,
 	},
 	{
 		.name		= "internal",
@@ -510,7 +509,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
-		.power_saving	= true,
 		.remux		= rx51_mmc2_remux,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index bdc8870..30c78c1 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -16,7 +16,6 @@ struct omap2_hsmmc_info {
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
-	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	deferred;	/* mmc needs a deferred probe */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
-- 
2.1.0

