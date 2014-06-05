From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/4] mmc: omap: don't select TPS65010
Date: Thu,  5 Jun 2014 23:14:40 +0200
Message-ID: <1402002881-1986640-4-git-send-email-arnd@arndb.de>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

The MMC host driver should not select the pmic driver, since that
may have other dependencies, notably i2c in this case. It's not
clear what the exact requirement of the driver is, but to preserve
the behavior, this patch changes the 'select' into 'depends on',
meaning you now have to turn on TPS65010 explicitly and then
MMC_OMAP.

Found during randconfig build testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index cdf21cc..adffe0e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -295,7 +295,7 @@ config MMC_MOXART
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
-	select TPS65010 if MACH_OMAP_H2
+	depends on TPS65010 || !MACH_OMAP_H2
 	help
 	  This selects the TI OMAP Multimedia card Interface.
 	  If you have an OMAP board with a Multimedia Card slot,
-- 
1.8.3.2

