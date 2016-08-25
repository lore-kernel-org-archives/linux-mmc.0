From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 17:50:16 +0200
Message-ID: <e703a068-810f-77fe-d702-138911669147@metafoo.de>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825151047.GO16583@xsjsorenbubuntu>
 <d5dd97b1-f58f-2e45-5c95-17a77a46b30c@metafoo.de>
 <20160825152944.GP16583@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160825152944.GP16583@xsjsorenbubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 08/25/2016 05:29 PM, Sören Brinkmann wrote:
> On Thu, 2016-08-25 at 17:23:47 +0200, Lars-Peter Clausen wrote:
>> On 08/25/2016 05:10 PM, Sören Brinkmann wrote:
>>> On Wed, 2016-08-24 at 18:23:03 -0500, Zach Brown wrote:
>>>> The sdhci controller on xilinx zynq devices will not function unless
>>>> the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
>>>> In cases where it is impossible to provide the cd bit in hardware,
>>>> setting the controller to test mode and then setting inserted to true
>>>> will get the controller to function with out the cd bit.
>>>>
>>>> The device property "fake-cd" will let the arasan driver know it needs
>>>> to fake the cd bit for the controller inorder for the controller to
>>>> function with a SD card that does not provide the CD bit.
>>>
>>> I thought the CD is, if not pinned out, tied off to some valid logic
>>> level. Isn't it enough to specify cd-inverted if needed to make it work
>>> in those cases?
>>
>> It is always brought out to some pin, that is the problem on the Zynq. This
>> means you'd have to set at least one pin aside as dummy CD or WP pin. Which
>> is not always possible when you are tight on available pins.
> 
> I have to admit that I haven't looked at Vivado for quite a while. Is it
> possible to select EMIO for those pins? If those are not routed anything
> they should be tied to some logic level, I believe.
> If they are always forced to be on a physical pin, do you let that pin
> just float? Otherwise, the logic level should also be defined, give and
> take a logic inversion.

Yes, it is possible to source them from EMIO. We had the same issue with WP
on one of our boards and the routing to EMIO approach was one of the
solutions I considered. But I could not find documentation on whether and
how the pins are tied when the FPGA is not configured or what happens during
reconfiguration, is there a chance of glitches.

So I went with the software solution of specifying disable-wp for the slot
instead.

But even if using EMIO works I think correctly describing the hardware,
which is that there is no external WP or CD pin connected, is the better
approach rather than playing around with invert flags, which has a different
semantical meaning. Software can than work with that information and take
the approach it is best to handle the situation. And this approach might
change if we find better ways to handle it, whereas the hardware description
stays static.



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
