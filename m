From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.15-rc8
Date: Fri, 12 Jan 2018 15:28:22 +0100
Message-ID: <1515767302-8567-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a few trivial MMC fixes intended for v4.15-rc8. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 91516a2a4734614d62ee3ed921f8f88acc67c000:

  mmc: core: apply NO_CMD23 quirk to some specific cards (2017-12-11 13:43:27 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.15-rc2-2

for you to fetch changes up to 2bd7b4aacdb6efa5ccd4749c365c171b884791d2:

  mmc: s3mci: mark debug_regs[] as static (2018-01-04 12:42:31 +0100)

----------------------------------------------------------------
MMC host:
 - s3mci: mark debug_regs[] as static
 - renesas_sdhi: Add MODULE_LICENSE

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: s3mci: mark debug_regs[] as static

Masaharu Hayakawa (1):
      mmc: renesas_sdhi: Add MODULE_LICENSE

 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 drivers/mmc/host/s3cmci.c            | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
