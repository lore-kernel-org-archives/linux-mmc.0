From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Wed, 11 Jan 2017 20:43:02 -0800
Message-ID: <CAJ_EiSQaE4FcLdf_8t8=6cNCZ+nAWhqqANKbfEp7VW02=Kj-RA@mail.gmail.com>
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
 <CAJ_EiSQYz2aEGiCv2npxmby0nHwmJJyR_jzY5wJOK98zp6Bvzg@mail.gmail.com> <CAPDyKFp5j5ZqJkavCSYwWQ7nKtjOqCTv=ubhjYRsSEJUw07e3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFp5j5ZqJkavCSYwWQ7nKtjOqCTv=ubhjYRsSEJUw07e3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 11, 2017 at 2:55 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 9 January 2017 at 05:53, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
>> On Fri, Dec 30, 2016 at 12:05 AM, Linus Walleij
>> <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> On Mon, Dec 19, 2016 at 1:01 AM, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
>>>
>>>> * SD8787 has a "powerdown" line, and CW1200 has a "powerup" line.. I
>>>> know this is a simple logic inversion.
>>>
>>> If this is a GPIO line, the GPIO subsystem can flag a line for
>>> inverted logic. GPIO_ACTIVE_LOW from device tree for example.
>>
>> Slight ping on Ulf on this thread :).
>
> Thanks, sorry for the delay!
>
>>
>> I do understand the inverted logic flag but that doesn't help if there
>> are different logic states between various chipsets.
>
> For cw1200 (I looked at code from an old ST-Ericsson vendor tree), the
> sequence is as follows:
>
> 1) Enable clock/power to the card/chip.
> 2) Assert GPIO pin. I assume this also can be done before the
> clock/power is enabled.
> 3) Wait some time (~50ms).
> 4) De-assert GPIO pin.
> 5) Wait some time (~20ms)
> 6) Assert GPIO pin.
> 7) Wait some time (~32ms).
>
> At power off, the GPIO pin is de-asserted and of course also the
> clock/power is disabled. Just to make sure we have all the relevant
> logic.
>
> Looking at mmc pwrseq simple, perhaps we can extend this to deal with
> GPIOs that needs to be *toggled*, as this is not just reset GPIOs.
> Then we also need to deal with the delays in-between the toggling.

Wouldn't we need to have a per chip function for each device
supported? As well document gpios? I suspect we'd need an array of
gpios defined in device tree since different devices will likely have
various numbers of pins to toggle

- Matt

>
> Thoughts?
>
> Kind regards
> Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
