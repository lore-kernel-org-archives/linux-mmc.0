From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/6] ARM: mach-shmobile: convert boards to use
 linux/mmc/sh_mobile_sdhi.h
Date: Fri, 11 Mar 2011 08:52:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110846390.23675@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Prepare to remove the temporary header.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 +-
 arch/arm/mach-shmobile/board-g4evm.c    |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1a8118c..7ae9e3b 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -24,9 +24,9 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index dee3e92..cccdf2d 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -31,7 +31,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index bbfc167..05fc5ac 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -32,10 +32,10 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-- 
1.7.2.3

