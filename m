From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fix for v.4.8 rc8
Date: Fri, 23 Sep 2016 12:28:10 +0200
Message-ID: <CAPDyKFrKQJyXbRBvmLT3esGjUdFA9GiQuZQ2oeL=TommFG4v2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's is yet another mmc fix, intended for v4.8 rc8. It's based on v4.8-rc7.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3be7988674ab33565700a37b210f502563d932e6:

  Linux 4.8-rc7 (2016-09-18 17:27:41 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.8-rc7

for you to fetch changes up to 005d675aa1909ad70456dec8c5b0ba9b60b52d24:

  mmc: dw_mmc: fix the spamming log message (2016-09-22 09:34:13 +0200)

----------------------------------------------------------------
MMC host:
 - dw_mmc: fix the spamming log message

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: fix the spamming log message

 drivers/mmc/host/dw_mmc.c | 14 +++++++++-----
 drivers/mmc/host/dw_mmc.h |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)
