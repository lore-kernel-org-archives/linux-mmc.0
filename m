From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] ARM: STi: DT: Enable second sdhci controller for
 stih416 b2020 boards.
Date: Thu, 22 May 2014 16:39:17 +0100
Message-ID: <20140522153917.GD19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-8-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57525 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbaEVPjY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:39:24 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so2183041iec.12
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 08:39:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400771902-26553-8-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>

On Thu, 22 May 2014, Peter Griffin wrote:

> The second controller is only present on the stih416 SoC. Also
> mark this as non-removeable as its eMMC.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  arch/arm/boot/dts/stih416-b2020.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/=
stih416-b2020.dts
> index 4e2df66..6cde745 100644
> --- a/arch/arm/boot/dts/stih416-b2020.dts
> +++ b/arch/arm/boot/dts/stih416-b2020.dts
> @@ -12,4 +12,12 @@
>  / {
>  	model =3D "STiH416 B2020";
>  	compatible =3D "st,stih416-b2020", "st,stih416";
> +
> +	soc {
> +		mmc1: sdhci@fe81f000 {
> +			status =3D "okay";
> +			non-removable;
> +		};
> +	};
> +

Superfluous '\n'.

>  };

Once rectified you can add my:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
