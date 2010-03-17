From: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?=
	<richard.rojfors@pelagicore.com>
Subject: Re: [PATCH 3/3] sdhci-pltfm: Do not print errors in case of an extended
 iomem size
Date: Wed, 17 Mar 2010 07:02:52 +0100
Message-ID: <4BA0708C.8070402@pelagicore.com>
References: <20100316183400.GA24191@oksana.dev.rtsoft.ru> <20100316183430.GC25670@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:45542 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0CQGVc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Mar 2010 02:21:32 -0400
In-Reply-To: <20100316183430.GC25670@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@csr.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/16/10 7:34 PM, Anton Vorontsov wrote:
> Some hosts have an extended SDHCI iomem size, so the driver should
> only print errors if the iomem size is less than 0x100.

With this change you allow a bigger resource than we really need.
I think you should also change request_mem_region and ioremap to only
request and map the actual needed size. (0x100)

> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 217b911..b6ee0d7 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -61,7 +61,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	if (resource_size(iomem) != 0x100)
> +	if (resource_size(iomem) < 0x100)
>  		dev_err(&pdev->dev, "Invalid iomem size. You may "
>  			"experience problems.\n");
>  

