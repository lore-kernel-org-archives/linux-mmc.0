From: Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 0/5] Add Genesys Logic GL975x support
Date: Fri, 30 Aug 2019 10:20:39 +0800
Message-ID: <20190830022039.8210-1-benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.

v7:
 - remove condition define CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c
 - making the accessors(MMC_SDHCI_IO_ACCESSORS) always available when selecting
   MMC_SDHCI_PCI in Kconfig

V6:
 - export sdhci_abot_tuning() function symbol
 - use C-style comments
 - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
 - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
 - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
 - remove .hw_reset 
 - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

V5:
 - add "change timeout of loop .." to a patch
 - fix typo "verndor" to "vendor"

V4:
 - change name from sdhci_gli_reset to sdhci_gl9750_reset
 - fix sdhci_reset to sdhci_gl9750_reset in sdhci_gl9750_ops
 - fix sdhci_gli_reset to sdhci_reset in sdhci_gl9755_ops
 
V3:
 - change usleep_range to udelay
 - add Genesys Logic PCI Vendor ID to a patch
 - separate the Genesys Logic specific part to a patch

V2:
 - change udelay to usleep_range

Ben Chuang (5):
  mmc: sdhci: Change timeout of loop for checking internal clock stable
  mmc: sdhci: Add PLL Enable support to internal clock setup
  PCI: Add Genesys Logic, Inc. Vendor ID
  mmc: sdhci: Export sdhci_abort_tuning function symbol
  mmc: host: sdhci-pci: Add Genesys Logic GL975x support

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 350 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  30 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 include/linux/pci_ids.h           |   2 +
 8 files changed, 390 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.22.1
