From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 02/22] OMAP: DMA: add omap_dma_has_sglist()
Date: Thu,  5 May 2011 14:51:02 +0300
Message-ID: <1304596282-4095-3-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>, Venkatraman S <svenkatr@ti.com>, Shilimkar Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Simplify detection of the sglist feature and add a
define for the super block end event that occurs
with sglist transfers.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
CC: Venkatraman S <svenkatr@ti.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c              |    5 +++++
 arch/arm/plat-omap/include/plat/dma.h |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7f64366..32a923a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1862,6 +1862,11 @@ int omap_get_dma_chain_src_pos(int chain_id)
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
 
+int omap_dma_has_sglist_mode(void)
+{
+	return dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT;
+}
+
 int omap_set_dma_sglist_mode(int lch, struct omap_dma_sglist_node *sgparams,
 	dma_addr_t padd, int nelem, struct omap_dma_channel_params *chparams)
 {
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 4d73eb1..3536eb4 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -209,6 +209,7 @@
 #define OMAP2_DMA_SECURE_ERR_IRQ	(1 << 9)
 #define OMAP2_DMA_SUPERVISOR_ERR_IRQ	(1 << 10)
 #define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
+#define OMAP2_DMA_SUPER_BLOCK_IRQ	(1 << 14)
 
 #define OMAP_DMA_CCR_EN			(1 << 7)
 #define OMAP_DMA_CCR_RD_ACTIVE		(1 << 9)
@@ -616,6 +617,8 @@ static inline int omap_lcd_dma_running(void)
 }
 #endif
 
+extern int omap_dma_has_sglist_mode(void);
+
 /**
  * omap_set_dma_sglist_mode()	Switch channel to scatter gather mode
  * @lch:	Logical channel to switch to sglist mode
-- 
1.7.0.4

