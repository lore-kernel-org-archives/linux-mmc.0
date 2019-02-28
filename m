From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc9
Date: Thu, 28 Feb 2019 15:22:39 +0100
Message-ID: <20190228142239.4078-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc9 (final). Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc8

for you to fetch changes up to e30be063d6dbcc0f18b1eb25fa709fdef89201fb:

  mmc: sdhci-esdhc-imx: correct the fix of ERR004536 (2019-02-28 12:18:31 +0100)

----------------------------------------------------------------
MMC core:
 - Fix NULL ptr crash for a special test case
 - Align max segment size with logical block size to prevent bugs in
   v5.1-rc1.
MMC host:
 - cqhci: Minor fixes
 - tmio: Prevent interrupt storm
 - tmio: Fixup SD/MMC card initialization
 - spi: Allow card to be detected during probe
 - sdhci-esdhc-imx: Fixup fix for ERR004536

----------------------------------------------------------------
Alamy Liu (2):
      mmc: cqhci: fix space allocated for transfer descriptor
      mmc: cqhci: Fix a tiny potential memory leak on error condition

BOUGH CHEN (1):
      mmc: sdhci-esdhc-imx: correct the fix of ERR004536

Jonathan Neuschäfer (1):
      mmc: spi: Fix card detection during probe

Ming Lei (1):
      mmc: core: align max segment size with logical block size

Ritesh Harjani (1):
      mmc: core: Fix NULL ptr crash from mmc_should_fail_request

Sergei Shtylyov (1):
      mmc: tmio_mmc_core: don't claim spurious interrupts

Takeshi Saito (1):
      mmc: tmio: fix access width of Block Count Register

 drivers/mmc/core/block.c                 |  6 ------
 drivers/mmc/core/core.c                  |  2 +-
 drivers/mmc/core/queue.c                 |  9 ++++++++-
 drivers/mmc/host/cqhci.c                 | 13 +++++++++++--
 drivers/mmc/host/mmc_spi.c               |  1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c       |  9 +++++----
 drivers/mmc/host/tmio_mmc.h              |  5 +++++
 drivers/mmc/host/tmio_mmc_core.c         | 17 ++++++++++++-----
 9 files changed, 44 insertions(+), 19 deletions(-)
