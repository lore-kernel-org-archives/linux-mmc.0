From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6] arm64: dts: hi3660: remove 'num-slots' property for dwmmc
Date: Thu, 15 Mar 2018 11:23:03 +0100
Message-ID: <CAPDyKFpkXzywx3bjvUX4Upm5_QR6maCY6n1Mmu+=hCOPvY+jtw@mail.gmail.com>
References: <CGME20180223064140epcas2p1fcfb5920453f965d16f717931155fa2f@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-6-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223064138.18401-6-jh80.chung@samsung.com>
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
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ab0b95ba5ae5..d6638b1f09ca 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -910,7 +910,6 @@
>                         #size-cells = <0>;
>                         cd-inverted;
>                         compatible = "hisilicon,hi3660-dw-mshc";
> -                       num-slots = <1>;
>                         bus-width = <0x4>;
>                         disable-wp;
>                         cap-sd-highspeed;
> @@ -948,7 +947,6 @@
>                         compatible = "hisilicon,hi3660-dw-mshc";
>                         reg = <0x0 0xff3ff000 0x0 0x1000>;
>                         interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> -                       num-slots = <1>;
>                         clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
>                                  <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
>                         clock-names = "ciu", "biu";
> --
> 2.15.1
>
