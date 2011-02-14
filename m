From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/1] sdhci: Add support PXA168, PXA910, and MMP2 controllers
Date: Sun, 13 Feb 2011 23:23:37 -0800
Message-ID: <4C169F7B-5950-4E3C-8B7D-A7C1E3EB3125@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59161 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751994Ab1BNH1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:27:42 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

Patch set 12 of 12

The current sdhci-pxa code is only useful for MMP2.  It does not
work on other PXA controllers.  Factor out the common code
and define 3 SoC specific files that control the SD hardware.

Take into account that while the PXA910 and PXA168 controllers
are similar they have different quirks due to hardware differences.

MMP2 is different since it is based on the SD 3.0 controller spec
while the other 2 SoC are based on SD 2.0 spec with SoC specific
extensions.


[PATCH] sdhci: Add support PXA168, PXA910, and MMP2 controllers

Select pxa controller based on CPU model: MMP2, PXA168, PXA910

Three new SoC specific files added:
sdhci-pxa168.c
sdhci-pxa910.c
sdhci-mmp2.c

These files control the platform specific behavior of the SD controller.
MMP2 and the PXAxxx controllers use different hardware registers
to control platform specific behavior. Platform flags come from
arch/mach-mmp/ files for board design (brownstone, jasper, aspenite etc)
settings (8 bit capable slot / card permanent).

quirks for SD/SoC specific behaviro defined in specific platform files
(sdhci-pxa168.c, sdhci-pxa910.c, sdhci-mmp2.c)

The correct SD controller is now shown Kconfig.

sdhci-pxa.c changed to act as a shim for the platform specific code.
Only generic operations are handled in sdhci-pxa.c. All
platform operations are passed to the platform code.

reset_enter() and reset_exit() used for silicon control.

