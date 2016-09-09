From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: Add r8a7796 support
Date: Fri, 9 Sep 2016 11:45:58 +0200
Message-ID: <CAPDyKFoU+rse-AkJ+SaEuhfLapVMqyevimRfy55jzTHx9xswsA@mail.gmail.com>
References: <1473158318-9088-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473158318-9088-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 6 September 2016 at 12:38, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>
>
> Add support for r8a7796 SoC.
>
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
>  drivers/mmc/host/sh_mobile_sdhi.c                  | 1 +
>  2 files changed, 2 insertions(+)
> ---
>  Based on mmc/next
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 0f610d4b5b00..13df9c2399c3 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -23,6 +23,7 @@ Required properties:
>                 "renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
>                 "renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
>                 "renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
> +               "renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
>
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index d679c8a533b6..49edff7fee49 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -94,6 +94,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
> --
> 2.7.0.rc3.207.g0ac5344
>
