From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 11:01:52 -0500
Message-ID: <5033B0F0.7050506@gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org> <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com> <87k3ws5uhs.fsf@octavius.laptop.org> <201208211208.49987.arnd@arndb.de> <87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com> <87pq6k46jg.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab2HUQBz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 12:01:55 -0400
In-Reply-To: <87pq6k46jg.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>

On 08/21/2012 10:18 AM, Chris Ball wrote:
> Hi,
> 
> On Tue, Aug 21 2012, Rob Herring wrote:
>>> cd-gpios and cd-external can be present on the same node.  if broken-cd
>>> is present, it must be the only one of these nodes used.
>>
>> I don't see the point of cd-external. Either you just use the CD
>> interrupt defined within the SDHCI or you have a gpio line independent
>> of the SDHCI and use cd-gpios.
> 
> You've described two of the possible cases, but not the third.  In the
> third case, you have a gpio line that is not independent of the SDHCI,
> because it is the SDHCI's CD pin brought out to be directly accessible
> via a GPIO.

That is covered by absence of cd-gpios and broken-cd. Any *-gpios
property means the signal is a GPIO line controlled by a GPIO controller.

I suppose you could have the CD state readable via the SDHCI, but the
interrupt comes from a GPIO controller. Or vice-versa, but that's a
pretty broken use case if you can't pick which way you are going to use
things.

> 
> The difference is in the handling of the interrupt -- if you don't have
> "cd-external" then you're just using the SDHCI's interrupt, but if you
> have an independent line then you're going to need to register your own
> IRQ handler on it, and "cd-external" signifies that.
> 
> Thomas wrote this explanation earlier in the thread:
>> "samsung,sdhci-cd-gpio" means that the cd-gpio line is not connected
>> to the card-detect pad of the sdhci controller. Instead, it identifies
>> cd-gpio as a gpio pin, connected to the card-detect pin of the "card
>> slot" and it can used as a source of external interrupt. The driver
>> can register card insert/remove handler for this interrupt and get
>> notified about the changes in card state.
>>
>> "sdhci-cd-internal" means that the "cd-gpio" line is used to connect
>> the card-detect pin of the card slot and the card-detect pad of the
>> sdhci controller. The controller is then aware of any changes in card
>> state and the controller generates appropriate interrupts to notify
>> changes in card-state.
> 

It seems you are mixing pin muxing and who controls/handles the CD
detect signal. Pin muxing is a separate issue and should be addressed by
pin mux bindings. Either the signal functions as a GPIO or it functions
as a CD as part of the SDHCI. You may have muxing on the CD pin that
allows it to function either way, but the DT binding should describe how
you want it to be configured and used.

Rob

> Thanks,
> 
> - Chris.
> 

