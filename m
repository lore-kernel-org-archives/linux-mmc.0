From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Fri, 2 Aug 2013 01:17:17 +0400
Message-ID: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org
Cc: linux-sh@vger.kernel.org, max.filippov@cogentembedded.com
List-Id: linux-mmc@vger.kernel.org

I'm testing SH-Mobile SDHI driver in DMA mode with a  new DMA controller  using
'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
to PIO but all commands time out after that.  It turned out that the fallback
code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
to them cleared, so that the function bails out early instead  of clearing the
DMA bit in the CTL_DMA_ENABLE register.  Fixing the RX/TX channel check so that
it takes place only when enabling DMA helps with the PIO fallback.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Chris Ball's 'mmc.git' repo, 'master' branch.

 drivers/mmc/host/tmio_mmc_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: mmc/drivers/mmc/host/tmio_mmc_dma.c
===================================================================
--- mmc.orig/drivers/mmc/host/tmio_mmc_dma.c
+++ mmc/drivers/mmc/host/tmio_mmc_dma.c
@@ -25,7 +25,7 @@
 
 void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
-	if (!host->chan_tx || !host->chan_rx)
+	if (enable && !(host->chan_tx && host->chan_rx))
 		return;
 
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
