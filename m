From: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: Re: [PATCH] mmc: sdhi: fill in actual_clock
Date: Thu, 29 Aug 2019 15:59:46 +0000
Message-ID: <FaBiPuw0MFfdsj60MQTULROSN-8cSV7sNRlgO5SSVPo5jfQopmm9zTq4JT71VxaO32qdcAhisOrhFYG_QLByLNHcBrMgshsI_WwP9rlH2ms=@protonmail.ch>
References: <20190828185518.4340-1-tszucs@protonmail.ch>
 <CAMuHMdWcp-3B7ZZjbyo02ECyzDX_rQxXF645OCutCkjUu_jWaA@mail.gmail.com>
Reply-To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWcp-3B7ZZjbyo02ECyzDX_rQxXF645OCutCkjUu_jWaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert,

It would be possible to call clk_get_rate() unconditionally but there's usu=
ally no need, thus the ternary. Are you in favor of that though?

It turns out I need to send a followup to fix some glitches. Please stay tu=
ned.

Kind regards,
Tamas


Tam=C3=A1s Sz=C5=B1cs
tszucs@protonmail.ch

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, August 29, 2019 9:47 AM, Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:

> Hi Tam=C3=A1s,
>
> On Wed, Aug 28, 2019 at 9:02 PM Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.c=
h wrote:
>
> > Save set clock in mmc_host actual_clock enabling exporting it via debug=
fs.
> > This will indicate the precise SD clock in I/O settings rather than onl=
y the
> > sometimes misleading requested clock.
> > Signed-off-by: Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.ch
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct =
tmio_mmc_host *host,
> > {
> > struct renesas_sdhi *priv =3D host_to_priv(host);
> > unsigned int freq, diff, best_freq =3D 0, diff_min =3D ~0;
> >
> > -         int i, ret;
> >
> >
> >
> > -         int i;
> >
> >           /* tested only on R-Car Gen2+ currently; may work for others =
*/
> >           if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> >
> >
> >
> > @@ -153,9 +153,11 @@ static unsigned int renesas_sdhi_clk_update(struct=
 tmio_mmc_host *host,
> > }
> > }
> >
> > -         ret =3D clk_set_rate(priv->clk, best_freq);
> >
> >
> >
> > -         host->mmc->actual_clock =3D
> >
> >
> > -                 clk_set_rate(priv->clk, best_freq) =3D=3D 0 ?
> >
> >
> > -                         best_freq : clk_get_rate(priv->clk);
> >
> >
>
> When clk_set_rate() returns 0 to indicate success, it may still have
> rounded the requested clock rate, no?
> So wouldn't it be better to always call clk_get_rate()?
>
> > -         return ret =3D=3D 0 ? best_freq : clk_get_rate(priv->clk);
> >
> >
> >
> > -         return host->mmc->actual_clock;
> >
> >
> >
> > }
>
> Gr{oetje,eeting}s,
>
> Geert
>
> ----------------------------
>
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> -- Linus Torvalds
