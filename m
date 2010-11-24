From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/5 v2] ARM: mach-shmobile: enable MMCIF DMA on ap4evb
Date: Wed, 24 Nov 2010 11:05:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011241057570.18622@axis700.grange>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Have to add DMA slave configuration to enable DMA for the sh7372 MMCIF
controller.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 arch/arm/mach-shmobile/board-ap4evb.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1443d2e..67a2f34 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -271,6 +271,15 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
+static struct sh_mmcif_dma sh_mmcif_dma = {
+	.chan_priv_rx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+	},
+	.chan_priv_tx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+	},
+};
+
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -278,6 +287,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
+	.dma		= &sh_mmcif_dma,
 };
 
 static struct platform_device sh_mmcif_device = {
-- 
1.7.2.3

