From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/5] arm: mach-mmp: mmp-pxa168-mmp2-multiple SD cards
Date: Sun, 13 Feb 2011 22:48:35 -0800
Message-ID: <B3A532AD-2197-4FED-AA51-2CE7C364F3A7@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51890 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751313Ab1BNGvm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 01:51:42 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

Support multiple sd/eMMC interfaces and PXA168 and MMP2 (brownstone)

Patch set 2/12


[PATCH 1/5] arm: mach-mmp: SDH register definitions for (pxa168, pxa910, mmp2)
Register definitions added for APMU registers for all platforms
Definitions are platform dependent (not same for pxa168, pxz910, mmp2).

[PATCH 2/5] arm: mach-mmp: mmp2.c uses revised APMU registers
defines for APMU_CLK_OPS

[PATCH 3/5] plat-pxa: sdhci.h define for PERMANENT SD/eMMC/SDIO cards

[PATCH 4/5] mach-mmp: PXA168: support multiple SD controllers
add support for pxa168 family for multiple sd controllers
move board specific settings from mfp-pxa168.h to aspenite.c

[PATCH 5/5] arm: mach-mmp: brownstone.c support multiple sd slots

Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
mmc1 is used for Wifi and slot is marked PERMANENT

Note: eMMC (mmc2) is set to initialize first to workaround a problem
where booting in logical order requires mmc create work queue
to be multi-threaded otherwise boot process hangs.  BUG report
send to linux-mmc and linux-kernel mailing list.