From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Date: Tue, 3 Sep 2019 17:10:35 +0200
Message-ID: <CAPDyKFpRtzS3CXAi4jKjyPOEd5KjCZ1Vqpi_fmm-F+O8eAqbmQ@mail.gmail.com>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 20:36, Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch> =
wrote:
>
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs=
.
> This will indicate the precise SD clock in I/O settings rather than only =
the
> sometimes misleading requested clock.
>
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index 64d3b5fb7fe5..4c9774dbcfc1 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>  {
>         struct renesas_sdhi *priv =3D host_to_priv(host);
>         unsigned int freq, diff, best_freq =3D 0, diff_min =3D ~0;
> -       int i, ret;
> +       int i;
>
>         /* tested only on R-Car Gen2+ currently; may work for others */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> @@ -153,9 +153,9 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>                 }
>         }
>
> -       ret =3D clk_set_rate(priv->clk, best_freq);
> +       clk_set_rate(priv->clk, best_freq);
>
> -       return ret =3D=3D 0 ? best_freq : clk_get_rate(priv->clk);
> +       return clk_get_rate(priv->clk);
>  }
>
>  static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_=
host *host,
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       if (new_clock =3D=3D 0)
> +       if (new_clock =3D=3D 0) {
> +               host->mmc->actual_clock =3D 0;
>                 goto out;
> +       }
>
> -       clock =3D renesas_sdhi_clk_update(host, new_clock) / 512;
> +       host->mmc->actual_clock =3D renesas_sdhi_clk_update(host, new_clo=
ck);
> +       clock =3D host->mmc->actual_clock / 512;
>
>         for (clk =3D 0x80000080; new_clock >=3D (clock << 1); clk >>=3D 1=
)
>                 clock <<=3D 1;
> --
> 2.11.0
>
