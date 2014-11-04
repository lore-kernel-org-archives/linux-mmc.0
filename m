From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v2 0/4] mmc: core: hw_reset changes
Date: Tue,  4 Nov 2014 16:07:02 +0100
Message-ID: <1415113626-30187-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49596 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663AbaKDPHY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 10:07:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routines more generic, so we can easily add a
power cycle of SD cards as well. Also simplify the (e)MMC specific
parts of the reset code.

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

v2:
 - Call the new bus_ops member hw_reset instead of power_reset
 - Create mmc_set_initial_state and call it from mmc_mmc_hw_reset
   instead of mmc_power_up
 - Keep "mmc_hw_reset" naming

Johan Rudholm (4):
  mmc: core: use mmc_send_status to check hw_reset
  mmc: core: group default initial state
  mmc: core: turn hw_reset into a bus_ops
  mmc: sd: add hw_reset callback

 drivers/mmc/card/mmc_test.c |    3 -
 drivers/mmc/core/core.c     |   99 +++++++++++++-----------------------------
 drivers/mmc/core/core.h     |    5 ++
 drivers/mmc/core/mmc.c      |   37 ++++++++++++++++
 drivers/mmc/core/sd.c       |   13 ++++++
 include/linux/mmc/core.h    |    1 -
 6 files changed, 86 insertions(+), 72 deletions(-)

-- 
1.7.2.5

