From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/6] mmc: omap_hsmmc: simplify cover/card detect logic
Date: Tue,  3 Mar 2015 13:28:12 +0100
Message-ID: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34899 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbCCM2c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Mar 2015 07:28:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>

These patches are trying to clean up the cover/card detect logic.

  Mobile phones (some) have no card detect pin, but
  can detect if the cover is removed. The purpose is the
  same; detect if card is being added/removed, but the
  details differ.
  When the cover is removed, it does not mean the card is
  gone. But it might, since it is accessible now. It's like
  a warning. All the driver does is to limit write access to
  the card, see protect_card flag. In contrast, card detect
  notifies us after the fact, e.g. card is gone, card is
  inserted.

While cover detect is only used by one platform (rx51), it
complicates the card detect logic. By separating the code
paths they both become easier to understand and maintain 

Patches have been tested by reverting: 95bebb5696ab
'mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration'
otherwise gpio detection is handled by mmc_of_parse

compile tested
OMAP2:
CONFIG_MACH_OMAP2_TUSB6010=y
CONFIG_MACH_OMAP3_BEAGLE=y
CONFIG_MACH_DEVKIT8000=y
CONFIG_MACH_OMAP_LDP=y
CONFIG_MACH_OMAP3530_LV_SOM=y
CONFIG_MACH_OMAP3_TORPEDO=y
CONFIG_MACH_OVERO=y
CONFIG_MACH_OMAP3517EVM=y
CONFIG_MACH_CRANEBOARD=y
CONFIG_MACH_OMAP3_PANDORA=y
CONFIG_MACH_TOUCHBOOK=y
CONFIG_MACH_OMAP_3430SDP=y
CONFIG_MACH_NOKIA_N810=y
CONFIG_MACH_NOKIA_N810_WIMAX=y
CONFIG_MACH_NOKIA_N8X0=y
CONFIG_MACH_NOKIA_RX51=y
CONFIG_MACH_CM_T35=y
CONFIG_MACH_CM_T3517=y
CONFIG_MACH_CM_T3730=y
CONFIG_MACH_SBC3530=y
CONFIG_MACH_TI8168EVM=y
CONFIG_MACH_TI8148EVM=y

Andreas Fenkart (6):
  mmc: omap_hsmmc: remove unused fields from struct omap_hsmmc_host
  mmc: omap_hsmmc: use slot-gpio functions to manage read-only pin
    directly
  mmc: omap_hsmmc: use distinctive code paths for cover / card detect
    logic
  ARM: OMAP2: HSMMC: platform_data: explicit gpio_cover / gpio_cd fields
  mmc: omap_hsmmc: simplify card/cover detect isr
  mmc: omap_hsmmc: use generic slot-gpio isr to manage card detect pin

 arch/arm/mach-omap2/hsmmc.c              | 33 +++++++++----
 drivers/mmc/host/omap_hsmmc.c            | 80 +++++++++-----------------------
 include/linux/platform_data/hsmmc-omap.h |  6 +--
 3 files changed, 48 insertions(+), 71 deletions(-)

-- 
2.1.4

