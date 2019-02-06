From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/3] mmc: core: Add SD Discard support
Date: Wed,  6 Feb 2019 13:28:04 +0200
Message-ID: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
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

V1->v2:
In the first patch, assign the discard arg for SD cards as well to keep
the code consistent. Rename "discard_arg" to "erase_arg", and elaborate
the change log.


Avri Altman (3):
  mmc: core: Calculate the discard arg only once
  mmc: core: Indicate SD specs higher than 4.0
  mmc: core: Add discard support to sd

 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/core.c  |  8 ++++++--
 drivers/mmc/core/mmc.c   |  8 ++++++++
 drivers/mmc/core/sd.c    | 15 +++++++++++++++
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/sd.h   |  6 ++++++
 6 files changed, 41 insertions(+), 11 deletions(-)

-- 
1.9.1
