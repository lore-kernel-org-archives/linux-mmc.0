From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Sat, 10 Oct 2009 11:42:15 -0700
Message-ID: <20091010114215.5f9d8c94@fido2.homeip.net>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
	<20090929231013.5d67b36a@fido2.homeip.net>
	<20091008203826.5e027347@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LAHBbCSByOM9OlEoTHz5HYY"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:52823 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948AbZJJSnW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 10 Oct 2009 14:43:22 -0400
In-Reply-To: <20091008203826.5e027347@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

--Sig_/LAHBbCSByOM9OlEoTHz5HYY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Oct 2009 20:38:26 +0200
Pierre Ossman <pierre@ossman.eu> wrote:

> >=20
> > In practice, I expect that the timings are close enough that this
> > will work anyway, but I think the situation is analogous to HS-MMC
> > vs HS-SD. There the timings are slightly different and you felt it
> > was enough to justify a separate host cap for each one.
> >=20
>=20
> It's difficult to say without seeing the spec. But if things are not
> backwards compatible, then we should probably add either a new timing
> mode, or a new bus mode (where we have open drain and push pull
> today).
>=20
> > In fact, thinking about it in those terms, it suggests we need to
> > retroactively introduce a reduced-voltage MMC host flag too, just in
> > case SDHCI 3.0 controllers barf on those cards...
> >=20
>=20
> Maybe. Again, it's difficult to say without seeing the specifics of
> the new specification.

Make sense. So, I guess the question is do we assume the best case (in
which case there is no additional work to do - the code that is now
in allows low voltage SDIO cards to try and run) or the worst case and
add pre-emptive mode flags?

David, you've actually seen the new spec right? What's your opinion?

--phil

--Sig_/LAHBbCSByOM9OlEoTHz5HYY
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrQ1YcACgkQ+NaxlGp1aC4YswCgi76PnDQku9qQ/2/N6upk4EEX
bgkAn2otlDK4nv0dDzxHO7ZjVuHIA1PN
=EkzT
-----END PGP SIGNATURE-----

--Sig_/LAHBbCSByOM9OlEoTHz5HYY--
