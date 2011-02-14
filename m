From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/2] arm: mach-mmp/plat-pxa: define sd private clock
 registers and use them
Date: Sun, 13 Feb 2011 22:54:57 -0800
Message-ID: <0DCB3728-C0FD-4BD7-99BF-FFB074311075@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33908 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab1BNG5d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 01:57:33 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

[PATCH 0/2] arm: mach-mmp/plat-pxa: define sd private clock
registers and use them.

Patch set 3/12

[PATCH 1/2] plat-pxa: Enable ability to adjust SD/MMC clocks
The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
clock.  This feature is useful and required depending on the board
design.  Add infrastructure to support SD clock tuning.

[PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in brownstone
Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz

