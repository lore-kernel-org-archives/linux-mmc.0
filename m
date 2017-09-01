From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Fri, 1 Sep 2017 15:32:35 +0200
Message-ID: <CAPDyKFoPyhGUVwjXHQ-1HcTN-p-3RaOE1zT+9w+GdeBeWbc1kg@mail.gmail.com>
References: <1504014726-17288-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1504014726-17288-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 August 2017 at 15:52, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for r8a7743/5 SoC.Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> DT binding patch for r8a7743/5 SoC is applied for mmc next. But the driver patch
> is still not applied for mmc next.So resending the driver patch.
>
> This patch is compiled and tested against mmc/next.
>
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 160fbb2..df44654 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -98,6 +98,8 @@
>         { .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
>         { .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
>         { .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
> --
> 1.9.1
>
