From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.10 - take 2/2
Date: Wed, 14 Dec 2016 10:47:25 +0100
Message-ID: <CAPDyKFpmyBcGk0zzZuAvVGLTT_giuYeVdUfB7sf+r4FVvS7uAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a second PR for MMC for v4.10.

As a matter of fact it's only one change that moves some mmc files
around. I thought it was a good idea to get this into v4.10, as it
gives us a nice and fresh base for v4.11.

Details are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ff6af28faff53a7389230026b83e543385f7b21d:

  mmc: sdhci-cadence: add Cadence SD4HC support (2016-12-08 15:02:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-2

for you to fetch changes up to f397c8d80a5e413984bd9ccdf4161c7156b365ce:

  mmc: block: Move files to core (2016-12-12 16:30:05 +0100)

----------------------------------------------------------------
MMC core:
 - Move files from the card directory to the core directory to enable
   future clean-ups of the generic mmc header files and interfaces.

----------------------------------------------------------------
Ulf Hansson (1):
      mmc: block: Move files to core

 drivers/mmc/Kconfig                    |  2 -
 drivers/mmc/Makefile                   |  1 -
 drivers/mmc/card/Kconfig               | 70 ----------------------------------
 drivers/mmc/card/Makefile              | 10 -----
 drivers/mmc/core/Kconfig               | 66 ++++++++++++++++++++++++++++++++
 drivers/mmc/core/Makefile              |  4 ++
 drivers/mmc/{card => core}/block.c     |  0
 drivers/mmc/{card => core}/block.h     |  0
 drivers/mmc/{card => core}/mmc_test.c  |  2 -
 drivers/mmc/{card => core}/queue.c     |  2 -
 drivers/mmc/{card => core}/queue.h     |  0
 drivers/mmc/{card => core}/sdio_uart.c |  2 +-
 12 files changed, 71 insertions(+), 88 deletions(-)
 delete mode 100644 drivers/mmc/card/Kconfig
 delete mode 100644 drivers/mmc/card/Makefile
 rename drivers/mmc/{card => core}/block.c (100%)
 rename drivers/mmc/{card => core}/block.h (100%)
 rename drivers/mmc/{card => core}/mmc_test.c (99%)
 rename drivers/mmc/{card => core}/queue.c (99%)
 rename drivers/mmc/{card => core}/queue.h (100%)
 rename drivers/mmc/{card => core}/sdio_uart.c (99%)
