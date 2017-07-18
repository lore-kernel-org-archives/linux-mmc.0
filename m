From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 4/6] mmc: Kconfig: downgrade CONFIG_MMC_DEBUG for host drivers only
Date: Tue, 18 Jul 2017 16:59:34 +0800
Message-ID: <1500368376-160272-5-git-send-email-shawn.lin@rock-chips.com>
References: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:47576 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdGRJBK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jul 2017 05:01:10 -0400
In-Reply-To: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We have removed all code depending on CONFIG_MMC_DEBUG
from mmc core now. So it's safe to make CONFIG_MMC_DEBUG
just for host drivers only and we expect to kill this option
in the future.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/Kconfig      | 7 -------
 drivers/mmc/Makefile     | 2 --
 drivers/mmc/host/Kconfig | 9 +++++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 7e803fc4..ec21388 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -12,13 +12,6 @@ menuconfig MMC
 	  If you want MMC/SD/SDIO support, you should say Y here and
 	  also to your specific host controller driver.
 
-config MMC_DEBUG
-	bool "MMC debugging"
-	depends on MMC != n
-	help
-	  This is an option for use by developers; most people should
-	  say N here.  This enables MMC core and driver debugging.
-
 if MMC
 
 source "drivers/mmc/core/Kconfig"
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 416b6d1..26ab7af 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -2,7 +2,5 @@
 # Makefile for the kernel mmc device drivers.
 #
 
-subdir-ccflags-$(CONFIG_MMC_DEBUG) := -DDEBUG
-
 obj-$(CONFIG_MMC)		+= core/
 obj-$(subst m,y,$(CONFIG_MMC))	+= host/
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2242633..66b1749 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -4,6 +4,15 @@
 
 comment "MMC/SD/SDIO Host Controller Drivers"
 
+config MMC_DEBUG
+	bool "MMC host drivers debugginG"
+	depends on MMC != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here. This enables MMC host driver debugging. And further
+	  added host drivers please don't invent their private macro for
+	  debugging.
+
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA
-- 
1.9.1


