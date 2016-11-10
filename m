From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.9 rc5
Date: Thu, 10 Nov 2016 22:39:36 +0100
Message-ID: <CAPDyKFoJaa1__V0Td+dVqJy3h50mWFS49iO-g+cCbR7VEQsjXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are some mmc fixes intended for v4.9 rc5. They are based on v4.9-rc5.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.9-rc4

for you to fetch changes up to f91346e8b5f46aaf12f1df26e87140584ffd1b3f:

  mmc: mxs: Initialize the spinlock prior to using it (2016-11-07
13:30:08 +0100)

----------------------------------------------------------------
MMC core:
 - Fix mmc card initialization for hosts not supporting HW busy detection
 - Fix mmc_test for sending commands during non-blocking write

MMC host:
 - mxs: Avoid using an uninitialized
 - sdhci: Restore enhanced strobe setting during runtime resume
 - sdhci: Fix a couple of reset related issues
 - dw_mmc: Fix a reset controller issue

----------------------------------------------------------------
Adrian Hunter (5):
      mmc: sdhci: Fix CMD line reset interfering with ongoing data transfer
      mmc: sdhci: Fix unexpected data interrupt handling
      mmc: sdhci: Reset cmd and data circuits after tuning failure
      mmc: sdhci: Fix missing enhanced strobe setting during runtime resume
      mmc: mmc_test: Fix "Commands during non-blocking write" tests

Fabio Estevam (1):
      mmc: mxs: Initialize the spinlock prior to using it

Jaehoon Chung (2):
      Documentation: synopsys-dw-mshc: add binding for reset-names
      mmc: dw_mmc: add the "reset" as name of reset controller

Ulf Hansson (1):
      mmc: mmc: Use 500ms as the default generic CMD6 timeout

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  5 +++
 drivers/mmc/card/mmc_test.c                        |  8 ++---
 drivers/mmc/core/mmc.c                             |  3 ++
 drivers/mmc/host/dw_mmc.c                          |  2 +-
 drivers/mmc/host/mxs-mmc.c                         |  4 +--
 drivers/mmc/host/sdhci.c                           | 36 ++++++++++++++++------
 6 files changed, 41 insertions(+), 17 deletions(-)
