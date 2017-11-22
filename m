From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Wed, 22 Nov 2017 18:08:15 +0100
Message-ID: <20171122170815.o3o5umayra7kbdg3@ninjato>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
 <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
 <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato>
 <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mffn6472jrfpubz4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58503 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdKVRIR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Nov 2017 12:08:17 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--mffn6472jrfpubz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Another try:

> # core
> obj-$(CONFIG_MMC_TMIO_CORE)		+= tmio_mmc_core.o
> # TMIO-builtin MMC
> obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc_original.o
> # Reneses
> obj-$(CONFIG_MMC_SDHI)		+= tmio_mmc_sdhi_core.o
> # UniPhier
> obj-$(CONFIG_MMC_UNIPHIER)		+= tmio_mmc_uniphier.o

I left the Kconfig symbols for easier updating and concentrated on the
filenames for now.


--mffn6472jrfpubz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloVrvsACgkQFA3kzBSg
KbbQGw/8C8J/0cOzQtQjilAl+Sjj0YeZT+6jlyv9ELCgliScLPiO4ay1EKUC76p2
9luSSRPn63P4GoIKgZ295Z8wYE8wfn5/IUza6vlDlF211t7FG//Bi2djCJCDRjsD
P82ndffcmDvNDP005/6hYVfZKJoJfexUlzBRlPgc7RkGEeU1WpYY77J652XoRYCF
xsBd/A7E4DkzHc5fOt+3FAsOZfPxrR0rkQgQPyhssv7dYKpoTAz8o9C52L1UpUUO
yq0aJEBZO81en4+1+iVBpEa7E/KLoZntlZfKADkIkmLfXTJv5w8ZF4OSmoEcZkzz
0daA8d+d94I84L67laNTUl6Yw3ahHTMkzgkGSBe6apuemNGEPo243rz9uY/sAHfA
Glzos8l7zsew0shYkT6Jqob3x5YrOrz/W6t2sUIhXHLJGJooprKnWbHBKP5Bl5kk
F3G0L+PEIietkg0X0eYVXSAEamawLcFPxkHgCFK9zhX7ESgRNEWk84E/+ok8QkZI
MWgtuqbOBrGj2eTDW4Z7N86TAVrdy9cSBE02OSUxFhYMfbHjK22229JnDiRuuTUO
PzqqsupKmvRfW9uc1eYFnp6RFHsf5Hr7npGPTZFS9H3pw7v1eekPibbG2qQ8VOi0
XaIDK2hMqGWsXWvONxXsJf2GS7Tu/vFbrKU6gnqgIFKhLFj+d4E=
=K8i5
-----END PGP SIGNATURE-----

--mffn6472jrfpubz4--
