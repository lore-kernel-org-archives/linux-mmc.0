From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 10:57:44 +0200
Message-ID: <20100924085744.GA10334@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
 <20100924064310.GA30543@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0D4BFC@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40571 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab0IXI5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 04:57:45 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D4BFC@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2010 at 03:08:52PM +0800, Zhu Richard-R65037 wrote:
> Hi Wolfram:
> See my comments.

BTW can't you get your mailer to quote like all others do? It is
inconvenient to read this way.

> > It would bring the conveniences to maintain stuff in the future if we=
=20
> > separate them.
>=20
> If you can name these conveniences and they are convincing, we can keep
> them seperate. At the moment, I don't see them (what doesn't mean they
> don't exist)
> [<Zhu Richard-r65037>] As Anton's description different eSDHC IP on the
> i.MX and the PPC may have the different IC bugs or limitations.

Sure thing. I don't see any problem with that as I don't want to merge
them completely, but just to share the common parts. Fixups can be done
in the specific part.

> As I know that although in the i.MX SOC family, there are a few
> differences between different SOCs. And the behaviors of SW driver may
> be impacted by these differences.

If you have even more incarnations of a similar core in the future to
come, that is another reason to share those parts which are in common.
Smaller differences can easily be handled in sdhci-esdhc-imx.c, I think.
For example, if stuff like

	if (cpu_is_mx35())
		quirks |=3D SDHCI_QUIRKS_NO_MULTIBLOCK;

will do, why would you want to duplicate all the code covering the
non-standard register layouts? Check the imx-spi driver how to handle
variations of a similar core.

> I'm afraid that the differences of eSDHC IP module between i.MX and PPC
> maybe bigger and bigger in future.

If the core of a future IMX99 might be too different, we can have a
custom driver then, but for now, I think a common driver is the way to
go.

> BTW, the block size of the i.MX eSDHC is not forced to 2K size. Up to
> now, the default 512byes per sector is used in FSL i.MX Linux BSP.

It is forced to 2K, because it would be otherwise set to 4K (according
to the cap-register) which is not conform to the spec 2.0. What is the
advantage of 512 byte?

> > And there is already one set of eSDHC driver for all the i.MX SOCs.
>=20
> I am confused: which set do you mean?
> [<Zhu Richard-r65037>] The driver used for i.MX eSDHC. The one used by
> i.MX35 in Linux kernel now, and the coming MX51 and so on.
> It is better that one driver supports all i.MX SOC's eSDHC modules in
> future (MX25, MX35, MX51, MX53...).

? Now I am totally confused. That is what I am aiming for :D My driver
was mainly tested on MX35 back then, but was clearly intended to be for
MX51. It was clearly mentioned in the subject "[PATCH 0/4] Adding
support for esdhc on mx35/51". Frankly, I was hoping for a patchset from
you adding the stuff you need for you MX51-board on top of mine, and not
a completely new series. Will have a look at that now...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkycaAgACgkQD27XaX1/VRvp2ACeIoDNcESZlB0em1t5F0U4My4v
K8UAnjbVxxuYLznAT7gfzctrlMOJ3uKp
=2oRm
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
