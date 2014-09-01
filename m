From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Mon, 01 Sep 2014 12:00:54 -0700
Message-ID: <20140901190054.5251.56409@quantum>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41169 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaIATBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 15:01:07 -0400
Received: by mail-pd0-f175.google.com with SMTP id ft15so6779631pdb.34
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 12:01:06 -0700 (PDT)
In-Reply-To: <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Quoting Maxime Ripard (2014-08-30 13:03:02)
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
>  drivers/clk/clk.c            | 17 ++++++++++++++---
>  include/linux/clk-provider.h |  5 +++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d87661af0c72..7dbceca694f1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1797,8 +1797,8 @@ out:
>   * clk_get_phase - return the phase shift of a clock signal
>   * @clk: clock signal source
>   *
> - * Returns the phase shift of a clock node in degrees, otherwise returns
> - * -EERROR.
> + * Returns the phase shift of a clock node in degrees. Any negative
> + * values are errors.
>   */
>  int clk_get_phase(struct clk *clk)
>  {
> @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
>                 goto out;
>  
>         clk_prepare_lock();
> -       ret = clk->phase;
> +
> +       if (clk->phase) {

So if a phase is zero, then we fall through and query the hardware?
Seems like this case might be hit a lot for clocks that implement
.get_phase but never have their phase shifted, and accesses to the
registers may be much slower than to memory.

Do you expect the phase to be changed behind our backs? E.g. firmware
changes it, or coming in and out of idle state, etc. If not then we can
store the phase at clock registration time and use a cached value.

See how the CLK_GET_RATE_NOCACHE and CLK_GET_ACCURACY_NOCACHE flags are
used for details on how we can handle the case where the phase might
change behind our back.

Regards,
Mike

> +               ret = clk->phase;
> +               goto out_unlock;
> +       }
> +
> +       if (!clk->ops->get_phase)
> +               goto out_unlock;
> +
> +       ret = clk->ops->get_phase(clk->hw);
> +
> +out_unlock:
>         clk_prepare_unlock();
>  
>  out:
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
> 2.0.2
> 
