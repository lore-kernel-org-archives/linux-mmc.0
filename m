From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: [PATCH] mmc: remove linux/blkdev.h include from host drivers
Date: Tue, 10 Apr 2012 23:06:23 +0400
Message-ID: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Pavel Pisa <ppisa@pikron.com>, Sascha Hauer <s.hauer@pengutronix.de>, Will Newton <will.newton@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

None of mmc host drivers using linux/blkdev.h header
really need anything from it. The slight exception is
atmel-mci, which uses blkdev.h only because it indirectly
pulls asm/cacheflush.h

So remove any inclusion of blkdev.h - it should also fix
build errors of dw_mmc and atmel-mci drivers when
CONFIG_BLOCK is disabled, like following:
------------------------------------------------------
In file included from drivers/mmc/host/dw_mmc.c:14:0:
include/linux/blkdev.h:1408:42: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
include/linux/blkdev.h:1408:42: warning: its scope is only this definit=
ion or declaration, which is probably not what you want [enabled by def=
ault]
include/linux/blkdev.h:1412:51: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
include/linux/blkdev.h:1417:1: error: unknown type name =E2=80=98bool=E2=
=80=99
include/linux/blkdev.h:1417:48: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
include/linux/blkdev.h: In function =E2=80=98blk_needs_flush_plug=E2=80=
=99:
include/linux/blkdev.h:1419:9: error: =E2=80=98false=E2=80=99 undeclare=
d (first use in this function)
include/linux/blkdev.h:1419:9: note: each undeclared identifier is repo=
rted only once for each function it appears in
make[1]: *** [drivers/mmc/host/dw_mmc.o] Error 1
make: *** [drivers/mmc/host/dw_mmc.o] Error 2
------------------------------------------------------

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Pavel Pisa <ppisa@pikron.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Will Newton <will.newton@imgtec.com>
Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---

 drivers/mmc/host/at91_mci.c  |    1 -
 drivers/mmc/host/atmel-mci.c |    2 +-
 drivers/mmc/host/dw_mmc.c    |    1 -
 drivers/mmc/host/imxmmc.c    |    1 -
 drivers/mmc/host/mxcmmc.c    |    1 -
 5 files changed, 1 insertions(+), 5 deletions(-)

I've compile tested everything with and without CONFIG_BLOCK enabled,
except for imxmmc.c - this driver seems to be long time broken
(at least since the removal of mach-imx in 2.6.31 - see commit
1341d34ffc296f98dc84876f35f3151525dc02a2 )=20

If there any plans to remove imxmmc.c soon, I can drop corresponding
chunk from this patch and resend it to not create conflicts.

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index efdb81d..bf43df4 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -59,7 +59,6 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.=
c
index 9819dc0..1304549 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -33,6 +32,7 @@
 #include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
=20
+#include <asm/cacheflush.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
=20
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bf3c9b4..757580b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -11,7 +11,6 @@
  * (at your option) any later version.
  */
=20
-#include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
diff --git a/drivers/mmc/host/imxmmc.c b/drivers/mmc/host/imxmmc.c
index ea0f3ce..6479964 100644
--- a/drivers/mmc/host/imxmmc.c
+++ b/drivers/mmc/host/imxmmc.c
@@ -17,7 +17,6 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/blkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index b2058b4..b511861 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/blkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
--=20
1.7.5.4
