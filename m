From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Fix clock rate passed to sunxi_mmc_clk_set_phase
Date: Mon, 21 Aug 2017 14:33:42 +0200
Message-ID: <CAPDyKFqqhGXzmXSVZuie++VcNJGs_9etV16MhLtMAoyB5oCQ4A@mail.gmail.com>
References: <20170810032954.9104-1-wens@csie.org>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRBJ5G5PGAKGQEIOJKZEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170810032954.9104-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10 August 2017 at 05:29, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> sunxi_mmc_clk_set_phase expects the actual card clock rate to be passed
> to it. When the internal divider code was reworked in commit 9a639c6073d3
> ("mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode"),
> this requirement was missed, and the module clock rate was passed in
> instead. This broke 8 bit DDR MMC on old controllers, as the module
> clock rate is double the card clock rate, for which we have no valid
> delay settings.
>
> Fix this by applying the internal divider to the clock rate right after
> we configure it in hardware.
>
> Fixes: 9a639c6073d3 ("mmc: sunxi: Support MMC DDR52 transfer mode with
>                       new timing mode")
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Sorry for all the regressions the A83T MMC series has caused.
> I only caught this while testing some other patches on the H3.
> I really hope this is the last one.
>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6c7eb859ace1..da5f46a14497 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -821,6 +821,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>         rval |= div - 1;
>         mmc_writel(host, REG_CLKCR, rval);
>
> +       /* update card clock rate to account for internal divider */
> +       rate /= div;
> +
>         if (host->use_new_timings) {
>                 /* Don't touch the delay bits */
>                 rval = mmc_readl(host, REG_SD_NTSR);
> @@ -828,6 +831,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 mmc_writel(host, REG_SD_NTSR, rval);
>         }
>
> +       /* sunxi_mmc_clk_set_phase expects the actual card clock rate */
>         ret = sunxi_mmc_clk_set_phase(host, ios, rate);
>         if (ret)
>                 return ret;
> @@ -849,7 +853,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 return ret;
>
>         /* And we just enabled our clock back */
> -       mmc->actual_clock = rate / div;
> +       mmc->actual_clock = rate;
>
>         return 0;
>  }
> --
> 2.13.3
>
