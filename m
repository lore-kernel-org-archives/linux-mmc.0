From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
Date: Wed, 16 Apr 2014 15:09:15 +0200
Message-ID: <20140416130915.GC11310@lunn.ch>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397652011-21284-4-git-send-email-antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 16, 2014 at 02:40:10PM +0200, Antoine T=E9nart wrote:
> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdh=
ci
> driver.
>=20
> Signed-off-by: Antoine T=E9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 40 +++++++++++++++++++++++++++++++=
+++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berl=
in2q.dtsi
> index 5925e6a16749..8f897d461460 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -67,6 +67,14 @@
>  		clock-div =3D <3>;
>  	};
> =20
> +	sdio1clk: sdio1clk {
> +		compatible =3D "fixed-factor-clock";
> +		#clock-cells =3D <0>;
> +		clocks =3D <&syspll>;
> +		clock-mult =3D <1>;
> +		clock-div =3D <4>;
> +	};
> +
>  	soc {
>  		compatible =3D "simple-bus";
>  		#address-cells =3D <1>;
> @@ -75,6 +83,38 @@
>  		ranges =3D <0 0xf7000000 0x1000000>;
>  		interrupt-parent =3D <&gic>;
> =20
> +		sdhci0: sdhci@ab0000 {
> +			compatible =3D "marvell,berlin2q-sdhci";
> +			reg =3D <0xab0000 0x200>;
> +			clocks =3D <&sdio1clk>;
> +			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;

Hi Antoine

I would expect these three last properties to be a property of the
board, not the SoC. Or am i missing something?

       Thanks
	Andrew
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
