From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH RFC 0/3] Add support for using external dma in SDHCI
Date: Mon,  5 Nov 2018 11:16:47 +0800
Message-ID: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
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

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using dmaengine

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 ++
 drivers/mmc/host/Kconfig                           |  13 ++
 drivers/mmc/host/sdhci-omap.c                      |   7 ++
 drivers/mmc/host/sdhci.c                           | 137 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |  12 ++
 5 files changed, 175 insertions(+), 1 deletion(-)

-- 
2.7.4
