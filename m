From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: mmcqd cpu utilization
Date: Wed, 2 Sep 2009 19:40:36 +0200
Message-ID: <20090902194036.07c1f72c@mjolnir.ossman.eu>
References: <007301ca2bf2$2888e2a0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-3599-1251913245-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:40233 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbZIBRko (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Sep 2009 13:40:44 -0400
In-Reply-To: <007301ca2bf2$2888e2a0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, hch@lst.de

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-3599-1251913245-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Sep 2009 12:23:59 -0500
"Madhusudhan" <madhu.cr@ti.com> wrote:

> Hi,
>=20
> Has anyone monitored the cpu utilization percentage when a MMC/SD card is=
 in
> use? I have noticed that mmc_queue_thread "mmcqd" consumes a lot of cpu
> cycles in a periodic fashion. What I mean here is that I see spikes of hi=
gh
> cpu utilization due to mmcqd. There will a cp or similar which will be
> already consuming cpu to transfer data to the MMC/SD device. Further mmcqd
> increases that load randomly to a high number.
>=20
> Has anyone seen similar behavior? Any thoughts?
>=20

My guess would be that the omap driver doesn't (cannot?) use the
hardware to wait for busy to end, so the system must poll.

Anything better than that guess will require some profiling. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-3599-1251913245-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqerhgACgkQ7b8eESbyJLgWBQCcCOkc+Q7e/awwfMVuZbDWofx2
LtAAoLbtB1SivvjiM6rAO1iiiRTiElh3
=HWrx
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-3599-1251913245-0001-2--
