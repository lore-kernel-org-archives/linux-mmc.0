From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Thu, 27 Oct 2011 07:15:32 +0200
Message-ID: <20111027051532.GA28387@pengutronix.de>
References: <20111027041851.GA18442@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50360 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1J0FPe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 01:15:34 -0400
Content-Disposition: inline
In-Reply-To: <20111027041851.GA18442@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Cc: linux-mmc@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 27, 2011 at 12:18:53PM +0800, Shawn.Dong wrote:
> sdhci_set_clock or sdhci_reset or sdhci_send_command may be used in
> critical region which is protected by spin_lock_irqsave. Thus, these
> functions will delay the responsing of the kernel interrupts.

Yes, so this needs to be improved, not the delay values.

> So in this case, using a mdelay will cause unnecessary latency. Our
> hardware, in most case will not cause 1ms to finish its job. Using
> udelay instead can reduce it.

Could you guarantee this for all other SDHCI hardware out there as well?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6o6PQACgkQD27XaX1/VRvFBACfc4OrmQDtgv6Fy9v8R4tV/9UC
1KcAn1jLvjEHeKFwRkoSGfoXmt6a1nMn
=s/W+
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
