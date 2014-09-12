From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
Date: Fri, 12 Sep 2014 18:23:02 +0800
Message-ID: <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35552 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbaILKXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Sep 2014 06:23:23 -0400
In-Reply-To: <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, Chris Ball <chris@printf.net>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Sep 12, 2014 at 4:18 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add the sample and output clocks for the MMC phase support.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
>  arch/arm/boot/dts/sun5i-a10s.dtsi |  79 ++++++++++++++++++++++++++---
>  arch/arm/boot/dts/sun5i-a13.dtsi  |  80 +++++++++++++++++++++++++----
>  arch/arm/boot/dts/sun6i-a31.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 104 +++++++++++++++++++++++++++++++++++---
>  arch/arm/boot/dts/sun8i-a23.dtsi  |  78 +++++++++++++++++++++++++---

Tested on my a23 tablet, looks good.

>  6 files changed, 502 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 380f914b226d..57ca74a149eb 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -227,6 +227,22 @@
>                         clock-output-names = "mmc0";
>                 };
>
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
>                 mmc1_clk: clk@01c2008c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -235,6 +251,22 @@
>                         clock-output-names = "mmc1";
>                 };
>
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
>                 mmc2_clk: clk@01c20090 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -243,6 +275,22 @@
>                         clock-output-names = "mmc2";
>                 };
>
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
> +
>                 mmc3_clk: clk@01c20094 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -251,6 +299,22 @@
>                         clock-output-names = "mmc3";
>                 };
>
> +               mmc3_output_clk: mmc_output_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_output";
> +               };
> +
> +               mmc3_sample_clk: mmc_sample_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_sample";
> +               };
> +
>                 ts_clk: clk@01c20098 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -392,8 +456,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun4i-a10-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";

Just a stylish nitpick. All the other resources in these files
are listed inline if possible, not one phandle/value per line.

But otherwise, it looks good.

ChenYu

