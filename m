From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/6] ARM: dts: socfpga: remove 'num-slots' property for dwmmc
Date: Thu, 15 Mar 2018 11:22:46 +0100
Message-ID: <CAPDyKFprYVFXXSq7Jv7BLwE0Liq2S2EDMmZY7MBp7tpbpdYsqA@mail.gmail.com>
References: <CGME20180223064140epcas2p2145faef6a2c44d7d20bb3d6099f12d18@epcas2p2.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-3-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223064138.18401-3-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org, Will Deacon <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On 23 February 2018 at 07:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Since 'num-slots' had already deprecated, remove the property in
> device-tree file.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 1 -
>  arch/arm/boot/dts/socfpga_arria5.dtsi             | 1 -
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi           | 1 -
>  arch/arm/boot/dts/socfpga_vt.dts                  | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
> index 040a164ba148..5822fd2085db 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
> +++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
> @@ -20,7 +20,6 @@
>
>  &mmc {
>         status = "okay";
> -       num-slots = <1>;
>         cap-sd-highspeed;
>         broken-cd;
>         bus-width = <4>;
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 8c037297296c..e59461f5416e 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -30,7 +30,6 @@
>                 };
>
>                 mmc0: dwmmc0@ff704000 {
> -                       num-slots = <1>;
>                         broken-cd;
>                         bus-width = <4>;
>                         cap-mmc-highspeed;
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index a05e3df23103..68ced67f8bfb 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -31,7 +31,6 @@
>                 };
>
>                 mmc0: dwmmc0@ff704000 {
> -                       num-slots = <1>;
>                         broken-cd;
>                         bus-width = <4>;
>                         cap-mmc-highspeed;
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index dfe2193cd4d5..547c38632c68 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -42,7 +42,6 @@
>                 };
>
>                 dwmmc0@ff704000 {
> -                       num-slots = <1>;
>                         broken-cd;
>                         bus-width = <4>;
>                         cap-mmc-highspeed;
> --
> 2.15.1
>
