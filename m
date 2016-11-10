From: Michael Walle <michael@walle.cc>
Subject: [PATCH] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Thu, 10 Nov 2016 17:47:36 +0100
Message-ID: <1478796456-30549-1-git-send-email-michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yangbo lu <yangbo.lu@freescale.com>, Michael Walle <michael@walle.cc>
List-Id: linux-mmc@vger.kernel.org

Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
cards in __mmc_switch()") the ESDHC driver is broken:
  mmc0: Card stuck in programming state! __mmc_switch
  mmc0: error -110 whilst initialising MMC card

Since this commit __mmc_switch() uses ->card_busy(), which is
sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
PRESENT_STATE register, specifically the DAT0 signal level bit. But the
ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup is
required to make the driver work again.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fb71c86..243fee9 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -66,6 +66,18 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+	/*
+	 * The DAT[3:0] line signal levels and the CMD line signal level is
+	 * not compatible with standard SDHC reegister. Move the corresponding
+	 * bits around.
+	 */
+	if (spec_reg == SDHCI_PRESENT_STATE) {
+		ret = value & 0xf8000000;
+		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
+		ret |= (value << 1) & 0x01000000;
+		return ret;
+	}
+
 	ret = value;
 	return ret;
 }
-- 
2.1.4
