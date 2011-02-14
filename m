From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/5] sdhci-pxa.  Mutliple bug fixes/enhancements
Date: Sun, 13 Feb 2011 22:57:48 -0800
Message-ID: <B73D79C3-69A9-4A4B-BA2F-A09AB6DC1D74@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60781 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751847Ab1BNHDB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:03:01 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

Patch set 4/12

[PATCH 1/5] sdhci: sdhci-pxa.c: delete clk gating code - not correct
clock gating is using wrong registers for mmp2 SoC
sdhc-pxa.c is not generic for pxa family.

[PATCH 2/5] sdhci: sdhci-pxa.c ensure clocks are enabled on all SD controllers
Do not rely on u-boot to do the right thing.  It does not.
Do not disable the system clock to the device as this may hang
the system if the register is touched

[PATCH 3/5] sdhci: sdhci-pxa.c enable CAP support for cards marked permanent
eMMC and Wifi cards that are fixed to the board are marked
permanent in the developemnt board files (eg brownstone.c for mmp2)
The platform specific code nows informs the mmc layer about this.

[PATCH 4/5] sdhci: sdhci-pxa.c: Enable BUS WIDTH testing for MMC/eMMC cards
The PXA family of controllers (PXA168/PXA910/MMP2) support CMD14/CMD19
transactions that are used to test the MMC/eMMC bus width for 1, 4, or
8 bits.
Indicate to the mmc layer that it is safe to do bus width testing.

[PATCH 5/5] sdhci: sdhci-pxa.c: Add QUIRKS for DMA/ADMA to match h/w
32 Bit DMA/ADMA Access
32 Bit Size
Support ADMA End Descriptor in current chain
	(no need for dummy entry)