From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/11] mmc: sdhci-of-esdhc: use of_property_read_bool
Date: Thu, 18 Aug 2016 10:36:39 +0300
Message-ID: <29aae420-01ef-b355-2fd8-87860a5f34d0@intel.com>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
 <1470387411-15879-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1470387411-15879-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 05/08/16 11:56, Julia Lawall wrote:
> Use of_property_read_bool to check for the existence of a property.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e1,e2;
> statement S2,S1;
> @@
> -       if (of_get_property(e1,e2,NULL))
> +       if (of_property_read_bool(e1,e2))
>         S1 else S2
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 239be2f..fb71c86 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -583,7 +583,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  
>  	np = pdev->dev.of_node;
>  
> -	if (of_get_property(np, "little-endian", NULL))
> +	if (of_property_read_bool(np, "little-endian"))
>  		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_le_pdata,
>  					sizeof(struct sdhci_esdhc));
>  	else
> 
> 

