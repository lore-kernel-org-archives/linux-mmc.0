From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 21 Aug 2017 13:30:02 +0200
Message-ID: <CAMuHMdWUxxp75u1VSLY3WnObmhSMDvP3skr9Uf3rV4Bf-ixy_w@mail.gmail.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com> <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503311897-18807-1-git-send-email-biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Biju,

On Mon, Aug 21, 2017 at 12:38 PM, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org> wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
>
> Signed-off-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> ---
> v1->v2
>     -Modified the listing SoC's description related to SoC
>      with 1 Clock and 2 Clocks
>
> This patch is compiled and tested against linux next tag
> next-20170817.
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 4fd8b7a..1e3106e 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -15,6 +15,8 @@ Required properties:
>                 "renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
>                 "renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
>                 "renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
> +               "renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
> +               "renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
>                 "renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
>                 "renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
>                 "renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
> @@ -33,10 +35,9 @@ Required properties:
>           If 2 clocks are specified by the hardware, you must name them as
>           "core" and "cd". If the controller only has 1 clock, naming is not
>           required.
> -         Below is the number clocks for each supported SoC:
> -          1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -             R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> -          2: R7S72100
> +         Most supported SoCs only have 1 clock. Devices which have more

That is actually mentioned in the paragraph above:

- clocks: Most controllers only have 1 clock source per channel. However, on
          some variations of this controller, the internal card detection
          logic that exists in this controller is sectioned off to be run by a
          separate second clock source to allow the main core clock to be turned
          off to save power.

so I suggest just integrating the (short) list in that paragraph.

> +         than 1 clock are listed below:
> +         2: R7S72100"

Bogus trailing double quote.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
