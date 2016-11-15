From: Michael Walle <michael@walle.cc>
Subject: [PATCH v4] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Tue, 15 Nov 2016 11:13:16 +0100
Message-ID: <1479204796-23982-1-git-send-email-michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yangbo lu <yangbo.lu@nxp.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Michael Walle <michael@walle.cc>
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
Fixes: 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy cards in __mmc_switch()")
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
---
v4:
 - add and use SDHCI_CMD_LVL macro
 - fix typo in comment, thanks alex
 - add acked-by

v3:
 - explain the bits in the comments
 - use bits[19:0] from the original value, all other will be taken from the
   fixup value.

v2:
 - use lower bits of the original value (that was actually a typo)
 - add fixes tag
 - fix typo

 drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
 drivers/mmc/host/sdhci.h          |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fb71c86..1bb11e4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -66,6 +66,20 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+	/*
+	 * The DAT[3:0] line signal levels and the CMD line signal level are
+	 * not compatible with standard SDHC register. The line signal levels
+	 * DAT[7:0] are at bits 31:24 and the command line signal level is at
+	 * bit 23. All other bits are the same as in the standard SDHC
+	 * register.
+	 */
+	if (spec_reg == SDHCI_PRESENT_STATE) {
+		ret = value & 0x000fffff;
+		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
+		ret |= (value << 1) & SDHCI_CMD_LVL;
+		return ret;
+	}
+
 	ret = value;
 	return ret;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c722cd2..ea38962 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -73,6 +73,7 @@
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
+#define  SDHCI_CMD_LVL		0x01000000
 
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
-- 
2.1.4
