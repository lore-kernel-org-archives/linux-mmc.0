From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 08/15] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
Date: Wed, 22 Jun 2016 15:34:41 +0300
Message-ID: <576A85E1.3010309@intel.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-9-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466445414-11974-9-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, Heiko Stuebner <heiko@sntech.de>
Cc: kishon@ti.com, robh+dt@kernel.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/06/16 20:56, Douglas Anderson wrote:
> In the the earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs") we can see the
> mechansim for specifying a syscon to properly set corecfg registers in
> sdhci-of-arasan.  Now let's use this mechanism to properly set
> corecfg_baseclkfreq on rk3399.
> 
>>From [1] the corecfg_baseclkfreq is supposed to be set to:
>   Base Clock Frequency for SD Clock.
>   This is the frequency of the xin_clk.
> 
> This is a relatively easy thing to do.  Note that we assume that xin_clk
> is not dynamic and we can check the clock at probe time.  If any real
> devices have a dynamic xin_clk future patches could register for
> notifiers for the clock.
> 
> At the moment, setting corecfg_baseclkfreq is only supported for rk3399
> since we need a specific map for each implementation.  The code is
> written in a generic way that should make this easy to extend to other
> SoCs.  Note that a specific compatible string for rk3399 is already in
> use and so we add that to the table to match rk3399.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
