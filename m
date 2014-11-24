From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v4 0/2] mmc: core: hw_reset changes
Date: Mon, 24 Nov 2014 12:06:36 +0100
Message-ID: <1416827198-29820-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:38362 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbaKXLGw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 06:06:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routines more generic, so we can easily add a
power cycle of SD cards as well. Also simplify the (e)MMC specific
parts of the reset code.

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

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
  mmc: core: turn hw_reset into a bus_ops
  mmc: sd: add hw_reset callback

 drivers/mmc/core/core.c |   56 +++++++++++++++-------------------------------
 drivers/mmc/core/core.h |    5 ++++
 drivers/mmc/core/mmc.c  |   40 +++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd.c   |   13 +++++++++++
 4 files changed, 76 insertions(+), 38 deletions(-)

-- 
1.7.2.5

