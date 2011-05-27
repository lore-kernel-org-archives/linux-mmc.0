From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] sh: add coherent DMA mask for SDHI devices
Date: Fri, 27 May 2011 12:44:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271243110.25265@axis700.grange>
References: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

It is now required, because the SDHI / TMIO driver is using
dma_alloc_coherent() to allocate the DMA bounce buffer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-sh7757lcr.c     |    3 ++-
 arch/sh/boards/mach-ap325rxa/setup.c |    6 ++++--
 arch/sh/boards/mach-ecovec24/setup.c |    6 ++++--
 arch/sh/boards/mach-kfr2r09/setup.c  |    3 ++-
 arch/sh/boards/mach-migor/setup.c    |    3 ++-
 arch/sh/boards/mach-se/7724/setup.c  |    6 ++++--
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index fa2a208..e40f82c 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -256,7 +256,8 @@ static struct platform_device sdhi_device = {
 	.resource       = sdhi_resources,
 	.id             = 0,
 	.dev	= {
-		.platform_data	= &sdhi_info,
+		.platform_data		= &sdhi_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 618bd56..c3e80cf 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -458,7 +458,8 @@ static struct platform_device sdhi0_cn3_device = {
 	.num_resources	= ARRAY_SIZE(sdhi0_cn3_resources),
 	.resource	= sdhi0_cn3_resources,
 	.dev = {
-		.platform_data = &sdhi0_cn3_data,
+		.platform_data		= &sdhi0_cn3_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
@@ -488,7 +489,8 @@ static struct platform_device sdhi1_cn7_device = {
 	.num_resources	= ARRAY_SIZE(sdhi1_cn7_resources),
 	.resource	= sdhi1_cn7_resources,
 	.dev = {
-		.platform_data = &sdhi1_cn7_data,
+		.platform_data		= &sdhi1_cn7_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bb13d0e..5b4e3c9 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -515,7 +515,8 @@ static struct platform_device sdhi0_device = {
 	.resource       = sdhi0_resources,
 	.id             = 0,
 	.dev	= {
-		.platform_data	= &sdhi0_info,
+		.platform_data		= &sdhi0_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
@@ -555,7 +556,8 @@ static struct platform_device sdhi1_device = {
 	.resource       = sdhi1_resources,
 	.id             = 1,
 	.dev	= {
-		.platform_data	= &sdhi1_info,
+		.platform_data		= &sdhi1_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 8b4abbb..76d9d08 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -375,7 +375,8 @@ static struct platform_device kfr2r09_sh_sdhi0_device = {
 	.num_resources  = ARRAY_SIZE(kfr2r09_sh_sdhi0_resources),
 	.resource       = kfr2r09_sh_sdhi0_resources,
 	.dev = {
-		.platform_data	= &sh7724_sdhi0_data,
+		.platform_data		= &sh7724_sdhi0_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 184fde1..e89a599 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -419,7 +419,8 @@ static struct platform_device sdhi_cn9_device = {
 	.num_resources	= ARRAY_SIZE(sdhi_cn9_resources),
 	.resource	= sdhi_cn9_resources,
 	.dev = {
-		.platform_data	= &sh7724_sdhi_data,
+		.platform_data		= &sh7724_sdhi_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI,
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 1235767..4caa846 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -477,7 +477,8 @@ static struct platform_device sdhi0_cn7_device = {
 	.num_resources  = ARRAY_SIZE(sdhi0_cn7_resources),
 	.resource       = sdhi0_cn7_resources,
 	.dev = {
-		.platform_data	= &sh7724_sdhi0_data,
+		.platform_data		= &sh7724_sdhi0_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
@@ -509,7 +510,8 @@ static struct platform_device sdhi1_cn8_device = {
 	.num_resources  = ARRAY_SIZE(sdhi1_cn8_resources),
 	.resource       = sdhi1_cn8_resources,
 	.dev = {
-		.platform_data	= &sh7724_sdhi1_data,
+		.platform_data		= &sh7724_sdhi1_data,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
-- 
1.7.2.5

