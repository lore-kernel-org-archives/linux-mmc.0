From: Aapo Vienamo <aapo.vienamo@iki.fi>
Subject: Re: [PATCH] mmc: tegra: fix inconsistent IS_ERR and PTR_ERR
Date: Tue, 4 Sep 2018 13:13:27 +0300
Message-ID: <20180904131327.1cb5b7b5@iki.fi>
References: <20180904025909.13700-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904025909.13700-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 4 Sep 2018 10:59:09 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Fix inconsistent IS_ERR and PTR_ERR in tegra_sdhci_init_pinctrl_info,
> the proper pointer to be passed as argument is 'pinctrl_state_1v8'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Aapo Vienamo <aapo.vienamo@iki.fi>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e80716c..c789158 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -724,7 +724,7 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>  		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
>  	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
>  		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
> -			 PTR_ERR(tegra_host->pinctrl_state_3v3));
> +			 PTR_ERR(tegra_host->pinctrl_state_1v8));
>  		return -1;
>  	}
>  
