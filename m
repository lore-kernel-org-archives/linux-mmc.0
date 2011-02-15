From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 4/4] arm: V2 configs: update pxa910 defconfig for SoC
 Selection
Date: Tue, 15 Feb 2011 13:55:11 -0800
Message-ID: <5DE28962-5F04-4D34-8D65-DF4020F135CD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47422 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755465Ab1BOV6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Feb 2011 16:58:47 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>


V2
==
Use make savedefconfigconfig to produce reduced size defconfig
per suggestion of Nico Pitre.

V1
==

took old pxa910_defconfig --
did make menuconfig
changed to CPU_PXA910

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/configs/pxa910_defconfig |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 1cd381e..8c405cd 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
@@ -9,7 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
-CONFIG_MACH_TAVOREVB=y
+CONFIG_CPU_PXA910=y
 CONFIG_MACH_TTC_DKB=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -30,7 +29,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
@@ -45,10 +43,8 @@ CONFIG_SERIAL_PXA_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
-- 
1.7.0.4


