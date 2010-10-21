From: Philip Rakity <prakity@marvell.com>
Subject: Re: sdhci: mmc:  determining card type and dynamic clocks
Date: Thu, 21 Oct 2010 10:37:52 -0700
Message-ID: <63E87425-A910-4658-AE78-DFD6D7852422@marvell.com>
References: <AED80D39-301D-490D-8729-C2CAA765F192@marvell.com>
 <alpine.LFD.2.00.1010211243250.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41419 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751885Ab0JURh5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Oct 2010 13:37:57 -0400
In-Reply-To: <alpine.LFD.2.00.1010211243250.2764@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>


On Oct 21, 2010, at 9:57 AM, Nicolas Pitre wrote:

> On Thu, 21 Oct 2010, Philip Rakity wrote:
> 
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
>> 	card->dev.bus = &mmc_bus_type;
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
>>     dynamic_clocks=FALSE;
>> else if host->mmc->card == MMC_TYPE_SDIO)
>>    	dynamic_clocks = TRUE;
>> else 
>>    	dynamic_clocks = FALSE;
>> 
>> 
>> My question is:  Is there a better way to pass the type of card to the sd driver?
> 
> I don't like this.  Again we should strive to make the controller driver 
> as simple as possible and let the core code handle this kind of clocking 
> logic as much as possible.  The OMAP driver is again a terribly bad 
> example to follow.

Not looking at OMAP

> 
> If there are cases where the clock still has to remain active with some 
> cards, it is far better to take care of such exceptions in only one 
> place instead of having to add a card quirk in every controller drivers.  
> The controller driver should remain card agnostic as much as possible 
> and not take decisions on its own based on card type.

Was not going to add a quirk.  The low level platform specific code for
sdhci.c can handle this if it knows the card type.  It can program the
appropriate hardware registers.

> 
> Stopping the clock would also be a good thing even for those controllers 
> without dynamic clock support. The core could certainly stop the clock 
> manually after a period of inactivity for example.


agree except that stopping the clock for SDIO cards is not a good thing to do in our experience.
if the core can signal this via set_ios this works for me.  This is why I suggested the code telling
set_ios the card type which allowed the platform specific code to enable or not dynamic 
clocks.

> 
> So if your controller hardware has the ability to dynamically stop the 
> clock on its own, then the driver should simply expose that knowledge to 
> the core with a capability bit, and the core should tell the driver to 
> enable that mode through mmc_set_ios() when applicable.

sd 3.0 spec (not marvell specific) suppports dynamic clocking as well as marvell v2.0
controller.

I can add a CAP bit -- but for SDIO cards we will certainly set this to not disable the clocks.

100,000 foot summary
a) add new mmc->caps bit indicating dynamic clocks can be supported in the controller
b) add new field in ios that indicates if clocks should be dynamic
c) pass this to set_ios
d) add platform specific hook to set_ios to control the dynamic clocking option.

Is my understanding correct ?



> 
> 
> Nicolas

