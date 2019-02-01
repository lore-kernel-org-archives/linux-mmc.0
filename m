From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc5
Date: Fri,  1 Feb 2019 10:59:54 +0100
Message-ID: <20190201095954.18273-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.0-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc4

for you to fetch changes up to 3751e008da0df4384031bd66a516c0292f915605:

  mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay (2019-01-28 12:49:28 +0100)

----------------------------------------------------------------
MMC host:
 - mediatek: Fix incorrect register write for tunings
 - bcm2835: Fixup leakage of DMA channel on probe errors

----------------------------------------------------------------
Chaotian Jing (1):
      mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Lukas Wunner (1):
      mmc: bcm2835: Fix DMA channel leak on probe error

 drivers/mmc/host/bcm2835.c | 2 ++
 drivers/mmc/host/mtk-sd.c  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
