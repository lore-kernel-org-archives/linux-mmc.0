From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: let GPIO based card detection have higher
 precedence
Date: Fri, 26 Jun 2015 13:19:43 +0300
Message-ID: <558D273F.8020108@intel.com>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org> <1435312810-23957-2-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1435312810-23957-2-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26/06/15 13:00, Ivan T. Ivanov wrote:
> Controller could have BROKEN_CARD_DETECTION quirk set, but drivers
> could use GPIO to detect card present state. Let, when defined, GPIO
> take precedence, so drivers could properly detect card state and not
> use polling.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bc14452..8bafb9f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1601,15 +1601,18 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
>  	if (host->flags & SDHCI_DEVICE_DEAD)
>  		return 0;
> 
> +	/*
> +	 * Try slot gpio detect, if defined it take precedence
> +	 * over build in controller functionality
> +	 */
> +	if (!IS_ERR_VALUE(gpio_cd))
> +		return !!gpio_cd;
> +

You've also put it above the MMC_CAP_NONREMOVABLE check which doesn't seem
right.

>  	/* If polling/nonremovable, assume that the card is always present. */
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
>  	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
>  		return 1;
> 
> -	/* Try slot gpio detect */
> -	if (!IS_ERR_VALUE(gpio_cd))
> -		return !!gpio_cd;
> -
>  	/* Host native card detect */
>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
> --
> 1.9.1
> 
> 
> 
