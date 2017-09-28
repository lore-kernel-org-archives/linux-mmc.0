From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an optional bus clock
Date: Thu, 28 Sep 2017 17:57:41 +0200
Message-ID: <87o9puhl3e.fsf@free-electrons.com>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170928150520.27616-1-gregory.clement@free-electrons.com>
        (Gregory CLEMENT's message of "Thu, 28 Sep 2017 17:05:20 +0200")
Sender: stable-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,
 
 On jeu., sept. 28 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 2eec2e652c53..845575593b59 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -466,6 +466,7 @@ static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> +	struct xenon_priv *priv;
>  	int err;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> @@ -474,6 +475,7 @@ static int xenon_probe(struct platform_device *pdev)
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	/*
>  	 * Link Xenon specific mmc_host_ops function,
> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
>  	if (err)
>  		goto free_pltfm;
>  
> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> +	if (IS_ERR(priv->axi_clk)) {
> +		err = PTR_ERR(priv->axi_clk);
> +		dev_err(&pdev->dev, "Failed to setup axi clk: %d\n", err);

I should manage the -EPROBE_DEFER case here. So a v2 of this patch is
coming soon.

Sorry to not have seen this before sending the patch.

Gregory

> +		priv->axi_clk = NULL;
> +	} else {
> +		err = clk_prepare_enable(priv->axi_clk);
> +		if (err)
> +			goto err_clk;
> +	}
> +
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
> -		goto err_clk;
> +		goto err_clk_axi;
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -502,11 +515,11 @@ static int xenon_probe(struct platform_device *pdev)
>  	/* Xenon specific dt parse */
>  	err = xenon_probe_dt(pdev);
>  	if (err)
> -		goto err_clk;
> +		goto err_clk_axi;
>  
>  	err = xenon_sdhc_prepare(host);
>  	if (err)
> -		goto err_clk;
> +		goto err_clk_axi;
>  
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> @@ -527,6 +540,9 @@ static int xenon_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  	xenon_sdhc_unprepare(host);
> +err_clk_axi:
> +	if (priv->axi_clk)
> +		clk_disable_unprepare(priv->axi_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  free_pltfm:
> @@ -538,6 +554,7 @@ static int xenon_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -546,6 +563,8 @@ static int xenon_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 0);
>  
>  	xenon_sdhc_unprepare(host);
> +	if (priv->axi_clk)
> +		clk_disable_unprepare(priv->axi_clk);
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 2bc0510c0769..9994995c7c56 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -83,6 +83,7 @@ struct xenon_priv {
>  	unsigned char	bus_width;
>  	unsigned char	timing;
>  	unsigned int	clock;
> +	struct clk      *axi_clk;
>  
>  	int		phy_type;
>  	/*
> -- 
> 2.14.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
