From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.12 rc3 - take 1/2
Date: Wed, 24 May 2017 10:40:41 +0200
Message-ID: <CAPDyKFppbduFunKcU64Cx3Die=XGb3VNR+1Qkm17QBXhAXq6nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.12 rc3. They are based
on v4.12-rc1.

If everything goes as expected, I intend to send yet another PR later
this week with some more fixes, hence take 1/2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc1

for you to fetch changes up to f5f968f2371ccdebb8a365487649673c9af68d09:

  mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read
(2017-05-22 18:18:04 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-xenon: Don't free data for phy allocated by devm*
 - sdhci-iproc: Suppress spurious interrupts
 - cavium: Fix probing race with regulator
 - cavium: Prevent crash with incomplete DT
 - cavium-octeon: Use proper GPIO name for power control
 - cavium-octeon: Fix interrupt enable code

----------------------------------------------------------------
David Daney (2):
      mmc: cavium-octeon: Fix interrupt enable code
      mmc: cavium-octeon: Use proper GPIO name for power control

Jan Glauber (3):
      mmc: cavium: Prevent crash with incomplete DT
      of/platform: Make of_platform_device_destroy globally visible
      mmc: cavium: Fix probing race with regulator

Jisheng Zhang (1):
      mmc: sdhci-xenon: kill xenon_clean_phy()

Srinath Mannam (1):
      mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read

 drivers/mmc/host/cavium-octeon.c   | 15 ++++++++++++---
 drivers/mmc/host/cavium-thunderx.c |  6 ++++++
 drivers/mmc/host/cavium.c          | 25 ++++++++++---------------
 drivers/mmc/host/sdhci-iproc.c     |  3 ++-
 drivers/mmc/host/sdhci-xenon-phy.c | 14 +-------------
 drivers/mmc/host/sdhci-xenon.c     |  6 +-----
 drivers/mmc/host/sdhci-xenon.h     |  1 -
 drivers/of/platform.c              |  3 ++-
 include/linux/of_platform.h        |  1 +
 9 files changed, 35 insertions(+), 39 deletions(-)
