From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 03/15] mmc: mvsdio: Convert to use devm_ioremap_resource
Date: Mon, 17 Jun 2013 11:42:23 +0530
Message-ID: <51BEA8C7.3090501@linaro.org>
References: <1370864113-17895-1-git-send-email-tushar.behera@linaro.org> <1370864113-17895-4-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46653 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab3FQGM3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2013 02:12:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so2492407pab.22
        for <linux-mmc@vger.kernel.org>; Sun, 16 Jun 2013 23:12:28 -0700 (PDT)
In-Reply-To: <1370864113-17895-4-git-send-email-tushar.behera@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@gmail.com, patches@linaro.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 06/10/2013 05:05 PM, Tushar Behera wrote:
> Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
> introduced devm_ioremap_resource() and deprecated the use of
> devm_request_and_ioremap().
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: linux-mmc@vger.kernel.org
> CC: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/mvsdio.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index d08fe6a..656f1f5 100644
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
> 

Ping.

-- 
Tushar Behera
