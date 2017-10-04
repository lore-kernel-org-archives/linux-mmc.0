From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: make function sdhci_at91_set_uhs_signaling
 static
Date: Wed, 4 Oct 2017 10:59:55 +0200
Message-ID: <CAPDyKFrLQdjd2nG3iH1_VQAFHSq7TQ44GUBhZXPHeO6b24KRBg@mail.gmail.com>
References: <20171003100636.26124-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003100636.26124-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 October 2017 at 12:06, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The function sdhci_at91_set_uhs_signaling  is local to the source and does
> not need to be in global scope, so make it static.
>
> Cleans up sparse warning:
> symbol 'sdhci_at91_set_uhs_signaling' was not declared. Should it be
> static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 4e47ed6bc716..682c573e20a7 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -114,7 +114,8 @@ static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
>         sdhci_set_power_noreg(host, mode, vdd);
>  }
>
> -void sdhci_at91_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
> +                                        unsigned int timing)
>  {
>         if (timing == MMC_TIMING_MMC_DDR52)
>                 sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
> --
> 2.14.1
>
