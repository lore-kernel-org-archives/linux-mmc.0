From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 1/2] mmc: Add helper function to check if a card is
 removable
Date: Sat, 28 Aug 2010 15:13:09 +0100
Message-ID: <1283004789.7653.76.camel@localhost>
References: <20100828133737.GH18829@console-pimps.org>
	 <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-XW5MVKk06JMV4eOOFdSN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45834 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653Ab0H1OOX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Aug 2010 10:14:23 -0400
In-Reply-To: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Yunpeng Gao <yunpeng.gao@intel.com>


--=-XW5MVKk06JMV4eOOFdSN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-08-28 at 14:53 +0100, Matt Fleming wrote:
[...]
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -272,5 +272,12 @@ static inline void mmc_set_disable_delay(struct mmc_=
host *host,
>  	host->disable_delay =3D disable_delay;
>  }
> =20
> +extern int mmc_assume_removable;

This variable is already declared in drivers/mmc/core/core.h.  Either
remove the declaration from there or define the following function there
instead of here.

> +static inline int mmc_card_is_removable(struct mmc_host *host)
> +{
> +	return (!(host->caps & MMC_CAP_NONREMOVABLE) || mmc_assume_removable);
> +}
> +

That '||' should be an '&&'.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-XW5MVKk06JMV4eOOFdSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATHkZdOe/yOyVhhEJAQKtKw//aXkmpQzd3SJWDnQf/XNtRUatQGpB/+Ki
AfkI9ohkMxlBQ8gJrZ7JvlyBWtLJjvi497ljeQDIN7SU4aZoA5AgzT2zex7o2fJv
ZFPhaoMn3xZjTwAHQWnBYQ6t7eW9PsJBEjO1wqB/KUBumzpCk3LArA8V74gr0OST
xGr1x6cXu8PJ7wiW2MSgOqZf6e4KLD0qY7msGfrOhqsb9yh8URlrw/XCMTk5QpBZ
TncnJNTtUBUDw/EqRzDZ8/fxqd4ooc/DbKUSfLnTAhM9HlAqSMjFKo87An2u+ZG3
bZrLgky+WTkZky2qB+nneu1ojuhmRGFwd1WM6gQxWEI322zmtB8dCl/lhEA4403o
CLRAsZExKtOZqmyjFTTdoNqaZmyirL4bsik/j7wdLP0KEWB3I4HxknUAmBTtVdll
kJt4fY30K7Gqt8vfnYrSgt/IF4feXXoxwA4owx9tDmD4Jj3AiJvhZWielTESxkmo
1CRn23VJmgkjGSfnogCnXc0+IHjB68ITAQ/09ncKYRfIG401z0dSsQVGx0AzqEmY
Nw8CuDh4mTG0z5XqLiaZkRrMgI0Cd7QI4w6xfiujifn+a2a2BSuX1wAjCo/0bWRd
NWP/vzWEE6ivamV2LNTpCa8BbwyIqpjCzSKs4dnwmqiO+NzUvVzHD9JHUCGHQs4u
Wzg3IduXdaI=
=CvKN
-----END PGP SIGNATURE-----

--=-XW5MVKk06JMV4eOOFdSN--
