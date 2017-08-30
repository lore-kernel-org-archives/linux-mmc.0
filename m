From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Wed, 30 Aug 2017 14:29:24 +0200
Message-ID: <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170825094953.3247-1-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 25 August 2017 at 11:49, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> The reset hook was left implemented. Provide a dumb implementation so that
> client drivers can depend on it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Do you want me to pick this up via my mmc tree? If so, is that okay by
the clock maintainers?

Kind regards
Uffe

> ---
>  drivers/clk/sunxi-ng/ccu_reset.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
> index 6c31d48783a7..1dc4e98ea802 100644
> --- a/drivers/clk/sunxi-ng/ccu_reset.c
> +++ b/drivers/clk/sunxi-ng/ccu_reset.c
> @@ -8,6 +8,7 @@
>   * the License, or (at your option) any later version.
>   */
>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/reset-controller.h>
>
> @@ -49,7 +50,18 @@ static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
>         return 0;
>  }
>
> +static int ccu_reset_reset(struct reset_controller_dev *rcdev,
> +                          unsigned long id)
> +{
> +       ccu_reset_assert(rcdev, id);
> +       udelay(10);
> +       ccu_reset_deassert(rcdev, id);
> +
> +       return 0;
> +}
> +
>  const struct reset_control_ops ccu_reset_ops = {
>         .assert         = ccu_reset_assert,
>         .deassert       = ccu_reset_deassert,
> +       .reset          = ccu_reset_reset,
>  };
> --
> 2.13.5
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
