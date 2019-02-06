From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported
 modes declared in the device tree
Date: Wed, 6 Feb 2019 16:14:33 +0100
Message-ID: <CAPDyKFoZYY4O_eXExvZQvJcnyHLc+JfQMbDmUe9mxJwR6QtchA@mail.gmail.com>
References: <20190205154225.14264-1-wens@csie.org> <20190205154225.14264-3-wens@csie.org>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRB7XT5PRAKGQEPD4TGSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190205154225.14264-3-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "# 4.0+" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 5 Feb 2019 at 16:42, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> This should be backported to stable kernels in case people try to run
> new device trees (that declare newly supported modes) with old kernels.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7415af8c8ff6..70fadc976795 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1415,6 +1415,21 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto error_free_dma;
>
> +       /*
> +        * If we don't support delay chains in the SoC, we can't use any
> +        * of the higher speed modes. Mask them out in case the device
> +        * tree specifies the properties for them, which gets added to
> +        * the caps by mmc_of_parse() above.
> +        */
> +       if (!(host->cfg->clk_delays || host->use_new_timings)) {
> +               mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> +                              MMC_CAP_1_2V_DDR | MMC_CAP_UHS);
> +               mmc->caps2 &= ~MMC_CAP2_HS200;
> +       }
> +
> +       /* TODO: This driver doesn't support HS400 mode yet */
> +       mmc->caps2 &= ~MMC_CAP2_HS400;
> +
>         ret = sunxi_mmc_init_host(host);
>         if (ret)
>                 goto error_free_dma;
> --
> 2.20.1
>
