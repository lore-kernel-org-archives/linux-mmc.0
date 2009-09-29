From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: + sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers.patch
 added to -mm tree
Date: Tue, 29 Sep 2009 20:25:27 +0200
Message-ID: <20090929202527.610c2138@mjolnir.ossman.eu>
References: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org>
	<812485.11160.qm@web28310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-31728-1254248738-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:51129 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbZI2SZf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 14:25:35 -0400
In-Reply-To: <812485.11160.qm@web28310.mail.ukl.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Michael Buesch <mb@bu3sch.de>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-31728-1254248738-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2009 16:05:12 -0700 (PDT)
Albert Herranz <albert_herranz@yahoo.es> wrote:

>=20
> Are there any comments/objections to this patch?
>=20

Hi Albert,

I've had some more time to think about this, and I think I was overly
harsh when criticizing your initial approach to this. The type field
seems like a fairly reasonable way to extend the system (although the
spec does not say anything about how to deal with unknown types). I
would assume that there is some official registry for these types
though, to avoid conflicts...

Anyway, my ideal solution would be something like this:

 - We start checking the type field in cistpl_funce. We already know
   about types 0 and 1 (and now 4).

 - We use this as a key for a subfunction, instead of the "func"
   parameter. We'd still need to verify that a type 0 is only used in
   the global CIS table, and a type 1 only in a local though.

 - Any known good types are silently returned upwards, queued for the
   function driver.

 - Any unknown types emit a warning in dmesg, but do not abort the
   init. This way we can have some kind of log if there is a parsing
   bug, or a buggy card.

All of this might not be needed in an initial version, but this would
be the model that would make blissful. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-31728-1254248738-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrCUSAACgkQ7b8eESbyJLi0sgCgoofZt7sxWkcveqZ0ZGprhBPT
pA8An0/5BJGonSEJi+s5wu7ypkB2HoW7
=gOX+
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-31728-1254248738-0001-2--
