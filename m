From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Date: Sat, 16 Feb 2019 00:50:25 +0530
Message-ID: <20190215192033.24203-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The following add driver patches for porting TI's am335x and am437x
devices to the sdhci-omap driver.

This involves adding external DMA support to sdhci (first 3 patches from
Chunyan) plus some miscellaneous patches to take care of deviations of
the controllers from the sdhci model.

DT changes will be posted in a separate series.

Untested versions of Chunyan's patches were posted before[1].

Tested on: am335x-evm, am335x-boneblack, am335x-sk, am437x-gpevm,
am43xx-gpevm, am437x-idk, dra7xx-evm, dra72x-evm

v2:
1. sdhci is using two bottom halves. One threaded_rq for card detect and a
   tasklet for finishing mmc requests. Patch 1 removes the tasklet and
   moves its function to the threaded_irq. This enables me to
   terminate_sync() in sdhci_request_done()

2. Factored out common code for between the normal adn external dma case

3. Using existing API sdhci_data_timeout_irq for disabling DTO during
   erase commands.

4. Fixed subject line for dt-bindings patch.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  dt-bindings: sdhci-omap: Add properties for using external dma
  mmc: sdhci-omap: Add using external dma

Faiz Abbas (5):
  mmc: sdhci: Get rid of finish_tasklet
  mmc: sdhci: Add quirk for disabling DTO during erase command
  mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
  dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
  mmc: sdhci-omap: Add am335x and am437x specific compatibles

 .../devicetree/bindings/mmc/sdhci-omap.txt    |   9 +
 drivers/mmc/host/Kconfig                      |   4 +
 drivers/mmc/host/sdhci-omap.c                 |  27 +-
 drivers/mmc/host/sdhci.c                      | 333 +++++++++++++++---
 drivers/mmc/host/sdhci.h                      |  12 +-
 5 files changed, 328 insertions(+), 57 deletions(-)

-- 
2.19.2
