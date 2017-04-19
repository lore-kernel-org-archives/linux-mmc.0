From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 07/25] mmc: sdhci-pci: Use ACPI DSM to get driver
 strength for some Intel devices
Date: Wed, 19 Apr 2017 14:24:20 +0200
Message-ID: <20170419122419.GA3832@katana>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
 <20170404084847.GB1439@katana>
 <47372fbd-9c16-725a-7f25-97481f09a6eb@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:42134 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762957AbdDSMYY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 08:24:24 -0400
Content-Disposition: inline
In-Reply-To: <47372fbd-9c16-725a-7f25-97481f09a6eb@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > do you think it makes sense then to have a similar encoded value from DT
> > (maybe "mmc-fixed-driver-type-<n>" with n=3D0..4)?
>=20
> The _DSM, being a device-specific method does not have to support differe=
nt
> devices with different requirements whereas DT does.

So, it is more like a vendor specific property (e.g. "renesas,
mmc-driver-type")? Sorry, I don't know much about ACPI.

> >                                                  This is a largely
> > reduced encoding of what you proposed in 2015 [1] but may be more
> > pragmatic for soldered on-board devices working on their max speeds with
> > fixed voltages and frequencies? Or did I get something wrong?
>=20
> What I proposed was being forced on me by the requirement to provide a
> solution that could meet any conceivable need.  That gets over-complicate=
d.

Yeah, that became pretty clear.

> But as you say, in practice people are probably only interested in provid=
ing
> one value for the max speed / frequency.

OK. Thanks for your answers! Much appreciated.


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY91bzAAoJEBQN5MwUoCm2aDAP/2ShryXUvwxDeiQPjtEyCjwd
UYgOCH5qmX7wgbvyOF79/v6hcLaBKF7BclgyJ6kqpQY/rn6WE/agSnut4eSXdQWE
cTP3EXzfc0s7teCQ+U/UXvCUp7UUf34+BLhJG7WePI378xWOSXKUljhJnQ9aiaiQ
INi0zSw+aD7rQGhIohC3kOhCL7aR8fxZhJdnkl/qjUngGxeUdoPxLSgbbusG7HM1
bFuH57IVSeB/gLtOGW6YUIam60heoPwTahA5NrSciP+7LB2sljmMjjBsDR0xJzPv
nrYzG49GzB4seQYfvQ9PTqvcjCNZPf2CoF7upTKemWNkWyjrLhJIIFI+jL3ehcJH
/cU1Cha2peP5sYzfLkqbNN/+x0P2gp5mEep8VIV3XD1fn6NNK53jXPABiIPRJQrS
7LS5ksr/UdUYZU9vTdWfCPHN4dmlgezvzfQJm3qPKiv6TJrjPAzFhUtBtOeEMvSb
qnvJk2kumxpdtxzEkmRIWVFWHsUsnjdbWIoXqv2jDCTUiy7sG1T6QTYjSqZxHhTa
nHLMPtJt/AVkQ57jU+o9SAypPaLxoc3wrH/JcOLb+O/s711prtWxQuOAPu2QhM6W
F9C6jvmywExWCmn5Cop6UOMpteIz0/wu85W7qwF3AU8ddHBHCHXJvxrsJp0fdyxy
6n9K785fTCZDZi90Z3fs
=zlZ7
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
