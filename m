From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.7 rc1
Date: Thu, 26 May 2016 10:11:18 +0200
Message-ID: <CAPDyKFpEhDLrme8miCFWqbWF87zYShNhtATGPBk88hyQ4c89Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are some mmc fixes intended for v4.7 rc1. They are based on a
commit earlier in the merge window and have been tested in linux-next
for a while.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 16490980e396fac079248b23b1dd81e7d48bebf3:

  Merge tag 'device-properties-4.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
(2016-05-16 19:51:04 -0700)

are available in the git repository at:


  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.7-rc1

for you to fetch changes up to 265984b36ce82fec67957d452dd2b22e010611e4:

  mmc: sdhci-acpi: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
(2016-05-23 11:52:41 +0200)

----------------------------------------------------------------
MMC core:
 - Prevent re-tuning while serving requests for RPMB partitions
 - Extend timeout for long read time quirk to support more eMMCs

MMC host:
 - sdhci-acpi: Ensure connected devices are powered when probing
 - sdhci-pci|acpi: Remove unreliable MMC_CAP_BUS_WIDTH_TEST for Intel HWs
 - dw_mmc: Correct the assigning of max_blk_size
 - dw_mmc-rockchip: Allow RPMB partitions to be created
 - dw_mmc-rockchip: Set the drive phase properly

----------------------------------------------------------------
Adrian Hunter (6):
      mmc: core: Add a facility to "pause" re-tuning
      mmc: block: Always switch back to main area after RPMB access
      mmc: block: Pause re-tuning while switched to the RPMB partition
      mmc: sdhci-acpi: Ensure connected devices are powered when probing
      mmc: sdhci-pci: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
      mmc: sdhci-acpi: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers

Douglas Anderson (1):
      mmc: dw_mmc: rockchip: Set the drive phase properly

Jaehoon Chung (1):
      mmc: dw_mmc: fix the wrong max_blk_size

Matt Gumbel (1):
      mmc: longer timeout for long read time quirk

Shawn Lin (1):
      mmc: dw_mmc-rockchip: add MMC_CAP_CMD23 capabilities

Ulf Hansson (1):
      ACPI / PM: Export acpi_device_fix_up_power()

 drivers/acpi/device_pm.c           |  1 +
 drivers/mmc/card/block.c           | 24 +++++++++++--
 drivers/mmc/core/core.c            |  4 +--
 drivers/mmc/core/host.c            | 24 +++++++++++++
 drivers/mmc/host/dw_mmc-rockchip.c | 72 +++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.c          |  6 ++--
 drivers/mmc/host/sdhci-acpi.c      | 13 ++++---
 drivers/mmc/host/sdhci-pci-core.c  |  5 +--
 include/linux/mmc/host.h           |  4 +++
 9 files changed, 133 insertions(+), 20 deletions(-)
