From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/11] Documentation: phy: Let the rockchip eMMC PHY get
 an exported card clock
Date: Fri, 10 Jun 2016 08:36:31 -0500
Message-ID: <20160610133631.GA10634@rob-hp-laptop>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-9-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465339484-969-9-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 07, 2016 at 03:44:41PM -0700, Douglas Anderson wrote:
> As of an earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add ability to export card clock") the SDHCI driver
> used on Rockchip SoCs can now expose its clock.  Let's now specify that
> the PHY can use it.
> 
> Letting the PHY get access to this clock means it can adjust
> phyctrl_frqsel field appropriately.  Although the Rockchip PHY appears
> slightly different than the reference Arasan one, you can see that the
> Arasan datasheet [1] had it defined as:
>   Select the frequency range of DLL operation:
>   3b'000 => 200MHz to 170 MHz
>   3b'001 => 170MHz to 140 MHz
>   3b'010 => 140MHz to 110 MHz
>   3b'011 => 110MHz to 80MHz
>   3b'100 => 80MHz to 50 MHz
>   3b'101 => 275Mhz to 250MHz
>   3b'110 => 250MHz to 225MHz
>   3b'111 => 225MHz to 200MHz
> 
> On the Rockchip version of the PHY we have less granularity but the idea
> is the same.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index 555cb0f40690..fd118b071e5e 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -7,6 +7,11 @@ Required properties:
>   - reg: PHY register address offset and length in "general
>     register files"
>  
> +Optional clocks (see ../clock/clock-bindings.txt), specified by name:
> + - emmcclk: The card clock exported by the SDHCI driver.  Although this is

This reads like emmcclk is the property. You need to list out clocks and 
clock-names.

> +	    listed as optional (because most boards can get basic functionality
> +	    without having access to it), it is strongly suggested.
> +
>  Example:
>  
>  
> @@ -20,6 +25,8 @@ grf: syscon@ff770000 {
>  	emmcphy: phy@f780 {
>  		compatible = "rockchip,rk3399-emmc-phy";
>  		reg = <0xf780 0x20>;
> +		clocks = <&sdhci>;
> +		clock-names = "emmcclk";
>  		#phy-cells = <0>;
>  	};
>  };
> -- 
> 2.8.0.rc3.226.g39d4020
> 
