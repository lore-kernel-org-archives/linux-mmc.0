From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/2] [hack] sh: disable initialisation of SDRAM
Date: Sat, 27 Nov 2010 08:05:57 +0900
Message-ID: <1290812757-20571-3-git-send-email-horms@verge.net.au>
References: <1290812757-20571-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1290812757-20571-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This disables SDRAM initialisation in very early boot
to allow a zImage to be booted from uboot.

This change applies on top of "ARM: mach-shmobile: Add zboot support for
SuperH Mobile ARM".

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt	2010-11-27 07:17:38.000000000 +0900
+++ linux-2.6/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt	2010-11-27 07:18:01.000000000 +0900
@@ -40,6 +40,7 @@ WAIT 1, 0xFE40009C
 LIST "BSC"
 ED 0xFEC10000, 0x00E0001B

+#if 0
 LIST "SBSC1"
 ED 0xFE400354, 0x01AD8000
 ED 0xFE400354, 0x01AD8001
@@ -77,6 +78,7 @@ ED 0xFE400028, 0xA55A0032
 ED 0xFE40002C, 0xA55A000C
 ED 0xFE400020, 0xA55A2048
 ED 0xFE400008, 0xBCC90959
+#endif

 LIST "Change CPGA setting"
 ED 0xE61500E0, 0x9E40352E
---
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
index e3ebfa7..1e06943 100644
--- a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
+++ b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
@@ -40,6 +40,7 @@ WAIT 1, 0xFE40009C
 LIST "BSC"
 ED 0xFEC10000, 0x00E0001B
 
+#if 0
 LIST "SBSC1"
 ED 0xFE400354, 0x01AD8000
 ED 0xFE400354, 0x01AD8001
@@ -77,6 +78,7 @@ ED 0xFE400028, 0xA55A0032
 ED 0xFE40002C, 0xA55A000C
 ED 0xFE400020, 0xA55A2048
 ED 0xFE400008, 0xBCC90959
+#endif
 
 LIST "Change CPGA setting"
 ED 0xE61500E0, 0x9E40352E
-- 
1.7.2.3

