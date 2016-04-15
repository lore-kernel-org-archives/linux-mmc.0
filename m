From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.6 rc4
Date: Fri, 15 Apr 2016 11:52:07 +0200
Message-ID: <CAPDyKFqmHgfavCacDmW0meqUOTJc8m+VLB1VR2arONaGCJ_8EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Laszlo Fiat <laszlo.fiat@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.6 rc4. It's based on v4.6 rc3.

Regarding the fix for the regression about mmcblk device indexes. The
approach taken to solve the problem seems to be good enough. There
were some discussions around the solution, but it seems like people
were happy about it in the end.

More details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.6-rc3

for you to fetch changes up to 70ad7f7e40af31e7ab4a1719602542856b7ea856:

  mmc: tegra: Disable UHS-I modes for Tegra124 (2016-04-14 11:40:01 +0200)

----------------------------------------------------------------
MMC core:
 - Restore similar old behaviour when assigning mmcblk device indexes

MMC host:
 - tegra: Disable UHS-I modes for Tegra124 to fix regression

----------------------------------------------------------------
Jon Hunter (1):
      mmc: tegra: Disable UHS-I modes for Tegra124

Ulf Hansson (1):
      mmc: block: Use the mmc host device index as the mmcblk device index

 drivers/mmc/card/block.c       | 18 +-----------------
 drivers/mmc/host/sdhci-tegra.c | 10 +---------
 2 files changed, 2 insertions(+), 26 deletions(-)
