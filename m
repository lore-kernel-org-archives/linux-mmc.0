From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] mmc: tmio: support IP-builtin card detection logic
Date: Sun, 19 Nov 2017 20:45:02 +0100
Message-ID: <20171119194502.bwxazcrg367pz74x@tetsubishi>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
 <1510136220-31853-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v35mchucdaphoj5b"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46926 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdKSTpH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 19 Nov 2017 14:45:07 -0500
Content-Disposition: inline
In-Reply-To: <1510136220-31853-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--v35mchucdaphoj5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 07:17:00PM +0900, Masahiro Yamada wrote:
> A card detect GPIO is set up only for platforms with "cd-gpios"
> DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
> core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
> if ctx->cd_gpio is unset.
>=20
> The bit 5 of the status register provides the current signal level
> of the CD line.  Allow to use it if the GPIO is unused.

I might be missing something: Why do we need to report something
sensible in this case? The card insert/eject interrupts calling
mmc_detect_change is not enough?


--v35mchucdaphoj5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloR3zcACgkQFA3kzBSg
KbbxGBAAiy/H6p6I7l9a+avpbtyM5VLA2ERC0oVvgCHR9YQa3jHPLn1aQLNdqcHW
r8Lswxssn73oIhMXH8Zg8ypwOiyPohhDpH7CGP9mS4iKYfUrwfAuXtFOUF9RTvON
y6kaTs3BDhYz2tLAZbDyZpCz2sMYXC+cAO/2LlXHTscwe6O/V/+8w+1wteF26D6F
kR9b0PqEPF7NNTEUCEDAhOyh8oqfD293cRMGsH+fDjbbcCPI+C7ufp+78PSwo/0d
X1ZMXxzbCKTkMX9q/TF3ytrTYUXL533G9J+PvI6S0Un+syuJFEdb2jIiEFbXjB9O
bJVKnRNMMwrgA1TcslNhaAFEKD8u5nu+m5rLWjjgIrVcbZyYDBWt2b5d78xAuXHg
4VGGPismxt65Aqt0UYcAcTd58pcx/ac5Od7RC5gnySwXsRcaJ1gNuv2RB78c9SpS
UHdtkK2AqkCC+Tma9BnJ75AuDCgMGG776yesDsZAc0m/oNtA1MT9KxzlEONVl8bd
rfSSO72VCUSdk/HiiGkvP9ws6ozj1hERGdPPAu7j1gIZ+XVxcd5nyuJGYKgowF7e
A7Q1uBT3vSNlmhuLnH3ihblbkofFXiY9VrXlu4nON56MDKj6Y1+YDXWqAwJocq+c
EU1QkjnqTJk24bwfhcXnqTe6anHTBTcxYh96KyuzZiGjetSGhLo=
=HOvC
-----END PGP SIGNATURE-----

--v35mchucdaphoj5b--
