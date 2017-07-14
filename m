From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 05/11] mmc: sunxi: Support controllers that
 can use both old and new timings
Date: Fri, 14 Jul 2017 17:40:34 +0800
Message-ID: <CAGb2v64gjLSdb83fR9OCZthtgMQz-UkmMhT9OmJkq3Xp6mJ-aA@mail.gmail.com>
References: <20170714064302.20383-1-wens@csie.org> <20170714064302.20383-6-wens@csie.org>
 <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBKVDULFQKGQEA4G3CTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 14, 2017 at 5:26 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 14 July 2017 at 08:42, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>> On the SoCs that introduced the new timing mode for MMC controllers,
>> both the old (where the clock delays are set in the CCU) and new
>> (where the clock delays are set in the MMC controller) timing modes
>> are available, and we have to support them both. However there are
>> two bits that control which mode is active. One is in the CCU, the
>> other is in the MMC controller. The settings on both sides must be
>> the same, or nothing will work.
>>
>> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
>> timing mode is active. This provides a way to know which mode is
>> active on that side, and we can set the bit on the MMC controller
>> side accordingly.

Argh... I forgot to update the commit log... :(

>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 0fb4e4c119e1..56e45c65b52d 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/err.h>
>>
>>  #include <linux/clk.h>
>> +#include <linux/clk/sunxi-ng.h>
>
> I don't like this. This looks like an SoC specific hack.
>
>>  #include <linux/gpio.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/spinlock.h>
>> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
>>         /* Does DATA0 needs to be masked while the clock is updated */
>>         bool mask_data0;
>>
>> -       bool needs_new_timings;
>> +       bool has_new_timings;
>>  };
>>
>>  struct sunxi_mmc_host {
>> @@ -293,6 +294,9 @@ struct sunxi_mmc_host {
>>
>>         /* vqmmc */
>>         bool            vqmmc_enabled;
>> +
>> +       /* timings */
>> +       bool            use_new_timings;
>>  };
>>
>>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
>> @@ -714,7 +718,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>>  {
>>         int index;
>>
>> -       if (!host->cfg->clk_delays)
>> +       if (host->use_new_timings)
>>                 return 0;
>>
>>         /* determine delays */
>> @@ -765,6 +769,15 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>             ios->bus_width == MMC_BUS_WIDTH_8)
>>                 clock <<= 1;
>>
>> +       if (host->use_new_timings) {
>> +               ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
>
> Can't this be solved through some other generic API/interface?

The old discussion is here: https://lkml.org/lkml/2017/5/5/77

It is possible to piggy back on existing API, but as Maxime mentioned
back in the discussion, it is confusing.

IIRC Mike said (via Maxime) an SoC specific call was the easy way
to handle this. I don't think there's anything generic about this.
Even if you could have a _set_mode callback for the clks, the modes
would be SoC specific anyway.

ChenYu

>
>> +               if (ret) {
>> +                       dev_err(mmc_dev(mmc),
>> +                               "error setting new timing mode\n");
>> +                       return ret;
>> +               }
>> +       }
>> +
>
> [...]
>
> Kind regards
> Uffe
