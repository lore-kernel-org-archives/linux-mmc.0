From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 0/15] Changes to support 150 MHz eMMC on rk3399
Date: Mon, 20 Jun 2016 20:17:02 +0200
Message-ID: <1805593.i4NJUkPJQz@diego>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:40532 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbcFTSRS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2016 14:17:18 -0400
In-Reply-To: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, mark.rutland@arm.com, catalin.marinas@arm.com, linus.walleij@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, wsa+renesas@sang-engineering.com, stefan.wahren@i2se.com, zhengxing@rock-chips.com, michal.simek@xilinx.com, geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, horms+renesas@verge.net.au, soren.brinkmann@xilinx.com, andrei.pistirica@microchip.com, ludovic.desroches@atmel.com, galak@codeaurora.org, yangbo.lu@freescale.com

Am Montag, 20. Juni 2016, 10:56:39 schrieb Douglas Anderson:
> The theme of this series of patches is to try to allow running the eMMC
> at 150 MHz on the rk3399 SoC, though the changes should still be correct
> and have merit on their own.  The motivation for running at 150 MHz is
> that doing so improves signal integrity and (with some eMMC devices)
> doesn't affect throughput.
> 
> These patches have been structured to keep things as separate as
> possible, but nevertheless there are still some dependencies between
> patches.  It probably makes the most sense for all of the non-device
> tree patches to go through a single tree.  PHY patches now have Acks
> from Kishon so that means things should be clear for all non-DTS patches
> to go through the MMC tree if Ulf agrees.  Device tree patches should be
> able to be landed separately and the worst what would happen is a
> warning in the kernel log if you have the code without the device tree.
> 
> The code patches are based on Ulf's mmc-next.  In v3 of the series I've
> pulled in the latest version of a previous PHY series posted by Brian
> Norris.
> 
> The device tree patches are based on Heiko's v4.8-armsoc/dts64.

just so it doesn't get lost from v2->v3, I plan on picking up the dts patches 
9 and 15 after the rest landed in the mmc tree - as they will only apply on 
top of my general dts branch.


Heiko
