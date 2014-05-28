From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Wed, 28 May 2014 12:27:35 +0200
Message-ID: <5385BA17.9040301@redhat.com>
References: <537E31F7.1030505@gmail.com>	<537F1148.3010102@redhat.com>	<20140523112239.GB12304@sirena.org.uk>	<537F3610.3050104@redhat.com>	<20140523162718.GE22111@sirena.org.uk>	<53806F26.6050706@redhat.com>	<20140525123452.GS22111@sirena.org.uk>	<53824294.1090609@redhat.com>	<20140526103807.GV22111@sirena.org.uk>	<538321AB.4050006@redhat.com>	<20140526142225.GF22111@sirena.org.uk>	<538356DA.7090302@redhat.com>	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>	<53838023.2080807@redhat.com> <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com> <5385AF94.90004@redhat.com> <5385B689.5000802@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaE1K2j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 May 2014 06:28:39 -0400
In-Reply-To: <5385B689.5000802@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 05/28/2014 12:12 PM, Arend van Spriel wrote:

<snip>

>>>> Yes, although I must admit that have not thought about how to deal with
>>>> slots, I've no experience with the mmc slots concept at all, or is slot
>>>> just a different name for sdio function ?
>>>
>>> Some mmc hosts may support more than one slot. Thus they can operate
>>> on more than one card.
>>>
>>> Currently, there are no support for this in the mmc core. There can
>>> only be one card per host, but that's due to software limitation of
>>> the mmc stack.  Following your suggestion; modelling the card as child
>>> node under the mmc host, can easily be extended to support more than
>>> one slot.
>>
>> Actually what I'm suggesting is based on Sascha Hauer's
>> "mmc: Add SDIO function devicetree subnode parsing"
>>
>> Patch, which models the sdio functions as child nodes, (with the
>> one with reg =<0>  being the card itself) this also makes sense since each
>> sdio-function gets its own device representing it, so having one child node
>> per sdio-functions leads to one child node per device which seems sensible.
> 
> To complicate thing, for brcmfmac the sdio functions are not considered individual devices. This means that brcmfmac creates one driver instance which claims multiple sdio functions.

Right, but that is not really important for the overall device tree model
we can just put all the info brcmfmac needs in the child-node for sdio-func 1,
and then the driver can get to it since it claims both functions anyways,
that is actually what the oob irq support patchset I posted a few days ago
does. But that patch-set is missing the extra slot level in the child-nodes,
so if we agree we want that extra level in the hierarchy I'll need to fix
that for v2 of the set.

Regards,

Hans
