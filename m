From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.16-rc2
Date: Sat, 17 Feb 2018 11:07:44 +0100
Message-ID: <1518862064-26269-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.16-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16-rc1

for you to fetch changes up to 118032be389009b07ecb5a03ffe219a89d421def:

  mmc: bcm2835: Don't overwrite max frequency unconditionally (2018-02-14 11:30:10 +0100)

----------------------------------------------------------------
MMC host:
 - meson-gx: Revert to earlier tuning process
 - bcm2835: Don't overwrite max frequency unconditionally

----------------------------------------------------------------
Jerome Brunet (1):
      Revert "mmc: meson-gx: include tx phase in the tuning process"

Phil Elwell (1):
      mmc: bcm2835: Don't overwrite max frequency unconditionally

 drivers/mmc/host/bcm2835.c      |  3 ++-
 drivers/mmc/host/meson-gx-mmc.c | 19 +------------------
 2 files changed, 3 insertions(+), 19 deletions(-)
