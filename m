From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v8 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Wed,  5 Mar 2014 09:27:47 +0100
Message-ID: <1394008070-30138-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:53985 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaCEIcg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 03:32:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

Hi Tony,

I had an infinite loop in hsmmc_disable_wake_irq. Since the SDIO
irq is level triggered, I have to disable the IRQ in the handler
otherwise it is called infinitely. 

Did some other minor changes see below.

v8
- rebased on top of Tony Lindgren<tony@atomide.com> changes
  - improved changelog describing the earlier work
  - improved wakeup irq setup
  - works on am3730 es platform now
- my changes on top:
  - compile tested with #undef CONFIG_OF
  - disable wake_irq in handler to prevent infinite loop  
  - fixed typo and added comment about wake-irq

v7
- rebase on 3.14.0-rc3-49726-g77e15ec
- split omap_hsmmc_pin_init due to regression on omap-3730 platform

v6
- rebase on Linux 3.13-rc3
- reformatting debugfs

v5
- fix compile error introduced by last minute one line fix

v4:
- switch to interrupts-extended format
- drop ti,swakeup-missing flag convert to comaptible section

v3:
- removed gpio_irq from platform_data

v2:
- incorparated changes as suggested by reviewers
- simplified workaround for am335x, gpio will now only wake
  the module from runtime suspend, not handle the sdio irq
  itself 

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO interrupt
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++
 drivers/mmc/host/omap_hsmmc.c                      |  337 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 363 insertions(+), 25 deletions(-)

-- 
1.7.10.4

