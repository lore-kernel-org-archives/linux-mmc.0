From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/4] arm: mach-mmp: Allow correct PXA Selections
Date: Sun, 13 Feb 2011 22:42:14 -0800
Message-ID: <1FB4110A-A461-4F8B-9425-44005824005C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36526 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724Ab1BNGnR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 01:43:17 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>


Patch Set 1/12

a) inconsistent behavior when board is selected and if
menu item is reselected board has disappeard

b) Ability to select options that will not build
	MMP2 and say PXA168

The behavior maps what is done by the mach-omap
(thanks to Anrd Bergmann for his help and suggestions)

Mach-MMP is (as now) the sytem type.  Once selected
the user can then select the SoC on the board and
only the boards that support that SoC are shown.

[PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone and SoC Selection
[PATCH 3/4] arm: configs: update pxa168 defconfig for SoC Selection
[PATCH 4/4] arm: configs: update pxa910 defconfig for SoC Selection

update defconfig to reflect the changes made in Patch 1.