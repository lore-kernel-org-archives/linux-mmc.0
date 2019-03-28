From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 07/24] arm64: dts: mt6392: Add PMIC mt6392 dtsi
Date: Thu, 28 Mar 2019 14:18:23 -0500
Message-ID: <CAL_JsqLN9+NeCjYcuiACtpxqsTzttemaLt=L9fkXH+EjiC4rdA@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-8-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-8-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Wenzhen Yu <wenzhen.yu@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list:SE
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 23, 2019 at 4:16 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add the regulator nodes for the MT6392 PMIC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 208 +++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> new file mode 100644
> index 000000000000..e33a45fd52af
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +&pwrap {
> +       pmic: mt6392 {

Same comments in binding example apply here.

> +               compatible = "mediatek,mt6392", "mediatek,mt6323";
> +               mediatek,system-power-controller;
> +
> +               mt6392_regulator: mt6392_regulator {
> +                       compatible = "mediatek,mt6392-regulator";
> +
> +                       mt6392_vproc_reg: buck_vproc {
> +                               regulator-name = "buck_vproc";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vsys_reg: buck_vsys {
> +                               regulator-name = "buck_vsys";
> +                               regulator-min-microvolt = <1400000>;
> +                               regulator-max-microvolt = <2987500>;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcore_reg: buck_vcore {
> +                               regulator-name = "buck_vcore";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vxo22_reg: ldo_vxo22 {
> +                               regulator-name = "ldo_vxo22";
> +                               regulator-min-microvolt = <2200000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <110>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vaud22_reg: ldo_vaud22 {
> +                               regulator-name = "ldo_vaud22";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcama_reg: ldo_vcama {
> +                               regulator-name = "ldo_vcama";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vaud28_reg: ldo_vaud28 {
> +                               regulator-name = "ldo_vaud28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vadc18_reg: ldo_vadc18 {
> +                               regulator-name = "ldo_vadc18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcn35_reg: ldo_vcn35 {
> +                               regulator-name = "ldo_vcn35";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3600000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vio28_reg: ldo_vio28 {
> +                               regulator-name = "ldo_vio28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vusb_reg: ldo_vusb {
> +                               regulator-name = "ldo_vusb";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmc_reg: ldo_vmc {
> +                               regulator-name = "ldo_vmc";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmch_reg: ldo_vmch {
> +                               regulator-name = "ldo_vmch";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vemc3v3_reg: ldo_vemc3v3 {
> +                               regulator-name = "ldo_vemc3v3";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vgp1_reg: ldo_vgp1 {
> +                               regulator-name = "ldo_vgp1";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vgp2_reg: ldo_vgp2 {
> +                               regulator-name = "ldo_vgp2";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcn18_reg: ldo_vcn18 {
> +                               regulator-name = "ldo_vcn18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamaf_reg: ldo_vcamaf {
> +                               regulator-name = "ldo_vcamaf";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm_reg: ldo_vm {
> +                               regulator-name = "ldo_vm";
> +                               regulator-min-microvolt = <1240000>;
> +                               regulator-max-microvolt = <1390000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vio18_reg: ldo_vio18 {
> +                               regulator-name = "ldo_vio18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcamd_reg: ldo_vcamd {
> +                               regulator-name = "ldo_vcamd";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamio_reg: ldo_vcamio {
> +                               regulator-name = "ldo_vcamio";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm25_reg: ldo_vm25 {
> +                               regulator-name = "ldo_vm25";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <2500000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vefuse_reg: ldo_vefuse {
> +                               regulator-name = "ldo_vefuse";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +               };
> +       };
> +};
> --
> 2.20.1
>
