From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] MMC: Fix checkpatch errors
Date: Sun, 19 Jun 2011 08:43:29 +0200
Message-ID: <20110619064329.GA1632@pengutronix.de>
References: <1308419423-18234-1-git-send-email-sebras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42989 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab1FSGnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jun 2011 02:43:31 -0400
Content-Disposition: inline
In-Reply-To: <1308419423-18234-1-git-send-email-sebras@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2011 at 07:50:23PM +0200, Sebastian Rasmussen wrote:

Please state in the commit-msg what kind of errors have been fixed.

They all seem to be whitespace related issues. Have you checked that the
binaries are identical before and after your patch? That could also go into=
 the
commit-msg.

> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> ---
>  drivers/mmc/card/block.c    |   14 ++++++--------
>  drivers/mmc/card/mmc_test.c |   34 +++++++++++++++++-----------------
>  drivers/mmc/card/queue.c    |   14 +++++++-------
>  drivers/mmc/core/core.c     |    2 +-
>  drivers/mmc/core/mmc.c      |    2 +-
>  drivers/mmc/core/mmc_ops.c  |    4 ++--
>  drivers/mmc/core/sd.c       |    2 +-
>  drivers/mmc/core/sd_ops.c   |    4 ++--
>  drivers/mmc/core/sdio.c     |    4 ++--
>  drivers/mmc/core/sdio_bus.c |    2 +-
>  drivers/mmc/core/sdio_cis.c |   18 ++++++++++--------
>  drivers/mmc/core/sdio_ops.h |    2 +-
>  12 files changed, 51 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 71da564..1c7049a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -908,10 +908,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq=
, struct request *req)
>  	return 1;
> =20
>   cmd_err:
> - 	/*
> - 	 * If this is an SD card and we're writing, we can first
> - 	 * mark the known good sectors as ok.
> - 	 *
> +	/*
> +	 * If this is an SD card and we're writing, we can first
> +	 * mark the known good sectors as ok.
> +	 *
>  	 * If the card is not SD, we can still ok written sectors
>  	 * as reported by the controller (which might be less than
>  	 * the real number of written sectors, but never more).
> @@ -1003,8 +1003,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struc=
t mmc_card *card,
>  	if (!subname) {
>  		md->name_idx =3D find_first_zero_bit(name_use, max_devices);
>  		__set_bit(md->name_idx, name_use);
> -	}
> -	else
> +	} else

else-block needs braces.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk39mpEACgkQD27XaX1/VRsIEwCgn8E3UcSdSpXGMcqaehxKgM5M
8S0AniGvgH16oF4pRNLxRhg9R7Yq7mIX
=YVwG
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
