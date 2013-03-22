From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] drivers: mmc: host: Use resource_size()
Date: Fri, 22 Mar 2013 12:39:06 -0400
Message-ID: <87hak3o0d1.fsf@octavius.laptop.org>
References: <1363043094-11352-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34026 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998Ab3CVQjJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:39:09 -0400
In-Reply-To: <1363043094-11352-1-git-send-email-gheorghiuandru@gmail.com>
	(Alexandru Gheorghiu's message of "Tue, 12 Mar 2013 01:04:54 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 11 2013, Alexandru Gheorghiu wrote:
> Used resource_size function instead of explicit computation.
> Patch found using coccinelle.
>
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  drivers/mmc/host/wmt-sdmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 154f0e8..541e097 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -925,7 +925,7 @@ static int wmt_mci_remove(struct platform_device *pdev)
>  	clk_put(priv->clk_sdmmc);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
>  
>  	mmc_free_host(mmc);

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
