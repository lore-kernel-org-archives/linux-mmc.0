From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Mon, 25 Nov 2013 14:26:46 +0100
Message-ID: <1385386009-14981-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:36936 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab3KYN3d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Nov 2013 08:29:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

v3:
- removed gpio_irq from platform_data

v2:
- incorparated changes as suggested by reviewers
- simplified workaround for am335x, gpio will now only wake
  the module from runtime suspend, not handle the sdio irq
  itself 

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ.
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x.
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 +++
 drivers/mmc/host/omap_hsmmc.c                      |  303 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 324 insertions(+), 22 deletions(-)

-- 
1.7.10.4

