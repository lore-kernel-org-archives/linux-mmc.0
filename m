From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: prevent stack from using higher speed modes
Date: Thu, 28 Jun 2018 10:13:31 +0200
Message-ID: <20180628081331.13051-4-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628081331.13051-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

If pinctrl configurations for higher speed modes are missing, the
stack currently uses the no 1.8V quirk. This comes close to what
we need but not exactly: E.g. if a eMMC chip uses 1.8V signaling
(by specifying a 1.8V only vqmmc-supply) while not providing any
100MHz/200MHz pinctrl configurations then the SDHCI_QUIRK2_NO_1_8_V
leads the stack to print signaling voltage switch failed errors
continuously:
  mmc1: Switching to 3.3V signalling voltage failed

Presumably because the stack tries to use 3.3V signaling:

  # cat /sys/kernel/debug/mmc1/ios
  ...
  timing spec:    8 (mmc DDR52)
  signal voltage: 0 (3.30 V)
  ...

With using SDHCI_QUIRK2_NO_UHS_HS200_HS400 we prevent the stack
from choosing any modes require speeds higher than 52MHz while
still allowing to select modes using 1.8V at lower speeds (e.g.
DDR52):

  # cat /sys/kernel/debug/mmc1/ios
  ...
  timing spec:    8 (mmc DDR52)
  signal voltage: 1 (1.80 V)
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 20a420b765b3..4a1c33018072 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1165,10 +1165,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 * fall back to not supporting uhs by specifying no
 			 * 1.8v quirk
 			 */
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+			host->quirks2 |= SDHCI_QUIRK2_NO_UHS_HS200_HS400;
 		}
 	} else {
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+		host->quirks2 |= SDHCI_QUIRK2_NO_UHS_HS200_HS400;
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */
-- 
2.18.0
