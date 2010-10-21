From: Philip Rakity <prakity@marvell.com>
Subject: Re: sdhci: mmc:  determining card type and dynamic clocks
Date: Thu, 21 Oct 2010 08:17:27 -0700
Message-ID: <1FC4EB0A-407F-4DDC-8E08-5B5FC71DC5C1@marvell.com>
References: <AED80D39-301D-490D-8729-C2CAA765F192@marvell.com>
 <4CC02D4D.8070600@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48149 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751092Ab0JUPSR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Oct 2010 11:18:17 -0400
In-Reply-To: <4CC02D4D.8070600@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


On Oct 21, 2010, at 5:08 AM, Adrian Hunter wrote:

> On 21/10/10 14:12, ext Philip Rakity wrote:
>> 
>> Sometimes it is useful for the SD driver to know the type of card that is in use so that dynamic sd bus clocking can be enabled or disabled.
>> Dynamic clocks are a feature of sd 3.0 and we can support this in our v2.0 controller.
>> 
>> The problem is that some SDIO cards are not happy when the clocks are dynamically stopped.  I have not seen any issues with SD/mmc/eMMC cards.  I suspect the reason for the SDIO problems is that the cards need the clock since SDIO cards can interrupt the CPU for service and the other card types cannot.
>> 
>> The information about the type of card being used is known by the mmc layer when
>> 
>> mmc_alloc_card(struct mmc_host *host, struct device_type *type) --- core/bus.c
>> 
>> is called but the sd driver cannot get to this information when set_ios() is called by the mmc layer since the host->card field is filled in too late.
>> 
>> I have added host->card = card to
>> 
>> struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
>> {
>> 	struct mmc_card *card;
>> 
>> 	card = kzalloc(sizeof(struct mmc_card), GFP_KERNEL);
>> 	if (!card)
>> 		return ERR_PTR(-ENOMEM);
>> 
>> 	card->host = host;
>> 
>> 	device_initialize(&card->dev);
>> 
>> 	card->dev.parent = mmc_classdev(host);
>> 	card->dev.bus =&mmc_bus_type;
>> 	card->dev.release = mmc_release_card;
>> 	card->dev.type = type;
>> +     host->card = card;
>> 	return card;
>> }
>> 
>> and this works for me provided the sd driver remembers to check for card being NULL  in the driver specific set_clock code.
>> 
>> My pseudo code is
>> 
>> if (host->mmc->card == NULL)
>>      dynamic_clocks=FALSE;
>> else if host->mmc->card == MMC_TYPE_SDIO)
>>     	dynamic_clocks = TRUE;
>> else
>>     	dynamic_clocks = FALSE;
>> 
>> 
>> My question is:  Is there a better way to pass the type of card to the sd driver?
>> 
> 
> Have you considered passing the I/O state (dynamic clocks?) instead
> of the card type?
> 


Not sure I understand.  The SD driver knows the clock state but does not know the type of card that is being used.  
The pseudo code goes into the platform specific driver code in mmc/host.   I do not know how to make the clocks state 
dynamic / vs continuous visible in the mmc/core layer.   I am not sure that providing a hook in the mmc/core layer for 
core/ to switch the clock state is desirable.

One consideration is that the clocks at the sd driver layer should start as continuous and then switch to dynamic once
the type of card is known.  The other way around is not safe.

