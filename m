From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: rename tmio_mmc_{pio => core}.c
Date: Tue, 2 May 2017 15:11:32 +0200
Message-ID: <20170502131132.gqg4uem2boborohm@ninjato>
References: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
 <1493723743-22821-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vctmhwfm3w5vqsmh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54206 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdEBNLg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 May 2017 09:11:36 -0400
Content-Disposition: inline
In-Reply-To: <1493723743-22821-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--vctmhwfm3w5vqsmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> - * linux/drivers/mmc/host/tmio_mmc_pio.c
> + * linux/drivers/mmc/host/tmio_mmc_core.c

I think we should drop the filenames here (and in other places)  and use
a human readable string instead?


--vctmhwfm3w5vqsmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkIhYAACgkQFA3kzBSg
KbYSHBAAkGJ3xIafhSA9NngJ6dPiYmrbO2JEmkf9mguVRo27CH529qBQQuXEDVsM
om5yyIXzTeen4fGp65dC0OpnXpj/1qGgKCj+cR+CYXWv9Hfc5Sk4HJMyAX9/FiJk
dvWUwPwvLoLJqOCiCp5jHj8jpz/W06TjfOgG+ivoGT770Z9EnNUljxysvmq6p5Ve
KZ4py5u/Swqf4eDiTmTktacsTHxRfJwan3jnPV37+3sTIZEKWGZ16gkvs20Q4FFK
oIzhzY23LP4MNj/Ng9VNLYYARTP4teRh5ks0Es7IJllYDRXfPFg0kRbKUEuIBJ1n
V029jecOjoQaj/hnmDhcTmn+i8JuyRB0UdYwbAjTU/tL/YB+ifvkiQN9xNQ3tp+0
WxHw2UdWw7njoDiCQKYDx4cYWRiaVOy0gidz27rhy/RNt9hduQwuaN0/Q4//FlFL
AGZeKNbwNvINGBerj+/XJDv6bIKmix+yxDIbAi5GV7nQsCh+tJS3j3NdvK/y+b1W
LxAv7BCv0mIx1Uc4M7+QB2KM9aZQRbWMTLRby1f2jxnXBUtwHyBA0DbkV16WGhup
J+yL3uNPkZn1A4OdjmtSfGeedoSHn0V9ngE6J3r3bjM0H5sMWIa4iuVtbfmJ6x3U
FggBYOJ59ZXIZjC7C6mfDdQRk601lY4ATfIjCeh2d46vsp5UCbg=
=IbHR
-----END PGP SIGNATURE-----

--vctmhwfm3w5vqsmh--
