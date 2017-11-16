From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
Date: Thu, 16 Nov 2017 10:37:35 +0100
Message-ID: <CAMuHMdW58hNHA2N5diu3tufpbVSc85Wf8gOkgi9qxKUGVzy2tA@mail.gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510759549-30404-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759549-30404-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Uli,

On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds compatible string and whitelists for internal DMAC implementation.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -88,6 +88,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
>  static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
>         { .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
> +       { .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_compatible, },

This change is not needed, due to the line below.

>         { .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
>         {},
>  };
> @@ -255,6 +256,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
>          { .soc_id = "r8a7795", .revision = "ES1.*" },
>          { .soc_id = "r8a7795", .revision = "ES2.0" },
>          { .soc_id = "r8a7796", .revision = "ES1.0" },
> +        { .soc_id = "r8a77995", .revision = "*" },

It may be safer to use "ES1.0" instead of a wildcard, like for the other
R-Car Gen3 SoCs, as we can't predict the future.

BTW, if you want to match against all revisions, there's no need to use
a "*" explicit wildcard.

>          { /* sentinel */ }
>  };

With at least my first comment taken into account:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
