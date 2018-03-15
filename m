From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] ARM: dts: lpc18xx: remove 'num-slots' property for dwmmc
Date: Thu, 15 Mar 2018 11:22:56 +0100
Message-ID: <CAPDyKFpYgVUwaWYyvRoGkX=m5kLi=L15_D4KZpgwW6iC2-WF4A@mail.gmail.com>
References: <CGME20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-5-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223064138.18401-5-jh80.chung@samsung.com>
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
>  arch/arm/boot/dts/lpc18xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
> index 7cae9c5e27db..10b8249b8ab6 100644
> --- a/arch/arm/boot/dts/lpc18xx.dtsi
> +++ b/arch/arm/boot/dts/lpc18xx.dtsi
> @@ -115,7 +115,6 @@
>                         compatible = "snps,dw-mshc";
>                         reg = <0x40004000 0x1000>;
>                         interrupts = <6>;
> -                       num-slots = <1>;
>                         clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
>                         clock-names = "ciu", "biu";
>                         resets = <&rgu 20>;
> --
> 2.15.1
>
