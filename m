From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
Date: Fri, 14 Jul 2017 11:57:35 +0200
Message-ID: <CAPDyKFqe1hFmfWziu04fW=cQa0EGvT11YzuJ0f-eHy6+u7vutQ@mail.gmail.com>
References: <20170714064302.20383-1-wens@csie.org> <20170714064302.20383-6-wens@csie.org>
 <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg@mail.gmail.com> <CAGb2v64gjLSdb83fR9OCZthtgMQz-UkmMhT9OmJkq3Xp6mJ-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34211 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdGNJ5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jul 2017 05:57:36 -0400
Received: by mail-qk0-f171.google.com with SMTP id d78so71263649qkb.1
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2017 02:57:36 -0700 (PDT)
In-Reply-To: <CAGb2v64gjLSdb83fR9OCZthtgMQz-UkmMhT9OmJkq3Xp6mJ-aA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On 14 July 2017 at 11:40, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Jul 14, 2017 at 5:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 14 July 2017 at 08:42, Chen-Yu Tsai <wens@csie.org> wrote:
>>> On the SoCs that introduced the new timing mode for MMC controllers,
>>> both the old (where the clock delays are set in the CCU) and new
>>> (where the clock delays are set in the MMC controller) timing modes
>>> are available, and we have to support them both. However there are
>>> two bits that control which mode is active. One is in the CCU, the
>>> other is in the MMC controller. The settings on both sides must be
>>> the same, or nothing will work.
>>>
>>> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
>>> timing mode is active. This provides a way to know which mode is
>>> active on that side, and we can set the bit on the MMC controller
>>> side accordingly.
>
> Argh... I forgot to update the commit log... :(
>
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
>>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index 0fb4e4c119e1..56e45c65b52d 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/err.h>
>>>
>>>  #include <linux/clk.h>
>>> +#include <linux/clk/sunxi-ng.h>
>>
>> I don't like this. This looks like an SoC specific hack.
>>
>>>  #include <linux/gpio.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/spinlock.h>
>>> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
>>>         /* Does DATA0 needs to be masked while the clock is updated */
>>>         bool mask_data0;
>>>
>>> -       bool needs_new_timings;
>>> +       bool has_new_timings;
>>>  };
>>>
>>>  struct sunxi_mmc_host {
>>> @@ -293,6 +294,9 @@ struct sunxi_mmc_host {
>>>
>>>         /* vqmmc */
>>>         bool            vqmmc_enabled;
>>> +
>>> +       /* timings */
>>> +       bool            use_new_timings;
>>>  };
>>>
>>>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
>>> @@ -714,7 +718,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>>>  {
>>>         int index;
>>>
>>> -       if (!host->cfg->clk_delays)
>>> +       if (host->use_new_timings)
>>>                 return 0;
>>>
>>>         /* determine delays */
>>> @@ -765,6 +769,15 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>>             ios->bus_width == MMC_BUS_WIDTH_8)
>>>                 clock <<= 1;
>>>
>>> +       if (host->use_new_timings) {
>>> +               ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
>>
>> Can't this be solved through some other generic API/interface?
>
> The old discussion is here: https://lkml.org/lkml/2017/5/5/77
>
> It is possible to piggy back on existing API, but as Maxime mentioned
> back in the discussion, it is confusing.
>
> IIRC Mike said (via Maxime) an SoC specific call was the easy way
> to handle this. I don't think there's anything generic about this.
> Even if you could have a _set_mode callback for the clks, the modes
> would be SoC specific anyway.

Right. But it would benefit that we can keep drivers generic, as they
are using generic APIs/interfaces. I prefer that.

Anyway, let me try to dig up the earlier discussion.

Kind regards
Uffe
