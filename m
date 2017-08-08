From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Fix NULL pointer reference
 on clk_delays
Date: Tue, 8 Aug 2017 12:37:44 +0200
Message-ID: <CAPDyKFr+Ajx5yBcTR2555w-7tamSY8ozpn-1S2gWCQSZaGAWcQ@mail.gmail.com>
References: <20170808070244.27410-1-wens@csie.org>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRB6NIU3GAKGQEF3EK6CI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170808070244.27410-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2017 at 09:02, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> Some SoCs do not support clk delays for MMC in the clock control unit.
> These include the old controllers in A10/A10s/A13/R8, and the new eMMC
> controller in A64. The config structure for these controllers do not
> specify clk_delays, but the check for this was replaced in commit
> b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
> and new timings").
>
> This patch adds back the check for clk_delays, and also adds comments
> for both checks in sunxi_mmc_clk_set_phase().
>
> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>                       both old and new timings")
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> This fixes an mmc regression on A10/A10s/A13/R8 and A64 introduced
> by the A83T mmc patches.
>
> v1 was inlined in a reply to "mmc: sunxi: fix new timings mode on A64
> EMMC (MMC2) controller"
>
> Changes since v1:
>
>   - Polished comments
>
> I've tested this on my A10 Cubieboard and A20 Cubieboard2.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 3777517982dd..9dc6d726ec49 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -722,9 +722,14 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  {
>         int index;
>
> +       /* clk controller delays not used under new timings mode */
>         if (host->use_new_timings)
>                 return 0;
>
> +       /* some old controllers don't support delays */
> +       if (!host->cfg->clk_delays)
> +               return 0;
> +
>         /* determine delays */
>         if (rate <= 400000) {
>                 index = SDXC_CLK_400K;
> --
> 2.13.3
>
