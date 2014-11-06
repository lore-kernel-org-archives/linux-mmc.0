From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v3 0/3] mmc: core: hw_reset changes
Date: Thu,  6 Nov 2014 14:46:53 +0100
Message-ID: <1415281616-24661-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:35102 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaKFNrv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 08:47:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routines more generic, so we can easily add a
power cycle of SD cards as well. Also simplify the (e)MMC specific
parts of the reset code.

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

Please have a look at the handling of bus_mode in
mmc_set_initial_state(), we set it to MMC_BUSMODE_PUSHPULL also when
powering off a device. If this is not OK, we'll just have to leave
bus_mode out of it.

v3:
 - Keep mmc_can_reset
 - Always set bus_mode = MMC_BUSMODE_PUSHPULL in mmc_set_initial_state()

v2:
 - Call the new bus_ops member hw_reset instead of power_reset
 - Create mmc_set_initial_state and call it from mmc_mmc_hw_reset
   instead of mmc_power_up
 - Keep "mmc_hw_reset" naming

Johan Rudholm (3):
  mmc: core: consistent handling of initial values
  mmc: core: turn hw_reset into a bus_ops
  mmc: sd: add hw_reset callback

 drivers/mmc/core/core.c |   99 ++++++++++++++++++-----------------------------
 drivers/mmc/core/core.h |    6 +++
 drivers/mmc/core/mmc.c  |   40 +++++++++++++++++++
 drivers/mmc/core/sd.c   |   13 ++++++
 4 files changed, 97 insertions(+), 61 deletions(-)

-- 
1.7.2.5

