From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v4 5/5] ARM: mmp2: update mmp2_defconfig to support mmc
Date: Wed,  8 Jun 2011 17:42:01 +0800
Message-ID: <1307526121-12059-6-git-send-email-zhangfei.gao@marvell.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:33015 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1FHJmU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 05:42:20 -0400
In-Reply-To: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

	1. support brownstone
	2. support mmc
	3. support basic filesystem and language
	4. remove dynamic_debug, since too many log during access sd

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/configs/mmp2_defconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 47ad3b1..5a58452 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -8,6 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
+CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -63,10 +64,16 @@ CONFIG_BACKLIGHT_MAX8925=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8925=y
+CONFIG_MMC=y
 # CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
@@ -81,7 +88,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_DYNAMIC_DEBUG=y
+# CONFIG_DYNAMIC_DEBUG is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.0.4

