From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc1
Date: Thu, 22 Dec 2016 12:18:57 +0100
Message-ID: <CAPDyKFrfcnfLQ6EbruxUHgv_5Sj4_LtQy_bJsjTQYUv5p3nM1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are some mmc fixes intended for v4.10 rc1. They are based from an
earlier commit during the merge window.

Details are as usual found in the signed tag. Please pull this in!

Merry Christmas!
Ulf Hansson


The following changes since commit e93b1cc8a8965da137ffea0b88e5f62fa1d2a9e6:

  Merge branch 'for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
(2016-12-19 08:23:53 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-3

for you to fetch changes up to e85baa8868b016513c0f5738362402495b1a66a5:

  mmc: sd: Meet alignment requirements for raw_ssr DMA (2016-12-21
08:34:30 +0100)

----------------------------------------------------------------
MMC core:
 - Further fix thread wake-up for requests
 - Use a bounce buffer to fix DMA issue for SSR register read

MMC host:
 - sdhci: Fix a regression for runtime PM
 - sdhci-cadence: Add a proper SoC specific DT compatible

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: sdhci: Fix to handle MMC_POWER_UNDEFINED
      mmc: core: Further fix thread wake-up

Masahiro Yamada (1):
      mmc: sdhci-cadence: add Socionext UniPhier specific compatible string

Paul Burton (1):
      mmc: sd: Meet alignment requirements for raw_ssr DMA

 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  6 ++--
 drivers/mmc/core/core.c                            | 12 ++++----
 drivers/mmc/core/sd.c                              | 12 ++++++--
 drivers/mmc/host/sdhci-cadence.c                   |  1 +
 drivers/mmc/host/sdhci.c                           | 33 +++++++++++++---------
 5 files changed, 39 insertions(+), 25 deletions(-)
