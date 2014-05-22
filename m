From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/8] ARM: STi: DT: Add sdhci pin configuration for stih415
Date: Thu, 22 May 2014 16:57:03 +0100
Message-ID: <20140522155703.GF19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-6-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400771902-26553-6-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

> This patch adds the required pin config for the sdhci controller
> present in the stih415 SoC.
>=20
> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>

Switch these round - same with all the other patches.

> ---
>  arch/arm/boot/dts/stih415-pinctrl.dtsi | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
>  2 files changed, 33 insertions(+)

[...]

> diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih4=
15.dtsi
> index d6f254f..6579b1d 100644
> --- a/arch/arm/boot/dts/stih415.dtsi
> +++ b/arch/arm/boot/dts/stih415.dtsi
> @@ -218,5 +218,17 @@
>  			resets	=3D <&powerdown STIH415_KEYSCAN_POWERDOWN>,
>  				  <&softreset STIH415_KEYSCAN_SOFTRESET>;
>  		};
> +
> +		mmc0: sdhci@fe81e000 {
> +			compatible =3D "st,sdhci";
> +			status =3D "disabled";
> +			reg =3D <0xfe81e000 0x1000>;
> +			interrupts =3D <GIC_SPI 145 IRQ_TYPE_NONE>;
> +			interrupt-names =3D "mmcirq";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_mmc0>;
> +			clock-names =3D "mmc";
> +			clocks =3D <&clk_s_a1_ls 1>;

Nit: These would be easier to read if the '=3D's were lined up (using t=
abs).

> +		};
>  	};
>  };

Apart from that:

  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
