From: Sascha Silbe <sascha-ml-reply-to-2012-2@silbe.org>
Subject: Re: [PATCH] mmc: sdhci: refine non-removable card checking for card detection
Date: Tue, 10 Apr 2012 10:05:04 +0200
Message-ID: <1334044850-sup-1149@twin.sascha.silbe.org>
References: <20120409231420.B54649D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1334045118-975119-11988-1068-3-="
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from setoy.chost.de ([217.160.209.225]:42567 "EHLO smtp.chost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751995Ab2DJIMD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 04:12:03 -0400
In-reply-to: <20120409231420.B54649D401E@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>


--=-1334045118-975119-11988-1068-3-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Daniel Drake's message of 2012-04-10 01:14:20 +0200:

> In the OLPC XO case, we need CONFIG_MMC_UNSAFE_RESUME because our root
> filesystem is stored on SD, but we also have external SD card slots
> where we want automatic card detection.
> =

> Refine the check to only apply to hosts marked as MMC_CAP_NONREMOVABLE,=

> which is defined to mean that the card is *really* nonremovable. This
> could be revisited in future if we find a way to improve
> CONFIG_MMC_UNSAFE_RESUME semantics.

What exactly is the behaviour after this patch? Will systems running
from SD cards attached to a host controller that's _not_ marked as
MMC_CAP_NONREMOVABLE (e.g. the external SD card slot on XOs) work again?
Or does it only fix running off internal SD cards (which are marked
MMC_CAP_NONREMOVABLE)?

Sascha

-- =

http://sascha.silbe.org/
http://www.infra-silbe.de/

--=-1334045118-975119-11988-1068-3-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBCgAGBQJPg+m3AAoJELpz82VMF3DaAdQH/1eEm3aHZgVPBDEgNBRTU8IH
pMHghEyBhmdovKRxQnxUIwEKk5UFbwrFepB4W26F0P15lJAPRjJShnQP9YeL8h67
8lIhdXc/q/l70qItUevmM1p6JnpfrIDBf9Ofr5+99Gl8R7uJ/mQR0XFS0YT7T73j
su4LyXV1+oBkkFlKP2/AhkSqRcrtAYq4Mr7emmlwokAdt5Y4OdFiFtmvCQA3gCso
9Fg9yC/GkLRdU7yqEz2xp8b3+HRJSAqo3iZzviGbRBPNMtbm173XlEFTpwCDJyFY
1DvOmNm2yGXYVIs+NE68d5moPGwuUhlQUhRngqGZmjMyEooZ3sZRx6KYJXUtpGA=
=4qup
-----END PGP SIGNATURE-----

--=-1334045118-975119-11988-1068-3-=--
