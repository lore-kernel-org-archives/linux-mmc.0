From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 5/5] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Tue, 5 Jul 2016 13:06:04 +0200
Message-ID: <CAMuHMdXEuZyrZUQbjBB600Fp+skKcHr8=FAzzqLv5_ttSeTmiA@mail.gmail.com>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au> <1467237940-24388-6-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467237940-24388-6-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 30, 2016 at 12:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c

> +static int sh_mobile_sdhi_init_dma(enum tmio_mmc_dmac_type dmac_type)
> +{
> +       switch (dmac_type) {
> +       case TMIO_MMC_INTERNAL_DMAC:
> +               return sdhi_internal_dmac_init_dma();
> +
> +       case TMIO_MMC_SYSC_DMAC:
> +               return sdhi_sysc_dmac_init_dma();
> +       }
> +}

Depending on compiler version and optimization level:

drivers/mmc/host/sh_mobile_sdhi.c:172:1: warning: control reaches end
of non-void function [-Wreturn-type]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
