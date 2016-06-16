From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
Date: Fri, 17 Jun 2016 01:39:55 +0200
Message-ID: <2340840.IUG4rtlpvT@phil>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50413 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbcFPXk0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2016 19:40:26 -0400
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, zhengxing@rock-chips.com, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org, galak@codeaurora.org

Am Montag, 13. Juni 2016, 16:04:24 schrieb Douglas Anderson:
> The theme of this series of patches is to try to allow running the eMMC
> at 150 MHz on the rk3399 SoC, though the changes should still be correct
> and have merit on their own.  The motivation for running at 150 MHz is
> that doing so improves signal integrity and (with some eMMC devices)
> doesn't affect throughput.
> 
> These patches have been structured to keep things as separate as
> possible, but nevertheless there are still some dependencies between
> patches.  It probably makes the most sense for all of the non-device
> tree patches to go through a single tree.  If others agree, perhaps the
> most sane would be to get Acks from PHY maintainers and then to land the
> patches in the MMC tree.  Device tree patches should be able to be
> landed separately and the worst what would happen is a warning in the
> kernel log if you have the code without the device tree.

while my evaluation board does not seem to have an enhanced strobe emmc, it 
nevertheless still runs fine with these patches applied, for the series 
(including the separate v2.1) on a rk3399-evb:

Tested-by: Heiko Stuebner <heiko@sntech.de>
