From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 03/11] clk: sunxi-ng: a83t: Support new
 timing mode for mmc2 clock
Date: Mon, 17 Jul 2017 18:12:35 +0800
Message-ID: <CAGb2v67Ofdr9zL=o82F6-90meYZGaYtr_zy7y-OeBH30n1gERQ@mail.gmail.com>
References: <20170714064302.20383-1-wens@csie.org> <20170714064302.20383-4-wens@csie.org>
 <20170717091402.3qb3fhdyhfbv6t66@flea>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBK43WLFQKGQEAKAFFFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170717091402.3qb3fhdyhfbv6t66@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 17, 2017 at 5:14 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> On Fri, Jul 14, 2017 at 02:42:54PM +0800, Chen-Yu Tsai wrote:
>> The MMC2 clock supports a new timing mode. When the new mode is active,
>> the output clock rate is halved.
>>
>> This patch sets the feature flag for the new timing mode, and adds
>> a pre-divider based on the mode bit.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 38 +++++++++++++++++++++++++++--------
>>  1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
>> index 947f9f6e05d2..ee6688e9b361 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
>> @@ -418,14 +418,36 @@ static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1-sample", "mmc1",
>>  static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1-output", "mmc1",
>>                      0x08c, 8, 3, 0);
>>
>> -/* TODO Support MMC2 clock's new timing mode. */
>> -static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
>> -                               0x090,
>> -                               0, 4,         /* M */
>> -                               16, 2,        /* P */
>> -                               24, 2,        /* mux */
>> -                               BIT(31),      /* gate */
>> -                               0);
>> +/*
>> + * MMC2 supports both old and new timing modes. When the new timing
>> + * mode is active, the output clock rate is halved by two. Here we
>> + * treat it as a variable pre-divider. Note that the pre-divider is
>> + * _not_ included in the possible factors during a set clock rate
>> + * operation. It is only read out.
>> + */
>> +static const struct ccu_mux_var_prediv mmc2_new_timing_predivs[] = {
>> +     { .index = 0, .shift = 30, .width = 1 },
>> +     { .index = 1, .shift = 30, .width = 1 },
>> +};
>> +static struct ccu_mp mmc2_clk = {
>> +     .enable = BIT(31),
>> +     .m      = _SUNXI_CCU_DIV(0, 4),
>> +     .p      = _SUNXI_CCU_DIV(16, 2),
>> +     .mux    = {
>> +             .shift  = 24,
>> +             .width  = 2,
>> +             .var_predivs    = mmc2_new_timing_predivs,
>> +             .n_var_predivs  = ARRAY_SIZE(mmc2_new_timing_predivs),
>> +     },
>> +     .common         = {
>> +             .reg            = 0x090,
>> +             .features       = CCU_FEATURE_MMC_TIMING_SWITCH,
>> +             .hw.init        = CLK_HW_INIT_PARENTS("mmc2",
>> +                                                   mod0_default_parents,
>> +                                                   &ccu_mp_ops,
>> +                                                   CLK_GET_RATE_NOCACHE),
>> +     },
>> +};
>
> Treating the new bit seems a bit of a hack to me. It only works
> because we're not evaluating the various pre-dividers during a
> determine_rate (and set_rate), but it might change in the future, and
> we will break all our eMMC controllers then.
>
> Since they're quite special, I was thinking about creating a new MMC
> clock type? We're going to use it on a number of SoCs, and we'll be
> able to model it properly, without crippling the regular and generic
> MP clocks.

Yes that should be doable. I could put them in the same file and
reuse all the existing MP clocks stuff by wrapping them in new
functions that check the timing mode bit.

Would that work for you?

ChenYu
