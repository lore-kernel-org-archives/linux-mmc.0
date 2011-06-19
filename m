From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] MMC: Fix checkpatch warnings
Date: Sun, 19 Jun 2011 08:48:37 +0200
Message-ID: <20110619064837.GB1632@pengutronix.de>
References: <1308419432-18273-1-git-send-email-sebras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59601 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab1FSGsj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jun 2011 02:48:39 -0400
Content-Disposition: inline
In-Reply-To: <1308419432-18273-1-git-send-email-sebras@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2011 at 07:50:32PM +0200, Sebastian Rasmussen wrote:

Description of what was done is missing. How it was tested might be interes=
ting
for such patches, too.

> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> ---
>  drivers/mmc/card/block.c     |   10 +++++-----
>  drivers/mmc/card/queue.c     |   15 +++++----------
>  drivers/mmc/card/sdio_uart.c |    2 +-
>  drivers/mmc/core/bus.c       |    5 +----
>  drivers/mmc/core/bus.h       |    2 +-
>  drivers/mmc/core/core.c      |    7 -------
>  drivers/mmc/core/debugfs.c   |    2 +-
>  drivers/mmc/core/host.c      |    4 ----
>  drivers/mmc/core/sd_ops.c    |    1 -
>  drivers/mmc/core/sdio_bus.c  |    9 ++++-----
>  drivers/mmc/core/sdio_irq.c  |   10 +++++-----
>  11 files changed, 23 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1c7049a..48cf063 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -34,6 +34,7 @@
>  #include <linux/delay.h>
>  #include <linux/capability.h>
>  #include <linux/compat.h>
> +#include <linux/uaccess.h>
> =20
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -42,7 +43,6 @@
>  #include <linux/mmc/sd.h>
> =20
>  #include <asm/system.h>
> -#include <asm/uaccess.h>
> =20
>  #include "queue.h"
> =20
> @@ -169,11 +169,11 @@ static ssize_t force_ro_store(struct device *dev, s=
truct device_attribute *attr,
>  	int ret;
>  	char *end;
>  	struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
> -	unsigned long set =3D simple_strtoul(buf, &end, 0);
> -	if (end =3D=3D buf) {
> -		ret =3D -EINVAL;
> +	unsigned long set
> +
> +	ret =3D kstrtoul(buf, 10, &set)
> +	if (ret < 0)
>  		goto out;
> -	}

You change code here, while other changes are whitespace related. I think t=
his
patch needs to be split up. If each patch does one thing, it will make
reviewing a lot easier, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk39m8UACgkQD27XaX1/VRsgWQCdHosdC83BUoXo1fmh3sLnizHt
cG0AnjXLpH85gPl+5oBBqmEm+F/D/DSG
=Ymya
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
