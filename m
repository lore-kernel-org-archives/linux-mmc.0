From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 14/15] phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
Date: Mon, 20 Jun 2016 20:14:52 +0200
Message-ID: <2890767.K8G0sjVPM4@diego>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org> <1466445414-11974-15-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466445414-11974-15-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 20. Juni 2016, 10:56:53 schrieb Douglas Anderson:
> The "phyctrl_frqsel" is described in the Arasan datasheet [1] as "the
> frequency range of DLL operation".  Although the Rockchip variant of
> this PHY has different ranges than the reference Arasan PHY it appears
> as if the functionality is similar.  We should set this phyctrl field
> properly.
> 
> Note: as per Rockchip engineers, apparently the "phyctrl_frqsel" is
> actually only useful in HS200 / HS400 modes even though the DLL itself
> it used for some purposes in all modes.  See the discussion in the
> earlier change in this series: ("mmc: sdhci-of-arasan: Always power the
> PHY off/on when clock changes").  In any case, it shouldn't hurt to set
> this always.
> 
> Note that this change should allow boards to run at HS200 / HS400 speed
> modes while running at 100 MHz or 150 MHz.  In fact, running HS400 at
> 150 MHz (giving 300 MB/s) is the main motivation of this series, since
> performance is still good but signal integrity problems are less
> prevelant at 150 MHz.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> ---
> Changes in v3:
> - Use phy_init / phy_exit (Heiko)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
