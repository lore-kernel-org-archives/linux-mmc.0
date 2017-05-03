From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [PATCH 1/4] mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
Date: Wed,  3 May 2017 12:05:22 +0200
Message-ID: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp93.register.it ([195.110.122.178]:39304 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750950AbdECKOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 May 2017 06:14:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>

The eSDHC can only DMA from 32-bit-aligned addresses.

This fixes the following test cases of mmc_test:
  11:	Badly aligned write
  12:	Badly aligned read
  13:	Badly aligned multi-block write
  14:	Badly aligned multi-block read

Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
---
 drivers/mmc/host/sdhci-esdhc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c4bbd74..e7893f2 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -19,6 +19,7 @@
  */
 
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
+				SDHCI_QUIRK_32BIT_DMA_ADDR | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-- 
2.7.4

