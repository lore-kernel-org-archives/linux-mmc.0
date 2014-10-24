From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH 0/4] mmc: core: hw_reset changes
Date: Fri, 24 Oct 2014 14:46:26 +0200
Message-ID: <1414154790-20893-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49504 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756460AbaJXMrI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Oct 2014 08:47:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Make the mmc_hw_reset routines more generic, so we can easily add a
power cycle of SD cards as well. Also simplify the (e)MMC specific
parts of the reset code.

As I don't have an eMMC device myself, much less one with a reset line,
I'd be very happy if someone could help me test the code with an eMMC?

Johan Rudholm (4):
  mmc: core: use mmc_send_status to check hw_reset
  mmc: core: use mmc_power_up in hw_reset
  mmc: core: make hw_reset generic
  mmc: sd: add power_reset callback

 drivers/mmc/card/block.c    |    2 +-
 drivers/mmc/card/mmc_test.c |    5 +--
 drivers/mmc/core/core.c     |   73 ++++++++-----------------------------------
 drivers/mmc/core/core.h     |    4 ++
 drivers/mmc/core/mmc.c      |   40 +++++++++++++++++++++++
 drivers/mmc/core/sd.c       |   16 +++++++++
 include/linux/mmc/core.h    |    5 +--
 7 files changed, 77 insertions(+), 68 deletions(-)

-- 
1.7.2.5

