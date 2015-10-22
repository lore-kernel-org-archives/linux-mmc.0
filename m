From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [RFC][PATCH v2] mmc_block: Allow more than 8 partitions per card
Date: Thu, 22 Oct 2015 19:13:08 +0100
Message-ID: <1445537588.10397.74.camel@decadent.org.uk>
References: <1445533241-10292-1-git-send-email-john.stultz@linaro.org>
	 <1445537261.10397.70.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-c5cZrS0ViWz0afBiQRmb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51194 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964928AbbJVSNW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 14:13:22 -0400
In-Reply-To: <1445537261.10397.70.camel@decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Colin Cross <ccross@android.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--=-c5cZrS0ViWz0afBiQRmb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2015-10-22 at 19:07 +0100, Ben Hutchings wrote:
> On Thu, 2015-10-22 at 10:00 -0700, John Stultz wrote:
> > From: Colin Cross <ccross@android.com>
> >=20
> > It is quite common for Android devices to utilize more
> > then 8 partitions on internal eMMC storage.
> >=20
> > The vanilla kernel can support this via
> > CONFIG_MMC_BLOCK_MINORS, however that solution caps the
> > system to 256 minors total, which limits the number of
> > mmc cards the system can support.
> [...]
>=20
> This commit was intended to allow support for 256 cards with any number
> of partitions:
>=20
> commit a26eba614afff0e39594101bcb73014a9a22fb33
> Author: Ben Hutchings <ben@decadent.org.uk>
> Date:=C2=A0=C2=A0=C2=A0Thu Nov 6 03:35:09 2014 +0000
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0mmc: block: Increase max_devices
>=20
> I don't think the new patch is sufficient or necessary to increase the
> limit further.

Of course, this does allow use of more than any predefined number of
partitions per card, the same as sd can. =C2=A0So it still has some
usefulness, though the commit message seems to overstate that.

Ben.

> Do you have a compatibility requirement to retain the numbering of the
> first 7 partitions?
>=20
> Ben.
>=20
--=20
Ben Hutchings
Q.  Which is the greater problem in the world today, ignorance or apathy?
A.  I don't know and I couldn't care less.
--=-c5cZrS0ViWz0afBiQRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAViknNOe/yOyVhhEJAQqcMRAAvijGZhlsyV+mBDEJtVQHg7HBB/kMSxsw
MHMrV59ErsqK+xqSx+ktJFaoa1P9+cAwUufTq4c5Zk02nFtFCpFWXxWAXsxOjipH
HV6heKGJsiXwbthfuf3+gRPsdR9f77eFLzh6W+qtVhzkrlZZirrNaYfNJuZBmEi+
DZOww0PwuPXRXbkM0X+PmlJ0xpFTaIOZyOqdwU+3+xjIwqhsyQ6wDC3aFnchOkW5
MNJqnPpXDnPyst/aT62UyFzpYktJuiABzSKgIEssp8mfpC35QqwmyhszQdAlDMM3
bappIFw4p45b0jf8osTc6wwEkQSamT9l84K38YDbSbkjHWkFc9CoG+QpCmLRw6rT
hJzlzTC435LVXnfoPas/RKLHy/Ir/bjdtfiOtTQsy3hKzYnhEelr8CxWrtUpDYnW
ZZUgkZTGN3th97hCf4RgeuuhdfX4f1R60D/t3dYdLLHUbvOVJwXDfbGORDmfXQcY
+7tYtmyhknKPcFqmQre7KyUvVKLhBe3pidRtn/fWmBQQe4n7R2ikrAQLhK5Ez/bX
75BGntHNmSDiXo0EJZ4dod4XARP9k53avjTfJtE5TIclEOsm66lGypuWLwazn/2m
onQRgWA+mVFZfhBR7/yF42T3pcBjdHCac1bK7tbBUWynZhoaHAKAXxaeXAg0SreZ
puWFepuU+Ls=
=82FS
-----END PGP SIGNATURE-----

--=-c5cZrS0ViWz0afBiQRmb--
