From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v5 0/2] mmc: core: hw_reset changes
Date: Fri, 28 Nov 2014 16:56:52 +0100
Message-ID: <1417190214-32181-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:37899 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaK1P5M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 10:57:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routines more generic, by putting the (e)MMC-
specific stuff in the new bus_ops->hw_reset. Simplify them by putting
the functionality required by the mmc_test framework in mmc_test.c

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

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
  mmc: core: let hw_reset default to power_cycle

 drivers/mmc/card/mmc_test.c |   24 +++++++++-----
 drivers/mmc/core/core.c     |   70 ++++++++++++++++--------------------------
 drivers/mmc/core/core.h     |    2 +-
 drivers/mmc/core/mmc.c      |   23 ++++++++++++++
 drivers/mmc/core/mmc_ops.c  |    1 +
 drivers/mmc/core/mmc_ops.h  |    1 -
 include/linux/mmc/core.h    |    5 ++-
 7 files changed, 70 insertions(+), 56 deletions(-)

-- 
1.7.2.5

