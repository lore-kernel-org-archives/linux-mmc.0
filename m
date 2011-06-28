From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: mmc_test Correct xfer_size at write
Date: Tue, 28 Jun 2011 18:50:28 +0200
Message-ID: <20110628185028.6af91b87@mjolnir.ossman.eu>
References: <4E09AEE5.4050505@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-27592-1309279832-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from c-62-220-186-130.cust.bredband2.com ([62.220.186.130]:40781
	"EHLO smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759415Ab1F1Qzf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 12:55:35 -0400
In-Reply-To: <4E09AEE5.4050505@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-27592-1309279832-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jun 2011 11:37:25 +0100
James Hogan <james.hogan@imgtec.com> wrote:

> Hi,
>=20
> I'm trying to figure out why the broken write transfer tests in mmc_test
> require the result to be -ETIMEDOUT, so that I can make dw_mmc pass
> these tests. Perhaps somebody could explain.
>=20
> I can understand for reads, that the controller is waiting for the start
> bit on the data lines and so it can timeout after a while if it doesn't
> see any. However for writes (as far as I can glean from the physical
> layer spec and a logic analyser) the data response token which is
> normally sent by the card in response to a write transfer is clocked out
> immediately after the data so is either there or it isn't.
>=20
> Have I misunderstood it or is -ETIMEDOUT just the error that is required
> by convention when the data response token is not detected?
>=20

It's more or less by convention. ETIMEDOUT is the closest thing we have
to "we expected a response from the card but got bupkis". You can find
some informal definitions here:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3Dinclude/linux/mmc/core.h;h=3Db6718e549a510780e0f8c9a3be17e64753d6c2f5;=
hb=3DHEAD#l81

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-27592-1309279832-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iF4EAREIAAYFAk4KBlcACgkQopDLsoqlmEKUHwD6A9seuo3SAKH8tTT3mXvTIxVh
28ZPQb91OTKpZEvu1m8A/jW9gQmTHPVC7RVWDkyYcdO9EH+L+UJpSgqqsbdc9oDR
=Lt8F
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-27592-1309279832-0001-2--
