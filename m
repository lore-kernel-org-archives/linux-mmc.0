From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH -next] mmc: jz4740: fix return value check in jz4740_mmc_probe()
Date: Sat, 24 Aug 2013 22:01:04 -0400
Message-ID: <87zjs6ttpb.fsf@octavius.laptop.org>
References: <CAPgLHd9ij8_+Kk7Sjp=5xVwg_t2EjkuhVPKf2C35Y5kRwa=zVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45472 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157Ab3HYCBK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 22:01:10 -0400
In-Reply-To: <CAPgLHd9ij8_+Kk7Sjp=5xVwg_t2EjkuhVPKf2C35Y5kRwa=zVA@mail.gmail.com> (Wei
	Yongjun's message of "Sat, 29 Jun 2013 08:44:53 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lars@metafoo.de, viresh.kumar@linaro.org, g.liakhovetski@gmx.de, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

Hi Wei,

On Fri, Jun 28 2013, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR(). Also there is already a error message within
> devm_ioremap_resource(), so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 0308c9f..d058f0c 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -783,9 +783,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!host->base) {
> -		ret = -EBUSY;
> -		dev_err(&pdev->dev, "Failed to ioremap base memory\n");
> +	if (IS_ERR(host->base)) {
> +		ret = PTR_ERR(host->base);
>  		goto err_free_host;
>  	}

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
