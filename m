From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/9] mmc: sdhci-sprd: Add optional gate clock support
Date: Mon, 3 Jun 2019 15:20:48 +0300
Message-ID: <2969091b-408d-c505-d406-ce4b4f0679e0@intel.com>
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <16b895cf30c235dc656eeed5888069b6266ab5f8.1558346019.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16b895cf30c235dc656eeed5888069b6266ab5f8.1558346019.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc: vincent.guittot@linaro.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> For the Spreadtrum SC9860 platform, we should enable another gate clock
> '2x_enable' to make the SD host controller work well.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index e741491..31ba7d6 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -60,6 +60,7 @@ struct sdhci_sprd_host {
>  	u32 version;
>  	struct clk *clk_sdio;
>  	struct clk *clk_enable;
> +	struct clk *clk_2x_enable;
>  	u32 base_rate;
>  	int flags; /* backup of host attribute */
>  };
> @@ -364,6 +365,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	}
>  	sprd_host->clk_enable = clk;
>  
> +	clk = devm_clk_get(&pdev->dev, "2x_enable");
> +	if (!IS_ERR(clk))
> +		sprd_host->clk_2x_enable = clk;
> +
>  	ret = clk_prepare_enable(sprd_host->clk_sdio);
>  	if (ret)
>  		goto pltfm_free;
> @@ -372,6 +377,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto clk_disable;
>  
> +	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
> +	if (ret)
> +		goto clk_disable2;
> +
>  	sdhci_sprd_init_config(host);
>  	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
> @@ -408,6 +417,9 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
> +
> +clk_disable2:
>  	clk_disable_unprepare(sprd_host->clk_enable);
>  
>  clk_disable:
> @@ -427,6 +439,7 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
>  	mmc_remove_host(mmc);
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
>  
>  	mmc_free_host(mmc);
>  
> @@ -449,6 +462,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
>  
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
>  
>  	return 0;
>  }
> @@ -459,19 +473,28 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
>  	int ret;
>  
> -	ret = clk_prepare_enable(sprd_host->clk_enable);
> +	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
>  	if (ret)
>  		return ret;
>  
> +	ret = clk_prepare_enable(sprd_host->clk_enable);
> +	if (ret)
> +		goto clk_2x_disable;
> +
>  	ret = clk_prepare_enable(sprd_host->clk_sdio);
> -	if (ret) {
> -		clk_disable_unprepare(sprd_host->clk_enable);
> -		return ret;
> -	}
> +	if (ret)
> +		goto clk_disable;
>  
>  	sdhci_runtime_resume_host(host);
> -
>  	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(sprd_host->clk_enable);
> +
> +clk_2x_disable:
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
> +
> +	return ret;
>  }
>  #endif
>  
> 
