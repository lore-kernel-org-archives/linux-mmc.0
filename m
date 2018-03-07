From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 00/11] mmc: sdhci-omap: Add UHS/HS200 mode support
Date: Wed, 7 Mar 2018 18:50:09 +0530
Message-ID: <20180307132020.30951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add UHS/HS200 mode support in sdhci-omap. The programming sequence
for voltage switching, tuning is followed from AM572x TRM
http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
(Similar to all AM57x/DRA7x SoCs). The patch series also implements
workaround for errata published in
http://www.ti.com/lit/er/sprz429k/sprz429k.pdf

patches are created on top of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

Patches in v2 already applied to mmc -next are dropped from the
series.

Changes from v2:
*) Changed SW timeout logic as per Adrians's suggestion
*) Validated SDIO with the current patches (added a couple of fixes
   found while adding SDIO support).
*) Used soc_device_match() instead of pdata-quirks as per Tony's
   suggestions.

Changes from v1:
*) Only poll on DAT0 and DATI for card_busy status
*) Cleanup iodelay patch as suggested by Tony.
*) Added quirk to disable HW timeout
*) Use the existing data timer but program a relatively accurate
   SW timeout value (Impacts all platforms)
*) Fix a bug in sdhci which was using data_timer for non data line
   commands

Kishon Vijay Abraham I (11):
  mmc: sdhci-omap: Fix when capabilities are obtained from
    SDHCI_CAPABILITIES reg
  mmc: sdhci-omap: Remove setting ADMA capability in driver
  mmc: sdhci-omap: Workaround for Errata i843
  mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt
    properties
  mmc: sdhci: Disable HS200 mode if controller can't support 1.8v
  mmc: sdhci: Add quirk to disable HW timeout
  mmc: sdhci: Program a relatively accurate SW timeout value
  mmc: sdhci-omap: Workaround for Errata i834
  dt-bindings: sdhci-omap: Add K2G specific binding
  mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
  mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  2 +
 drivers/mmc/host/sdhci-omap.c                      | 78 +++++++++++++++++++---
 drivers/mmc/host/sdhci.c                           | 75 +++++++++++++++++----
 drivers/mmc/host/sdhci.h                           | 15 +++++
 4 files changed, 148 insertions(+), 22 deletions(-)

-- 
2.11.0
