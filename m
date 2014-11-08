From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 05/10] omap_hsmmc: remove never read power_saving field in omap2_hsmmc_info
Date: Sat,  8 Nov 2014 15:33:12 +0100
Message-ID: <1415457197-14294-6-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

these fields are never read, probably an unimplemented feature
or superseded by pm_runtime

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 --
 arch/arm/mach-omap2/hsmmc.h                  | 1 -
 2 files changed, 3 deletions(-)

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
2.1.1

