From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: add comment why sdio_reset is done at init
	time
Date: Thu, 24 Feb 2011 18:41:21 +0000
Message-ID: <20110224184121.GA11663@void.printf.net>
References: <1091D46E-68D9-49FC-BBA6-6908BC1835AD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47656 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab1BXSlW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 13:41:22 -0500
Content-Disposition: inline
In-Reply-To: <1091D46E-68D9-49FC-BBA6-6908BC1835AD@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Philip,

On Sun, Feb 13, 2011 at 11:12:28PM -0800, Philip Rakity wrote:
> 
> sdio_reset sends a CMD52 to reset the sdio card.  This is
> highly recommended for sdio cards being reinitialized.  Since
> we do not know if the card is being reinitialized we just send
> the command.  SD/eMMC cards are supposed to ignore the CMD
> before the CMD0.  Document why we are doing this.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 34a7e8c..d9fb0d3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1494,6 +1494,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>  		mmc_hostname(host), __func__, host->f_init);
>  #endif
>  	mmc_power_up(host);
> +
> +	/*
> +	 * sdio_reset sends CMD52 to reset card.  Since we do not know
> +	 * if the card is being re-initialzed just send it.  CMD52
> +	 * should be ignored by SD/eMMC cards
> +	 */
>  	sdio_reset(host);
>  	mmc_go_idle(host);
>  

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
