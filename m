From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 03/11] Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs
Date: Sat, 18 Jun 2016 16:15:01 +0200
Message-ID: <1933773.0TPXapTvBs@diego>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-4-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:27 schrieb Douglas Anderson:
> As can be seen in Arasan's datasheet [1] there are several "corecfg"
> settings in their SDHCI IP Block that are supposed to be controlled by
> software.  Although the datasheet referenced is a bit vague about how to
> access corecfg, in Figure 5 you can see that for Arasan's PHY (a
> separate component than their SDHCI component) they describe the
> "phyctrl" registers as being "FROM SOC CTL REG", implying that it's up
> to the licensee of the Arasan IP block to implement these registers.  It
> seems sane to assume that the "corecfg" registers in their SDHCI IP
> block works in a similar way for all licensees of the IP Block.
> 
> Device tree has a model that allows a device to get a reference to
> random registers located elsewhere in the SoC: sysctl.  Let's leverage
> this model and allow adding a sysctl reference to access the control
> registers for the Arasan SDHCI PHYs.
> 
> Having a reference to the control registers doesn't do much for us on
> its own since the Arasan spec doesn't specify how these corecfg values
> are laid out in memory.  In the SDHCI driver we'll need a map detailing
> where each corecfg can be found in each implementation.  This map can be
> found using the primary compatible string of the SDHCI device.  In that
> spirit, document that existing rk3399 device trees already have a
> specific compatible string, though up to now they've always been relying
> on the driver supporting the generic.
> 
> Note that since existing devices seem to work fairly well as-is, we'll
> list the syscon reference as "optional", but it's likely that we'll run
> into much fewer problems if we can actually set the proper values in the
> syscon, so it is strongly suggested that any SoCs where we have a map to
> set the corecfg also include a reference to the syscon.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

I was trying to find public datasheets of other arasan-5.1 users, but wasn't 
sucessful. But I guess this solution should be versatile enough to support the 
implementation on other socs anyway, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
