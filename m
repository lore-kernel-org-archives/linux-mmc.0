From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] mmc: sdhci: Clear MMC_CAP_1_8V_DDR in the SDHCI_QUIRK2_NO_1_8_V case
Date: Thu, 11 Jun 2015 10:24:40 -0300
Message-ID: <1434029080-11298-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, b29396@freescale.com, kernel@pengutronix.de, linux@arm.linux.org.uk, kevin.lemoi@savant.com, otavio@ossystems.com.br, linux-mmc@vger.kernel.org, stable@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-mmc@vger.kernel.org

From: Kevin Lemoi <kevin.lemoi@savant.com>

SDHCI_QUIRK2_NO_1_8_V flag should disable MMC_CAP_1_8V_DDR.

Otherwise we get the following errors when accessing eMMC on a mx6sl
board:

mmc0: MAN_BKOPS_EN bit is not set
mmc0: power class selection to bus width 8 ddr 4 failed
mmc0: error -110 whilst initialising MMC card
mmc0: MAN_BKOPS_EN bit is not set
mmc0: power class selection to bus width 8 ddr 4 failed
mmc0: error -110 whilst initialising MMC card
mmc0: MAN_BKOPS_EN bit is not set
mmc0: power class selection to bus width 8 ddr 4 failed
mmc0: error -110 whilst initialising MMC card

With this fix in place it is possible to successfully mount the rootfs
from the emmc on the mx6sl board with 'no-1-8-v' property passed in the
device tree.

Cc: stable@vger.kernel.org
Signed-off-by: Kevin Lemoi <kevin.lemoi@savant.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 706bb60..10304cc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3140,9 +3140,11 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}
 
-	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
+	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);
+		mmc->caps &= ~MMC_CAP_1_8V_DDR;
+	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
-- 
1.9.1
