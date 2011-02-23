From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] mmc: cb710: Remove set-but-unused variable.
Date: Thu, 24 Feb 2011 00:03:09 +0100
Message-ID: <20110223230309.GB15104@pengutronix.de>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org>
 <1298500153-28081-2-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1BWXDN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 18:03:13 -0500
Content-Disposition: inline
In-Reply-To: <1298500153-28081-2-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2011 at 05:29:12PM -0500, Chris Ball wrote:
> drivers/mmc/host/sdhci-pci.c: In function =E2=80=98sdhci_pci_probe_slot=
=E2=80=99:
> drivers/mmc/host/sdhci-pci.c:913:18: warning: variable =E2=80=98addr=E2=
=80=99 set but
> not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/cb710-mmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 66b4ce5..280c03a 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -179,7 +179,6 @@ static int cb710_wait_for_event(struct cb710_slot *sl=
ot, u8 what)
>  static int cb710_wait_while_busy(struct cb710_slot *slot, uint8_t mask)
>  {
>  	unsigned limit =3D 500000;	/* FIXME: real timeout */
> -	int err =3D 0;
> =20
>  #ifdef CONFIG_CB710_DEBUG
>  	u32 e, x;
> @@ -190,7 +189,6 @@ static int cb710_wait_while_busy(struct cb710_slot *s=
lot, uint8_t mask)
>  		if (!--limit) {
>  			cb710_dump_regs(cb710_slot_to_chip(slot),
>  				CB710_DUMP_REGS_MMC);
> -			err =3D -ETIMEDOUT;
>  			break;
>  		}
>  		udelay(1);

What about changing return 0 into return err? It gets checked in
cb710_mmc_powerup().

The _other two_ patches:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1lki0ACgkQD27XaX1/VRsvzACfapRoWsFGUyePu+FmIbZJyuvu
HSEAnjnypQFF3tfoIY/XteIrvgxJSp7Y
=I+Np
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
