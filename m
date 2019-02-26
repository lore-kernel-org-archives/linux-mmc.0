From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
Date: Tue, 26 Feb 2019 12:29:21 +0100
Message-ID: <20190226112921.GB7654@latitude>
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
 <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 09:18:06AM +0100, Ulf Hansson wrote:
> On Sun, 10 Feb 2019 at 18:31, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
=2Enet> wrote:
> >
> > When using the mmc_spi driver with a card-detect pin, I noticed that the
> > card was not detected immediately after probe, but only after it was
> > unplugged and plugged back in (and the CD IRQ fired).
> >
> > The call tree looks something like this:
> >
> > mmc_spi_probe
> >   mmc_add_host
> >     mmc_start_host
> >       _mmc_detect_change
> >         mmc_schedule_delayed_work(&host->detect, 0)
> >           mmc_rescan
> >             host->bus_ops->detect(host)
> >               mmc_detect
> >                 _mmc_detect_card_removed
> >                   host->ops->get_cd(host)
> >                     mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
> >   mmc_gpiod_request_cd
> >     ctx->cd_gpio =3D desc
> >
> > To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
> > is registered.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> This works well as fix and for stable! However, we should probably
> clean up the code in ->probe() to avoid this thing altogether.

I figured that calling mmc_gpiod_request_cd before mmc_add_host *should*
avoid the 'return -ENOSYS' in mmc_gpio_get_cd. However it turned out to
be not as simple as swapping around a few lines in mmc_spi_probe, when I
wrote/tested this patch.

> Anyway, I send a patch for that - on top.

Thanks!

> Applied for fixes and added a stable tag, thanks!

Great.


Thanks,
Jonathan Neusch=C3=A4fer

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlx1IwkACgkQCDBEmo7z
X9vOuQ//ap3y5yOcvpnTDTH1GQJjshzHygc7MRPTiHDrbWohSitzELdb6df3oTsA
33g9FVE35Az3CNVDGdncfM41zKKTK/g5BS/Uatjs4U4usO1E0tqlKHR0kp8CuR5l
iZUsB/kFmtcrAdni7RyE045hYZT+wlwk+l/63MthdpQSvhEa7ps3/xDnDvC+qO1x
X6TOr7pW5gwnaun+ZQ08hvDg62MCUFtDIntIDLpE1iC/RpibBR79IRXFGVgsstk6
YQbyauG11wbfMetXhJ6v63j3g5f6NILr0Nwx7z9kMvn1HYht0fxtQDBjULH0WJRR
MX+D+PptV2x6q6eE4dzIDhaNBSVXy+dSMaS/WYhNr4AjTV8UAF9in+0u0bz6PPe6
hNWhzaiEgKT7qRnH2ivJ4CImf8EcwRsyZjU6inx31y7RezxyKYgPtVis0g0Kmhex
yLK8hYO3jXsYGEWe7fBBSuaOoBlnthltkkLNWGIYS4pTT3Wk5Syl3Feo1UhPo3Ye
1VWt8RYuLiY6rLOpsSsn3KY4sM8+R/EMu4eNZx4r422u+OsXUh9RS1e5uAMgQOF2
hOAXBv+swD3l+Kgg3uMiqhhlDYqOexmI1jzeLvFObOSFE7PPfoBQwQJdwq51dhfb
FwyLY7uv4x4uiz6FTmyRp6wIc4AyVS3lZmz62AaaCaqefpsiJDw=
=Bzd2
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
