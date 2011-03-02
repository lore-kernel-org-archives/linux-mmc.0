From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc/sdio: remember new card RCA when redetecting card
Date: Wed, 02 Mar 2011 11:32:41 -0500
Message-ID: <m3lj0xsct2.fsf@pullcord.laptop.org>
References: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55528 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab1CBQea (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2011 11:34:30 -0500
In-Reply-To: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
	(Linus Walleij's message of "Tue, 1 Mar 2011 14:41:04 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Tue, Mar 01 2011, Linus Walleij wrote:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> During redetection of a SDIO card, a request for a new card RCA
> was submitted to the card, but was then overwritten by the old RCA.
> This caused the card to be deselected instead of selected when using
> the incorrect RCA.

Nico, would you mind taking a look at this, please?  Assigning to a
member of oldcard because we know it's later going to be copied into
card seems a little ugly to me (at least without a comment explaining
that); I'm wondering if you'd suggest something else here.

And, just to check we're all on the same page, this would be a
regression introduced back at 2.6.32 when the "oldcard" handling
was first merged, so it should be sent up with a stable tag.

(I'm not yet sure whether I want to send this to mainline during the
last week of a release and without any previous testing, given that
the bug is more than a year old already.  Let's see what Nico says.)

Thanks.

> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-by: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/sdio.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 617e9ad..30d065d 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -395,6 +395,13 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>  		if (err)
>  			goto remove;
>  
> +		/*
> +		 * Update oldcard with the new RCA received from the
> +		 * SDIO device.
> +		 */
> +		if (oldcard)
> +			oldcard->rca = card->rca;
> +
>  		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
>  	}

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
