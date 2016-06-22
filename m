From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/15] Changes to support 150 MHz eMMC on rk3399
Date: Wed, 22 Jun 2016 17:23:44 +0200
Message-ID: <CAPDyKFpiNu0ASHiDCT1ZXG5Sbb-ei+U3cDins87_PtkvN2g25g@mail.gmail.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36619 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbcFVPXr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 11:23:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so92386302wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 08:23:46 -0700 (PDT)
In-Reply-To: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, groeck@chromium.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Stefan Wahren <stefan.wahren@i2se.com>, zhengxing@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.

On 20 June 2016 at 19:56, Douglas Anderson <dianders@chromium.org> wrote:
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
>
> Changes in v3:
> - Add Brian's PHY patches into my series
> - Add collected tags
> - Add dependency on COMMON_CLK (actually in v2.1) (Guenter Roeck)
> - Use phy_init / phy_exit (Heiko)
> - Add Kishon's Ack
>
> Changes in v2:
> - Drop 170 MHz comment (only applicable to a subtly different Arasan PHY)
> - Indicate that 5.1 ms is calculated (Shawn).
> - Clean up description of rk3399 PHY (Shawn)
> - Add Rob Herring's Ack.
> - Reorder includes (Shawn)
> - Adjust commit message wording (Rob)
> - List out clocks and clock names (Rob)
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
> - Warn if we're more than 15 MHz from ideal rate (Shawn)
> - Fix typo USB => SDHCI (Shawn)
>
> Brian Norris (2):
>   phy: rockchip-emmc: configure default output tap delay
>   phy: rockchip-emmc: reindent the register definitions
>
> Douglas Anderson (11):
>   phy: rockchip-emmc: Increase lock time allowance
>   mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes
>   Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg
>     regs
>   mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
>   arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
>   Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
>   mmc: sdhci-of-arasan: Add ability to export card clock
>   Documentation: phy: Let the rockchip eMMC PHY get an exported card
>     clock
>   phy: rockchip-emmc: Minor code cleanup in
>     rockchip_emmc_phy_power_on/off()
>   phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
>   arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
>
> Shawn Lin (2):
>   phy: rockchip-emmc: give DLL some extra time to be ready
>   phy: rockchip-emmc: configure frequency range and drive impedance
>
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 ++-
>  .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   9 +
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   5 +
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 333 +++++++++++++++++++--
>  drivers/phy/phy-rockchip-emmc.c                    | 216 ++++++++++---
>  6 files changed, 525 insertions(+), 74 deletions(-)
>
> --
> 2.8.0.rc3.226.g39d4020
>

Thanks, applied for next! (Skipped the DTS changes in patch9 and patch
15, as those will be picked up by Heiko).

Kind regards
Uffe
