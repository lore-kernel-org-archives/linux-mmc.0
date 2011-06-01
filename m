From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/2] sdio: report error if pending IRQ but none function
 bits
Date: Wed, 1 Jun 2011 10:30:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106011029390.30544@xanadu.home>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org> <1306874008-28867-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44255 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab1FAOam (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 10:30:42 -0400
Received: by qwk3 with SMTP id 3so2608286qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 07:30:41 -0700 (PDT)
In-Reply-To: <1306874008-28867-3-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Chris Ball <cjb@laptop.org>

On Tue, 31 May 2011, Per Forlin wrote:

> Return error in case of pending IRQ but none functions bits
> in CCCR_INTx is set.
> 
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 2f81ddc..8184b6e 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -50,6 +50,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>  		return ret;
>  	}
>  
> +	if (!pending) {
> +		printk(KERN_WARNING "%s: pending IRQ but none function bits\n",
> +		       mmc_card_id(card));
> +		ret = -EINVAL;
> +	}

Nope, this won't work with the polled interrupt mode.


Nicolas
