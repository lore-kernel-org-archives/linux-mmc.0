From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/12] mmc: sdhci-omap: Add UHS/HS200 mode support
Date: Thu, 14 Dec 2017 18:39:29 +0530
Message-ID: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add UHS/HS200 mode support in sdhci-omap. The programming sequence
for voltage switching, tuning is followed from AM572x TRM
http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
(Similar to all AM57x/DRA7x SoCs). The patch series also implements
workaround for errata published in
http://www.ti.com/lit/er/sprz429k/sprz429k.pdf.

While most of this series is specific to sdhci-omap, it also
patches sdhci to use software timer when the requested timeout
is greater than hardware capablility. This re-uses the SW data timer
already implemented in sdhci while disabling the HW timeout (so that
spurious timeout is not observed). The patch for sdhci.c is based on
an earlier patch that was done specific to omap_hsmmc.c
(https://patchwork.kernel.org/patch/9791449/)

It also includes a pdata-quirk patch since both pdata-quirks and
sdhci-omap uses struct sdhci_omap_platform_data.

The dt patches enabling UHS/HS200 will be follow this patch series.

This series is created on
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

Kishon Vijay Abraham I (12):
  mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
  mmc: sdhci-omap: Add card_busy host ops
  mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
  mmc: sdhci-omap: Add tuning support
  mmc: sdhci-omap: Workaround for Errata i802
  mmc: sdhci_omap: Add support to set IODELAY values
  mmc: sdhci_omap: Fix sdhci-omap quirks
  mmc: sdhci-omap: Add support to override f_max and iodelay from pdata
  mmc: sdhci: Use software timer when timeout greater than hardware
    capablility
  dt-bindings: sdhci-omap: Add K2G specific binding
  mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
  ARM: OMAP2+: Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x
    EVM

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   2 +
 arch/arm/mach-omap2/pdata-quirks.c                 |  34 +-
 drivers/mmc/host/sdhci-omap.c                      | 446 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                           |  41 +-
 drivers/mmc/host/sdhci.h                           |  11 +
 include/linux/platform_data/sdhci-omap.h           |  35 ++
 6 files changed, 544 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/platform_data/sdhci-omap.h

-- 
2.11.0
