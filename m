From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.7 final
Date: Wed, 20 Jul 2016 10:06:27 +0200
Message-ID: <CAPDyKFpGvvYBDgkrLTCgBeS=7PAGhXizh3iu3AqPsmuHJHjS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a few late mmc fixes intended for v4.7 final. They are based
on v4.7-rc7.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 92d21ac74a9e3c09b0b01c764e530657e4c85c49:

  Linux 4.7-rc7 (2016-07-10 20:24:59 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.7-rc7

for you to fetch changes up to b3802db5eb72d2a96f4aa4ff0abb937033df2acf:

  mmc: pxamci: fix potential oops (2016-07-18 11:50:40 +0200)

----------------------------------------------------------------
MMC core:
 - Fix eMMC packed command header endianness
 - Fix free of uninitialized buffer for mmc ioctl

MMC host:
 - pxamci: Fix potential oops in ->probe()

----------------------------------------------------------------
Robert Jarzmik (1):
      mmc: pxamci: fix potential oops

Taras Kondratiuk (1):
      mmc: block: fix packed command header endianness

Ville Viinikka (1):
      mmc: block: fix free of uninitialized 'idata->buf'

 drivers/mmc/card/block.c  | 16 +++++++++-------
 drivers/mmc/host/pxamci.c | 16 +++++++++-------
 2 files changed, 18 insertions(+), 14 deletions(-)
