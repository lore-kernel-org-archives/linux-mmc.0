From: Arend van Spriel <arend@broadcom.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Mon, 26 May 2014 09:51:18 +0200
Message-ID: <5382F276.8090305@broadcom.com>
References: <537DC832.3020006@redhat.com> <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk> <537F3610.3050104@redhat.com> <20140523162718.GE22111@sirena.org.uk> <53806F26.6050706@redhat.com> <20140525123452.GS22111@sirena.org.uk> <53824294.1090609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:27687 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaEZHvX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 03:51:23 -0400
In-Reply-To: <53824294.1090609@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>Russell King - ARM Linux <linux@arm.linux.org.uk>

+ Russell

On 05/25/14 21:20, Hans de Goede wrote:
> Hi,
>
> On 05/25/2014 02:34 PM, Mark Brown wrote:
>> On Sat, May 24, 2014 at 12:06:30PM +0200, Hans de Goede wrote:
>>> On 05/23/2014 06:27 PM, Mark Brown wrote:
>>>> On Fri, May 23, 2014 at 01:50:40PM +0200, Hans de Goede wrote:
>>>>> On 05/23/2014 01:22 PM, Mark Brown wrote:
>>
>>>>> The compatible is not a Linux specific thing, it is a marking saying
>>>>> that something needs to take care of enabling the clks (and whatever
>>>>> else we will make part of the binding for this compatible), before
>>>>> scanning the mmc bus.
>>
>>>> We could just say that the mere presence of a child node with the right
>>>> properties is sufficient to trigger the bus to do the startup?
>>
>>> Yes, except that most involved property names are standardized, ie clocks,
>>> and we want to be able to opt out of the KISS mmc core code for
>>> (future) complex power on sequences.
>>
>> This is why I'm suggesting keying off the specific compatible strings
>> for drivers that want to opt out of the helpers rather than having a
>> compatible string to enable the helpers (which may depend on the
>> particular Linux version if the feature sets of drivers change for
>> example).
>>
>>>> If the device is sufficiently complicated to need a special power up
>>>> sequence I'd expect we'd be able to have a compatible string which would
>>>> provide enough information for us to figure things out.
>>
>>> Hmm, so what you're suggesting is indeed more of an opt out then my initial
>>> opt-in to KISS powerup idea. So to be clear what you're suggesting is:
>>
>>> mmc core walks host mmc-child nodes. Loads drivers based on compatibles
>>> there. The checks a flag field in the driver to see if the driver wants to
>>> opt-out of the KISS powerup code. The problem with this is that it won't
>>
>> Yes.
>>
>>> work reliable with modules, think the mmc probe being done from the ramdisk,
>>> and the driver in question only being available from the rootfs. I really
>>
>> Why is that a problem - if we have no driver for the device there is no
>> point in powering it up in the first place is there?
>
> Well the driver may show up later, so if we only do the power-up once we have
> a driver, this means we need to re-check if we need to do the powerup later.
>
> Also the mmc people are very much against specifying a driver, as that is
> something which should be probed not specified. I agree with them I've
> already seen boards were more or less standardized sdio modules from different
> vendors are used, they have various standard sdio powerup related things, like
> an enable signal in standard places, but different editions of the boards
> have different sdio modules soldered on, using different drivers.
>
> I expect that with some care we can make all variants of these boards work with
> a single dts file, by using a simple sdio wifi powerup mechanism, and after
> that letting the mmc core figure out which module is actually soldered on.
>
>>> believe that using opt-in with a compatible such as simple-sdio-powerup
>>> is by far the safest thing to do, and as an added advantage we don't need
>>> to worry about how to deal with the future complex power on cases at all,
>>> we leave all the room in the world for various future scenarios. since as
>>> soon as the simple-sdio-powerup compatible is not there the mmc core will
>>> behave as it does today.
>>
>> Please remember that the DT is *supposed* to be an ABI - systems are
>> supposed to be able to ship with a fixed DT and have it work with random
>> operating systems they have no knowledge of (and may not even exist at
>> the time the DT is being created).  This means we can't rely on removing
>> a compatible string later on.
>
> I know that the DT is an ABI, and I'm not arguing for removing support for
> the simple-sdio-powerup compatible from the kernel when a more complex
> case arrives, nor am I arguing to remove it from the DT for existing working
> boards. The idea behind the simple-sdio-powerup compatible is that it makes
> the simple powerup behavior opt-in. So if a new board comes along which
> requires something more complex, the people working on this can do what ever
> they want / need without the simple powerup code getting in the way, as
> long as they don't *add* the simple-sdio-powerup compatible to their *new*
> DT file.
>
> Basically the idea behind the simple-sdio-powerup compatible is to make
> the worst case scenario for more complex boards to be the scenario which
> we have today, i.e. no support for sdio powerup at all, rather then having
> something in place which actually may get in the way, making things worse
> then they are today.

Hi Hans,

I recalled a recent patchset from Russell King. He was working on i.MX6 
platform with brcmfmac device and ended reworking sdhci/mmc host 
controller code in a series of patches [1]. Patch 34 might be similar to 
what you are trying to accomplish.

Regards,
Arend
