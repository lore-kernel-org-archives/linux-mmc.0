From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 06/12] mmc: sdhci-of-at91: use sdhci_pltfm_init for
 private allocation
Date: Wed, 6 Jan 2016 10:02:15 +0100
Message-ID: <20160106090215.GG2334@odux.rfo.atmel.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
 <1452052565-4232-7-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452052565-4232-7-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Jisheng,

Thanks for your patch but it needs to be updated since it breaks this
driver.

-       struct sdhci_at91_priv  *priv = pltfm_host->priv;
+       struct sdhci_at91_priv  *priv = sdhci_pltfm_priv(pltfm_host);

is missing in sdhci_at91_runtime_suspend and sdhci_at91_runtime_resume
causing a NULL pointer dereference.

On Wed, Jan 06, 2016 at 11:55:59AM +0800, Jisheng Zhang wrote:
> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
> sdhci-of-at91 driver to this allocation.
> 
> Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 06d0b50..765eb09 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -68,11 +68,13 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	soc_data = match->data;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(&pdev->dev, "unable to allocate private data\n");
> -		return -ENOMEM;
> -	}
> +	host = sdhci_pltfm_init(pdev, soc_data,
> +				sizeof(*priv));

Can be on the same line.

Regards

Ludovic

> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
>  	if (IS_ERR(priv->mainck)) {
> @@ -92,10 +94,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->gck);
>  	}
>  
> -	host = sdhci_pltfm_init(pdev, soc_data, 0);
> -	if (IS_ERR(host))
> -		return PTR_ERR(host);
> -
>  	/*
>  	 * The mult clock is provided by as a generated clock by the PMC
>  	 * controller. In order to set the rate of gck, we have to get the
> @@ -135,9 +133,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	clk_prepare_enable(priv->mainck);
>  	clk_prepare_enable(priv->gck);
>  
> -	pltfm_host = sdhci_priv(host);
> -	pltfm_host->priv = priv;
> -
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto clocks_disable_unprepare;
> @@ -163,7 +158,7 @@ static int sdhci_at91_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host	*host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
> -	struct sdhci_at91_priv	*priv = pltfm_host->priv;
> +	struct sdhci_at91_priv	*priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	sdhci_pltfm_unregister(pdev);
>  
> -- 
> 2.7.0.rc3
> 
