From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: pwrseq-simple: Add an optional
 post-power-on-delay
Date: Sat, 2 Jul 2016 11:11:43 +0200
Message-ID: <af2b6f24-53c6-9f45-83f6-8967e03d01f9@redhat.com>
References: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqJ0XVJb=Q9FT8g_OUTbgZWr-E58xQS0iCR4hv-9EHCcPA@mail.gmail.com>
 <b056f5c8-e77f-ff90-afa5-cd77e446e2dd@redhat.com>
 <20160701004732.GA20831@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701004732.GA20831@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

HI,

On 01-07-16 02:47, Rob Herring wrote:
> On Thu, Jun 23, 2016 at 11:33:27AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 23-06-16 00:25, Rob Herring wrote:
>>> On Wed, Jun 22, 2016 at 12:59 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Some devices need a while to boot their firmware after providing clks /
>>>> de-asserting resets before they are ready to receive sdio commands.
>>>>
>>>> This commits adds a post-power-on-delay-ms devicetree property to
>>>> mmc-pwrseq-simple for use with such devices.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>> Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>>>> drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>>>> 2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>>>> index ce0e767..e254368 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>>>> @@ -16,6 +16,8 @@ Optional properties:
>>>>   See ../clocks/clock-bindings.txt for details.
>>>> - clock-names : Must include the following entry:
>>>>   "ext_clock" (External clock provided to the card).
>>>> +- post-power-on-delay-ms : Delay in ms after powering the card and
>>>> +       de-asserting the reset-gpios (if any)
>>>
>>> Presumably you need this delay post any reset, not just after power on
>>
>> mmc-pwrseq is only about doing power-on / off, not about providing
>> reset functionality.
>
> Yes, but the property (e.g. the delay) is relevant for both and reset is
> part of the power seq.
>
>>> if you are waiting for firmware to boot. So the name is not all that
>>> clear. How about a "reset-timing-ms" property that takes 3 values for
>>> pre-assert time (normally 0), assertion time, post assert time. Of
>>> course, I can still think of ways that breaks like when in this
>>> sequence do clocks need to be turned on.
>>
>> If you look at bindings/mmc/mmc-pwrseq-simple.txt out side of
>> the diff context it contains:
>>
>> - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
>>         at initialization and prior we start the power up procedure of the card.
>>         They will be de-asserted right after the power has been provided to the
>>         card.
>> - clocks : Must contain an entry for the entry in clock-names.
>>   See ../clocks/clock-bindings.txt for details.
>> - clock-names : Must include the following entry:
>>   "ext_clock" (External clock provided to the card).
>>
>> Notice how the existing docs talk about a power-up procedure (which matches
>> the pwrseq name and purpose of these bindings).
>>
>> I actually started with calling the property "post-reset-delay-ms", but then
>> I realized that what we really want is the ability to specify a time to
>> wait (for e.g. firmware to boot) after completing the power-up procedure
>> (and before starting the probe). The power-up procedure currently can
>> also includes enabling external clocks to the sdio device (if any) and
>> enabling regulators, so having a "reset-timing-ms" property does not
>> seem right, as that would suggest it is ok to do the wait after deasserting
>> reset, but before e.g. enabling external clocks. Where what we really
>> want is to enable all necessary resources (or iow complete the powerup
>> procedure) and then wait.
>>
>> You're right that in some cases more complicated timings may be necessary,
>> but that can get really complicated like e.g.: enable regulator1, wait 10 ms,
>> enable regulator2, wait 15ms, enable external clock1, ...
>>
>> And such complex timings fall outside of the scope of the mmc-pwrseq-simple
>> binding, the idea being that for complex cases we do a device specific
>> pwrseq binding, and then the smarts are in implementation of that specific
>> pwrseq driver. As you've said yourself before we do not want to turn
>> devicetree into a scripting language.
>
> Exactly. The challenge is any single property is hard to push back on
> that we've crossed that line. I don't want to see this expanded one
> property at a time without any foresight on additional needs. If we can
> add a property that is more flexible, but doesn't add to the complexity
> then that would be better. So this one alone is fine, but the next one
> I'll be less receptive.

Understood, so does this mean that you're happy with the patch as
originally posted, or would you still like to see some changes ?

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
