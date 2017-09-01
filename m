From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc8
Date: Fri, 1 Sep 2017 13:20:16 +0200
Message-ID: <CAPDyKFr8pOpNGG2r1fhEd1BJtg3a=YnYq2GNLtGY-1sYZsSMYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are two more mmc fixes intended for v4.13-rc8.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit cc4a41fe5541a73019a864883297bd5043aa6d98:

  Linux 4.13-rc7 (2017-08-27 17:20:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13-rc7

for you to fetch changes up to 99c14fc360dbbb583a03ab985551b12b5c5ca4f1:

  mmc: sdhci-xenon: add set_power callback (2017-08-30 14:11:47 +0200)

----------------------------------------------------------------
MMC core:
 - Fix block status codes

MMC host:
 - sdhci-xenon: Fix SD bus voltage select

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix block status codes

Zhoujie Wu (1):
      mmc: sdhci-xenon: add set_power callback

 drivers/mmc/core/block.c       |  6 +++---
 drivers/mmc/host/sdhci-xenon.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)