>                         interrupts = <32>;
>                         status = "disabled";
>                 };
> @@ -401,8 +471,14 @@
>                 mmc1: mmc@01c10000 {
>                         compatible = "allwinner,sun4i-a10-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ahb_gates 9>, <&mmc1_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 9>,
> +                                <&mmc1_clk>,
> +                                <&mmc1_sample_clk>,
> +                                <&mmc1_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <33>;
>                         status = "disabled";
>                 };
> @@ -410,8 +486,14 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun4i-a10-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <34>;
>                         status = "disabled";
>                 };
> @@ -419,8 +501,14 @@
>                 mmc3: mmc@01c12000 {
>                         compatible = "allwinner,sun4i-a10-mmc";
>                         reg = <0x01c12000 0x1000>;
> -                       clocks = <&ahb_gates 11>, <&mmc3_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 11>,
> +                                <&mmc3_clk>,
> +                                <&mmc3_sample_clk>,
> +                                <&mmc3_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <35>;
>                         status = "disabled";
>                 };
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index 531272c0e526..59c93287fd66 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -212,6 +212,22 @@
>                         clock-output-names = "mmc0";
>                 };
>
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
>                 mmc1_clk: clk@01c2008c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -220,6 +236,22 @@
>                         clock-output-names = "mmc1";
>                 };
>
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
>                 mmc2_clk: clk@01c20090 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -228,6 +260,22 @@
>                         clock-output-names = "mmc2";
>                 };
>
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
> +
>                 ts_clk: clk@01c20098 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -353,8 +401,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <32>;
>                         status = "disabled";
>                 };
> @@ -362,8 +416,14 @@
>                 mmc1: mmc@01c10000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ahb_gates 9>, <&mmc1_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 9>,
> +                                <&mmc1_clk>,
> +                                <&mmc1_sample_clk>,
> +                                <&mmc1_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <33>;
>                         status = "disabled";
>                 };
> @@ -371,12 +431,17 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <34>;
>                         status = "disabled";
>                 };
> -
>                 usbphy: phy@01c13400 {
>                         #phy-cells = <1>;
>                         compatible = "allwinner,sun5i-a13-usb-phy";
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index b131068f4f35..2c5cee912f33 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -202,30 +202,78 @@
>                         clock-output-names = "ms";
>                 };
>
> -               mmc0_clk: clk@01c20088 {
> +               mmc0_clk: clk_mmc@01c20088 {
>                         #clock-cells = <0>;
> -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> +                       compatible = "allwinner,sun4i-a10-mmc-clk";
>                         reg = <0x01c20088 0x4>;
>                         clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
>                         clock-output-names = "mmc0";
>                 };
>
> -               mmc1_clk: clk@01c2008c {
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
>                         #clock-cells = <0>;
> -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
> +               mmc1_clk: clk_mmc@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-clk";
>                         reg = <0x01c2008c 0x4>;
>                         clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
>                         clock-output-names = "mmc1";
>                 };
>
> -               mmc2_clk: clk@01c20090 {
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
>                         #clock-cells = <0>;
> -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
> +               mmc2_clk: clk_mmc@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-clk";
>                         reg = <0x01c20090 0x4>;
>                         clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
>                         clock-output-names = "mmc2";
>                 };
>
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
> +
>                 ts_clk: clk@01c20098 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -335,8 +383,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <32>;
>                         status = "disabled";
>                 };
> @@ -344,8 +398,14 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <34>;
>                         status = "disabled";
>                 };
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 543f895d18d3..436eb7429a7d 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -252,6 +252,22 @@
>                         clock-output-names = "mmc0";
>                 };
>
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
>                 mmc1_clk: clk@01c2008c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -260,6 +276,22 @@
>                         clock-output-names = "mmc1";
>                 };
>
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
>                 mmc2_clk: clk@01c20090 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -268,6 +300,22 @@
>                         clock-output-names = "mmc2";
>                 };
>
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
> +
>                 mmc3_clk: clk@01c20094 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -276,6 +324,22 @@
>                         clock-output-names = "mmc3";
>                 };
>
> +               mmc3_output_clk: mmc_output_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_output";
> +               };
> +
> +               mmc3_sample_clk: mmc_sample_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_sample";
> +               };
> +
>                 spi0_clk: clk@01c200a0 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -366,8 +430,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb1_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 8>;
>                         reset-names = "ahb";
>                         interrupts = <0 60 4>;
> @@ -377,8 +447,14 @@
>                 mmc1: mmc@01c10000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ahb1_gates 9>, <&mmc1_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 9>,
> +                                <&mmc1_clk>,
> +                                <&mmc1_sample_clk>,
> +                                <&mmc1_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 9>;
>                         reset-names = "ahb";
>                         interrupts = <0 61 4>;
> @@ -388,8 +464,14 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb1_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 10>;
>                         reset-names = "ahb";
>                         interrupts = <0 62 4>;
> @@ -399,8 +481,14 @@
>                 mmc3: mmc@01c12000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c12000 0x1000>;
> -                       clocks = <&ahb1_gates 11>, <&mmc3_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 11>,
> +                                <&mmc3_clk>,
> +                                <&mmc3_sample_clk>,
> +                                <&mmc3_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 11>;
>                         reset-names = "ahb";
>                         interrupts = <0 63 4>;
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 82097c905c48..aa61f4887a5e 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -275,6 +275,22 @@
>                         clock-output-names = "mmc0";
>                 };
>
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
>                 mmc1_clk: clk@01c2008c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -283,6 +299,22 @@
>                         clock-output-names = "mmc1";
>                 };
>
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
>                 mmc2_clk: clk@01c20090 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -291,6 +323,22 @@
>                         clock-output-names = "mmc2";
>                 };
>
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
> +
>                 mmc3_clk: clk@01c20094 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -299,6 +347,22 @@
>                         clock-output-names = "mmc3";
>                 };
>
> +               mmc3_output_clk: mmc_output_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_output";
> +               };
> +
> +               mmc3_sample_clk: mmc_sample_clk@01c20094 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20094 0x4>;
> +                       clocks = <&mmc3_clk>;
> +                       clock-output-names = "mmc3_sample";
> +               };
> +
>                 ts_clk: clk@01c20098 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -512,8 +576,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <0 32 4>;
>                         status = "disabled";
>                 };
> @@ -521,8 +591,14 @@
>                 mmc1: mmc@01c10000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ahb_gates 9>, <&mmc1_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 9>,
> +                                <&mmc1_clk>,
> +                                <&mmc1_sample_clk>,
> +                                <&mmc1_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <0 33 4>;
>                         status = "disabled";
>                 };
> @@ -530,8 +606,14 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <0 34 4>;
>                         status = "disabled";
>                 };
> @@ -539,8 +621,14 @@
>                 mmc3: mmc@01c12000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c12000 0x1000>;
> -                       clocks = <&ahb_gates 11>, <&mmc3_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb_gates 11>,
> +                                <&mmc3_clk>,
> +                                <&mmc3_sample_clk>,
> +                                <&mmc3_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         interrupts = <0 35 4>;
>                         status = "disabled";
>                 };
> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
> index a35039224cb5..4379ae93b217 100644
> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> @@ -224,6 +224,22 @@
>                         clock-output-names = "mmc0";
>                 };
>
> +               mmc0_output_clk: mmc_output_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_output";
> +               };
> +
> +               mmc0_sample_clk: mmc_sample_clk@01c20088 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20088 0x4>;
> +                       clocks = <&mmc0_clk>;
> +                       clock-output-names = "mmc0_sample";
> +               };
> +
>                 mmc1_clk: clk@01c2008c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -232,6 +248,22 @@
>                         clock-output-names = "mmc1";
>                 };
>
> +               mmc1_output_clk: mmc_output_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_output";
> +               };
> +
> +               mmc1_sample_clk: mmc_sample_clk@01c2008c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c2008c 0x4>;
> +                       clocks = <&mmc1_clk>;
> +                       clock-output-names = "mmc1_sample";
> +               };
> +
>                 mmc2_clk: clk@01c20090 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-mod0-clk";
> @@ -239,6 +271,22 @@
>                         clocks = <&osc24M>, <&pll6>;
>                         clock-output-names = "mmc2";
>                 };
> +
> +               mmc2_output_clk: mmc_output_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-output-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_output";
> +               };
> +
> +               mmc2_sample_clk: mmc_sample_clk@01c20090 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mmc-sample-clk";
> +                       reg = <0x01c20090 0x4>;
> +                       clocks = <&mmc2_clk>;
> +                       clock-output-names = "mmc2_sample";
> +               };
>         };
>
>         soc@01c00000 {
> @@ -250,8 +298,14 @@
>                 mmc0: mmc@01c0f000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c0f000 0x1000>;
> -                       clocks = <&ahb1_gates 8>, <&mmc0_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 8>,
> +                                <&mmc0_clk>,
> +                                <&mmc0_sample_clk>,
> +                                <&mmc0_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 8>;
>                         reset-names = "ahb";
>                         interrupts = <0 60 4>;
> @@ -261,8 +315,14 @@
>                 mmc1: mmc@01c10000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c10000 0x1000>;
> -                       clocks = <&ahb1_gates 9>, <&mmc1_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 9>,
> +                                <&mmc1_clk>,
> +                                <&mmc1_sample_clk>,
> +                                <&mmc1_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 9>;
>                         reset-names = "ahb";
>                         interrupts = <0 61 4>;
> @@ -272,8 +332,14 @@
>                 mmc2: mmc@01c11000 {
>                         compatible = "allwinner,sun5i-a13-mmc";
>                         reg = <0x01c11000 0x1000>;
> -                       clocks = <&ahb1_gates 10>, <&mmc2_clk>;
> -                       clock-names = "ahb", "mmc";
> +                       clocks = <&ahb1_gates 10>,
> +                                <&mmc2_clk>,
> +                                <&mmc2_sample_clk>,
> +                                <&mmc2_output_clk>;
> +                       clock-names = "ahb",
> +                                     "mmc",
> +                                     "sample",
> +                                     "output";
>                         resets = <&ahb1_rst 10>;
>                         reset-names = "ahb";
>                         interrupts = <0 62 4>;
> --
> 2.1.0
>
