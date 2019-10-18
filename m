From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6 v2] MMC: JZ4740: Add support for LPM.
Date: Fri, 18 Oct 2019 10:52:41 +0200
Message-ID: <CAPDyKFo9juNmf6hrcBjzOprS6GwzAPBq8y3ReGu=ry+MdxT9Bg@mail.gmail.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com> <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>, Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Paul Burton <paul.burton@mips.com>, Mark Rutland <mark.rutland@arm.com>, syq@debian.org, Linus Walleij <linus.walleij@linaro.org>, armijn@tjaldur.nl, Thomas Gleixner <tglx@linutronix.de>, YueHaibing <yuehaibing@huawei.com>, Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, 12 Oct 2019 at 07:19, Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>
> add support for low power mode of Ingenic's MMC/SD Controller.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

I couldn't find a proper coverletter for the series, please provide
that next time as it really helps review. Additionally, it seems like
you forgot to change the prefix of the patches to "mmc: jz4740" (or at
least you chosed upper case letters), but I will take care of that
this time. So, I have applied the series for next, thanks!

I also have a general question. Should we perhaps rename the driver
from jz4740_mmc.c to ingenic.c (and the file for the DT bindings, the
Kconfig, etc), as that seems like a more appropriate name? No?

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 44a04fe..4cbe7fb 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -43,6 +43,7 @@
>  #define JZ_REG_MMC_RESP_FIFO   0x34
>  #define JZ_REG_MMC_RXFIFO      0x38
>  #define JZ_REG_MMC_TXFIFO      0x3C
> +#define JZ_REG_MMC_LPM         0x40
>  #define JZ_REG_MMC_DMAC                0x44
>
>  #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
> @@ -102,6 +103,12 @@
>  #define JZ_MMC_DMAC_DMA_SEL BIT(1)
>  #define JZ_MMC_DMAC_DMA_EN BIT(0)
>
> +#define        JZ_MMC_LPM_DRV_RISING BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_1NS_DLY BIT(30)
> +#define        JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY BIT(29)
> +#define        JZ_MMC_LPM_LOW_POWER_MODE_EN BIT(0)
> +
>  #define JZ_MMC_CLK_RATE 24000000
>
>  enum jz4740_mmc_version {
> @@ -860,6 +867,22 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
>         }
>
>         writew(div, host->base + JZ_REG_MMC_CLKRT);
> +
> +       if (real_rate > 25000000) {
> +               if (host->version >= JZ_MMC_X1000) {
> +                       writel(JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY |
> +                                  JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4760) {
> +                       writel(JZ_MMC_LPM_DRV_RISING |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4725B)
> +                       writel(JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +       }
> +
>         return real_rate;
>  }
>
> --
> 2.7.4
>
>
