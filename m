From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] mmc: shmobile: add renesas,sdhi-rcar-gen1/gen2 in DT compatible
Date: Tue, 5 Aug 2014 08:59:37 +0200
Message-ID: <CAMuHMdWrbT2vvn+H=R1QhoUNzyPDUFoYMsPjtFW2sPOkVyCScw@mail.gmail.com>
References: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
	<87vbq7ocbi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87vbq7ocbi.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, goda <yusuke.goda.sx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 5, 2014 at 5:16 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
> Current driver has SoC level .compatible
> (r8a7778/r8a7779/r8a7790/r8a7791),
> but these can be match as generation level.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 ++
>  1 file changed, 2 insertions(+)

I think you should also update
Documentation/devicetree/bindings/mmc/tmio_mmc.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
