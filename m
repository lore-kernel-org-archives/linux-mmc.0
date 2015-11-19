From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.4 rc2
Date: Thu, 19 Nov 2015 11:03:45 +0100
Message-ID: <CAPDyKFqu9O5UT+jXjBcMWvMjCA+t-yLSCcsdWuhSYKFKLW=vMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are some mmc fixes intended for v4.4 rc2. It's based on a commit
prior rc1 as I wanted to get them a bit more tested in next before
sending you the pull request.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ce5c2d2c256a4c8b523036537cd6be2d6af8f69d:

  arm64: fixup for mm renames (2015-11-07 16:45:51 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.4-rc1

for you to fetch changes up to d3df0465db00cf4ed9f90d0bfc3b827d32b9c796:

  mmc: remove bondage between REQ_META and reliable write (2015-11-09
14:04:52 +0100)

----------------------------------------------------------------
MMC core:
 - Improve reliability when selecting HS200 mode
 - Improve reliability when selecting HS400 mode
 - mmc: remove bondage between REQ_META and reliable write

MMC host:
 - pxamci: Fix read-only gpio detection polarity
 - mtk-sd: Preinitialize delay_phase to fix the case when delay is zero
 - android-goldfish: Fix build dependency by adding HAS_DMA
 - dw_mmc: Remove Seungwon Jeon from MAINTAINERS

----------------------------------------------------------------
Adrian Hunter (4):
      mmc: mmc: Improve reliability of mmc_select_hs200()
      mmc: mmc: Fix HS setting in mmc_select_hs400()
      mmc: mmc: Move mmc_switch_status()
      mmc: mmc: Improve reliability of mmc_select_hs400()

Geert Uytterhoeven (2):
      mmc: mediatek: Preinitialize delay_phase in get_best_delay()
      mmc: MMC_GOLDFISH should depend on HAS_DMA

Luca Porzio (1):
      mmc: remove bondage between REQ_META and reliable write

Robert Jarzmik (1):
      mmc: pxamci: fix read-only gpio detection polarity

Ulf Hansson (1):
      MAINTAINERS: mmc: Remove Seungwon Jeon from dw_mmc

 MAINTAINERS               |  1 -
 drivers/mmc/card/block.c  | 11 ++----
 drivers/mmc/core/mmc.c    | 93 +++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/Kconfig  |  1 +
 drivers/mmc/host/mtk-sd.c |  2 +-
 drivers/mmc/host/pxamci.c |  2 +-
 6 files changed, 75 insertions(+), 35 deletions(-)
