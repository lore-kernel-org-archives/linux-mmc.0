From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Fri, 08 Jul 2011 11:24:17 -0700
Message-ID: <8739ig8wby.fsf@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<1309538376-23260-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57239 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753888Ab1GHSYW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 14:24:22 -0400
In-Reply-To: <1309538376-23260-3-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Fri, 1 Jul 2011 22:09:35 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com

Balaji T K <balajitk@ti.com> writes:

> add runtime pm support to HSMMC host controller
> Use runtime pm API to enable/disable HSMMC clock
> Use runtime autosuspend APIs to enable auto suspend delay
>
> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore Kadiyala
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

It's not relevant for this merge window, but I'm exploring some future
changes to our PM core code and have a question about how MMC works for
system suspend.

Basially, the question is: can the driver be reworked such that a system
suspend does not need to runtime resume the device?  For most devices,
we kind of expect that if the device is runtime suspended, a system
suspend will have nothing extra to do, but this driver runtime resumes
the device during system suspend in order to do "stuff", which I
admitedly don't fully undestand.

Ideally, the "stuff" needed for runtime suspend and system suspend could
be made to be common such that a system suspend of a runtime suspended
device would be a noop.

Is this possible?

Kevin

> @@ -2100,6 +2087,7 @@ static int omap_hsmmc_suspend(struct device *dev)
>  		return 0;
>  
>  	if (host) {
> +		pm_runtime_get_sync(host->dev);
>  		host->suspended = 1;
>  		if (host->pdata->suspend) {
>  			ret = host->pdata->suspend(&pdev->dev,
> @@ -2114,13 +2102,11 @@ static int omap_hsmmc_suspend(struct device *dev)
>  		}
>  		cancel_work_sync(&host->mmc_carddetect_work);
>  		ret = mmc_suspend_host(host->mmc);
> -		mmc_host_enable(host->mmc);
> +
>  		if (ret == 0) {
>  			omap_hsmmc_disable_irq(host);
>  			OMAP_HSMMC_WRITE(host->base, HCTL,
>  				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
> -			mmc_host_disable(host->mmc);
> -			clk_disable(host->iclk);
>  			if (host->got_dbclk)
>  				clk_disable(host->dbclk);
>  		} else {
> @@ -2132,9 +2118,8 @@ static int omap_hsmmc_suspend(struct device *dev)
>  					dev_dbg(mmc_dev(host->mmc),
>  						"Unmask interrupt failed\n");
>  			}
> -			mmc_host_disable(host->mmc);
>  		}
> -
> +		pm_runtime_put_sync(host->dev);
>  	}
>  	return ret;
>  }
