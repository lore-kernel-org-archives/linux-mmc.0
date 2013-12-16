From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
Date: Mon, 16 Dec 2013 12:58:44 +0100
Message-ID: <52AEEAF4.3010703@metafoo.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com> 	 <1386901645-28895-1-git-send-email-ynvich@gmail.com> 	 <1386901645-28895-4-git-send-email-ynvich@gmail.com> 	 <201312142006.26979.arnd@arndb.de>  <1387049660.7152.317.camel@host5.omatika.ru> <52AECEB2.4070807@gmail.com> <1387194450.13062.134.camel@host5.omatika.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387194450.13062.134.camel-7ZSkjCHmnyFmet/iJI8ZvA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DOCUMENTATION <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 12/16/2013 12:47 PM, Sergei Ianovich wrote:
> On Mon, 2013-12-16 at 10:58 +0100, Daniel Mack wrote:
>> On 12/14/2013 08:34 PM, Sergei Ianovich wrote:
>>> On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:
>>
>>>> The patch looks ok in case we are merging your patches for 3.14
>>>> and Daniel's patches later than that. If they end up in the
>>>> same merge window however, we'd have to be care to resolve
>>>> the obvious conflict in a proper way.
>>>
>>> The most recently published Daniel's patch (Aug 2013) wraps
>>> IORESOURCE_DMA handling on DT presence in a similar way,
>>
>> Erm, no it doesn't. My patch uses dma_request_slave_channel_compat() in
>> DT case, and that works fine with the current version of pdma, and
>> there's no need to read the "dmas" properties directly.
>>
>> If you want to provide a way to simply denote the dma channel numbers,
>> without looking at the actual phandle, then yes, we could merge this
>> patch first, but it would be effectively reverted a proper implementation.
> 
> Daniel is right. His patch doesn't need to read "dmas" directly. So my
> patch won't need to change drivers/mmc/host/pxamci.c at all, if it is
> applied after Daniel's one.
> 

Btw. any driver that parses the dmas property manually should be considered
broken. This is a classical layering violation. The layout of the dma
specifier is DMA controller specific and should be completely transparent to
the device driver.

- Lars
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
