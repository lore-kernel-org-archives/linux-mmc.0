From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] tmio_mmc: Keep card-detect interrupts enabled
Date: Wed, 17 Feb 2010 16:37:45 +0900
Message-ID: <20100217073745.32726.24254.sendpatchset@t400s>
References: <20100217073735.32726.12020.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, akpm@linux-foundation.org, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de
List-Id: linux-mmc@vger.kernel.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On SuperH platforms the SDHI controller does not produce any command IRQs after
a completed IO. This leads to card-detect interrupts staying disabled. Do not
disable card-detect interrupts on DATA IRQs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Previously posted by Guennadi to linux-mmc 20100216 as
 "[PATCH] tmio_mmc: keep card-detect interrupts enabled"

 drivers/mmc/host/tmio_mmc.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 692dc23..dafecfb 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -55,10 +55,8 @@
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
-#define TMIO_MASK_READOP  (TMIO_STAT_RXRDY | TMIO_STAT_DATAEND | \
-		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
-#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DATAEND | \
-		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
+#define TMIO_MASK_READOP  (TMIO_STAT_RXRDY | TMIO_STAT_DATAEND)
+#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DATAEND)
 #define TMIO_MASK_CMD     (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT | \
 		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
 #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
-- 
1.6.2.4

--
