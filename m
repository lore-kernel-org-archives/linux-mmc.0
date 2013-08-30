From: "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH V2 0/7] Add password protected lock/unlock support for
 SD/MMC
Date: Fri, 30 Aug 2013 16:14:18 -0400
Message-ID: <1377893665-26754-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3341 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab3H3UPi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Aug 2013 16:15:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Al Cooper <alcooperx@gmail.com>

This set of patches adds support for password protected locking
and unlocking of MMC and SD devices. It uses the LOCK/UNLOCK command
(CMD42) available in both the MMC and SD command sets.

Some of this code was based on a patch set submitted in 2006 by
Anderson Briglia "Add MMC Password Protection (lock/unlock)". This
patch set never made it into mainline. 

By default, a card with no password assigned is always in "unlocked"
state. After password assignment, in the next power cycle the card
switches to a "locked" state where only the "basic" and "lock card"
command classes are accepted by the card. Only after unlocking it with
the correct password can the card be used for normal operations like
block I/O.

Password management and caching is done through the "Kernel Key
Retention Service" mechanism and the sysfs filesystem. Two new sysfs
attributes were added. The "lock" attribute is used to lock, unlock,
assign a password, clear a password and force erase a card. The
"unlock_retry" attribute is used to retry an unlock that failed
during boot because the rootfs was not yet available with the password.

Changed for V2:
The V2 changes were not functional and were just general cleanup.
  - Use stub functions to reduce the number of CONFIG ifdefs.
  - Add static to a few functions that were local.
  - Use pr_warn instead of pr_warning.
  - Improve a few variable names and messages.

Al Cooper (7):
  mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
  mmc: lock: Add low level LOCK_UNLOCK command
  mmc: lock: Add function to unlock a password locked card
  mmc: lock: Add card lock/unlock maintenance commands
  mmc: lock: Change SD init functionality to handle locked SD cards
  mmc: lock: Prevent partition table read for locked cards.
  mmc: lock: Change MMC init to handle locked cards.

 drivers/mmc/card/block.c   |   7 +++
 drivers/mmc/core/Kconfig   |   8 +++
 drivers/mmc/core/core.c    | 131 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h    |  15 ++++-
 drivers/mmc/core/mmc.c     | 123 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c | 112 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |  13 +++++
 drivers/mmc/core/sd.c      | 134 +++++++++++++++++++++++++++++++++------------
 include/linux/mmc/card.h   |   6 ++
 9 files changed, 512 insertions(+), 37 deletions(-)

-- 
1.8.1.3


