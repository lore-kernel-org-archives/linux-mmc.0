From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
Date: Mon, 20 Jun 2011 15:06:55 +0900
Message-ID: <1308550015-15717-6-git-send-email-horms@verge.net.au>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

The SDHI block on the ag5evm requires waiting for idle
before writing to some registers.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies:
	"mmc: sdhi: Add write16_hook"
	"ARM: mach-shmobile: ag5evm: consistently name sdhi info structures"
---
 arch/arm/mach-shmobile/board-ag5evm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..cdfdd62 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -341,6 +341,7 @@ static struct platform_device mipidsi0_device = {
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
 };
@@ -382,7 +383,7 @@ void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
 }
 
 static struct sh_mobile_sdhi_info sh_sdhi1_info = {
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.set_pwr	= ag5evm_sdhi1_set_pwr,
-- 
1.7.4.4

