From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Sat, 3 Aug 2013 02:33:28 +0400
Message-ID: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54895 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab3HBWdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 18:33:23 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so837447lbh.33
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2013 15:33:21 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org
Cc: linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

I'm testing SH-Mobile SDHI driver in DMA mode with  a new DMA controller  using
'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
to PIO but all commands time out after that.  It turned out that the fallback
code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
to them cleared, so that the function bails out early instead  of clearing the
DMA bit in the CTL_DMA_ENABLE register. The regression was introduced by commit
162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock).
Moving tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
tmio_mmc_start_dma_{rx|tx}() helps.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org # 3.1+

---
The patch is against Chris Ball's 'mmc.git' repo, 'master' branch.

Changes in version 2:
- removed extra check from tmio_mmc_enable_dma();
- moved tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
  tmio_mmc_start_dma_{rx|tx}().

 drivers/mmc/host/tmio_mmc_dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: renesas/drivers/mmc/host/tmio_mmc_dma.c
===================================================================
--- renesas.orig/drivers/mmc/host/tmio_mmc_dma.c
+++ renesas/drivers/mmc/host/tmio_mmc_dma.c
@@ -104,6 +104,7 @@ static void tmio_mmc_start_dma_rx(struct
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
+		tmio_mmc_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_rx = NULL;
@@ -116,7 +117,6 @@ pio:
 		}
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
-		tmio_mmc_enable_dma(host, false);
 	}
 
 	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
@@ -185,6 +185,7 @@ static void tmio_mmc_start_dma_tx(struct
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
+		tmio_mmc_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_tx = NULL;
@@ -197,7 +198,6 @@ pio:
 		}
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
-		tmio_mmc_enable_dma(host, false);
 	}
 
 	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
