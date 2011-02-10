From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] dw_mmc: Run card detect tasklet during slot
	initialisation.
Date: Thu, 10 Feb 2011 19:43:54 +0000
Message-ID: <20110210194353.GA19076@void.printf.net>
References: <AANLkTi=NFjSaGFOrJm24nHB_ngEyqA6eQ4g835yQDMdX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60618 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab1BJTnz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 14:43:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=NFjSaGFOrJm24nHB_ngEyqA6eQ4g835yQDMdX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Hi Will,

On Thu, Feb 10, 2011 at 10:40:42AM +0000, Will Newton wrote:
> We need to run the card detect tasklet at the end of slot initialisation
> as it is possible that a card has been inserted prior to boot, so we don't
> see an insertion interrupt and now the card is sitting there inserted but with
> no power to it.
> 
> Signed-off-by: Neil Jones <neil.jones@imgtec.com>
> Signed-off-by: Will Newton <will.newton@imgtec.com>
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> ---
>  drivers/mmc/host/dw_mmc.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2fcc825..0b0bedd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1441,6 +1441,13 @@ static int __init dw_mci_init_slot(struct
> dw_mci *host, unsigned int id)
>  	/* Card initially undetected */
>  	slot->last_detect_state = 0;
> 
> +
> +	/*
> +	 * Card may have been plugged in prior to boot so we
> +	 * need to run the detect tasklet
> +	 */
> +	tasklet_schedule(&host->card_tasklet);
> +
>  	return 0;
>  }
> 

Pushed to mmc-next, after:

* rewrapping the commit message to be < 80 chars
* removing the redundant first added newline in the patch
* fixing the patch being corrupt due to line-wrapping

Please fix these in the future (especially the linewrap), thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
