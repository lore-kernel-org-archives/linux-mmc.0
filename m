From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Date: Wed, 1 May 2019 12:50:29 -0500
Message-ID: <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
References: <20190423114424.3578-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423114424.3578-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>, Ashish Kumar <ashish.kumar@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 23, 2019 at 6:42 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
>
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
>
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  8 ++++++
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 13 +++++++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 27 +++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 14c79f4691ea..180e5d2a00d1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -42,6 +42,14 @@
>         status = "okay";
>  };
>
> +&esdhc {
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index f86b054a74ae..1bfaf4294db4 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -30,6 +30,19 @@
>         };
>  };
>
> +&esdhc {
> +       status = "okay";
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr12;
> +       };
> +
> +&esdhc1 {
> +       status = "okay";
> +       mmc-hs200-1_8v;
> +       };
> +
>  &i2c0 {
>         status = "okay";
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2896bbcfa3bb..d13cd3fb455b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -274,6 +274,33 @@
>                         status = "disabled";
>                 };
>
> +               esdhc: esdhc@2140000 {

mmc@...

> +                       compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +                       reg = <0x0 0x2140000 0x0 0x10000>;
> +                       interrupts = <0 28 0x4>; /* Level high type */
> +                       clock-frequency = <0>;

Filled in by bootloader? If so, add a comment.

> +                       clocks = <&clockgen 2 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
> +               esdhc1: esdhc@2150000 {

mmc@...

> +                       compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +                       reg = <0x0 0x2150000 0x0 0x10000>;
> +                       interrupts = <0 63 0x4>; /* Level high type */
> +                       clock-frequency = <0>;
> +                       clocks = <&clockgen 2 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       broken-cd;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
>                 sata: sata@3200000 {
>                         compatible = "fsl,ls1028a-ahci";
>                         reg = <0x0 0x3200000 0x0 0x10000>,
> --
> 2.17.1
>
