From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/3] mmc: sdhci-esdhc-imx: fix no UHS modes
Date: Thu, 28 Jun 2018 10:13:28 +0200
Message-ID: <20180628081331.13051-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

Currently sdhci-esdhc-imx.c sets SDHCI_QUIRK2_NO_1_8_V if no
100MHz/200MHz pinctrl configurations are present in order to
prevent the stack from choosing high speed modes.

This does work for SD cards quite well, since 1.8V matches all
higher speed modes, and all lower speed modes run with 3.3V.

However, when running a eMMC on 1.8V only, this causes issues:
If vqmmc-supply is set to 1.8V only, and the driver at the same
time sets SDHCI_QUIRK2_NO_1_8_V, the stack has troubls selecting
a valid mode and continuously prints:
  mmc1: Switching to 3.3V signalling voltage failed

There are already board device trees which work around this by
not setting vqmmc-supply, e.g.
arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi.

Introducing a new quirk was the only way which I came up with,
but maybe there is a better way to prevent higher speed modes
while allowing 1.8V eMMC?

Stefan Agner (3):
  mmc: sdhci-esdhc-imx: get rid of support_vsel
  mmc: sdhci: add quirk to prevent higher speed modes
  mmc: sdhci-esdhc-imx: prevent stack from using higher speed modes

 drivers/mmc/host/sdhci-esdhc-imx.c          | 12 ++++--------
 drivers/mmc/host/sdhci.c                    |  8 ++++++++
 drivers/mmc/host/sdhci.h                    |  2 ++
 include/linux/platform_data/mmc-esdhc-imx.h |  2 --
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.18.0
