From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 0/6 v2] mmc: tmio: Add SDIO IRQ support
Date: Mon, 20 Dec 2010 15:53:45 +0000
Message-ID: <1292860431-16195-1-git-send-email-arnd@arndnet.de>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:34183 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758095Ab0LTQFI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Dec 2010 11:05:08 -0500
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>

[PATCH 1/6 v2] mmc: tmio: implement SDIO IRQ
[PATCH 2/6 v2] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
[PATCH 3/6 v2] mmc: tmio: disable IRQs early in remove
[PATCH 4/6 v2] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
[PATCH 5/6 v2] sh: sh7724 Enable SDIO IRQs
[PATCH 6/6 v2] [RFC] sh: sh7722 Enable SDIO IRQs

These patches add SDIO IRQ support for the tmio mmc cell
of the sh_mobile_sdhi mfd and activate the usage of
SDIO IRQs on all SoCs where sh_mobile_sdhi is currently
used.

Changes since the earlier patchset:
- Add TMIO_MMC_SDIO_IRQ flag, which expresses that  the hardware is known
  to support SDIO IRQ as suggested by Magnus Damm
- Activate this flag for sh_mobile_sdhi
- Add a patch which disables IRQs early in remove
  to avoid spurious SDIO IRQs, during module unload
- Patches 4-6 are unmodified but included for
  completeness

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
