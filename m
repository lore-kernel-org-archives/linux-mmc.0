From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
Date: Mon, 27 Aug 2018 12:07:08 +0200
Message-ID: <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Allow SDHCI drivers to hook code before and after sdhci_request() by
> making it externally visible.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

This one happens to be useful for other variants but Tegras, hence I
have applied this one for next. Thanks!

Thierry, you may thus drop this one from your PR. Also, you should
probably base your pull request on top of my next branch, as I have
already started to queue up some changes for sdhci.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index da47f7b..1e0c0a6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
>   *                                                                           *
>  \*****************************************************************************/
>
> -static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct sdhci_host *host;
>         int present;
> @@ -1675,6 +1675,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         mmiowb();
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_request);
>
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cc963a5..73c4744 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -729,6 +729,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>                      unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>                            unsigned short vdd);
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> --
> 2.7.4
>
