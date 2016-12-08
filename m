From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/2] mmc: sdhci: export sdhci_execute_tuning()
Date: Thu, 8 Dec 2016 13:31:57 +0100
Message-ID: <CAPDyKFoEYgLNX=SnMu32iXHZ5hzF-89Yve0csuNiKO79UavyRg@mail.gmail.com>
References: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com> <1480903854-22701-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480903854-22701-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 5 December 2016 at 03:10, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Some SDHCI-compat controllers support not only SD, but also eMMC,
> but they use different commands for tuning: CMD19 for SD, CMD21 for
> eMMC.
>
> Due to the difference of the underlying mechanism, some controllers
> (at least, the Cadence IP is the case) provide their own registers
> for the eMMC tuning.
>
> This commit will be useful when we want to override .execute_tuning
> callback (for eMMC HS200 tuning), but still let it fall back to
> sdhci_execute_tuning() for SD timing.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> I want to use this in the next commit.
> The Cadence IP supports eMMC as well as SD.
>
> I want to re-use the sdhci_execute_tuning() for SD timing.
>
> On the other hand, Cadence provides its own way for eMMC HS200 tuning;
> I need to touch some registers that are specific to Cadence's design.
>
>
> Changes in v4:
>   - export sdhci_execute_tuning() instead of using
>     execute_execute_tuning()
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42ef3eb..0c03a89 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1948,7 +1948,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>         return 0;
>  }
>
> -static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>         u16 ctrl;
> @@ -2141,6 +2141,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         spin_unlock_irqrestore(&host->lock, flags);
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>
>  static int sdhci_select_drive_strength(struct mmc_card *card,
>                                        unsigned int max_dtr, int host_drv,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 9c35776..786eee9 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -689,6 +689,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> +int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host);
> --
> 2.7.4
>
