From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: jz4740: Add support for the JZ4725B
Date: Wed, 22 Aug 2018 11:49:15 +0200
Message-ID: <CAPDyKFr+xbnMdzj90bHi84gD9W4U0CUvrExBdmhJ-1miFi8xog@mail.gmail.com>
References: <20180821152151.32113-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821152151.32113-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ezequiel Garcia <ezequiel@collabora.co.uk>, od@zcrc.me, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2018 at 17:21, Paul Cercueil <paul@crapouillou.net> wrote:
> The JZ4725B is the first JZ SoC version that introduced a 32-bit IMASK
> register, not the JZ4750.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/jz4740.txt | 1 +
>  drivers/mmc/host/jz4740_mmc.c                    | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
> index 7cd8c432d7c8..8a6f87f13114 100644
> --- a/Documentation/devicetree/bindings/mmc/jz4740.txt
> +++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
> @@ -7,6 +7,7 @@ described in mmc.txt.
>  Required properties:
>  - compatible: Should be one of the following:
>    - "ingenic,jz4740-mmc" for the JZ4740
> +  - "ingenic,jz4725b-mmc" for the JZ4725B
>    - "ingenic,jz4780-mmc" for the JZ4780
>  - reg: Should contain the MMC controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the MMC controller.
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 993386c9ea50..0c1efd5100b7 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -115,7 +115,7 @@
>
>  enum jz4740_mmc_version {
>         JZ_MMC_JZ4740,
> -       JZ_MMC_JZ4750,
> +       JZ_MMC_JZ4725B,
>         JZ_MMC_JZ4780,
>  };
>
> @@ -176,7 +176,7 @@ struct jz4740_mmc_host {
>  static void jz4740_mmc_write_irq_mask(struct jz4740_mmc_host *host,
>                                       uint32_t val)
>  {
> -       if (host->version >= JZ_MMC_JZ4750)
> +       if (host->version >= JZ_MMC_JZ4725B)
>                 return writel(val, host->base + JZ_REG_MMC_IMASK);
>         else
>                 return writew(val, host->base + JZ_REG_MMC_IMASK);
> @@ -1012,6 +1012,7 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
>
>  static const struct of_device_id jz4740_mmc_of_match[] = {
>         { .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
> +       { .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
>         { .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
>         {},
>  };
> --
> 2.11.0
>
