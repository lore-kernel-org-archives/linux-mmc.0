From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v6 0/2] mmc: core: hw_reset changes
Date: Fri,  9 Jan 2015 12:08:17 +0100
Message-ID: <1420801699-6274-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:34728 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756612AbbAILI2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Jan 2015 06:08:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routine more generic, by putting the (e)MMC-
specific stuff in the new bus_ops->hw_reset in mmc.c. Add a
bus_ops->hw_reset for SD cards, allowing them to be restarted when
errors occur.

Always check if the reset was sucessful and propagate this to the
caller.

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

v6:
 - Always perform the mmc_send_status reset check, which allows us to
   have only one interface to the card reset functions
 - Because of this, add the bus_ops->hw_reset to sd.c instead of
   falling back to a power_cycle

v5:
 - Move the mmc_test-specific code to mmc_test.c
 - Fall back to a power_cycle if the bus_ops->hw_reset is missing
 - Because of this, skip the bus_ops->hw_reset in sd.c

v4:
 - Rebase onto next

v3:
 - Keep mmc_can_reset
 - Always set bus_mode = MMC_BUSMODE_PUSHPULL in mmc_set_initial_state()

v2:
 - Call the new bus_ops member hw_reset instead of power_reset
 - Create mmc_set_initial_state and call it from mmc_mmc_hw_reset
   instead of mmc_power_up
 - Keep "mmc_hw_reset" naming

Johan Rudholm (2):
  mmc: core: refactor the hw_reset routines
  mmc: sd: add hw_reset callback

 drivers/mmc/card/mmc_test.c |   18 ++++-------
 drivers/mmc/core/core.c     |   70 +++++++++++++++----------------------------
 drivers/mmc/core/core.h     |    1 +
 drivers/mmc/core/mmc.c      |   32 +++++++++++++++++++
 drivers/mmc/core/sd.c       |    7 ++++
 include/linux/mmc/core.h    |    1 -
 6 files changed, 71 insertions(+), 58 deletions(-)

-- 
1.7.2.5

