From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 03/11] Documentation: mmc: sdhci-of-arasan: Add
 soc-ctl-syscon for corecfg regs
Date: Tue, 14 Jun 2016 08:33:54 +0800
Message-ID: <39b13297-782e-043f-96d3-95643f188f31@rock-chips.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:59081 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422674AbcFNAeD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 20:34:03 -0400
In-Reply-To: <1465859076-4868-4-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org

=D4=DA 2016/6/14 7:04, Douglas Anderson =D0=B4=B5=C0:
> As can be seen in Arasan's datasheet [1] there are several "corecfg"
> settings in their SDHCI IP Block that are supposed to be controlled b=
y
> software.  Although the datasheet referenced is a bit vague about how=
 to
> access corecfg, in Figure 5 you can see that for Arasan's PHY (a
> separate component than their SDHCI component) they describe the
> "phyctrl" registers as being "FROM SOC CTL REG", implying that it's u=
p
> to the licensee of the Arasan IP block to implement these registers. =
 It
> seems sane to assume that the "corecfg" registers in their SDHCI IP
> block works in a similar way for all licensees of the IP Block.
>
> Device tree has a model that allows a device to get a reference to
> random registers located elsewhere in the SoC: sysctl.  Let's leverag=
e
> this model and allow adding a sysctl reference to access the control
> registers for the Arasan SDHCI PHYs.
>
> Having a reference to the control registers doesn't do much for us on
> its own since the Arasan spec doesn't specify how these corecfg value=
s
> are laid out in memory.  In the SDHCI driver we'll need a map detaili=
ng
> where each corecfg can be found in each implementation.  This map can=
 be
> found using the primary compatible string of the SDHCI device.  In th=
at
> spirit, document that existing rk3399 device trees already have a
> specific compatible string, though up to now they've always been rely=
ing
> on the driver supporting the generic.
>
> Note that since existing devices seem to work fairly well as-is, we'l=
l
> list the syscon reference as "optional", but it's likely that we'll r=
un
> into much fewer problems if we can actually set the proper values in =
the
> syscon, so it is strongly suggested that any SoCs where we have a map=
 to
> set the corecfg also include a reference to the syscon.
>
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-=
1-3.pdf


Looks good.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - Clean up description of rk3399 PHY (Shawn)
> - Add Rob Herring's Ack.
>
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 27 ++++++++++++=
++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b=
/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 31b35c3a5e47..476604e6ce2a 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -9,8 +9,12 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
>
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> -                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
> +  - compatible: Compatibility string.  One of:
> +    - "arasan,sdhci-8.9a": generic Arasan SDHCI 8.9a PHY
> +    - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
> +    - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> +    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC P=
HY
> +      For this device it is strongly suggested to include arasan,soc=
-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and =
"clk_ahb"
> @@ -22,6 +26,11 @@ Required Properties for "arasan,sdhci-5.1":
>    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
>    - phy-names:  MUST be "phy_arasan".
>
> +Optional Properties:
> +  - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/=
syscon.txt)
> +    used to access core corecfg registers.  Offsets of registers in =
this
> +    syscon are determined based on the main compatible string for th=
e device.
> +
>  Example:
>  	sdhci@e0100000 {
>  		compatible =3D "arasan,sdhci-8.9a";
> @@ -42,3 +51,17 @@ Example:
>  		phys =3D <&emmc_phy>;
>  		phy-names =3D "phy_arasan";
>  	} ;
> +
> +	sdhci: sdhci@fe330000 {
> +		compatible =3D "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> +		reg =3D <0x0 0xfe330000 0x0 0x10000>;
> +		interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +		clock-names =3D "clk_xin", "clk_ahb";
> +		arasan,soc-ctl-syscon =3D <&grf>;
> +		assigned-clocks =3D <&cru SCLK_EMMC>;
> +		assigned-clock-rates =3D <200000000>;
> +		phys =3D <&emmc_phy>;
> +		phy-names =3D "phy_arasan";
> +		status =3D "disabled";
> +	};
>


--=20
Best Regards
Shawn Lin

