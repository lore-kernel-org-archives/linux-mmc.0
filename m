From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:07:08 -0800
Message-ID: <8F28F9C1-D154-45A0-9936-2B2749291BBA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41095 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868Ab0LVHLy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 02:11:54 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>


This patch set consists of 23 patches.  

Patches 0001 - 0002 were done to support brownstone but are not yet in the linux-next or mmc-next trees.
0001-ARM-mmp-append-brownstone-support.patch
0002-ARM-mmp-add-mmc-resource-for-sdh-controllers.patch

Patches 0003-0006 fix errors in the existing code or remove options not used (quirks)
0003-sdhci-delete-clk-gating-code-since-not-correct.patch
0004-sdhci-remove-support-for-quirks-in-sdhci-pxa.c-n.patch
0005-Enable-BUS-WIDTH-testing-for-MMC-eMMC-cards.patch
0006-sdhci-ensure-clocks-are-enabled-on-mulitple-control.patch

Patch 0007 allow private registers to be reset on reset --
0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch

Patch 0008-0009 allow f_max to be set -- no option today to this.
0008-sdhci-support-setting-f_max-clock-via-call-back.patch
0009-sdhci-add-platform-support-for-setting-f_max-clock.patch

Patch 0010 extends arch support for multiple SD cards
0010-plat-pxa-add-infrastructure-support-for-multiple-sd.patch

Patch 0011 enables support for PERMANENT cards in the SD layer

Patch 0012 - 0013 adds definitions to enable SD clock adjustments in board file
0012-plat-pxa-Enable-ability-to-adjust-SD-MMC-clocks.patch
0013-mach-mmp-Enable-multiple-platform-support-for-SD-MM.patch

Patch 0014 defines a callback in SD layer to ensure the SD operation is complete
before starting another one

Patch 0015 adds the ability to select the correct CPU chip.  PXA168, PXA910, MMP2.
These are different chips

Patch 0016 SD layer create platform specific files for the 3 SoC PXA168, PXA910, MMP2
MMP2 has been tested.  PXA168 and PXA910 are work in progress but this platform
code has been tested in a slightly different form under Marvell Linux for Aspen and PXA910. 
0016-sdhci-Add-support-PXA168-PXA910-and-MMP2-controll.patch

Patch 0017 arch -- Only show development boards that the SoC chosen supports
previous if say MMP2 was selected development boards for PXA168 and PXA910
could be selected

Patch 0018 -- mmc layer adds support for hardware clock gating
0018-mmc-add-support-for-H-W-clock-gating-of-SD-controll.patch

Patches 0019-0020 extend clock gating support to the SD layer
Patch 0021 adds the support to the platform specific driver for mmp2

Patch 0022 -- fixes a regression found during bus width testing.
Patch 0023 -- extends the clk delay needed by MMP2 when running dual data rate eMMC