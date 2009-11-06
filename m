From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] tmio_mmc: keep card-detect interrupts enabled
Date: Fri, 6 Nov 2009 11:45:27 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0911061127240.4389@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754654AbZKFKpP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Nov 2009 05:45:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ian@mnementh.co.uk

On SuperH platforms the SDHI controller does not produce any command IRQs 
after a completed IO. This leads to card-detect interrupts staying 
disabled. Do not disable card-detect interrupts on DATA IRQs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Marked as RFC because I'm not really sure this is a correct approach to 
fix this problem, and whether this will have negative effect on other 
tmio_mmc MFD users.

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c676767..0b31d44 100644
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
