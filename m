From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 1/4] mmc: sdhci-cadence: add suspend / resume support
Date: Mon, 28 Aug 2017 13:11:30 +0300
Message-ID: <9143e4b7-bb93-c775-30d1-a327051b820e@intel.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
 <1503461703-16225-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503461703-16225-2-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Hu Ziji <huziji@marvell.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 23/08/17 07:15, Masahiro Yamada wrote:
> Currently, the probe function initializes the PHY, but PHY settings
> are lost during the sleep state.  Restore the PHY registers when
> resuming.
> 
> To facilitate this, split sdhci_cdns_phy_init() into the DT parse
> part and PHY update part so that the latter can be invoked from the
> resume hook.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v4:
>  - disable clk if resume fails.
> 
> Changes in v3:
>  - Use #ifdef CONFIG_PM_SLEEP instead of __maybe_unused
>  - Add own sdhci_cdns_suspend implementation to not depend on
>    the core change
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-cadence.c | 106 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 19d5698244b5..3dca3b3c6436 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -67,9 +67,16 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> +struct sdhci_cdns_phy_param {
> +	u8 addr;
> +	u8 data;
> +};
> +
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	bool enhanced_strobe;
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_phy_param phy_params[0];
>  };
>  
>  struct sdhci_cdns_phy_cfg {
> @@ -115,9 +122,22 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  	return 0;
>  }
>  
> -static int sdhci_cdns_phy_init(struct device_node *np,
> -			       struct sdhci_cdns_priv *priv)
> +static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
>  {
> +	unsigned int count = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> +		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
> +			count++;
> +
> +	return count;
> +}
> +
> +static void sdhci_cdns_phy_param_parse(struct device_node *np,
> +				       struct sdhci_cdns_priv *priv)
> +{
> +	struct sdhci_cdns_phy_param *p = priv->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> @@ -127,9 +147,19 @@ static int sdhci_cdns_phy_init(struct device_node *np,
>  		if (ret)
>  			continue;
>  
> -		ret = sdhci_cdns_write_phy_reg(priv,
> -					       sdhci_cdns_phy_cfgs[i].addr,
> -					       val);
> +		p->addr = sdhci_cdns_phy_cfgs[i].addr;
> +		p->data = val;
> +		p++;
> +	}
> +}
> +
> +static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < priv->nr_phy_params; i++) {
> +		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
> +					       priv->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -302,6 +332,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> +	size_t priv_size;
> +	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  
> @@ -313,7 +345,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, sizeof(*priv));
> +	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> +	priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
> +	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
>  		goto disable_clk;
> @@ -322,7 +356,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->clk = clk;
>  
> -	priv = sdhci_cdns_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
> @@ -336,7 +371,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> -	ret = sdhci_cdns_phy_init(dev->of_node, priv);
> +	sdhci_cdns_phy_param_parse(dev->of_node, priv);
> +
> +	ret = sdhci_cdns_phy_init(priv);
>  	if (ret)
>  		goto free;
>  
> @@ -353,6 +390,57 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_cdns_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int ret;
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +	return 0;
> +}
> +
> +static int sdhci_cdns_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdhci_cdns_phy_init(priv);
> +	if (ret)
> +		goto disable_clk;
> +
> +	ret = sdhci_resume_host(host);
> +	if (ret)
> +		goto disable_clk;
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_cdns_suspend, sdhci_cdns_resume)
> +};
> +
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{ .compatible = "socionext,uniphier-sd4hc" },
>  	{ .compatible = "cdns,sd4hc" },
> @@ -363,7 +451,7 @@ MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
>  static struct platform_driver sdhci_cdns_driver = {
>  	.driver = {
>  		.name = "sdhci-cdns",
> -		.pm = &sdhci_pltfm_pmops,
> +		.pm = &sdhci_cdns_pm_ops,
>  		.of_match_table = sdhci_cdns_match,
>  	},
>  	.probe = sdhci_cdns_probe,
> 
