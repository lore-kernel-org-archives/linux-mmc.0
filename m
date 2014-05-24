From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Sat, 24 May 2014 12:10:58 +0200
Message-ID: <53807032.5020500@redhat.com>
References: <537DC832.3020006@redhat.com> <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk> <537F3610.3050104@redhat.com> <537F4B5E.80306@broadcom.com> <537F4CE5.10707@redhat.com> <537F6143.3050703@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbaEXKL6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 May 2014 06:11:58 -0400
In-Reply-To: <537F6143.3050703@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

Hi,

On 05/23/2014 04:54 PM, Arend van Spriel wrote:
> On 05/23/14 15:28, Hans de Goede wrote:
>> Hi,
>>
>> On 05/23/2014 03:21 PM, Arend van Spriel wrote:
>>> On 05/23/14 13:50, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 05/23/2014 01:22 PM, Mark Brown wrote:
>>>>> On Fri, May 23, 2014 at 11:13:44AM +0200, Hans de Goede wrote:
>>>>>
>>>>>> Thinking more about this, I would like to make one change to my
>>>>>> proposal, the mmc-core should only do power up of child-nodes if
>>>>>> they have a compatible of: "simple-sdio-powerup". This way
>>>>>> when we add something more complex, we can keep the simple powerup
>>>>>> code in the mmc core, keeping what we've already using this working
>>>>>> and the mmc core won't respond to the child nodes for more complex
>>>>>> devices, so it won't conflict with more complex power-up handling
>>>>>> handled by some other driver.
>>>>>
>>>>> Would it not be better to have this be something in the driver struct
>>>>> rather than in the device tree?  Putting a compatible in there would be
>>>>> encoding details of the Linux implementation in the DT which doesn't
>>>>> seem right especially since these are details we're thinking of changing
>>>>> later on.
>>>>
>>>> The compatible is not a Linux specific thing, it is a marking saying
>>>> that something needs to take care of enabling the clks (and whatever
>>>> else we will make part of the binding for this compatible), before
>>>> scanning the mmc bus.
>>>>
>>>>> Something like have the driver set flags saying if it wants
>>>>> to do complicated things.
>>>>
>>>> Chicken<->   egg, we won't know which driver to use before we've probed
>>>> the mmc bus, and we cannot probe the bus before enabling the clks, etc.
>>>
>>> The approach I took with brcmfmac is that upon module init I search the DT for "brcm,bcm43xx-fmac" compatible and get the clock and/or gpio resource and enable them before registering the sdio driver. The difficulty is probably when using the driver built-in as the clocks and gpios may not be available yet and we can not rely on deferred probing in module init stage.
>>
>> I know, and that approach does not work, by the time the brcmfmac loads,
>> the mmc core has long probed the mmc bus and decided no one is home.
> 
> Ok. That is due to the non-removable property, right? I assumed a mmc rescan, which is (supposedly) triggered upon sdio driver registration, would subsequently find the device.

That is what I thought, but I tried without the non-removable property and
the sdio wifi was still not recognized.

Regards,

Hans
