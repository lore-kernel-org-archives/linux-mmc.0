From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Thu, 12 Jan 2017 16:57:30 +0100
Message-ID: <CAPDyKFpm_B0aSQ2sY6yz9eYGzp1sokLVt0uk5K-9UkU=gYOOEw@mail.gmail.com>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
 <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
 <CAPDyKFpCY+LHFkJVJGHaSDODVR7_Xr2ohpdOAn9Hd3qZbDTQ6w@mail.gmail.com>
 <B85DDAB6-D86B-4DD9-BF2C-BCB9FA09CD15@ranostay.consulting>
 <CAPDyKFp9t1SEwQZ=uTHegbpgxxevQEy4kC=wPkc8Bo16030MNg@mail.gmail.com>
 <CAJ_EiSQWN0KF1rJDwzOeoi--g1Z0XNYevYzCLG=NngcdgF6VUw@mail.gmail.com>
 <20161209180930.nsy2ys66q2thbxpx@rob-hp-laptop> <CAPDyKFp2L7x=dV6O5XrA53-OOXE0sf+P3tNH93XGyzNheX9vjQ@mail.gmail.com>
 <CAJ_EiST_kSDn=ypnnZJJJ-wmB7Avp+MT7uK00H+aDhQGc4Yddg@mail.gmail.com>
 <CAJ_EiSRAQefYj+B3AKLb1EWXQUGccV=Z4op0T5sAdo3-vDVOhg@mail.gmail.com>
 <CACRpkdad7JXzxYfuB_XYdo2vuZmEt5iWgq79Va5cWwTaJc6Y5Q@mail.gmail.com>
 <CAJ_EiSQYz2aEGiCv2npxmby0nHwmJJyR_jzY5wJOK98zp6Bvzg@mail.gmail.com>
 <CAPDyKFp5j5ZqJkavCSYwWQ7nKtjOqCTv=ubhjYRsSEJUw07e3Q@mail.gmail.com> <CAJ_EiSQaE4FcLdf_8t8=6cNCZ+nAWhqqANKbfEp7VW02=Kj-RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37226 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdALP5d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 10:57:33 -0500
Received: by mail-wm0-f43.google.com with SMTP id c206so26933449wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 07:57:32 -0800 (PST)
In-Reply-To: <CAJ_EiSQaE4FcLdf_8t8=6cNCZ+nAWhqqANKbfEp7VW02=Kj-RA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>

On 12 January 2017 at 05:43, Matt Ranostay <matt@ranostay.consulting> wrote:
> On Wed, Jan 11, 2017 at 2:55 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 9 January 2017 at 05:53, Matt Ranostay <matt@ranostay.consulting> wrote:
>>> On Fri, Dec 30, 2016 at 12:05 AM, Linus Walleij
>>> <linus.walleij@linaro.org> wrote:
>>>> On Mon, Dec 19, 2016 at 1:01 AM, Matt Ranostay <matt@ranostay.consulting> wrote:
>>>>
>>>>> * SD8787 has a "powerdown" line, and CW1200 has a "powerup" line.. I
>>>>> know this is a simple logic inversion.
>>>>
>>>> If this is a GPIO line, the GPIO subsystem can flag a line for
>>>> inverted logic. GPIO_ACTIVE_LOW from device tree for example.
>>>
>>> Slight ping on Ulf on this thread :).
>>
>> Thanks, sorry for the delay!
>>
>>>
>>> I do understand the inverted logic flag but that doesn't help if there
>>> are different logic states between various chipsets.
>>
>> For cw1200 (I looked at code from an old ST-Ericsson vendor tree), the
>> sequence is as follows:
>>
>> 1) Enable clock/power to the card/chip.
>> 2) Assert GPIO pin. I assume this also can be done before the
>> clock/power is enabled.
>> 3) Wait some time (~50ms).
>> 4) De-assert GPIO pin.
>> 5) Wait some time (~20ms)
>> 6) Assert GPIO pin.
>> 7) Wait some time (~32ms).
>>
>> At power off, the GPIO pin is de-asserted and of course also the
>> clock/power is disabled. Just to make sure we have all the relevant
>> logic.
>>
>> Looking at mmc pwrseq simple, perhaps we can extend this to deal with
>> GPIOs that needs to be *toggled*, as this is not just reset GPIOs.
>> Then we also need to deal with the delays in-between the toggling.
>
> Wouldn't we need to have a per chip function for each device
> supported? As well document gpios? I suspect we'd need an array of

I was hoping to avoid this, but the more I look at it, it seems inevitable.

> gpios defined in device tree since different devices will likely have
> various numbers of pins to toggle

Maybe we can think of a clever way to combine cw1200 with your case?
Perhaps a "mmc pwrseq toggle". :-) If not, please go ahead an repost a
device specific mmc pwrseq for your case.

I realize this would be a good opportunity for me to work on enabling
support for cw1200 on ux500, but as the implementation of the
clock/power control also needs to be up-streamed, I am quite far from
being done.

Kind regards
Uffe
