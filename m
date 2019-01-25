From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc4
Date: Fri, 25 Jan 2019 14:50:43 +0100
Message-ID: <20190125135043.22286-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc4. Details about the
highlights are as usual found in the signed tag.

Note that, my GPG-key expired last week, I have set a new expiration date for
it and re-published it, however not sure if it's been replicated to all
keyservers yet. Please tell if there is any issues from your side.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc2

for you to fetch changes up to f3716b8ae9347797b73896725f192c3a7b0069b5:

  mmc: dw_mmc-bluefield: : Fix the license information (2019-01-22 08:46:20 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-acpi: Fixup build dependency for PCI
 - sdhci-omap: Resolve Kconfig warnings on keystone
 - sdhci-iproc: Propagate errors from DT parsing
 - meson-gx: Fixup IRQ handling in release callback
 - meson-gx: Use signal re-sampling to fixup tuning
 - dw_mmc-bluefield: Fix the license information

----------------------------------------------------------------
Andreas Fenkart (1):
      mmc: meson-gx: enable signal re-sampling together with tuning

Faiz Abbas (1):
      mmc: host: Fix Kconfig warnings on keystone_defconfig

Liming Sun (1):
      mmc: dw_mmc-bluefield: : Fix the license information

Remi Pommarel (1):
      mmc: meson-gx: Free irq in release() callback

Sinan Kaya (1):
      mmc: sdhci-acpi: Make PCI dependency explicit

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

 drivers/mmc/host/Kconfig            |  4 ++--
 drivers/mmc/host/dw_mmc-bluefield.c |  5 -----
 drivers/mmc/host/meson-gx-mmc.c     | 32 ++++++++++++++++++++------------
 drivers/mmc/host/sdhci-iproc.c      |  5 ++++-
 4 files changed, 26 insertions(+), 20 deletions(-)
