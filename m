From: Igor Grinberg <grinberg@compulab.co.il>
Subject: =?UTF-8?q?=5BPATCH=209/9=5D=20ARM=3A=20OMAP=3A=20remove=20plat/board=2Eh=20file?=
Date: Wed, 29 Aug 2012 02:18:57 +0300
Message-ID: <1346195937-6383-10-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:49956 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab2H1XTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 19:19:25 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org

plat/board.h file is now empty - remove it.

Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap1/board-generic.c          |    1 -
 arch/arm/mach-omap1/board-voiceblue.c        |    1 -
 arch/arm/mach-omap1/devices.c                |    1 -
 arch/arm/mach-omap1/serial.c                 |    1 -
 arch/arm/mach-omap2/board-2430sdp.c          |    1 -
 arch/arm/mach-omap2/board-4430sdp.c          |    1 -
 arch/arm/mach-omap2/board-apollon.c          |    1 -
 arch/arm/mach-omap2/board-devkit8000.c       |    1 -
 arch/arm/mach-omap2/board-generic.c          |    1 -
 arch/arm/mach-omap2/board-igep0020.c         |    1 -
 arch/arm/mach-omap2/board-ldp.c              |    1 -
 arch/arm/mach-omap2/board-n8x0.c             |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c      |    1 -
 arch/arm/mach-omap2/board-omap3logic.c       |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c     |    1 -
 arch/arm/mach-omap2/board-omap3touchbook.c   |    1 -
 arch/arm/mach-omap2/board-omap4panda.c       |    1 -
 arch/arm/mach-omap2/board-overo.c            |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 -
 arch/arm/mach-omap2/board-rx51.c             |    1 -
 arch/arm/mach-omap2/board-zoom.c             |    1 -
 arch/arm/mach-omap2/common.c                 |    1 -
 arch/arm/mach-omap2/devices.c                |    1 -
 arch/arm/mach-omap2/gpmc-nand.c              |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c           |    1 -
 arch/arm/mach-omap2/gpmc-smc91x.c            |    1 -
 arch/arm/mach-omap2/gpmc-smsc911x.c          |    1 -
 arch/arm/mach-omap2/pm-debug.c               |    1 -
 arch/arm/mach-omap2/pm24xx.c                 |    1 -
 arch/arm/mach-omap2/serial.c                 |    1 -
 arch/arm/plat-omap/common.c                  |    1 -
 arch/arm/plat-omap/counter_32k.c             |    1 -
 arch/arm/plat-omap/debug-devices.c           |    3 ---
 arch/arm/plat-omap/devices.c                 |    1 -
 arch/arm/plat-omap/include/plat/board.h      |   13 -------------
 arch/arm/plat-omap/include/plat/mmc.h        |    1 -
 arch/arm/plat-omap/include/plat/usb.h        |    1 -
 arch/arm/plat-omap/sram.c                    |    1 -
 drivers/mmc/host/omap.c                      |    1 -
 drivers/mmc/host/omap_hsmmc.c                |    1 -
 drivers/mtd/onenand/omap2.c                  |    2 --
 41 files changed, 0 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/board.h

diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/=
board-generic.c
index d032734..04b5fda 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -23,7 +23,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/mux.h>
-#include <plat/board.h>
=20
 #include <mach/usb.h>
=20
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap=
1/board-voiceblue.c
index 11e1ff3..1668af3 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -35,7 +35,6 @@
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
-#include <plat/board.h>
=20
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/device=
s.c
index fa1fa4d..1feca35 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -20,7 +20,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/tc.h>
-#include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.=
c
index 6809c9e..0d1709b 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -22,7 +22,6 @@
=20
 #include <asm/mach-types.h>
=20
-#include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
=20
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/=
board-2430sdp.c
index 9511584..36eee4b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -33,7 +33,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/=
board-4430sdp.c
index ad8a7d9..04e8574 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -34,7 +34,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/=
board-apollon.c
index e5fa46b..a6a1b48 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -35,7 +35,6 @@
 #include <asm/mach/flash.h>
=20
 #include <plat/led.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
=20
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-oma=
p2/board-devkit8000.c
index 6567c1c..870a2a5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -40,7 +40,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
index 6f93a20..38024a5 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -20,7 +20,6 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include "common-board-devices.h"
=20
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2=
/board-igep0020.c
index 7491529..c4f17bb 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -29,7 +29,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/boar=
d-ldp.c
index ef9e829..c37c2a1 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -35,7 +35,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/mcspi.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <mach/board-zoom.h>
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/boa=
rd-n8x0.c
index 677357f..5397209 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -25,7 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/menelaus.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-om=
ap2/board-omap3beagle.c
index 6202fc7..293e3b2 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -39,7 +39,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-oma=
p2/board-omap3logic.c
index fca93d1..a63a49d 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -41,7 +41,6 @@
 #include "common-board-devices.h"
=20
 #include <plat/mux.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-o=
map2/board-omap3pandora.c
index 57aebee..633c445 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,7 +40,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <mach/hardware.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach=
-omap2/board-omap3touchbook.c
index 485d14d..d3556c9 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -44,7 +44,6 @@
 #include <asm/mach/flash.h>
 #include <asm/system_info.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-oma=
p2/board-omap4panda.c
index 70f6d1d..3911c13 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -39,7 +39,6 @@
 #include <asm/mach/map.h>
 #include <video/omapdss.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/bo=
