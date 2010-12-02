From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/3]set timeout control reg for such SDHCI host
Date: Thu, 2 Dec 2010 12:53:30 +0100
Message-ID: <20101202115329.GE3345@pengutronix.de>
References: <20101202112613.GC10358@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48078 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab0LBLxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 06:53:33 -0500
Content-Disposition: inline
In-Reply-To: <20101202112613.GC10358@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, arjan@linux.intel.com, alan@linux.intel.com, akpm@linux-foundation.org, adrian.hunter@nokia.com


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 02, 2010 at 07:26:13PM +0800, Chuanxiao Dong wrote:

> +	if (host->quirks & SDHCI_QUIRK_FORCE_ERASE_SINGLE) {
> +		/* Set the timeout to be the maximum value */
> +		if (cmd->erase_timeout)
> +			sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
> +	}
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);

Hmm, this looks like another argument for Philip's idea to always use
the maximum timeout value and skip the quirks related to it?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz3iLkACgkQD27XaX1/VRsRFACgtNpV4S15ULJxkDjUn9Ck7VEJ
AI8AoMVFkVEN1newoLQgPcbEUZrfTTIk
=Uy3r
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
