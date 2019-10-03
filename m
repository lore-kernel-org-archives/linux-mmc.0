From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC
 driver and binding
Date: Thu, 3 Oct 2019 12:01:14 +0200
Message-ID: <CAPDyKFoDhtXwzsEzh2tST96VQHqu2PKHq4F=Zs__mqA1=AVaTQ@mail.gmail.com>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-7-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916154546.24982-7-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add MAINTAINERS entry for Actions Semi SD/MMC driver with its binding.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c31e6492b601..d13138330b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1375,6 +1375,7 @@ F:        drivers/clk/actions/
>  F:     drivers/clocksource/timer-owl*
>  F:     drivers/dma/owl-dma.c
>  F:     drivers/i2c/busses/i2c-owl.c
> +F:     drivers/mmc/host/owl-mmc.c
>  F:     drivers/pinctrl/actions/*
>  F:     drivers/soc/actions/
>  F:     include/dt-bindings/power/owl-*
> @@ -1383,6 +1384,7 @@ F:        Documentation/devicetree/bindings/arm/actions.yaml
>  F:     Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
>  F:     Documentation/devicetree/bindings/dma/owl-dma.txt
>  F:     Documentation/devicetree/bindings/i2c/i2c-owl.txt
> +F:     Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
>  F:     Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  F:     Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> --
> 2.17.1
>
