From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 0/6 v3] mmc: tmio: Add SDIO IRQ support
Date: Tue, 28 Dec 2010 23:22:30 +0100
Message-ID: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:52583 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751338Ab0L1WYJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Dec 2010 17:24:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

[PATCH 1/6 v3] mmc: tmio: implement SDIO IRQ
[PATCH 2/6 v3] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
[PATCH 3/6 v3] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
[PATCH 4/6 v3] sh: sh7724 Enable SDIO IRQs
[PATCH 5/6 v3] sh: sh7722 Enable SDIO IRQs
[PATCH 6/6 v3] sh: sh7723 / ap325rxa enable SDIO IRQs

These patches add SDIO IRQ support for the tmio mmc cell
of the sh_mobile_sdhi mfd and activate the usage of
SDIO IRQs on all SoCs where sh_mobile_sdhi is currently
used.

The patchset depends on:
    mmc: tmio_mmc: allow multi-element scatter-gather lists
        https://patchwork.kernel.org/patch/317142/
    mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
        https://patchwork.kernel.org/patch/317162/
    mmc: tmio: merge the private header into the driver
        https://patchwork.kernel.org/patch/349931/
    mmc: tmio: implement a bounce buffer for unaligned DMA
        https://patchwork.kernel.org/patch/349941/

Changes in v3:
- Drop the patch which disables IRQs early in remove
  it caused hangs during rmmod
- Disable device IRQ in tmio_mmc_clk_start/stop to
  avoid spurious SDIO IRQs (previously there was a
  small time window where this could happen)
- Fix a null pointer dereference which would have been
  triggered when spurious SDIO IRQs would have been generated
- Include patch for sh7723 / ap325rx

Changes in v2:
- Add TMIO_MMC_SDIO_IRQ flag, which expresses that  the hardware is known
  to support SDIO IRQ as suggested by Magnus Damm
- Activate this flag for sh_mobile_sdhi
- Add a patch which disables IRQs early in remove
  to avoid spurious SDIO IRQs, during module unload
- Patches 4-6 are unmodified but included for
  completeness

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

