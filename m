From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2] mmc: mmci: Use pm_runtime_put_noidle() during
 ->probe()
Date: Fri, 19 Dec 2014 10:59:22 +0000
Message-ID: <20141219105922.GF11285@n2100.arm.linux.org.uk>
References: <1418986459-13443-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40135 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752146AbaLSK73 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:59:29 -0500
Content-Disposition: inline
In-Reply-To: <1418986459-13443-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On Fri, Dec 19, 2014 at 11:54:19AM +0100, Ulf Hansson wrote:
> Previously the pm_runtime_put() caused the device to be runtime PM
> suspended, but then immediately being resumed when we add the host.
> 
> Prevent this unnecessary runtime PM suspend/resume cycle during
> ->probe() by using the pm_runtime_put_noidle() variant instead.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	Move pm_runtime_put_noidle() after mmc_add_host().
> 
> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 8232e9a..d2bbd25 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1739,10 +1739,10 @@ static int mmci_probe(struct amba_device *dev,
>  
>  	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>  	pm_runtime_use_autosuspend(&dev->dev);
> -	pm_runtime_put(&dev->dev);
>  
>  	mmc_add_host(mmc);
>  
> +	pm_runtime_put_noidle(&dev->dev);

I think you'd want this to be _put() in this case.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
