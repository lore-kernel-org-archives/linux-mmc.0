Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7896C433B4
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3F3611CC
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 08:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349657AbhDGIrQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349662AbhDGIqo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Apr 2021 04:46:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FC34AFAA;
        Wed,  7 Apr 2021 08:44:41 +0000 (UTC)
Message-ID: <25e9fc3bedd8f97dd151b1f36d752f032c6ec628.camel@suse.de>
Subject: Re: [PATCH 2/3] mmc: sdhci-iproc: Cap min clock frequency on BCM2711
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
Date:   Wed, 07 Apr 2021 10:44:39 +0200
In-Reply-To: <2d40b062-5809-15ce-b9d1-651644ff6e22@i2se.com>
References: <20210406104802.20898-1-nsaenz@kernel.org>
         <20210406104802.20898-3-nsaenz@kernel.org>
         <2d40b062-5809-15ce-b9d1-651644ff6e22@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tGvxp0AIZJH+Ku21vLzc"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-tGvxp0AIZJH+Ku21vLzc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-04-06 at 19:59 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.04.21 um 12:48 schrieb Nicolas Saenz Julienne:
> > There is a known bug on BCM2711's SDHCI core integration where the
> > controller will hang when the difference between the core clock and the
> > bus clock is too great. Specifically this can be reproduced under the
> > following conditions:
> >=20
> > - No SD card plugged in, polling thread is running, probing cards at
> > =C2=A0=C2=A0100KHz.
> > - BCM2711's core clock configured at 500MHz or more.
> >=20
> > So set 200MHz as the minimum clock frequency available for that board.
> i think it should be 200 kHz?

Of course... Sorry for that.

Regards,
Nicolas

> >=20
> > For more information on the issue see this:
> > https://lore.kernel.org/linux-mmc/20210322185816.27582-1-nsaenz@kernel.=
org/T/#m11f2783a09b581da6b8a15f302625b43a6ecdeca
> >=20
> > Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BC=
M2711")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > ---
> > =C2=A0drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
> > =C2=A01 file changed, 18 insertions(+)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-ip=
roc.c
> > index ddeaf8e1f72f..1ef888e91f73 100644
> > --- a/drivers/mmc/host/sdhci-iproc.c
> > +++ b/drivers/mmc/host/sdhci-iproc.c
> > @@ -173,6 +173,23 @@ static unsigned int sdhci_iproc_get_max_clock(stru=
ct sdhci_host *host)
> > =C2=A0		return pltfm_host->clock;
> > =C2=A0}
> > =C2=A0
> >=20
> > +/*
> > + * There is a known bug on BCM2711's SDHCI core integration where the
> > + * controller will hang when the difference between the core clock and=
 the bus
> > + * clock is too great. Specifically this can be reproduced under the f=
ollowing
> > + * conditions:
> > + *
> > + *  - No SD card plugged in, polling thread is running, probing cards =
at
> > + *    100KHz.
> > + *  - BCM2711's core clock configured at 500MHz or more
> > + *
> > + * So we set 200MHz as the minimum clock frequency available for that =
SoC.
> > + */
> > +static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_hos=
t *host)
> > +{
> > +	return 200000;
> > +}
> > +
> > =C2=A0static const struct sdhci_ops sdhci_iproc_ops =3D {
> > =C2=A0	.set_clock =3D sdhci_set_clock,
> > =C2=A0	.get_max_clock =3D sdhci_iproc_get_max_clock,
> > @@ -271,6 +288,7 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_o=
ps =3D {
> > =C2=A0	.set_clock =3D sdhci_set_clock,
> > =C2=A0	.set_power =3D sdhci_set_power_and_bus_voltage,
> > =C2=A0	.get_max_clock =3D sdhci_iproc_get_max_clock,
> > +	.get_min_clock =3D sdhci_iproc_bcm2711_get_min_clock,
> > =C2=A0	.set_bus_width =3D sdhci_set_bus_width,
> > =C2=A0	.reset =3D sdhci_reset,
> > =C2=A0	.set_uhs_signaling =3D sdhci_set_uhs_signaling,



--=-tGvxp0AIZJH+Ku21vLzc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBtcPcACgkQlfZmHno8
x/52Jgf+N8kWfn+v2p/Ij2knXikk1L0/UbLfSkffUvHLSJ3lSSqzbHoS5cWE5cWT
Bw1ln4+GmxoCVmJcBlHwsML5w+IgV5mw5AhYnnGLVfb9kAKyxDKupRdE2GcrKMA7
dYPd4Pd6vzGl244qEcHC2If/zy3oEoWrRs/Kci/6lvithzqxB4IOPV3aKRIEc+sS
PRKt2j+jEv3NO9r08YvnU9shK4muX5VH29gp+x8s+VlW1yRKCj0L5PJ1Au5y7AcF
gX8IvW+YVRY8z7fYhh8MnKEk0WVV1qvOk3Zyfut4P/wfwCzIcA2Yb7/Bvd7EgXz0
NTKjPFG+Fhc4l1TuNoc4xmR1eFKDKA==
=afNN
-----END PGP SIGNATURE-----

--=-tGvxp0AIZJH+Ku21vLzc--

