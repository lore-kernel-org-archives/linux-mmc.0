From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 09/10 v3] ARM: mach-shmobile: specify inverted SDHI card-detect
 signal polarity
Date: Fri, 25 May 2012 17:16:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251651550.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62810 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab2EYPQh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:16:37 -0400
In-Reply-To: <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On mackerel and ag5evm the SDHI0 CD signal is inverted (active low). To
prepare for the generic GPIO CD handler the MMC_CAP2_INVERTED_CD flag
has to be specified in platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    1 +
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 5a6f22f..545fd06 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -370,6 +370,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_caps2	= MMC_CAP2_INVERTED_CD,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
 	.cd_gpio	= GPIO_PORT251,
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b577f7c..5881bb1 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1047,6 +1047,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.tmio_caps2	= MMC_CAP2_INVERTED_CD,
 	.cd_gpio	= GPIO_PORT172,
 };
 
-- 
1.7.2.5

