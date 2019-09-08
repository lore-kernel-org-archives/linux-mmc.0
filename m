From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 00/11] mmc: core: PM fixes/improvements for SDIO IRQs
Date: Sun,  8 Sep 2019 12:12:25 +0200
Message-ID: <20190908101236.2802-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Changes in v2:
	- Added reviewed/tested-by tags.
	- Updated some changelogs.
	- Renamed sdio_irq_enabled() to sdio_irq_claimed().
	- Don't set sdio_irq_pending when resuming SDIO card, but just queue the
	work.

The power management support for SDIO cards have slowly been improved, but
there are still quite some serious problems, especially when dealing with the
so called SDIO IRQs during system suspend/resume.

This series makes some additional improvements to this code in the mmc core,
but also includes some needed adaptations for the sdhci, the dw_mmc and the
mtk-sd host drivers.

The series is also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdio_irq_suspend_next_v2

Kind regards
Uffe


Matthias Kaehlcke (1):
  mmc: core: Move code to get pending SDIO IRQs to a function

Ulf Hansson (10):
  mmc: core: Add helper function to indicate if SDIO IRQs is enabled
  mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
  mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
  mmc: core: Clarify sdio_irq_pending flag for
    MMC_CAP2_SDIO_IRQ_NOTHREAD
  mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
  mmc: core: WARN if SDIO IRQs are enabled for non-powered card in
    suspend
  mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
  mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
  mmc: sdhci: Drop redundant code for SDIO IRQs
  mmc: sdhci: Convert to use sdio_irq_claimed()

 drivers/mmc/core/sdio.c            |  4 ++-
 drivers/mmc/core/sdio_irq.c        | 57 +++++++++++++++++++-----------
 drivers/mmc/host/dw_mmc.c          |  4 +++
 drivers/mmc/host/mtk-sd.c          |  3 ++
 drivers/mmc/host/sdhci-esdhc-imx.c | 34 ++++++++----------
 drivers/mmc/host/sdhci.c           | 12 ++-----
 drivers/mmc/host/sdhci.h           |  6 ----
 include/linux/mmc/host.h           | 10 ++++++
 8 files changed, 75 insertions(+), 55 deletions(-)

-- 
2.17.1
