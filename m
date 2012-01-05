From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] drivers: mmc/memstick: Fix dependencies for MEMSTICK_TIFM_MS and MMC_TIFM_SD
Date: Thu,  5 Jan 2012 01:15:24 -0200
Message-ID: <1325733324-4519-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57196 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761Ab2AEDPf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 22:15:35 -0500
Received: by ghbg21 with SMTP id g21so42461ghb.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jan 2012 19:15:34 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warning:

warning: (MMC_TIFM_SD && MEMSTICK_TIFM_MS) selects TIFM_CORE which has unmet 
direct dependencies (MISC_DEVICES && EXPERIMENTAL && PCI)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/memstick/host/Kconfig |    2 +-
 drivers/mmc/host/Kconfig      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
index cc0997a..9f78c13 100644
--- a/drivers/memstick/host/Kconfig
+++ b/drivers/memstick/host/Kconfig
@@ -6,7 +6,7 @@ comment "MemoryStick Host Controller Drivers"
 
 config MEMSTICK_TIFM_MS
 	tristate "TI Flash Media MemoryStick Interface support  (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PCI
+	depends on EXPERIMENTAL && PCI && MISC_DEVICES
 	select TIFM_CORE
 	help
 	  Say Y here if you want to be able to access MemoryStick cards with
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index cf444b0..248352f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -346,7 +346,7 @@ config MMC_MXS
 
 config MMC_TIFM_SD
 	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PCI
+	depends on EXPERIMENTAL && PCI && MISC_DEVICES
 	select TIFM_CORE
 	help
 	  Say Y here if you want to be able to access MMC/SD cards with
-- 
1.7.1

