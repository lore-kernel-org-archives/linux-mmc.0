From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v3 06/12] mmc: sdhci-of-at91: use sdhci_pltfm_init for
 private allocation
Date: Wed, 6 Jan 2016 14:13:16 +0100
Message-ID: <20160106131316.GJ2334@odux.rfo.atmel.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
 <1452076303-1960-7-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452076303-1960-7-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 06, 2016 at 06:31:37PM +0800, Jisheng Zhang wrote:
> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
> sdhci-of-at91 driver to this allocation.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7e7d8f0..43f729f 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -58,7 +58,7 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_at91_priv *priv = pltfm_host->priv;
> +	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
>  	ret = sdhci_runtime_suspend_host(host);
> @@ -74,7 +74,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_at91_priv *priv = pltfm_host->priv;
> +	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
>  	ret = clk_prepare_enable(priv->mainck);
> @@ -124,11 +124,12 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	soc_data = match->data;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(&pdev->dev, "unable to allocate private data\n");
> -		return -ENOMEM;
> -	}
> +	host = sdhci_pltfm_init(pdev, soc_data, sizeof(*priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
>  	if (IS_ERR(priv->mainck)) {
> @@ -148,10 +149,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
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
> @@ -191,9 +188,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	clk_prepare_enable(priv->mainck);
>  	clk_prepare_enable(priv->gck);
>  
> -	pltfm_host = sdhci_priv(host);
> -	pltfm_host->priv = priv;
> -
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto clocks_disable_unprepare;
> @@ -230,7 +224,7 @@ static int sdhci_at91_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host	*host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
> -	struct sdhci_at91_priv	*priv = pltfm_host->priv;
> +	struct sdhci_at91_priv	*priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 2.7.0.rc3
> 
