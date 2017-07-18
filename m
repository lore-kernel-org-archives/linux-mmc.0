From: Ian Molton <ian@mnementh.co.uk>
Subject: [PATCH] MMC: Remove HIGHMEM dependency from mmc-spi driver
Date: Tue, 18 Jul 2017 13:19:15 +0100
Message-ID: <20170718121915.23303-2-ian@mnementh.co.uk>
References: <20170718121915.23303-1-ian@mnementh.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [217.148.43.144] ([217.148.43.144]:51526 "EHLO mnementh.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751322AbdGRMT2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Jul 2017 08:19:28 -0400
In-Reply-To: <20170718121915.23303-1-ian@mnementh.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

I cannot see why this is needed. kmap() should be safe in this case.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5755b69f2f72..a8980e9e688b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -494,7 +494,7 @@ config MMC_GOLDFISH
 
 config MMC_SPI
 	tristate "MMC/SD/SDIO over SPI"
-	depends on SPI_MASTER && !HIGHMEM && HAS_DMA
+	depends on SPI_MASTER && HAS_DMA
 	select CRC7
 	select CRC_ITU_T
 	help
-- 
2.11.0

