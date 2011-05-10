From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Tue, 10 May 2011 22:02:14 +0200
Message-ID: <20110510220214.916621d1.ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__10_May_2011_22_02_14_+0200_7wBI=yZks1o_S6dX"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:55523 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab1EJUCa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 16:02:30 -0400
In-Reply-To: <20110509203612.GC21323@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

--Signature=_Tue__10_May_2011_22_02_14_+0200_7wBI=yZks1o_S6dX
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__10_May_2011_22_02_14_+0200_JjnNHRL.1zHq8_rT"


--Multipart=_Tue__10_May_2011_22_02_14_+0200_JjnNHRL.1zHq8_rT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 9 May 2011 22:36:12 +0200
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, May 09, 2011 at 09:23:25PM +0100, Russell King - ARM Linux wrote:
>=20
> > NAK.  This has been proposed before, and rejected.  See the comments
> > against the original proposal:
>=20
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D6525/1
>=20
> Hrm, this looks like the bodge we're doing for !REGULATOR isn't actually
> helping here unless we do a NULL || IS_ERR() in the error check.  The
> ifdefs are certainly fail.
>=20

[Adding Linus Walleij to CC as he was the author of a similar NAKed
patch]

I was blindly trusting code already in mainline again, and for that I
apologize, I finally took the time to look at the implementation
of IS_ERR() and test its use, and being IS_ERR(NULL) true it is not what
we want indeed, see the attached test program.

So, I am going to remove the ifdefs anyway but use IS_ERR_OR_NULL();
how does that sound? Am I still missing anything?
Or changing the regulator_get() stub to return an error (-ENOSYS?) might
be worth it?

Thanks Russel for pointing out the issue BTW.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Multipart=_Tue__10_May_2011_22_02_14_+0200_JjnNHRL.1zHq8_rT
Content-Type: text/x-csrc;
 name="IS_ERR_regulator_get.c"
Content-Disposition: attachment;
 filename="IS_ERR_regulator_get.c"
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>

/* from /include/linux/compiler.h */
#define likely_notrace(x)       __builtin_expect(!!(x), 1)
#define unlikely_notrace(x)     __builtin_expect(!!(x), 0)

#define likely(x)   likely_notrace(x)
#define unlikely(x) unlikely_notrace(x)

/* from include/linux/compiler-gcc4.h */
#define __must_check            __attribute__((warn_unused_result))

/* From include/linux/err.h */
#define MAX_ERRNO       4095

#define IS_ERR_VALUE(x) unlikely((x) >=3D (unsigned long)-MAX_ERRNO)

static inline long __must_check IS_ERR(const void *ptr)
{

	return IS_ERR_VALUE((unsigned long)ptr);
}

static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
{
	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
}


/* Mimic regulator_get() when CONFIG_REGULATOR is defined */
unsigned long *regulator_get_full()
{
	unsigned long *ptr;

	return ptr;
}

/* Mimic regulator_get() when CONFIG_REGULATOR is NOT defined */
unsigned long *regulator_get_stub()
{
	return NULL; /* or maybe return -ENOSYS; ? */
}

int main(void)
{
	unsigned long *vcc =3D NULL;

	vcc =3D regulator_get_full();
	if (IS_ERR(vcc))
		printf("full: IS_ERR         =3D true\n");
	else
		printf("full: IS_ERR         =3D false\n");

	if (IS_ERR_OR_NULL(vcc))
		printf("full: IS_ERR_OR_NULL =3D true\n");
	else
		printf("full: IS_ERR_OR_NULL =3D false\n");


	vcc =3D regulator_get_stub();
	if (IS_ERR(vcc))
		printf("stub: IS_ERR         =3D true\n");
	else
		printf("stub: IS_ERR         =3D false\n");

	if (IS_ERR_OR_NULL(vcc))
		printf("stub: IS_ERR_OR_NULL =3D true\n");
	else
		printf("stub: IS_ERR_OR_NULL =3D false\n");

	return 0;
}

--Multipart=_Tue__10_May_2011_22_02_14_+0200_JjnNHRL.1zHq8_rT--

--Signature=_Tue__10_May_2011_22_02_14_+0200_7wBI=yZks1o_S6dX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3JmcYACgkQ5xr2akVTsAH2tQCgkgSQaqmMBHoD+uhkWa6Ohix7
zN8AnAi0fW9Mg6ZFWvwjqdFwiqagT6Ts
=PtuO
-----END PGP SIGNATURE-----

--Signature=_Tue__10_May_2011_22_02_14_+0200_7wBI=yZks1o_S6dX--
