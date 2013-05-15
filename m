From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [RESEND PATCH v2 0/3] omap_hsmmc: SDIO IRQ on AM335x family
Date: Wed, 15 May 2013 10:45:13 +0200
Message-ID: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:53296 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab3EOIp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 May 2013 04:45:27 -0400
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MKOUK-1Ud5ZD3SNS-001jlr for
 <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 10:45:25 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

No changes to the patches itself.

Only the dependency on some omap-gpio enable_irq/disable_irq patch
has been removed.

While developing, I was struck by a bug with disable_irq. After reviewing
the disable_irq code path, I thought the interrrupt got never disabled
for omap.  After fixing the bug I was hunting, which was completely
unrelated to disable_irq, I never verified if the dependency was really
needed.

While trying to upstream my disable_irq fixes for gpio-omap, I realized,
that disable_irq was always working for gpio-omap through the generic
lazy disable mechanism.

/**
 *      irq_disable - disable interrupt generation
 *      @desc:  irq descriptor which should be disabled
 *
 *      If the chip does not implement the irq_disable callback, we
 *      use a lazy disable approach. That means we mark the interrupt
 *      disabled, but leave the hardware unmasked. If an interrupt
 *      happens, then the interrupt flow handler masks the line at the
 *      hardware level and marks it pending.
 */
void irq_disable(struct irq_desc *desc)
{
        irq_state_set_disabled(desc);
        if (desc->irq_data.chip->irq_disable) {
                desc->irq_data.chip->irq_disable(&desc->irq_data);
                irq_state_set_masked(desc);
        }
}

The 4+ weeks testing mentionned in the 1st patch, was done with a
dedicated irq_disable hook in gpio-omap. I'm positive that it is not
needed at all, still the test was repeated for 1 day without that hook.

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

