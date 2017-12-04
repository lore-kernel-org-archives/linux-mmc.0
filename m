From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: properly init drv_type
Date: Mon, 4 Dec 2017 09:50:45 +0100
Message-ID: <20171204085045.oxodfyuczbbfkach@ninjato>
References: <20171130144910.4320-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdWEWRy64foR9tNwxvwg-z3FLE8ZVT5CjmuEQ1sZtyHrBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jlujnbfdf7qwth2w"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWEWRy64foR9tNwxvwg-z3FLE8ZVT5CjmuEQ1sZtyHrBQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>, Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org


--jlujnbfdf7qwth2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 09:31:13AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Thu, Nov 30, 2017 at 3:49 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > When the latest version of parsing the new eMMC bindings was moved from
> > core.c to mmc.c, it was overlooked that drv_type could be used
> > uninitialized. Fix it!
> >
> > Fixes: 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver ty=
pe")
> > Reported-by: Colin Ian King <colin.king@canonical.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/mmc/core/mmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index a552f61060d212..0d1c6b025ca596 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1290,7 +1290,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >
> >  static void mmc_select_driver_type(struct mmc_card *card)
> >  {
> > -       int card_drv_type, drive_strength, drv_type;
> > +       int card_drv_type, drive_strength, drv_type =3D 0;
> >         int fixed_drv_type =3D card->host->fixed_drv_type;
> >
> >         card_drv_type =3D card->ext_csd.raw_driver_strength |
>=20
> Could this be the cause of the issues Simon was seeing, cfr. 'Possible
> regression due to "arm64: renesas: salvator: set driver type for eMMC"'?

Yes, there is a chance. It still worked for me, though.


--jlujnbfdf7qwth2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolDGEACgkQFA3kzBSg
KbbLaQ/6A2rj0g6Yn+K70XBwuCoGPeh/HEeX+9NVFR/l3NA3Nnb9sa2EAFPtVcaz
GtNybNt5IV0hPAWSn6Xtp3vb2GbvvHEzKOYgPy/1Ku5R/6sT2zszcZTX6kAoAwTV
lhkz2fmHr/saFKGBAwh5dypcG/fB7jEL4mPwGW3YOWiWoSyU/ayxR0idssU0MDoX
POsUUwRK0hrRM2zcfX2NbIFbEOessqJ+t0Z10OCcKTdoqXHRto/cS6AMjVjN6mGi
MwsWykp6rbVK8a+EEAEadbc+M3aR3HwFHBL2zPRNucdMLs6inhp4thEv1XOloUAD
dPHDO3lijJ+c4/Bg4pX0t9oPQqVVAwuIlodA5+x3WfNNPmHFGpBAUouadLXgxCS+
kyAxSsT6wmRm9iMWLLPgDv9Pwno0pruOkqwjr2BmF+e+26XDDl4RD4ljaaER50Ht
5NSFJcXtoOeOMc8dwgO6/xAuJOcJzlusyTzzxhGuF5JhyyR1AWkhGZqCPbdXxgKc
Ku9UcJloKQMjAldMkMwCFaX/k8641jVUS1M2JaER6THs5Id+LAP+1470/1+5DOYf
mlPvAEiw25MGrtb7pQRNDCyXzrIlH5ja+QTxQtMMJp4S6yCDKiMXWejor709wJXJ
t89ejmYiN3AlQMEjIikm64pf1xI6CP6esTCl5hat06ERLTPoaq4=
=bVH6
-----END PGP SIGNATURE-----

--jlujnbfdf7qwth2w--
