From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc8
Date: Fri,  6 Sep 2019 12:21:37 +0200
Message-ID: <20190906102137.637-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.3-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc7

for you to fetch changes up to 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d:

  Revert "mmc: core: do not retry CMD6 in __mmc_switch()" (2019-09-03 16:53:28 +0200)

----------------------------------------------------------------
MMC core:
 - Fix card init for some eMMCs that need retries for CMD6

----------------------------------------------------------------
Jan Kaisrlik (1):
      Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
