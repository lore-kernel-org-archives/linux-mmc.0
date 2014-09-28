From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 03/12] clk: Add a function to retrieve phase
Date: Sat, 27 Sep 2014 17:17:32 -0700
Message-ID: <20140928001732.19023.2496@quantum>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53259 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaI1AR4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Sep 2014 20:17:56 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so3355398pab.40
        for <linux-mmc@vger.kernel.org>; Sat, 27 Sep 2014 17:17:56 -0700 (PDT)
In-Reply-To: <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Quoting Maxime Ripard (2014-09-11 13:18:17)
> The current phase API doesn't look into the actual hardware to get the phase
> value, but will rather get it from a variable only set by the set_phase
> function.
> 
> This will cause issue when the client driver will never call the set_phase
> function, where we can end up having a reported phase that will not match what
> the hardware has been programmed to by the bootloader or what phase is
> programmed out of reset.
> 
> Add a new get_phase function for the drivers to implement so that we can get
> this value.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/clk.c            | 10 ++++++++++
>  include/linux/clk-provider.h |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d87661af0c72..113d75db371d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1934,6 +1934,16 @@ int __clk_init(struct device *dev, struct clk *clk)
>                 clk->accuracy = 0;
>  
>         /*
> +        * Set clk's phase.
> +        * Since a phase is by definition relative to its parent, just
> +        * query the current clock phase, or just assume it's in phase.
> +        */
> +       if (clk->ops->get_phase)
> +               clk->phase = clk->ops->get_phase(clk->hw);
> +       else
> +               clk->phase = 0;

I probably wasn't paying enough attention to this. Based on the
coverletter I thought that v3 would introduce something like
CLK_GET_PHASE_NOCACHE and stuff that logic into a __clk_get_phase
function? Looks like this version of the series doesn't handle phases
that can be changed by hardware (e.g. coming out of idle).

Correct me if I am wrong, but it looks like we retrieve the phase only
once at init and then never again? The rest of the time we rely on
clk->phase to always be accurate...

Regards,
Mike

> +
> +       /*
>          * Set clk's rate.  The preferred method is to use .recalc_rate.  For
>          * simple clocks and lazy developers the default fallback is to use the
>          * parent's rate.  If a clock doesn't have a parent (or is orphaned)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 69b20d4c1e1a..abec961092a7 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -130,6 +130,10 @@ struct dentry;
>   *             set then clock accuracy will be initialized to parent accuracy
>   *             or 0 (perfect clock) if clock has no parent.
>   *
> + * @get_phase: Queries the hardware to get the current phase of a clock.
> + *             Returned values are 0-359 degrees on success, negative
> + *             error codes on failure.
> + *
>   * @set_phase: Shift the phase this clock signal in degrees specified
>   *             by the second argument. Valid values for degrees are
>   *             0-359. Return 0 on success, otherwise -EERROR.
> @@ -182,6 +186,7 @@ struct clk_ops {
>                                     unsigned long parent_rate, u8 index);
>         unsigned long   (*recalc_accuracy)(struct clk_hw *hw,
>                                            unsigned long parent_accuracy);
> +       int             (*get_phase)(struct clk_hw *hw);
>         int             (*set_phase)(struct clk_hw *hw, int degrees);
>         void            (*init)(struct clk_hw *hw);
>         int             (*debug_init)(struct clk_hw *hw, struct dentry *dentry);
> -- 
> 2.1.0
> 
