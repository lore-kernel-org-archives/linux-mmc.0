From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/7] mmc: sdhci-pltfm: fix and tidy up sdhci_pltfm_init()
Date: Thu, 14 Apr 2016 11:29:43 +0900
Message-ID: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org




Masahiro Yamada (7):
  mmc: sdhci-pltfm: bail out if register resource is too small
  mmc: sdhci-pltfm: check return value of platform_get_irq()
  mmc: sdhci-pltfm: use devm_request_mem_region()
  mmc: sdhci-pltfm: use devm_ioremap()
  mmc: sdhci-pltfm: use devm_ioremap_resource()
  mmc: sdhci-pltfm: move devm_ioremap_resource() up
  mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()

 drivers/mmc/host/sdhci-pltfm.c | 46 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

-- 
1.9.1
