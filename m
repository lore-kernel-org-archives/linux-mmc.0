From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] mmc: davinci: allow driver to work without DMA resource
Date: Fri, 1 Feb 2013 12:27:04 +0530
Message-ID: <510B6740.7050808@ti.com>
References: <1359620433-3546-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39009 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3BAG5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Feb 2013 01:57:15 -0500
In-Reply-To: <1359620433-3546-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, mporter@ti.com, davinci-linux-open-source@linux.davincidsp.com, gregkh@linuxfoundation.org, cjb@laptop.org

On 1/31/2013 1:50 PM, Manjunathappa, Prakash wrote:
> Do not return probe failure with missing DMA resources,
> allow driver to work in PIO mode.
> Tested on da850-evm.

It will be nice to mention what exactly was tested. rootfs mount? file
create/deletion? mount/unmount?

> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  drivers/mmc/host/davinci_mmc.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 2063677..382b79d 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1190,13 +1190,15 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  
>  	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>  	if (!r)
> -		goto out;
> -	host->rxdma = r->start;
> +		dev_warn(&pdev->dev, "DMA resource not specified\n");

Why not be specific and call it "RX DMA" instead. Anyone who gets this
error will have to do that anyway since you have now got two identical
error messages.

> +	else
> +		host->rxdma = r->start;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>  	if (!r)
> -		goto out;
> -	host->txdma = r->start;
> +		dev_warn(&pdev->dev, "DMA resource not specified\n");

"TX DMA" here.

Thanks,
Sekhar
