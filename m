From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: usdhi6rol0: Add maintainers
Date: Mon, 22 Jul 2019 15:41:55 +0200
Message-ID: <CAPDyKFpT7HtJbWo5Em6f+UU+7t7eNGb+WypCzg5xumzqvE=aHg@mail.gmail.com>
References: <20190709135351.25628-1-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709135351.25628-1-larper@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jesper Nilsson <jespern@axis.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lars Persson <larper@axis.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 9 Jul 2019 at 15:54, Lars Persson <lars.persson@axis.com> wrote:
>
> The usdhi6rol0 driver is exclusively used for the ARTPEC family of
> SoCs. Other SoCs with the same IP of Panasonic origin use the tmio_mmc
> driver. Therefore we assigner maintainer responsibility to us at Axis
> until the two drivers become unified.
>
> Change-Id: I38b6fd0addc1d93ae172332b67e6eb71c0871508

I dropped this.

> Signed-off-by: Lars Persson <larper@axis.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 677ef41cb012..a91d04e5c084 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1432,6 +1432,7 @@ F:        arch/arm/mach-artpec
>  F:     arch/arm/boot/dts/artpec6*
>  F:     drivers/clk/axis
>  F:     drivers/crypto/axis
> +F:     drivers/mmc/host/usdhi6rol0.c
>  F:     drivers/pinctrl/pinctrl-artpec*
>  F:     Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>
> --
> 2.11.0
>
