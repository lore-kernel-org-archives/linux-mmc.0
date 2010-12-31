From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Fri, 31 Dec 2010 04:49:42 +0000
Message-ID: <20101231044942.GC19122@void.printf.net>
References: <4D1A1B19.8000902@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45544 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab0LaEtv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Dec 2010 23:49:51 -0500
Content-Disposition: inline
In-Reply-To: <4D1A1B19.8000902@windriver.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: linux-mmc@vger.kernel.org, Hein Tibosch <hein_tibosch@yahoo.es>, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>

Hi Andy,

This patch doesn't apply against mmc-next, which makes it hard to review
properly; could you rebase/resend?

I like the look of these changes, just a few comments:

On Tue, Dec 28, 2010 at 09:15:05AM -0800, Andy Ross wrote:
> @@ -1450,19 +1440,12 @@ void mmc_rescan(struct work_struct *work)
>  	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead)
>  		host->bus_ops->detect(host);
> 
> -	mmc_bus_put(host);
> -
> -
> -	mmc_bus_get(host);
> -
>  	/* if there still is a card present, stop here */
>  	if (host->bus_ops != NULL) {
>  		mmc_bus_put(host);
>  		goto out;
>  	}

Let's leave these in -- I think we're depending on the side-effect of 
mmc_bus_put() clearing out host->bus_ops.  I'll check and submit a
separate patch adding a comment there explaining what's going on.

> +		/* Try SDIO, then SD, then MMC */
> +		if(mmc_attach_sdio(host) == 0)
> +			break;
> +		else if(mmc_attach_sd(host) == 0)
> +			break;
> +		else if(mmc_attach_mmc(host) == 0)
> +			break;

Space after if, and perhaps let's use !mmc_attach_*() rather than == 0
for brevity.  I guess we could also consider:

		/* Try SDIO, then SD, then MMC */
		if (mmc_attach_sdio(host) && mmc_attach_sd(host) &&
		    mmc_attach_mmc(host))
			mmc_power_off(host);

	mmc_release_host(host);

which would save quite a few lines, but perhaps it's less clear (or not
equivalent somehow).  What do you think?

> -out_fail:
> -		mmc_release_host(host);
> -		mmc_power_off(host);
> +              mmc_power_off(host);

This looks misaligned.

> + 	if((err = mmc_send_op_cond(host, 0, &ocr)))
> +		return err;

Redundant parens, and space after if.

> +	if((err =mmc_send_io_op_cond(host, 0, &ocr)))

As above, plus space after =.

Thanks!  You might also consider splitting this up into two separate
patches, but I'll leave that up to you.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
