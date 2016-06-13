From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 03/11] Documentation: mmc: sdhci-of-arasan: Add
 soc-ctl-syscon for corecfg regs
Date: Mon, 13 Jun 2016 16:18:24 +0800
Message-ID: <45a7e8c7-5bd4-8c40-004a-b8906eff881a@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36362 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097AbcFMISd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 04:18:33 -0400
In-Reply-To: <1465339484-969-4-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org

On 2016/6/8 6:44, Douglas Anderson wrote:
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

yes, the interaction of phy and controller should be more explicitly
now. Why not make it mandatory for arasan,sdhci-5.1.

>
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 27 ++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 31b35c3a5e47..b67e623ca1ff 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -9,8 +9,12 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
>
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> -                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
> +  - compatible: Compatibility string.  One of:
> +    - "arasan,sdhci-8.9a"
> +    - "arasan,sdhci-4.9a"
> +    - "arasan,sdhci-5.1"
> +    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": The PHY in rk3399.

The PHY in rk3399?

> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -22,6 +26,11 @@ Required Properties for "arasan,sdhci-5.1":
>    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
>    - phy-names:  MUST be "phy_arasan".
>
> +Optional Properties:
> +  - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
> +    used to access core corecfg registers.  Offsets of registers in this
> +    syscon are determined based on the main compatible string for the device.
> +
>  Example:
>  	sdhci@e0100000 {
>  		compatible = "arasan,sdhci-8.9a";
> @@ -42,3 +51,17 @@ Example:
>  		phys = <&emmc_phy>;
>  		phy-names = "phy_arasan";
>  	} ;
> +
> +	sdhci: sdhci@fe330000 {
> +		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> +		reg = <0x0 0xfe330000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		arasan,soc-ctl-syscon = <&grf>;
> +		assigned-clocks = <&cru SCLK_EMMC>;
> +		assigned-clock-rates = <200000000>;
> +		phys = <&emmc_phy>;
> +		phy-names = "phy_arasan";
> +		status = "disabled";
> +	};
>


-- 
Best Regards
Shawn Lin

