From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Wed, 18 Apr 2012 13:15:20 +0300
Message-ID: <20120418101519.GU13842@arwen.pp.htv.fi>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:37048 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab2DRKQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 06:16:25 -0400
Received: by lagy4 with SMTP id y4so7286838lag.22
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 03:16:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 11:10:35AM +0100, Russell King wrote:
> Using coherent DMA memory with the OMAP DMA engine results in
> unpredictable behaviour due to memory ordering issues; as things stand,
> there is no guarantee that data written to coherent DMA memory will be
> visible to the DMA hardware.
>=20
> This is because the OMAP dma_write() accessor contains no barriers,
> necessary on ARMv6 and above.  The effect of this can be seen in comments
> in the OMAP serial driver, which incorrectly talks about cache flushing
> for the coherent DMA stuff.
>=20
> Rather than adding barriers to the accessors, add it in the DMA support
> code just before we enable DMA, and just after we disable DMA.  This
> avoids having barriers for every DMA register access.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

cool, should this go to stable too ?

--=20
balbi

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjpQ3AAoJEIaOsuA1yqRE5NQP+QEZzK6LAN/dhY/2kjjKYJAW
2ZK+kq8JWVgvlGzVKKqa9NmrmYutq2LhIDHQxGiZWgsYZDh5iCHnst9wlng8ueqT
ASfCKbLvv8hZXlVVEuFaMXDxwFYY+jA12uh8asqXyVIo2uBIoCo7CoabwKhxAQQR
cjh95RC2XKk96xZV306lIeW02hJSGR2aE1cFAnCqQtUwFCCpJgryR23BZDZV3A0A
ezFf7cxLyS6meoHJOB60v9B6Ao6eVSsBQUpnzYBvelcJ5mgixG6DhqjmLPoc7I1P
qi8afwaJF0JJ1dL2IlqC1CnRMZ2CUvSxJIl+CHKNWT9DbK4gdBFgIjSXHl+R842N
Tb2IbG0J03cME5QRLUYitbChniHjEBrK6DJEsUi3RHvXIfHiDBZGXCHe5SKWtAMy
B6Ip3D/8Z4s7kDbqsK8Z+rbQHng72ULnhIplgZGXnS4nbxgOqcuxHTU6k4GhbF3V
zsrWwIhIjr1bmlAE47yMvgOkUEVs6NcjwrD0ZE91pMD419/G2ci9LOMrPPI5d+EG
wxOPwEbbzS/NAZTidYJkaYE3kRqyriNb7FFgHC5hDyYXAkcilZMPouWPHDFYN08i
Aaw1F2TENBw5olpiADwkiqCmME0scGgMDgChD2bZSdMZt70Gp860TYuAXFR3k9mE
WUt2yn4s/YT8d+XW+QkZ
=9it2
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
