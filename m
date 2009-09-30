From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Tue, 29 Sep 2009 23:10:13 -0700
Message-ID: <20090929231013.5d67b36a@fido2.homeip.net>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Sch3UpbTMnGTAwLXJvQQ=.Z"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:35930 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbZI3GKu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2009 02:10:50 -0400
In-Reply-To: <20090929233732.62f470e0@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

--Sig_/Sch3UpbTMnGTAwLXJvQQ=.Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2009 23:37:32 +0200
Pierre Ossman <pierre@ossman.eu> wrote:

> I must have missed that part of discussion. If the voltage fully
> overlaps with the MMC definition, then I don't see the controllers
> having to be designed explicitly for SD 3.0. If not, then we probably
> need a new voltage bit for the hosts. In that case separating
> supporting from non-supporting should sort itself out easily.

The reason I think we need is a host cap is that low voltage operations
apparently implies different signal timings. This is second hand from
David as there are no public specs for 3.0 available yet. So, the
failure case is a controller that publishes support for low voltage,
but only expects MMC cards to use it.

In practice, I expect that the timings are close enough that this will
work anyway, but I think the situation is analogous to HS-MMC vs HS-SD.
There the timings are slightly different and you felt it was enough to
justify a separate host cap for each one.

In fact, thinking about it in those terms, it suggests we need to
retroactively introduce a reduced-voltage MMC host flag too, just in
case SDHCI 3.0 controllers barf on those cards...

Am I being too doom-and-gloom here? David, do you have an opinion on
this one?

>=20
> Btw, you really need to whip some sense into the line handling of your
> email client. :)

Indeed. Let's see if it's any better this time :-)

Thanks for taking the time to chime in on this one.

--phil

--Sig_/Sch3UpbTMnGTAwLXJvQQ=.Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrC9kUACgkQ+NaxlGp1aC52OgCgwkbrKcFlfGkfBcr2ZZedFaBA
OwUAnA18eKPOElT+LAsIu4n8BnfTm3be
=5T3M
-----END PGP SIGNATURE-----

--Sig_/Sch3UpbTMnGTAwLXJvQQ=.Z--
