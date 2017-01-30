From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] mmc: bcm2835: Add new driver for the internal SD controller.
Date: Mon, 30 Jan 2017 09:22:23 +0100
Message-ID: <CAPDyKFr=x9KkzWxaeTJsJgonGMPY_RV6i2HRLLsqB9zZgYiy5A@mail.gmail.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-3-git-send-email-kraxel@redhat.com> <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
 <ec09cd58-6613-82d7-60a9-7a7c2d9ae673@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ec09cd58-6613-82d7-60a9-7a7c2d9ae673-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 27 January 2017 at 17:04, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> Am 27.01.2017 um 16:27 schrieb Ulf Hansson:
>> On 27 January 2017 at 12:36, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>>
>>> The 2835 has two SD controllers:  The Arasan SDHCI controller (supported
>>> by the iproc driver) and a custom SD controller.  This patch adds a
>>> driver for the custom SD controller.
>>>
>>> The custom controller runs faster, and driving the sdcard with the
>>> custom controller also allows to drive the rpi3 wifi with the iproc
>>> driver.
>>>
>> I don't understand this relationship. Is this somewhat configurable in runtime?
>
> The configuration is done by devicetree via pin muxing. AFAIK both SD
> controller are available on the same pins (2 pin groups = pin 22 to 27 +
> pin 48 to 53). So it's possible to use both SD controllers at the same
> time with different pin groups. This is necessary to use Wifi via SDIO
> on the RPi 3 while the other controller handles SD card with the rootfs.
>
>>
>> Is the WIFI module a removable SDIO card?
>
> No
>
>>  So you can decide which
>> controller that is best suited to use?
>
> Yes, but it requires also both drivers.
>

Okay, thanks for clarifying - I will go on with the review.

If a re-spin of the series is needed, please make sure to update the
coverletter with some information from above, so I don't get confused
again. :-)

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
