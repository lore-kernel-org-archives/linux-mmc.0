From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 16/33] mmc: sdhci-xenon: use match_string() helper
Date: Thu, 24 May 2018 10:58:42 +0300
Message-ID: <91fa698a-5e9f-d5ef-c50e-eada27db7c04@intel.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 21/05/18 14:57, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index ec87943..a35804b 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -814,15 +814,10 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	int i, ret;
> +	int ret;
>  
> -	for (i = 0; i < NR_PHY_TYPES; i++) {
> -		if (!strcmp(phy_name, phy_types[i])) {
> -			priv->phy_type = i;
> -			break;
> -		}
> -	}
> -	if (i == NR_PHY_TYPES) {
> +	priv->phy_type = match_string(phy_types, NR_PHY_TYPES, phy_name);
> +	if (priv->phy_type < 0) {
>  		dev_err(mmc_dev(host->mmc),
>  			"Unable to determine PHY name %s. Use default eMMC 5.1 PHY\n",
>  			phy_name);
> 
