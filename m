From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] mmc: sdhci-iproc: use sdhci_pltfm_unregister directly
Date: Tue, 26 Jan 2016 18:00:31 -0800
Message-ID: <56A824BF.3030202@broadcom.com>
References: <1453803963-6385-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453803963-6385-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, ulf.hansson@linaro.org, rjui@broadcom.com, jonmason@broadcom.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jisheng,

Looks good.

Acked-by: Scott Branden <sbranden@broadcom.com>

On 16-01-26 02:26 AM, Jisheng Zhang wrote:
> The sdhci_iproc_remove() is jsut a wrapper to sdhci_pltfm_unregister.
> So use the sdhci_pltfm_unregister() for the .remove hook directly.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/mmc/host/sdhci-iproc.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3b423b0..24c5546 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -220,11 +220,6 @@ err:
>   	return ret;
>   }
>
> -static int sdhci_iproc_remove(struct platform_device *pdev)
> -{
> -	return sdhci_pltfm_unregister(pdev);
> -}
> -
>   static struct platform_driver sdhci_iproc_driver = {
>   	.driver = {
>   		.name = "sdhci-iproc",
> @@ -232,7 +227,7 @@ static struct platform_driver sdhci_iproc_driver = {
>   		.pm = SDHCI_PLTFM_PMOPS,
>   	},
>   	.probe = sdhci_iproc_probe,
> -	.remove = sdhci_iproc_remove,
> +	.remove = sdhci_pltfm_unregister,
>   };
>   module_platform_driver(sdhci_iproc_driver);
>
>
