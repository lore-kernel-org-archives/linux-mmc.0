From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
Date: Mon, 30 Jul 2018 17:06:22 +0200
Message-ID: <CAPDyKFopeCwOO0jVet8EG6hkiVROfZH=TUv57qWkoL6BeM9qSw@mail.gmail.com>
References: <20180722125407.43107-1-icenowy@aosc.io>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRB36S7TNAKGQEBV3ZHBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180722125407.43107-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 22 July 2018 at 14:54, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
> Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
> (e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
> capable of doing 3.3V DDR transmission.
>
> Add capability of 3.3V DDR when DDR is available (extra clock or new
> timing).
>
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..4ea8e2611079 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1388,7 +1388,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
>         if (host->cfg->clk_delays || host->use_new_timings)
> -               mmc->caps      |= MMC_CAP_1_8V_DDR;
> +               mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
