From: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Date: Fri, 30 Aug 2019 09:33:17 +0000
Message-ID: <zQCmpTJgh3DStTAOFOYXmO44eMRsagV7uM-pCHjc3YlsFmTQuG2GNK9ELGBQZsFn44kr91MRGZ3U7z45D79XHNvCuMTuA6PltlSDx379ws0=@protonmail.ch>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
 <CAMuHMdVe_d6N8hhG0VNZMKAGwXm7kiOQVnqNkL9+6DbkBsKAZw@mail.gmail.com>
Reply-To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVe_d6N8hhG0VNZMKAGwXm7kiOQVnqNkL9+6DbkBsKAZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert,

You are correct, there is no way to distinguish between the old and new ker=
nels just by mmc ios output when the bus is down. I don't think it's an iss=
ue. I find it more helpful to have this information available.
Yes, actual_clock should only display when non-zero and it should be zero w=
hen the bus is down. I fixed this in v2.

Kind regards,
Tamas


Tam=C3=A1s Sz=C5=B1cs
tszucs@protonmail.ch

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, August 30, 2019 9:21 AM, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:

> Hi Tam=C3=A1s,
>
> On Thu, Aug 29, 2019 at 8:37 PM Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.c=
h wrote:
>
> > Save set clock in mmc_host actual_clock enabling exporting it via debug=
fs.
> > This will indicate the precise SD clock in I/O settings rather than onl=
y the
> > sometimes misleading requested clock.
> > Signed-off-by: Tam=C3=A1s Sz=C5=B1cs tszucs@protonmail.ch
>
> Thanks for the update!
>
> Reviewed-by: Geert Uytterhoeven geert+renesas@glider.be
>
> However, one question below.
>
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mm=
c_host *host,
> > sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> > sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> >
> > -         if (new_clock =3D=3D 0)
> >
> >
> >
> > -         if (new_clock =3D=3D 0) {
> >
> >
> > -                 host->mmc->actual_clock =3D 0;
> >
> >
>
> The actual clock is present in the debugfs output only when non-zero.
> Hence userspace cannot distinguish between an old kernel where the
> Renesas SDHI driver didn't fill in actual_clock, and a new kernel when
> the SDHI controller is powered down.
> Could that be an issue? Should the old value be retained?
> Probably it's OK, as this is debugfs, not an official ABI.
>
> Gr{oetje,eeting}s,
>
> Geert
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------
>
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> -- Linus Torvalds
