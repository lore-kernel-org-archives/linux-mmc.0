From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH] mmc: pwrseq-simple: Add an optional post-power-on-delay
Date: Thu, 23 Jun 2016 11:33:27 +0200
Message-ID: <b056f5c8-e77f-ff90-afa5-cd77e446e2dd@redhat.com>
References: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqJ0XVJb=Q9FT8g_OUTbgZWr-E58xQS0iCR4hv-9EHCcPA@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORB36ZV25QKGQE7IFVQEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAL_JsqJ0XVJb=Q9FT8g_OUTbgZWr-E58xQS0iCR4hv-9EHCcPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 23-06-16 00:25, Rob Herring wrote:
> On Wed, Jun 22, 2016 at 12:59 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Some devices need a while to boot their firmware after providing clks /
>> de-asserting resets before they are ready to receive sdio commands.
>>
>> This commits adds a post-power-on-delay-ms devicetree property to
>> mmc-pwrseq-simple for use with such devices.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>>  drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> index ce0e767..e254368 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> @@ -16,6 +16,8 @@ Optional properties:
>>    See ../clocks/clock-bindings.txt for details.
>>  - clock-names : Must include the following entry:
>>    "ext_clock" (External clock provided to the card).
>> +- post-power-on-delay-ms : Delay in ms after powering the card and
>> +       de-asserting the reset-gpios (if any)
>
> Presumably you need this delay post any reset, not just after power on

mmc-pwrseq is only about doing power-on / off, not about providing
reset functionality.

> if you are waiting for firmware to boot. So the name is not all that
> clear. How about a "reset-timing-ms" property that takes 3 values for
> pre-assert time (normally 0), assertion time, post assert time. Of
> course, I can still think of ways that breaks like when in this
> sequence do clocks need to be turned on.

If you look at bindings/mmc/mmc-pwrseq-simple.txt out side of
the diff context it contains:

- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
         at initialization and prior we start the power up procedure of the card.
         They will be de-asserted right after the power has been provided to the
         card.
- clocks : Must contain an entry for the entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
- clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).

Notice how the existing docs talk about a power-up procedure (which matches
the pwrseq name and purpose of these bindings).

I actually started with calling the property "post-reset-delay-ms", but then
I realized that what we really want is the ability to specify a time to
wait (for e.g. firmware to boot) after completing the power-up procedure
(and before starting the probe). The power-up procedure currently can
also includes enabling external clocks to the sdio device (if any) and
enabling regulators, so having a "reset-timing-ms" property does not
seem right, as that would suggest it is ok to do the wait after deasserting
reset, but before e.g. enabling external clocks. Where what we really
want is to enable all necessary resources (or iow complete the powerup
procedure) and then wait.

You're right that in some cases more complicated timings may be necessary,
but that can get really complicated like e.g.: enable regulator1, wait 10 ms,
enable regulator2, wait 15ms, enable external clock1, ...

And such complex timings fall outside of the scope of the mmc-pwrseq-simple
binding, the idea being that for complex cases we do a device specific
pwrseq binding, and then the smarts are in implementation of that specific
pwrseq driver. As you've said yourself before we do not want to turn
devicetree into a scripting language.

However having a single wait after doing a straight forward power-up cycle
seems to me like something which is appropriate for the mmc-pwrseq-simple
binding.

Regards,

Hans
