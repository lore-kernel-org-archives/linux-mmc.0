From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3 v5] mmc: sh_mmcif: calculate best clock with parent clock
Date: Wed, 13 May 2015 09:55:23 +0200
Message-ID: <CAMuHMdV5aVEqEkOi5sk4rB2NoqzWBp2NvtP=k4pXJ0JjNeKo1w@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87a8x9fck7.wl%kuninori.morimoto.gx@renesas.com>
	<87617xfchj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32882 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbbEMHzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 03:55:23 -0400
In-Reply-To: <87617xfchj.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

Hi Morimoto-san,

On Wed, May 13, 2015 at 4:18 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> MMCIF IP on R-Car series has parent clock which can be set
> several rate, and it was not implemented on old SH-Mobile series
> (= SH-Mobile series parent clock was fixed rate)
> R-Car series MMCIF can use more high speed access if it setup
> parent clock. This patch adds parent clock setup method,
> and r8a7790/r8a7791 can use it.

Thanks for this update.

I'm still wondering if we can do this without hardcoding frequencies in the
driver...

>From the discussion before:
"So the upper limit is a limitation of the MMCIF hardware, while the lower
 limit is a limitation of the CPG."

> index e13c5f41..7ade263 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c

> @@ -224,6 +225,15 @@ enum sh_mmcif_wait_for {
>         MMCIF_WAIT_FOR_STOP,
>  };
>
> +/*
> + * difference for each SoC
> + */
> +struct sh_mmcif_ver {
> +       u32 clkdiv_map;         /* see CE_CLK_CTRL::CLKDIV */
> +       unsigned int pf_min;    /* parent frequency min */

I don't think you need an explicit lower limit: clk_round_rate() will
never return a frequency that's lower than the parent clock's lower limit.

> +       unsigned int pf_max;    /* parent frequency max */
> +};
> +
>  struct sh_mmcif_host {
>         struct mmc_host *mmc;
>         struct mmc_request *mrq;
> @@ -248,6 +258,7 @@ struct sh_mmcif_host {
>         bool ccs_enable;                /* Command Completion Signal support */
>         bool clk_ctrl2_enable;
>         struct mutex thread_lock;
> +       const struct sh_mmcif_ver *ver;
>
>         /* DMA support */
>         struct dma_chan         *chan_rx;
> @@ -256,8 +267,16 @@ struct sh_mmcif_host {
>         bool                    dma_active;
>  };
>
> +static const struct sh_mmcif_ver sh_mmcif_gen2 = {
> +       .clkdiv_map     = 0x3ff,
> +       .pf_min         = 12187500,
> +       .pf_max         = 97500000,

By any chance, does setting "max-frequency = <97500000>" from the standard
MMC DT bindings have the same effect?

> +};
> +
>  static const struct of_device_id sh_mmcif_of_match[] = {
>         { .compatible = "renesas,sh-mmcif" },
> +       { .compatible = "renesas,mmcif-r8a7790", .data = &sh_mmcif_gen2 },
> +       { .compatible = "renesas,mmcif-r8a7791", .data = &sh_mmcif_gen2 },
>         { }
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
