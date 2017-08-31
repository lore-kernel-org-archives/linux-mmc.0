From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: meson-gx: fix __ffsdi2 undefined on arm32
Date: Thu, 31 Aug 2017 12:45:27 +0200
Message-ID: <CAPDyKFoJfDZsyzyy2=Ajst3haK0Cm27FHO-HcbZjS9kyZomxhA@mail.gmail.com>
References: <201708310823.lfxGt2Kh%fengguang.wu@intel.com> <20170831092958.31948-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:38815 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdHaKp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Aug 2017 06:45:28 -0400
Received: by mail-io0-f177.google.com with SMTP id 81so20210300ioj.5
        for <linux-mmc@vger.kernel.org>; Thu, 31 Aug 2017 03:45:28 -0700 (PDT)
In-Reply-To: <20170831092958.31948-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

On 31 August 2017 at 11:29, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Using __bf_shf does not compile on arm 32 architecture.
> This has gone unnoticed till now cause the driver is only used on arm64.
>
> In addition, __bf_shf was already used in the driver without any issue.
> It was used on a constant value, so the call was probably optimized
> away.
>
> Replace __bf_shf by __ffs fixes the problem
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Thanks, applied for next!

> ---
>
> Hi Ulf,
>
> Sorry for not catching this earlier.
> If you still intend to keep the series applied in next, here is a fixup patch
> to squash with the offending commit during your rebase.

I decided to put it on top. Thanks for posting the fixup quickly.

Kind regards
Uffe

>
> Regards
> Jerome
>
>  drivers/mmc/host/meson-gx-mmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 2fa18faa7f0f..7d7aa2389b7c 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -201,13 +201,13 @@ static int meson_mmc_clk_get_phase(struct clk_hw *hw)
>         u32 val;
>
>         val = readl(mmc->reg);
> -       p = (val & mmc->phase_mask) >> __bf_shf(mmc->phase_mask);
> +       p = (val & mmc->phase_mask) >> __ffs(mmc->phase_mask);
>         degrees = p * 360 / phase_num;
>
>         if (mmc->delay_mask) {
>                 period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
>                                          clk_get_rate(hw->clk));
> -               d = (val & mmc->delay_mask) >> __bf_shf(mmc->delay_mask);
> +               d = (val & mmc->delay_mask) >> __ffs(mmc->delay_mask);
>                 degrees += d * mmc->delay_step_ps * 360 / period_ps;
>                 degrees %= 360;
>         }
> @@ -223,11 +223,11 @@ static void meson_mmc_apply_phase_delay(struct meson_mmc_phase *mmc,
>
>         val = readl(mmc->reg);
>         val &= ~mmc->phase_mask;
> -       val |= phase << __bf_shf(mmc->phase_mask);
> +       val |= phase << __ffs(mmc->phase_mask);
>
>         if (mmc->delay_mask) {
>                 val &= ~mmc->delay_mask;
> -               val |= delay << __bf_shf(mmc->delay_mask);
> +               val |= delay << __ffs(mmc->delay_mask);
>         }
>
>         writel(val, mmc->reg);
> @@ -254,7 +254,7 @@ static int meson_mmc_clk_set_phase(struct clk_hw *hw, int degrees)
>                 r = do_div(p, 360 / phase_num);
>                 d = DIV_ROUND_CLOSEST(r * period_ps,
>                                       360 * mmc->delay_step_ps);
> -               d = min(d, mmc->delay_mask >> __bf_shf(mmc->delay_mask));
> +               d = min(d, mmc->delay_mask >> __ffs(mmc->delay_mask));
>         }
>
>         meson_mmc_apply_phase_delay(mmc, p, d);
> @@ -518,7 +518,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         init.num_parents = MUX_CLK_NUM_PARENTS;
>
>         mux->reg = host->regs + SD_EMMC_CLOCK;
> -       mux->shift = __bf_shf(CLK_SRC_MASK);
> +       mux->shift = __ffs(CLK_SRC_MASK);
>         mux->mask = CLK_SRC_MASK >> mux->shift;
>         mux->hw.init = &init;
>
> @@ -540,7 +540,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         init.num_parents = 1;
>
>         div->reg = host->regs + SD_EMMC_CLOCK;
> -       div->shift = __bf_shf(CLK_DIV_MASK);
> +       div->shift = __ffs(CLK_DIV_MASK);
>         div->width = __builtin_popcountl(CLK_DIV_MASK);
>         div->hw.init = &init;
>         div->flags = (CLK_DIVIDER_ONE_BASED |
> --
> 2.9.5
>
