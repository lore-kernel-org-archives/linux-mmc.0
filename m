From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: Convert to using %pOFn instead of device_node.name
Date: Tue, 28 Aug 2018 10:59:53 +0300
Message-ID: <b64da243-c049-31aa-625c-e9e4d751b213@intel.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-32-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-32-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28/08/18 04:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index c335052d0c02..5956e90380e8 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -660,8 +660,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>  		return 0;
>  
>  	if (of_address_to_resource(np, 1, &iomem)) {
> -		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
> -			np->name);
> +		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %pOFn\n",
> +			np);
>  		return -EINVAL;
>  	}
>  
> 
