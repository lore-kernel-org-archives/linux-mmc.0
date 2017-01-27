From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc6
Date: Fri, 27 Jan 2017 09:46:50 +0100
Message-ID: <CAPDyKFo2NBzBCw273ckEo_Guwqx=frpRgoUjhJc7tB9PMs_KHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's one mmc fix intended for v4.10 rc6. Based on v4.10-rc5.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-rc5

for you to fetch changes up to e9748e0364fe82dc037d22900ff13a62d04518bf:

  mmc: dw_mmc: force setup bus if active slots exist (2017-01-23 10:19:30 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Fix runtime PM resume path

----------------------------------------------------------------
Ziyuan Xu (1):
      mmc: dw_mmc: force setup bus if active slots exist

 drivers/mmc/host/dw_mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
