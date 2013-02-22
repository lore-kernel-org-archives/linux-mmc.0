From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v2] mmc: davinci: allow driver to work without DMA
 resource
Date: Fri, 22 Feb 2013 13:03:38 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA47D52@DBDE01.ent.ti.com>
References: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58473 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099Ab3BVNDt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Feb 2013 08:03:49 -0500
In-Reply-To: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Porter, Matt" <mporter@ti.com>, "ido@wizery.com" <ido@wizery.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

Hi Chris,

As there are no comments, Could you please accept this patch?

Thanks,
Prakash

On Tue, Feb 05, 2013 at 17:52:24, Manjunathappa, Prakash wrote:
> Do not return probe failure with missing DMA resources,
> allow driver to work in PIO mode.
> Tested on da850-evm by mounting partition followed by
> file creation and deletion.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Since v1:
> Specified missing DMA resource(RX/TX).
> 
>  drivers/mmc/host/davinci_mmc.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 2063677..27123f8 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1190,13 +1190,15 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  
>  	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>  	if (!r)
> -		goto out;
> -	host->rxdma = r->start;
> +		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
> +	else
> +		host->rxdma = r->start;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>  	if (!r)
> -		goto out;
> -	host->txdma = r->start;
> +		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
> +	else
> +		host->txdma = r->start;
>  
>  	host->mem_res = mem;
>  	host->base = ioremap(mem->start, mem_size);
> -- 
> 1.7.4.1
> 
> 

