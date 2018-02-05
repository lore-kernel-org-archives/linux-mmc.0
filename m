From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 00/16] mmc: sdhci-omap: Add UHS/HS200 mode support
Date: Mon, 5 Feb 2018 18:20:13 +0530
Message-ID: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add UHS/HS200 mode support in sdhci-omap. The programming sequence
for voltage switching, tuning is followed from AM572x TRM
http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
(Similar to all AM57x/DRA7x SoCs). The patch series also implements
workaround for errata published in
http://www.ti.com/lit/er/sprz429k/sprz429k.pdf.

It also includes a pdata-quirk patch since both pdata-quirks and
sdhci-omap uses struct sdhci_omap_platform_data.

The dt patches enabling UHS/HS200 will follow this series.

Changes from v1:
*) Only poll on DAT0 and DATI for card_busy status
*) Cleanup iodelay patch as suggested by Tony.
*) Added quirk to disable HW timeout
*) Use the existing data timer but program a relatively accurate
   SW timeout value (Impacts all platforms)
*) Fix a bug in sdhci which was using data_timer for non data line
   commands

I've tested on dra72-evm, dra7xx-evm, dra71-evm, am572x-idk, am571x-idk
dra76-evm, am57xx-evm and k2g-evm.

I've also pushed the series (along with dt) to
https://github.com/kishon/linux-wip.git sdhci_uhs_v2

Kishon Vijay Abraham I (16):
  mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
  mmc: sdhci-omap: Add card_busy host ops
  mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
  mmc: sdhci-omap: Add tuning support
  mmc: sdhci-omap: Workaround for Errata i802
  mmc: sdhci_omap: Add support to set IODELAY values
  mmc: sdhci_omap: Fix sdhci-omap quirks
  mmc: sdhci-omap: Add support to override f_max and iodelay from pdata
  mmc: sdhci: Add quirk to disable HW timeout
  mmc: sdhci: Fix to use data_timer only for data line commands
  mmc: sdhci: Program a relatively accurate SW timeout value
  mmc: sdhci-omap: Workaround for Errata i834
  dt-bindings: sdhci-omap: Add K2G specific binding
  mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
  mmc: sdhci-omap: Add SPDX identifier
  ARM: OMAP2+: Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x
    EVM

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   2 +
 arch/arm/mach-omap2/pdata-quirks.c                 |  34 +-
 drivers/mmc/host/sdhci-omap.c                      | 430 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  62 ++-
 drivers/mmc/host/sdhci.h                           |  17 +
 include/linux/platform_data/sdhci-omap.h           |  22 ++
 6 files changed, 518 insertions(+), 49 deletions(-)
 create mode 100644 include/linux/platform_data/sdhci-omap.h

-- 
2.11.0
