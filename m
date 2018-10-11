From: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
Date: Thu, 11 Oct 2018 17:25:39 +0000
Message-ID: <AMSPR04MB503AE4F55B3FAE7E77842218FE10@AMSPR04MB503.eurprd04.prod.outlook.com>
References: <20181011063522.7767-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011063522.7767-1-yinbo.zhu@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>Yinbo Zhu <yinbo.zhu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> Sent: Thursday, October 11, 2018 1:35 AM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; linux-
> mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> ulf.hansson@linaro.org; Leo Li <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; devicetree@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
>=20
> There are two eSDHC controllers in lx2160a. This patch is to enable eSDHC=
 for
> RDB and QDS board.
>=20
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		squash all lx2160a esdhc dts patch into the original patch

Hi Yinbo,

What I meant is that the eSDHC nodes should be squashed into the patches ad=
ding these device tree.  I don't see a good reason that SDHC nodes should b=
e a separate patch for now, especially when the original patch is still bei=
ng reviewed and could be changing.
https://lore.kernel.org/patchwork/patch/995433/
https://lore.kernel.org/patchwork/patch/995434/

Regards,
Leo
>=20
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |    8 ++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   15 ++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   25
> +++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index bc30173..b58b96c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -294,6 +294,14 @@
>  	status =3D "okay";
>  };
>=20
> +&esdhc0 {
> +	status =3D "okay";
> +};
> +
> +&esdhc1 {
> +	status =3D "okay";
> +};
> +
>  &dspi0 {
>  	dflash0: n25q128a {
>  		#address-cells =3D <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 53b0e80..cbe8919 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -170,6 +170,21 @@
>  	status =3D "okay";
>  };
>=20
> +&esdhc0 {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status =3D "okay";
> +};
> +
> +&esdhc1 {
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	bus-width =3D <8>;
> +	status =3D "okay";
> +};
> +
>  &fspi {
>  	status =3D "okay";
>  	nxp,fspi-has-second-chip;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index fa4a1f8..174544a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -356,6 +356,31 @@
>  			little-endian;
>  		};
>=20
> +		esdhc0: esdhc@2140000 {
> +			compatible =3D "fsl,esdhc";
> +			reg =3D <0x0 0x2140000 0x0 0x10000>;
> +			interrupts =3D <0 28 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 1>;
> +			voltage-ranges =3D <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		esdhc1: esdhc@2150000 {
> +			compatible =3D "fsl,esdhc";
> +			reg =3D <0x0 0x2150000 0x0 0x10000>;
> +			interrupts =3D <0 63 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 1>;
> +			voltage-ranges =3D <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;
> +			little-endian;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
>  		gpio0: gpio@2300000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> --
> 1.7.1
