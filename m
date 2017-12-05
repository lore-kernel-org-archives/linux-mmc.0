From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 10/22] mmc: tmio: support IP-builtin card detection
 logic
Date: Tue, 5 Dec 2017 16:28:39 +0100
Message-ID: <20171205152839.czialo64b7nsgadu@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
 <20171204151320.4ypa2y5r335hcg7j@ninjato>
 <CAK7LNATeFZMVocscnfkYTU=5=dyRSNrrgVoh0rEvLyQvku9VSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7m4afatkbay4psrq"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48834 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdLEP2l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Dec 2017 10:28:41 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNATeFZMVocscnfkYTU=5=dyRSNrrgVoh0rEvLyQvku9VSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>


--7m4afatkbay4psrq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Another possibility would select this in _probe().
> We would need to evaluate mmc_can_gpio_cd() only once when probing.

I like this, too.

Maybe like this to be more obvious:

	if (mmc_can_gpio_cd(mmc))
		 _host->ops.get_cd = mmc_gpio_get_cd;
	else
		 _host->ops.get_cd = tmio...

?

--7m4afatkbay4psrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlomuyQACgkQFA3kzBSg
KbbFaw/9FvN3QaM4/Kee3sgPSsOQA987U7+pbDj+TG0znyCpxno1EOv1G2BXKkOM
Tr6mYLTF2+Bu7Rd9p+Alb35k8W87fRbM55IFfxnJvEo7IdkDbLR+DlbqPcFanWUp
EriyU3Qe3pOvtE1IhYkO+v12t4VuvPXW+NhI4EjoBww+vbSx3THyZlnhQTvLmPu6
bYNF43EGWri3X+448mRBqaC1Yhu8SkmOV9a884rqIuogKeA3t05IY9LGR2bLZ3rp
iVoIU3kf6GR86DGOQb8gS0xk/0Ctmn4FbUOCO0vJeF6joaUZOsM++kkozxDCm8ou
h+pwNsEC8gZbFmZey9fFNtkQdAv1Tc5ZH4Ptuc6Vp6qBrJqUMv8YGAwk8Tq7Mdnn
VqMYFYg1dXTvGuwGbubVkJ+3iV/4G+obsQ01wdSoz69xcwmnW2vzsP/JywFAcRcJ
ou5zEVrk/GJL+12eaNkJPvj2imIH4DJuGS+0Bldzn61ElW/T/mcu1R/pbYSjCOtR
09hx+GSH1EiB1F5e8MIni9AozNaF15vmsZyxxPuDl2GB6AYgnmv0djWZfd45inSV
7qZfWoyGYmyFaZ4CwlcLER0/YPNEjpG7hxel7hkekQ49mCIBwVYWYOOmXRWarGcO
Sa2Zx2EwYx2sve0Ugr1i16WgdjUBAPM/ITVFA/i3DRx+D8mDICg=
=AEIz
-----END PGP SIGNATURE-----

--7m4afatkbay4psrq--
