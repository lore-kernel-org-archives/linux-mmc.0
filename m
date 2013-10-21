From: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 4/6] clocksource: kona: Add basic use of
 external clock
Date: Mon, 21 Oct 2013 14:07:14 -0700
Message-ID: <CAAYSxhoBvr2Q=ZEQX6hgBjLorgjCjeLLqB9WP2RQ1YFBejjHbg@mail.gmail.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
	<1381960030-1640-5-git-send-email-tim.kryger@linaro.org>
	<20131017140542.GE24056@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131017140542.GE24056-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 17, 2013 at 7:05 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Oct 16, 2013 at 10:47:08PM +0100, Tim Kryger wrote:
>> When an clock handle is specified in the device tree, enable it and use
>> it to determine the external clock frequency.
>
> I'd drop handle here and just say "When a clock is specified".
>
> This will need a binding document update.

Can you be more specific about what you are looking for here?

Shall I just say that the frequency property is now deprecated since
it actually belongs to the external clock whose association with a
kona timer instance might be declared in the DT using the common clock
bindings but could also be declared through other means?

>> Signed-off-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/clocksource/bcm_kona_timer.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
>> index 0d7d8c3..fd11f96 100644
>> --- a/drivers/clocksource/bcm_kona_timer.c
>> +++ b/drivers/clocksource/bcm_kona_timer.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/jiffies.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/types.h>
>> +#include <linux/clk.h>
>>
>>  #include <linux/io.h>
>>  #include <asm/mach/time.h>
>> @@ -107,11 +108,18 @@ static const struct of_device_id bcm_timer_ids[] __initconst = {
>>  static void __init kona_timers_init(struct device_node *node)
>>  {
>>       u32 freq;
>> +     struct clk *external_clk;
>>
>> -     if (!of_property_read_u32(node, "clock-frequency", &freq))
>> +     external_clk = of_clk_get_by_name(node, NULL);
>
> Is there only a single external clock input to the kona timer, or is
> only one relevant here?
>
> Are there any other inputs currently not modelled (e.g. regulators)?

The timer block relies upon a single clock and does not use any regulators.

>> +
>> +     if (!IS_ERR(external_clk)) {
>> +             arch_timer_rate = clk_get_rate(external_clk);
>> +             clk_prepare_enable(external_clk);
>> +     } else if (!of_property_read_u32(node, "clock-frequency", &freq)) {
>>               arch_timer_rate = freq;
>> -     else
>> -             panic("clock-frequency not set in the .dts file");
>> +     } else {
>> +             panic("neither clock-frequency or clocks handle in .dts file");
>
> Nit: it's not a handle, it's a phandle+args pair.
>
> Why not just "Unable to determine clock frequency"?

Sure that sounds fine.

>
> Do we need to panic here? Might a system have other clocks it could use
> to continue?

I completely agree that this driver could be improved.  However, this
is unrelated to the topic of this series so I will address it later in
a separate patch.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
