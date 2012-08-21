From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 11:18:59 -0400
Message-ID: <87pq6k46jg.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58368 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2HUPTI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Aug 2012 11:19:08 -0400
In-Reply-To: <5033A34E.7040201@gmail.com> (Rob Herring's message of "Tue, 21
	Aug 2012 10:03:42 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

On Tue, Aug 21 2012, Rob Herring wrote:
>> cd-gpios and cd-external can be present on the same node.  if broken-cd
>> is present, it must be the only one of these nodes used.
>
> I don't see the point of cd-external. Either you just use the CD
> interrupt defined within the SDHCI or you have a gpio line independent
> of the SDHCI and use cd-gpios.

You've described two of the possible cases, but not the third.  In the
third case, you have a gpio line that is not independent of the SDHCI,
because it is the SDHCI's CD pin brought out to be directly accessible
via a GPIO.

The difference is in the handling of the interrupt -- if you don't have
"cd-external" then you're just using the SDHCI's interrupt, but if you
have an independent line then you're going to need to register your own
IRQ handler on it, and "cd-external" signifies that.

Thomas wrote this explanation earlier in the thread:
> "samsung,sdhci-cd-gpio" means that the cd-gpio line is not connected
> to the card-detect pad of the sdhci controller. Instead, it identifies
> cd-gpio as a gpio pin, connected to the card-detect pin of the "card
> slot" and it can used as a source of external interrupt. The driver
> can register card insert/remove handler for this interrupt and get
> notified about the changes in card state.
> 
> "sdhci-cd-internal" means that the "cd-gpio" line is used to connect
> the card-detect pin of the card slot and the card-detect pad of the
> sdhci controller. The controller is then aware of any changes in card
> state and the controller generates appropriate interrupts to notify
> changes in card-state.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
