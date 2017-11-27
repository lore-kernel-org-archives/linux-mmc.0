From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] dt-bindings: mmc: renesas_sdhi: Add r8a77995 support
Date: Mon, 27 Nov 2017 10:57:52 +0100
Message-ID: <CAPDyKFrRkBY+Z=f4n4xpO6HWBfARQdDfLQ17N6sk3x5oaRAFdQ@mail.gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510759549-30404-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759549-30404-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 November 2017 at 16:25, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds bindings for the R-Car D3 SoC's SDHI IP.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 3c67624..d8685cb 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -26,6 +26,7 @@ Required properties:
>                 "renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
>                 "renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
>                 "renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
> +               "renesas,sdhi-r8a77995" - SDHI IP on R8A77995 SoC
>                 "renesas,sdhi-shmobile" - a generic sh-mobile SDHI controller
>                 "renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
>                 "renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
