From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: sdhci: mmc:  determining card type and dynamic clocks
Date: Thu, 21 Oct 2010 15:08:45 +0300
Message-ID: <4CC02D4D.8070600@nokia.com>
References: <AED80D39-301D-490D-8729-C2CAA765F192@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28598 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0JUMIy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 08:08:54 -0400
In-Reply-To: <AED80D39-301D-490D-8729-C2CAA765F192@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 21/10/10 14:12, ext Philip Rakity wrote:
>
> Sometimes it is useful for the SD driver to know the type of card that is in use so that dynamic sd bus clocking can be enabled or disabled.
> Dynamic clocks are a feature of sd 3.0 and we can support this in our v2.0 controller.
>
> The problem is that some SDIO cards are not happy when the clocks are dynamically stopped.  I have not seen any issues with SD/mmc/eMMC cards.  I suspect the reason for the SDIO problems is that the cards need the clock since SDIO cards can interrupt the CPU for service and the other card types cannot.
>
> The information about the type of card being used is known by the mmc layer when
>
> mmc_alloc_card(struct mmc_host *host, struct device_type *type) --- core/bus.c
>
> is called but the sd driver cannot get to this information when set_ios() is called by the mmc layer since the host->card field is filled in too late.
>
> I have added host->card = card to
>
> struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
> {
> 	struct mmc_card *card;
>
> 	card = kzalloc(sizeof(struct mmc_card), GFP_KERNEL);
> 	if (!card)
> 		return ERR_PTR(-ENOMEM);
>
> 	card->host = host;
>
> 	device_initialize(&card->dev);
>
> 	card->dev.parent = mmc_classdev(host);
> 	card->dev.bus =&mmc_bus_type;
> 	card->dev.release = mmc_release_card;
> 	card->dev.type = type;
> +     host->card = card;
> 	return card;
> }
>
> and this works for me provided the sd driver remembers to check for card being NULL  in the driver specific set_clock code.
>
> My pseudo code is
>
> if (host->mmc->card == NULL)
>       dynamic_clocks=FALSE;
> else if host->mmc->card == MMC_TYPE_SDIO)
>      	dynamic_clocks = TRUE;
> else
>      	dynamic_clocks = FALSE;
>
>
> My question is:  Is there a better way to pass the type of card to the sd driver?
>

Have you considered passing the I/O state (dynamic clocks?) instead
of the card type?

