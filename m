From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/2] mmc: core: Add SD Discard support
Date: Tue, 26 Feb 2019 17:10:23 +0200
Message-ID: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands matches those
in eMMC, Which leaves to set the appropriate discard arg in CMD38 if
DISCARD_SUPPORT (b313) is set in the SD_STATUS register.

We set this arg on card init: not in mmc_init_erase as one might expect
but arbitrarily once the card indicated its discard support.  This is
because unlike erase, it doesn't really involve any logic, and we want
to avoid the unnecessary complication.

V2->v3:
The first 2 patches in the series got accepted.
Elaborate the changelog of some of the differences between discard and
erase. Clean some inconsistency in arg checking in mmc_erase().
Add a patch to set the timeout for sd discard.

V1->v2:
In the first patch, assign the discard arg for SD cards as well to keep
the code consistent. Rename "discard_arg" to "erase_arg", and elaborate
the change log.


Avri Altman (2):
  mmc: core: Add discard support to sd
  mmc: core: Add sd discard timeout

 drivers/mmc/core/core.c | 15 +++++++++++----
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.9.1
