From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] sdhci: Add device tree property sd-broken-highspeed
Date: Thu, 6 Oct 2016 10:03:56 +0200
Message-ID: <CAPDyKFqw7mcvW=HTnZ9AoDFEk4TTBsecphaYxMGrEneDoKOevw@mail.gmail.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
 <1474660869-15532-2-git-send-email-zach.brown@ni.com> <CAPDyKFogDKM86XKo1iQE1KU5HpEic23FD5YQGF9QjSFYBDJn4Q@mail.gmail.com>
 <CAL_JsqLjtn2-FaO_h9JWOsZqttQ35yV6KOnQz2Z-cMr=0GHJCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqLjtn2-FaO_h9JWOsZqttQ35yV6KOnQz2Z-cMr=0GHJCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 5 October 2016 at 22:03, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Oct 5, 2016 at 1:33 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On 23 September 2016 at 22:01, Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org> wrote:
>>> Certain board configurations can make highspeed malfunction due to
>>> timing issues. In these cases a way is needed to force the controller
>>> and card into standard speed even if they otherwise appear to be capable
>>> of highspeed.
>>>
>>> The sd-broken-highspeed property will let the sdhci driver know that
>>> highspeed will not work.
>>>
>>> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> index 8a37782..59332ea 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> @@ -52,6 +52,8 @@ Optional properties:
>>>  - no-sdio: controller is limited to send sdio cmd during initialization
>>>  - no-sd: controller is limited to send sd cmd during initialization
>>>  - no-mmc: controller is limited to send mmc cmd during initialization
>>> +- sd-broken-highspeed: Highspeed is broken, even if the controller and card
>>> +  themselves claim they support highspeed.
>>
>> Regarding a broken card, that is managed via the card quirks and not in DT.
>>
>> If this is about a controller limitation, we already have the option
>> to describe what it supports, so we don't need an option to tell what
>> it *not* supports.
>>
>> For example "cap-sd-highspeed" tells whether the controller supports
>> SD high-speed, please use that instead.
>
> If a controller has a capability register and it lies (perhaps the
> board has limitations that the SoC does not), then you may need to
> disable a feature.

I understand, although the SDHCI capabilities register is broken for
most SDHCI variants. In principle, we would more or less have to add a
*-broken binding for each bit in that register. I don't like that!

Maybe a better option is to add a "sdhci-cap-broken" or perhaps
"sdhci-cap-speed-modes-broken", which tells the driver to not rely on
the capabilities register and instead find out what *is* supported by
looking at the other mmc generic DT bindings.

What do you think of that?

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
