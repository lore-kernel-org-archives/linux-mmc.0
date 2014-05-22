From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] ARM: STi: DT: Add sdhci controller for stih416
Date: Thu, 22 May 2014 16:58:50 +0100
Message-ID: <20140522155850.GG19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-5-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43126 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaEVP65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:58:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so3715794igb.9
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 08:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400771902-26553-5-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>

On Thu, 22 May 2014, Peter Griffin wrote:

> This patch adds device tree config for both sdhci controllers
> on the stih416 SoC.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  arch/arm/boot/dts/stih416.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih4=
16.dtsi
> index 06473c5..a035df0 100644
> --- a/arch/arm/boot/dts/stih416.dtsi
> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -236,5 +236,29 @@
>  			resets	=3D <&powerdown STIH416_KEYSCAN_POWERDOWN>,
>  				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
>  		};
> +
> +		mmc0: sdhci@fe81e000 {
> +			compatible =3D "st,sdhci";
> +			status =3D "disabled";
> +			reg =3D <0xfe81e000 0x1000>;
> +			interrupts =3D <GIC_SPI 127 IRQ_TYPE_NONE>;
> +			interrupt-names =3D "mmcirq";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_mmc0>;
> +			clock-names     =3D "mmc";
> +			clocks =3D <&clk_s_a1_ls 1>;
> +		};
> +
> +		mmc1: sdhci@fe81f000 {
> +			compatible =3D "st,sdhci";
> +			status =3D "disabled";
> +			reg =3D <0xfe81f000 0x1000>;
> +			interrupts =3D <GIC_SPI 128 IRQ_TYPE_NONE>;
> +			interrupt-names =3D "mmcirq";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&pinctrl_mmc1>;
> +			clock-names     =3D "mmc";
> +			clocks =3D <&clk_s_a1_ls 8>;
> +		};

Line these up and make them look pretty too.

After that:

  Acked-by: Lee Jones <lee.jones@linaro.org>

>  	};
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