ard-overo.c
index 779734d..193d160 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -42,7 +42,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
=20
-#include <plat/board.h>
 #include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index df2534d..3b9fc61 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -28,7 +28,6 @@
 #include <asm/system_info.h>
=20
 #include <plat/mcspi.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/dma.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 345dd93..92924eb 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -24,7 +24,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/mcspi.h>
-#include <plat/board.h>
 #include "common.h"
 #include <plat/dma.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/boa=
rd-zoom.c
index 4e7e561..4994438 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -22,7 +22,6 @@
 #include <asm/mach/arch.h>
=20
 #include "common.h"
-#include <plat/board.h>
 #include <plat/usb.h>
=20
 #include <mach/board-zoom.h>
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.=
c
index 069f972..6c2ff4f 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
=20
 #include <plat/hardware.h>
-#include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/clock.h>
=20
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index c00c689..56dfa2d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -26,7 +26,6 @@
 #include <asm/pmu.h>
=20
 #include "iomap.h"
-#include <plat/board.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc=
-nand.c
index 386dec8..513ed9e 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -18,7 +18,6 @@
=20
 #include <plat/cpu.h>
 #include <plat/nand.h>
-#include <plat/board.h>
 #include <plat/gpmc.h>
=20
 static struct resource gpmc_nand_resource =3D {
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/g=
pmc-onenand.c
index a0fa9bb..c5f005e 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -20,7 +20,6 @@
=20
 #include <plat/cpu.h>
 #include <plat/onenand.h>
-#include <plat/board.h>
 #include <plat/gpmc.h>
=20
 static struct omap_onenand_platform_data *gpmc_onenand_data;
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gp=
mc-smc91x.c
index ba10c24..3f75ff0 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
=20
-#include <plat/board.h>
 #include <plat/gpmc.h>
 #include <plat/gpmc-smc91x.h>
=20
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/=
gpmc-smsc911x.c
index b6c77be..a3a2887 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -20,7 +20,6 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
=20
-#include <plat/board.h>
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
=20
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-de=
bug.c
index 814bcd9..3e1345f 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
=20
 #include <plat/clock.h>
-#include <plat/board.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.=
c
index 9e54dc9..de1caf1 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -38,7 +38,6 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/dma.h>
-#include <plat/board.h>
=20
 #include <mach/irqs.h>
=20
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index c1b93c7..10f7f02 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -29,7 +29,6 @@
=20
 #include <plat/omap-serial.h>
 #include "common.h"
-#include <plat/board.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 7c04748..e5778ed 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -17,7 +17,6 @@
 #include <linux/dma-mapping.h>
=20
 #include <plat/common.h>
-#include <plat/board.h>
 #include <plat/vram.h>
 #include <plat/dsp.h>
 #include <plat/dma.h>
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/coun=
ter_32k.c
index dbf1e03..902d2ff 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -24,7 +24,6 @@
=20
 #include <plat/hardware.h>
 #include <plat/common.h>
-#include <plat/board.h>
=20
 #include <plat/clock.h>
=20
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/de=
bug-devices.c
index caa1f7b..c7a4c09 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -17,9 +17,6 @@
=20
 #include <mach/hardware.h>
=20
-#include <plat/board.h>
-
-
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
  */
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.=
c
index 1cba927..287ac37 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -23,7 +23,6 @@
 #include <asm/memblock.h>
=20
 #include <plat/tc.h>
-#include <plat/board.h>
 #include <plat/mmc.h>
 #include <plat/menelaus.h>
 #include <plat/omap44xx.h>
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-om=
ap/include/plat/board.h
deleted file mode 100644
index d92f1b5..0000000
--- a/arch/arm/plat-omap/include/plat/board.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/board.h
- *
- *  Information structures for board-specific data
- *
- *  Copyright (C) 2004	Nokia Corporation
- *  Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
- */
-
-#ifndef _OMAP_BOARD_H
-#define _OMAP_BOARD_H
-
-#endif
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap=
/include/plat/mmc.h
index eb3e4d5..8b4e4f2 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -15,7 +15,6 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
=20
-#include <plat/board.h>
 #include <plat/omap_hwmod.h>
=20
 #define OMAP15XX_NR_MMC		1
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap=
/include/plat/usb.h
index 548a4c8..bd20588 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -5,7 +5,6 @@
=20
 #include <linux/io.h>
 #include <linux/usb/musb.h>
-#include <plat/board.h>
=20
 #define OMAP3_HS_USB_PORTS	3
=20
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 766181c..d861aa7 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/sram.h>
-#include <plat/board.h>
 #include <plat/cpu.h>
=20
 #include "sram.h"
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 50e08f0..5b7d420 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
=20
-#include <plat/board.h>
 #include <plat/mmc.h>
 #include <asm/gpio.h>
 #include <plat/dma.h>
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 3a09f93..f871b31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -40,7 +40,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <mach/hardware.h>
-#include <plat/board.h>
 #include <plat/mmc.h>
 #include <plat/cpu.h>
=20
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 398a827..10ed992 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -44,8 +44,6 @@
=20
 #include <plat/dma.h>
=20
-#include <plat/board.h>
-
 #define DRIVER_NAME "omap2-onenand"
=20
 #define ONENAND_IO_SIZE		SZ_128K
--=20
1.7.8.6

