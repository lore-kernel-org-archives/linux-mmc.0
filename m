From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: tegra: use mmc_of_parse to get the support of
 standard MMC DT bindings
Date: Wed, 20 Feb 2013 10:07:35 -0700
Message-ID: <512502D7.4090605@wwwdotorg.org>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com> <1361343902-15223-3-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361343902-15223-3-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 02/20/2013 12:05 AM, Joseph Lo wrote:
> Updating the sdhci-tegra driver to use mmc_of_parse to support standard
> MMC DT bindings. Then we can remove the redundant code that already support

>  static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> -
> -	if (!gpio_is_valid(tegra_host->wp_gpio))
> -		return -1;
> -
> -	return gpio_get_value(tegra_host->wp_gpio);
> +	return mmc_gpio_get_ro(host->mmc);
>  }

It'd be nice if there was a standard version of this function that could
be plugged directly into struct sdhci_ops, so that each individual
driver doesn't have to re-invent this wrapper.

> @@ -220,15 +203,12 @@ static void sdhci_tegra_parse_dt(struct device *dev,
>  					struct sdhci_tegra *tegra_host)
>  {
...
> +	struct sdhci_host *host;
...
> +	host = platform_get_drvdata(to_platform_device(dev));
> +	mmc_of_parse(host->mmc);
>  }

It might be simpler to change the function prototype to simply pass in
the host object too.
