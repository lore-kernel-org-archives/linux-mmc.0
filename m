From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/8] ARM: STi: DT: Add sdhci pins for stih416
Date: Thu, 22 May 2014 16:59:43 +0100
Message-ID: <20140522155943.GH19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-4-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:50270 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbaEVP7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:59:50 -0400
Received: by mail-ig0-f178.google.com with SMTP id hl10so3710122igb.11
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 08:59:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400771902-26553-4-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>

On Thu, 22 May 2014, Peter Griffin wrote:

> This adds the required pin config for both SDHCI controllers on
> the stih416 SoC.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  arch/arm/boot/dts/stih416-pinctrl.dtsi | 39 ++++++++++++++++++++++++=
++++++++++
>  1 file changed, 39 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/d=
ts/stih416-pinctrl.dtsi
> index 6252188..140af6b 100644
> --- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
> @@ -467,6 +467,45 @@
>  					};
>  				};
>  			};
> +
> +			mmc0 {
> +				pinctrl_mmc0: mmc0 {
> +					st,pins {
> +						mmcclk =3D <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
> +						data0 =3D <&PIO14 4 ALT4 BIDIR_PU BYPASS 0>;
> +						data1 =3D <&PIO14 5 ALT4 BIDIR_PU BYPASS 0>;
> +						data2 =3D <&PIO14 6 ALT4 BIDIR_PU BYPASS 0>;
> +						data3 =3D <&PIO14 7 ALT4 BIDIR_PU BYPASS 0>;
> +						cmd =3D <&PIO15 1 ALT4 BIDIR_PU BYPASS 0>;
> +						wp =3D <&PIO15 3 ALT4 IN>;
> +						data4 =3D <&PIO16 4 ALT4 BIDIR_PU BYPASS 0>;
> +						data5 =3D <&PIO16 5 ALT4 BIDIR_PU BYPASS 0>;
> +						data6 =3D <&PIO16 6 ALT4 BIDIR_PU BYPASS 0>;
> +						data7 =3D <&PIO16 7 ALT4 BIDIR_PU BYPASS 0>;
> +						pwr =3D <&PIO17 1 ALT4 OUT>;
> +						cd =3D <&PIO17 2 ALT4 IN>;
> +						led =3D <&PIO17 3 ALT4 OUT>;
> +					};
> +				};
> +			};
> +			mmc1 {
> +				pinctrl_mmc1: mmc1 {
> +					st,pins {
> +						mmcclk =3D <&PIO15 0 ALT3 BIDIR_PU NICLK 0 CLK_B>;
> +						data0 =3D <&PIO13 7 ALT3 BIDIR_PU BYPASS 0>;
> +						data1 =3D <&PIO14 1 ALT3 BIDIR_PU BYPASS 0>;
> +						data2 =3D <&PIO14 2 ALT3 BIDIR_PU BYPASS 0>;
> +						data3 =3D <&PIO14 3 ALT3 BIDIR_PU BYPASS 0>;
> +						cmd =3D <&PIO15 4 ALT3 BIDIR_PU BYPASS 0>;
> +						data4 =3D <&PIO15 6 ALT3 BIDIR_PU BYPASS 0>;
> +						data5 =3D <&PIO15 7 ALT3 BIDIR_PU BYPASS 0>;
> +						data6 =3D <&PIO16 0 ALT3 BIDIR_PU BYPASS 0>;
> +						data7 =3D <&PIO16 1 ALT3 BIDIR_PU BYPASS 0>;
> +						pwr =3D <&PIO16 2 ALT3 OUT>;
> +						nreset =3D <&PIO13 6 ALT3 OUT>;
> +					};
> +				};
> +			};
>  		};
> =20
>  		pin-controller-fvdp-fe {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
