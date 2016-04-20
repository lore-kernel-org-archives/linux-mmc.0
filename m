From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 0/7] mmc: sdhci-pltfm: fix and tidy up sdhci_pltfm_init()
Date: Wed, 20 Apr 2016 11:16:24 +0900
Message-ID: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org



Changes in v2:
  - Remove resource size checking rather than fix it.
  - Add \n to the tail of the error message

Masahiro Yamada (7):
  mmc: sdhci-pltfm: drop error message for too small MMIO resource size
  mmc: sdhci-pltfm: check return value of platform_get_irq()
  mmc: sdhci-pltfm: use devm_request_mem_region()
  mmc: sdhci-pltfm: use devm_ioremap()
  mmc: sdhci-pltfm: use devm_ioremap_resource()
  mmc: sdhci-pltfm: move devm_ioremap_resource() up
  mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()

 drivers/mmc/host/sdhci-pltfm.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

-- 
1.9.1
