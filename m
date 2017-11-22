From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/6 v3] mmc: sdhci-acpi: Handle return value of
 platform_get_irq
Date: Wed, 22 Nov 2017 14:02:58 +0200
Message-ID: <f40f2259-1f79-6c79-8997-76d955fd7714@intel.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <ecd11732b6a29aee23a1be94616755e575b0d438.1511066652.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:25086 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbdKVMDS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Nov 2017 07:03:18 -0500
In-Reply-To: <ecd11732b6a29aee23a1be94616755e575b0d438.1511066652.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, ben-linux@fluff.org, ulf.hansson@linaro.org, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

On 19/11/17 06:52, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
> 
>  drivers/mmc/host/sdhci-acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b988997..0d9965b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -566,6 +566,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	host->hw_name	= "ACPI";
>  	host->ops	= &sdhci_acpi_ops_dflt;
>  	host->irq	= platform_get_irq(pdev, 0);
> +	if (host->irq <= 0) {
> +		err = -EINVAL;
> +		goto err_free;
> +	}
>  
>  	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
>  					    resource_size(iomem));
> 

