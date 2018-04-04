From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: send tune request twice to work
 around errata
Date: Wed, 4 Apr 2018 09:35:53 +0200
Message-ID: <CAPDyKFpgrHTD9_FcfAi7kU3_N0=Hqty4tS7suTotPF98kzxM-w@mail.gmail.com>
References: <1522142993-25654-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522142993-25654-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 27 March 2018 at 11:29, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Cadence sent out an errata report to their customers of this IP.
> This errata is not so severe, but the tune request should be sent
> twice to avoid the potential issue.
>
> Quote from the report:
>
> Problem Summary
> ---------------
> The IP6116 SD/eMMC PHY design has a timing issue on receive data path.
> This issue may lead to an incorrect values of read/write pointers of
> the synchronization FIFO. Such a situation can happen at the SDR104
> and HS200 tuning procedure when the PHY is requested to change a phase
> of sampling clock when moving to the next tuning iteration.
>
> Workarounds
> -----------
> The following are valid workarounds to resolve the issue:
>
> 1. In eMMC mode, software sends tune request twice instead of once at
>    each iteration. This means that the clock phase is not changed on
>    the second request so there is no potential for clock instability.
> 2. In SD mode, software must not use the hardware tuning and instead
>    perform an almost identical procedure to eMMC, using the HRS34 Tune
>    Force register.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Do you want this to be tagged for stable as well? And perhaps you
could add a fixes tag?

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 0f589e2..bc30d16 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -253,6 +253,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>         struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>         void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>         u32 tmp;
> +       int i, ret;
>
>         if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
>                 return -EINVAL;
> @@ -260,11 +261,24 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>         tmp = readl(reg);
>         tmp &= ~SDHCI_CDNS_HRS06_TUNE;
>         tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_TUNE, val);
> -       tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> -       writel(tmp, reg);
>
> -       return readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> -                                 0, 1);
> +       /*
> +        * Workaround for IP errata:
> +        * The IP6116 SD/eMMC PHY design has a timing issue on receive data
> +        * path. Send tune request twice.
> +        */
> +       for (i = 0; i < 2; i++) {
> +               tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> +               writel(tmp, reg);
> +
> +               ret = readl_poll_timeout(reg, tmp,
> +                                        !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> +                                        0, 1);
> +
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> --
> 2.7.4
>
