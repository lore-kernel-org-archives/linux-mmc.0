From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 21/21] mmc: sdhci.h: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:09:38 +0800
Message-ID: <1453871378-4175-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:37046 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbcA0FOM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:14:12 -0500
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We remove SDHCI_QUIRK_BROKEN_CARD_DETECTION since now
sdhci core and variant drivers will not use it. And we
also move up the quirk number one-by-one.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci.h | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7654ae5..41988ef 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -356,36 +356,34 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
 /* Controller does not provide transfer-complete interrupt when not busy */
 #define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
-/* Controller has unreliable card detection */
-#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
 /* Controller reports inverted write-protect state */
-#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
+#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<15)
 /* Controller does not like fast PIO transfers */
-#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<16)
 /* Controller has to be forced to use block size of 2048 bytes */
-#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<17)
 /* Controller cannot do multi-block transfers */
-#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
+#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<18)
 /* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
+#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<19)
 /* Controller needs 10ms delay between applying power and clock */
-#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<20)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
-#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<21)
 /* Controller reports wrong base clock capability */
-#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
+#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<22)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
-#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<23)
 /* Controller is missing device caps. Use caps provided by host */
-#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
+#define SDHCI_QUIRK_MISSING_CAPS			(1<<24)
 /* Controller uses Auto CMD12 command to stop the transfer */
-#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<25)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
-#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<26)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
-#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<27)
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
-#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<28)
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
-- 
2.3.7


