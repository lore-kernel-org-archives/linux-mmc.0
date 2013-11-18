From: Alexey Neyman <stilor@att.net>
Subject: Re: [PATCH] mmc: sdhci: Avoid needless loop while handling SDIO interrupts in sdhci_irq()
Date: Mon, 18 Nov 2013 12:01:11 -0800
Message-ID: <2863850.GcQ0l6lPBj@mistral>
References: <CAA+hA=StthxfMWjQ+0fhdRiPuDDVWUGrrW9E71Q+E3RoF_QdHw@mail.gmail.com> <1383709236-26692-1-git-send-email-stilor@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm25-vm7.access.bullet.mail.bf1.yahoo.com ([216.109.115.198]:42524
	"EHLO nm25-vm7.access.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab3KRUBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2013 15:01:13 -0500
In-Reply-To: <1383709236-26692-1-git-send-email-stilor@att.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

[yet another patch ping]

On Tuesday, November 05, 2013 07:40:36 PM Alexey Neyman wrote:
> Ignore Card Interrupt bit in the interrupt status if we already know that
> mmc_signal_sdio_irq() is going to be called at the end of sdhci_irq(). This
> avoids a needless loop in sdhci_irq() repeatedly reading interrupt status
> and doing nothing.
> 
> Signed-off-by: Alexey Neyman <stilor@att.net>
> Acked-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7a7fb4f..a83cd1b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2491,6 +2491,14 @@ again:
>  	result = IRQ_HANDLED;
> 
>  	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +
> +	/*
> +	 * If we know we'll call the driver to signal SDIO IRQ, disregard
> +	 * further indications of Card Interrupt in the status to avoid a
> +	 * needless loop.
> +	 */
> +	if (cardint)
> +		intmask &= ~SDHCI_INT_CARD_INT;
>  	if (intmask && --max_loops)
>  		goto again;
>  out:

