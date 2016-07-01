From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] mmc: pwrseq-simple: Add an optional post-power-on-delay
Date: Fri, 1 Jul 2016 11:03:19 +1000
Message-ID: <CAGRGNgW8zdi_vbqtjfG=pTaEmpVw9UEaitVkQjPxWwwe_izsQA@mail.gmail.com>
References: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqJ0XVJb=Q9FT8g_OUTbgZWr-E58xQS0iCR4hv-9EHCcPA@mail.gmail.com>
 <b056f5c8-e77f-ff90-afa5-cd77e446e2dd@redhat.com> <20160701004732.GA20831@rob-hp-laptop>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQIP76OUQLBB24C265QKGQEACQOK7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160701004732.GA20831@rob-hp-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi All,

On Fri, Jul 1, 2016 at 10:47 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 11:33:27AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 23-06-16 00:25, Rob Herring wrote:
>> >On Wed, Jun 22, 2016 at 12:59 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> >>Some devices need a while to boot their firmware after providing clks /
>> >>de-asserting resets before they are ready to receive sdio commands.
>> >>
>> >>This commits adds a post-power-on-delay-ms devicetree property to
>> >>mmc-pwrseq-simple for use with such devices.
>> >>
>> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> >>---
>> >> Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>> >> drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>> >> 2 files changed, 11 insertions(+)
>> >>
>> >>diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>index ce0e767..e254368 100644
>> >>--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>@@ -16,6 +16,8 @@ Optional properties:
>> >>   See ../clocks/clock-bindings.txt for details.
>> >> - clock-names : Must include the following entry:
>> >>   "ext_clock" (External clock provided to the card).
>> >>+- post-power-on-delay-ms : Delay in ms after powering the card and
>> >>+       de-asserting the reset-gpios (if any)
>> >
>> >Presumably you need this delay post any reset, not just after power on
>>
>> mmc-pwrseq is only about doing power-on / off, not about providing
>> reset functionality.
>
> Yes, but the property (e.g. the delay) is relevant for both and reset is
> part of the power seq.
>
>> >if you are waiting for firmware to boot. So the name is not all that
>> >clear. How about a "reset-timing-ms" property that takes 3 values for
>> >pre-assert time (normally 0), assertion time, post assert time. Of
>> >course, I can still think of ways that breaks like when in this
>> >sequence do clocks need to be turned on.
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

Stupid question:

In the interests of making this more flexible without adding any real
"scripting", what about adding three optional delays to this binding:
1. clock delay - time from "boot" to clocks being enabled
2. reset delay - time from "boot" to resets being de-asserted
3. boot delay - time from "boot" until the mmc-pwrseq-simple driver
assumes the card is ready to be probed

Where the "boot" time is when the mmc-pwrseq-simple driver starts
enabling this card. All three delays default to 0, the boot delay is
never less than either of the other delays and the time taken to
enable clocks or de-assert resets is not counted.

IMHO this allows the maximum amount of flexibility (resets and clocks
can be in either order) without turning this into a scripting
language. I also feel that it has a nice finality about it. (Of course
if you wanted to go mad and turn this into a scripting language,
allowing multiple pwrseq items per card would be the simplest way to
do that.)

Of course this also makes everything more complicated and I'm
expecting this proposal to be nak'd for obvious reasons, but I had to
ask.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
