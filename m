From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] mmc: sunxi: Check the value returned
 by clk_round_rate
Date: Wed, 24 Aug 2016 11:32:26 +0200
Message-ID: <CAPDyKFpQ2b=0aAWUcGjFDnea3K2W+zxH5Xk0fyhOzM8MADBubg@mail.gmail.com>
References: <57bc12b2.9be81c0a.1246a.9f47SMTPIN_ADDED_MISSING@mx.google.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBK6T6W6QKGQEBKZ4S6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <57bc12b2.9be81c0a.1246a.9f47SMTPIN_ADDED_MISSING-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2016 at 10:51, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrote:
> clk_round_rate() may return an error. Check it.
>
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks, applied for next!

For some reason this patch didn't go into the mmc patchtracker,
probably because you have several lists on cc. Future wise I guess
it's better if you have linux-mmc on the *to* list.

Kind regards
Uffe

> ---
> Rebase on linux-next
> ---
>  drivers/mmc/host/sunxi-mmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ec91ce..142ab3f 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -692,7 +692,8 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                                   struct mmc_ios *ios)
>  {
> -       u32 rate, rval, clock = ios->clock;
> +       long rate;
> +       u32 rval, clock = ios->clock;
>         int ret;
>
>         /* 8 bit DDR requires a higher module clock */
> @@ -701,13 +702,18 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 clock <<= 1;
>
>         rate = clk_round_rate(host->clk_mmc, clock);
> -       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
> +       if (rate < 0) {
> +               dev_err(mmc_dev(host->mmc), "error rounding clk to %d: %ld\n",
> +                       clock, rate);
> +               return rate;
> +       }
> +       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
>                 clock, rate);
>
>         /* setting clock rate */
>         ret = clk_set_rate(host->clk_mmc, rate);
>         if (ret) {
> -               dev_err(mmc_dev(host->mmc), "error setting clk to %d: %d\n",
> +               dev_err(mmc_dev(host->mmc), "error setting clk to %ld: %d\n",
>                         rate, ret);
>                 return ret;
>         }
> --
> 2.9.3
>
