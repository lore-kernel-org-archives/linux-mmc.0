From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Fri, 8 Dec 2017 15:59:56 +0100
Message-ID: <20171208145955.av4uhpluldbhshog@ninjato>
References: <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
 <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato>
 <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
 <20171122170815.o3o5umayra7kbdg3@ninjato>
 <CAPDyKFpuiurgT5Zwo--EcaWOjZOdmSYotHrwH=c-byq3nkaxYw@mail.gmail.com>
 <20171127171401.o7ch26oot2au5oux@ninjato>
 <CAK7LNAQtLdXBw_JzW2dYdVtC0b6eGCvO5KByXfKKJVxi02i61g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wj424ilakl3w5maw"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60036 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbdLHPAF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Dec 2017 10:00:05 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNAQtLdXBw_JzW2dYdVtC0b6eGCvO5KByXfKKJVxi02i61g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--wj424ilakl3w5maw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yamada-san, Ulf,

> How about CONFIG names and functions?
> Prefix CONFIG options with CONFIG_MMC_TMIO ?

To be precise, I'd favour this:

# core
obj-$(CONFIG_MMC_TMIO_CORE)           += tmio_mmc_core.o
# TMIO-builtin MMC
obj-$(CONFIG_MMC_TMIO_ORIGINAL)       += tmio_mmc_original.o
# Reneses
obj-$(CONFIG_MMC_TMIO_SDHI_CORE)      += tmio_mmc_sdhi_core.o
# UniPhier
obj-$(CONFIG_MMC_TMIO_UNIPHIER)       += tmio_mmc_uniphier.o

But I am not sure if renaming CONFIG_MMC_TMIO to
CONFIG_MMC_TMIO_ORIGINAL is a regression risk?

> What should I do for function names?
> Shall I start with tmio_mmc_uniphier_ ?

I'll leave this to you and Ulf. If we e.g. rename "renesas_sdhi_core.c"
to "tmio_mmc_sdhi_core.c", I would still leave the function names as is
(prefixed with 'renesas_sdhi_*'). I wouldn't mind your functions
starting with "uniphier_mmc_" even, but that's just me.

Thanks,

   Wolfram


--wj424ilakl3w5maw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloqqOcACgkQFA3kzBSg
Kbb12Q//WMQjrDmAQ5bs5mq1OwDZN91274UTRbyv913XWIFwAezypXwQlSNfWHdM
1ECXhNOjtR+6tpUqQPnk7U1BiYphs+OqANj0KAr6oznEdruPr1R9Zodzy72zHEMn
cycrN+p/7dcGjz9dVMYkUY7vjdSIn/+IAOBKAXTgrDPZIrhziqBXST/6ym67KXne
b3Hu6vzyLkUc/+CXAPZrTkvCdPimoNkeDBAnAOzbDTp721SIhW6WEFlJuVHBIaEU
YSR+4YvqZOAmQc2rq1aOHpZOngo048dzBiBWlAVOm7Mwm3HjBfB89oU4U1g2NCCG
WPPi0rtnvL73ulN/NctKgiCWzQV/G4LThEIzQs1Xgb9I+7G+Vyvdac7jFX4t2Lye
2ncTfguNOT21O65nGbWv3px4FUvnfNdSANNic1oZiUvYmxgtxFNjWdtigT4ruFc5
pl9NygktpNUTEgPFzGwx5SG+E9JHUF57cUNbEjTxMYngXcs1DkPI0rbbNRkSTbjx
AZn3UFptI08JUMtsWSm+vM5Ib5wqOm7ucJ6esq2F11bR641jc5OHT04W4d43OuOY
REe+yJKPAE8BVX90ioqU9Ucnps8z2biOMpXFWGSS9plUOhLZJi2wIgnOKYMC6ytz
+kZXJr9t4fi7C5TDjkvdBzsabJE8dM1mfV5gPtVjq8hXwEW0/HM=
=CZCx
-----END PGP SIGNATURE-----

--wj424ilakl3w5maw--
