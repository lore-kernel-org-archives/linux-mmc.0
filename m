From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V4 0/3] Add support for using external dma in SDHCI
Date: Tue, 11 Dec 2018 17:12:49 +0800
Message-ID: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Currently the generic SDHCI code in the Linux kernel supports the SD
standard DMA integrated into the host controller but does not have any
support for external DMA controllers implemented using dmaengine meaning
that custom code is needed for any systems that use a generic DMA
controller with SDHCI which in practice means any SDHCI controller that
doesn't have an integrated DMA controller so we should have this as a
generic feature.

There are already a number of controller specific drivers that have dmaengine
code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
in their specific driver for sending command with external dma using dmaengine
framework, with this patchset, them will take advantage of the generic support.
TI's omap controller is the case as an example.

Any comments are very appreciated.

Thanks,
Chunyan

Changes from v3 (https://lkml.org/lkml/2018/12/4/74):
(The code only on patch 1/3 was revised since v3)
* Moved the check for command data from sdhci_external_dma_setup() to sdhci_external_dma_prepare_data();
* Cut a copy of prepare_data() for external DMA instead of using sdhci_prepare_data() to
  avoid the host use ADMA rather than external DMA;  In this way, if failed to setup external DMA, host
  can fall back to ADMA/SDMA/PIO which standard sd host controller supports.
* Added dmaengine_terminate_sync() when finished transfers or some error occured;
* Adjusted print message in __sdhci_add_host() for the case of using external DMA.

Changes from v2 (https://lkml.org/lkml/2018/11/12/1936):
* Remove CONFIG_EXTERNAL_DMA prompt and help graph;
* Add checking for cmd->data;
* Select MMC_SDHCI_EXTERNAL_DMA for MMC_SDHCI_OMAP;
* Add checking if there's 'dmas' in device tree before decide using external dma.

Changes from v1 (https://lkml.org/lkml/2018/11/5/110):
(The code on patch 1/3 only was revised)
* Address comments from Arnd:
- Release channel when failed to request it unconditionally;
- Skip warning message if get EPROBE_DEFER;
* Address Andrian's comments:
- Replace extdma with external_dma;
- Add release dma resources in sdhci_cleanup_host() and sdhci_remove_host();
- Release dma resources once dmaengine_submit() failed.
- Put rx/tx_chan in struct sdhci_host, and removed unused structure.
* Fall back to the DMA/PIO which standard SDHCI supports, if sdhci_external_dma_setup()
  or sdhci_external_dma_init failed;

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using external dma

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 +
 drivers/mmc/host/Kconfig                           |   4 +
 drivers/mmc/host/sdhci-omap.c                      |  10 +
 drivers/mmc/host/sdhci.c                           | 250 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |   8 +
 5 files changed, 278 insertions(+), 1 deletion(-)

-- 
2.7.4
