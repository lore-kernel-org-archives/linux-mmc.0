From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] drivers: mmc: host: use devm_ioremap_resource()
Date: Tue, 14 May 2013 09:39:25 +0900
Message-ID: <001601ce503b$7bfd1840$73f748c0$@samsung.com>
References: <1368369860-32085-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65091 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab3ENAj1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 20:39:27 -0400
In-reply-to: <1368369860-32085-1-git-send-email-laurent.navet@gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Laurent Navet' <laurent.navet@gmail.com>, nico@fluxnic.net, cjb@laptop.org
Cc: andrew@lunn.ch, thomas.petazzoni@free-electrons.com, jason@lakedaemon.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>

Sunday, May 12, 2013 11:44 PM, Laurent Navet wrote:
> 
> eplace a call to deprecated devm_request_and_ioremap by devm_ioremap_resource.

CC'ed Sachin Kamat

Fix the typo: eplace -> replace

> 
> Found with coccicheck and this semantic patch:
>  scripts/coccinelle/api/devm_ioremap_resource.cocci
> 
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>

It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/mmc/host/mvsdio.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 8960fc8..a66ee4b 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -758,9 +758,9 @@ static int __init mvsd_probe(struct platform_device *pdev)
> 
>  	spin_lock_init(&host->lock);
> 
> -	host->base = devm_request_and_ioremap(&pdev->dev, r);
> -	if (!host->base) {
> -		ret = -ENOMEM;
> +	host->base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(host->base)) {
> +		ret = PTR_ERR(host->base);
>  		goto out;
>  	}
> 
> --
> 1.7.10.4

