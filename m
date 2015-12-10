From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Thu, 10 Dec 2015 15:32:06 +0100
Message-ID: <CAPDyKFrUcKGHDbc84+LhtR-uG4+1WiMnU9dyhW4Lof8RhxUZEg@mail.gmail.com>
References: <CAOw_LSFRskOLSPW31DUpbYv8wsrH68wkmW=F7s2jCLsRvSLfsg@mail.gmail.com>
	<CAOw_LSFCY6mTKykBNpjdVoFu5B33nD2hdf9-4NigOXz22UZK-w@mail.gmail.com>
	<CAPDyKFpJ_3zuiYnP=QcDvd-6CCOUU=jjUdXK0qbeDTQnv+Jrfg@mail.gmail.com>
	<CAOw_LSFhEuDLNfF4HCBhqx_-DmCgiV0oCYn61C7Ahr-x+LPLPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:32789 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbLJOcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2015 09:32:08 -0500
Received: by vkca188 with SMTP id a188so84514408vkc.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2015 06:32:06 -0800 (PST)
In-Reply-To: <CAOw_LSFhEuDLNfF4HCBhqx_-DmCgiV0oCYn61C7Ahr-x+LPLPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Lenski <dlenski@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Marcus Overhagen <marcus.overhagen@gmail.com>

On 8 December 2015 at 17:34, Daniel Lenski <dlenski@gmail.com> wrote:
> On Dec 8, 2015 6:11 AM, "Ulf Hansson" <ulf.hansson@linaro.org> wrote:
>>
>> On 4 December 2015 at 21:34, Daniel Lenski <dlenski@gmail.com> wrote:
>> > In conclusion... it seems that the kernel is attempting to drive this
>> > card faster than it can actually work. What I'm trying to figure out
>> > now:
>> > - How does the kernel attempt to figure out the capability of a given
>> > SD card? Where is that in the kernel source tree?
>>
>> drivers/mmc/core/*
>>
>> It's kind of complicated, but please go ahead and have a look.
>
> Will do.
>
>> > - Is it possible to make the list of supported caps a module
>> > parameter, to more easily throttle high-speed modes that don't work
>> > with a particular card?
>>
>> Maybe a sysfs/debugfs interface would be better, but I like the idea!
>>
>> Currently there is no way for userspace to disable some of these
>> "speed mode" caps, which would be very useful in cases like yours.
>>
>> I don't know if I ever will get time to hack on such code, so feel
>> free to have a try yourself!
>
> Ideally, would it be better to have a userspace control at the level of the
> individual host control drivers, or for the entire mmc/SD subsystem?

I think per host controller would be the best.

>
>> Regarding how to fix this problem right now, I guess we should remove
>> the caps which the host driver wrongly claims to support. Do you want
>> to send a patch for that?
>
> I can do that, but am unsure whether it is truly an issue with the host
> driver, or the card itself, in my case.
>
> Is there any information which I can use to clearly rule one or the other
> case out?

Well, you can try other SDHC cards and you may also try the failing
card to see if it works with another host controller.

>
> If I understood Marcus Overhagen's original post correctly, he was
> successful with a UHS SDHC card and this same controller.

Okay. It may be that this card need some special treatment or that the
UHS support for rtsx is fragile.

>
> Thanks,
> Dan

Kind regards
Uffe
