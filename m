From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH 0/3] Signal voltage switch procedure for UHS mode
Date: Fri, 7 Dec 2012 17:19:33 +0100
Message-ID: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:35058 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422842Ab2LGQjl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 11:39:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Johan Rudholm <johan.rudholm@stericsson.com>

This patch series attempts to make the 1.8V signal voltage switch
required for UHS mode work according to the SD specification.

These patches have been tested with a couple of UHS SD cards, one of
which sometimes requires up to five power cycles before it accepts the
signal voltage switch. The patches have also been tested with various
other SD cards, as well as one SDIO WLAN chip (cw1200) to check
for regressions. The patches have also been tested with
CONFIG_MMC_CLKGATE.

As usual, I'd be very grateful if someone could help me test this patch
with an UHS SDIO card and perhaps also a combo card (which does seem to
be rare these days?)?

This patch series is based on previous RFC/patch:

[RFC/PATCH v2] mmc: core: Fixup signal voltage switch

Changelog:
	v2 -> This patch series
	- Removed the extra argument to the card_busy host_ops function
	- Added mmc_power_cycle
	- Some clarifying comments
	v1 -> v2
	- Removed reset of signal voltage in mmc_sd_get_cid, since
	  "mmc: core: reset signal voltage on power up"
	previous two patches -> v1:
	- Keep calls to mmc_host_clk_hold / mmc_host_clk_release
	- Add retry-loop / power cycle in sdio.c
	- Fall back to 3.3 V if the switch repeatedly fails
	- Add an extra argument to the card_busy host_ops function,
	  which can be used to signal polling use of the function

Johan Rudholm (3):
  mmc: core: Add mmc_power_cycle
  mmc: core: Add card_busy to host_ops
  mmc: core: Fixup signal voltage switch

 drivers/mmc/core/core.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/sd.c    |   26 +++++++++++++++++++++-----
 drivers/mmc/core/sdio.c  |   25 +++++++++++++++++++++++--
 include/linux/mmc/host.h |    3 +++
 5 files changed, 91 insertions(+), 7 deletions(-)

-- 
1.7.10

