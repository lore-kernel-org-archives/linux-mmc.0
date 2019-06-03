From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] mmc: sdhci-sprd: Check the enable clock's return
 value correctly
Date: Mon, 3 Jun 2019 15:09:53 +0300
Message-ID: <a3276a2f-f857-eaf8-11c2-fe383c47df8a@intel.com>
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <7e4d922ba5aff5241b0186e9480a98b14693b28d.1558346019.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e4d922ba5aff5241b0186e9480a98b14693b28d.1558346019.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc: vincent.guittot@linaro.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> Missed to check the enable clock's return value, fix it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 9a822e2..e741491 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -368,7 +368,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto pltfm_free;
>  
> -	clk_prepare_enable(sprd_host->clk_enable);
> +	ret = clk_prepare_enable(sprd_host->clk_enable);
>  	if (ret)
>  		goto clk_disable;
>  
> 
