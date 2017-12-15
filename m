From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.15-rc4
Date: Fri, 15 Dec 2017 17:32:18 +0100
Message-ID: <1513355538-31655-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.15-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.15-rc2

for you to fetch changes up to 91516a2a4734614d62ee3ed921f8f88acc67c000:

  mmc: core: apply NO_CMD23 quirk to some specific cards (2017-12-11 13:43:27 +0100)

----------------------------------------------------------------
MMC core:
 - Fix use of uninitialized drv_typ variable
 - Apply NO_CMD23 quirk to some specific SD cards to make them work

----------------------------------------------------------------
Christoph Fritz (1):
      mmc: core: apply NO_CMD23 quirk to some specific cards

Wolfram Sang (1):
      mmc: core: properly init drv_type

 drivers/mmc/core/card.h   | 2 ++
 drivers/mmc/core/mmc.c    | 2 +-
 drivers/mmc/core/quirks.h | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)
