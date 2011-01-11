From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 13/16] MMC: jz4740: don't treat NULL clk as an error
Date: Tue, 11 Jan 2011 23:22:26 +0000
Message-ID: <20110111232226.GB25752@void.printf.net>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com> <1294749833-32019-14-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42457 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab1AKXW1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 18:22:27 -0500
Content-Disposition: inline
In-Reply-To: <1294749833-32019-14-git-send-email-jamie@jamieiles.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Jamie,

On Tue, Jan 11, 2011 at 12:43:50PM +0000, Jamie Iles wrote:
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock.  clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.
> 
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  drivers/mmc/host/jz4740_mmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index b3a0ab0..74218ad 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/mmc/host.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> @@ -827,8 +828,8 @@ static int __devinit jz4740_mmc_probe(struct platform_device* pdev)
>  	}
>  
>  	host->clk = clk_get(&pdev->dev, "mmc");
> -	if (!host->clk) {
> -		ret = -ENOENT;
> +	if (IS_ERR(host->clk)) {
> +		ret = PTR_ERR(host->clk);
>  		dev_err(&pdev->dev, "Failed to get mmc clock\n");
>  		goto err_free_host;
>  	}

Thanks, pushed to mmc-next and queued as a .38 fix.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
