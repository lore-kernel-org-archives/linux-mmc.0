From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v2 0/3] omap_hsmmc: SDIO IRQ on AM335x family
Date: Fri, 12 Apr 2013 14:38:24 +0200
Message-ID: <1365770307-19859-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51253 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304Ab3DLMil (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 08:38:41 -0400
Received: from mailout-de.gmx.net ([10.1.76.1]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MSFoz-1TyyQl2qNP-00TQI4 for
 <linux-mmc@vger.kernel.org>; Fri, 12 Apr 2013 14:38:40 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

This is a resend of an earlier patch
http://comments.gmane.org/gmane.linux.ports.arm.omap/90381

It's rebased against Linux 3.9-rc6 / 31880c37c11e28cb8
Main changes are two bug fixes. Also did lots of testing.

Fixes are a race condition during suspend and the gpio
irq being disabled unintendedly.

The gpio irq is managed via the 'disable_depth' ref counter of
the irq subsystem, driver simply call enable_irq/disable_irq when
needed.

                      sdio irq    sdio irq
                      unmasked     masked
   -----------------------------------------
    runtime suspend  |    0     |   1
    runtime default  |    1     |   2

               irq disable depth


only when sdio irq is enabled AND module is idle, the ref drops
to zero and the gpio irq is effectively armed.

problem was that omap_hsmmc_enable_sdio_irq(.. disable)
was called when the irq was already disabled. This corrupted
the ref count. Another issue was to ensure that the ref count
starts with the right initial value (2).

I did quite some duration testing. Test setup is two sdio wifi
cards, running iperf as server/client. Test is running for 8+
days now, still running.

# cat /sys/kernel/debug/mmc0/regs                        
[snip]
pinmux config   sdio
sdio irq        enabled
pm suspends     19993594

So there had been ~20 Mio sdio to gpio pinmux transitions.

Without enabling the pinmux toggling in the dts file, there is no
functional change. The driver will use polling as it does now.
If you want to enable it, you also need to implement
enable_irq/disable_irq for omap chips.

https://patchwork.kernel.org/patch/1886421/
http://permalink.gmane.org/gmane.linux.ports.arm.omap/97093


/Andi


Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle mode.
  mmc: omap_hsmmc: debugfs entries for GPIO mode.
  mmc: omap_hsmmc: add PSTATE to debugfs regs_show.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 +++
 drivers/mmc/host/omap_hsmmc.c                      |  269 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    4 +
 3 files changed, 294 insertions(+), 21 deletions(-)

-- 
1.7.10.4

