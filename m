Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C934C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9402072A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFLhS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:37:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:60104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFLhS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 06:37:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D2BEAC23;
        Fri,  6 Mar 2020 11:37:16 +0000 (UTC)
Message-ID: <63c490557c344e74c287361541b7e100f5c68bb7.camel@suse.de>
Subject: Re: [PATCH 10/10] ARM: dts: bcm2711: Add vmmc regulator in emmc2
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 06 Mar 2020 12:37:14 +0100
In-Reply-To: <714c41ef-85ea-da2b-1701-9132703a832c@raspberrypi.com>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
         <20200306103857.23962-11-nsaenzjulienne@suse.de>
         <408aa93f-b5c8-c4b3-384b-c8d018a8d549@i2se.com>
         <714c41ef-85ea-da2b-1701-9132703a832c@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dgDR5QAIQKj09tBjjIOy"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-dgDR5QAIQKj09tBjjIOy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 11:35 +0000, Phil Elwell wrote:
> Nicolas, Stefan,
>=20
> On 06/03/2020 11:07, Stefan Wahren wrote:
> > Hi Nicolas,
> >=20
> > On 06.03.20 11:38, Nicolas Saenz Julienne wrote:
> > > The SD card power can be controlled trough a pin routed into the boar=
d's
> > > external GPIO expander. Turn that into a regulator and provide it to
> > > emmc2.
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >   arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > index e26ea9006378..8e98e917f9f4 100644
> > > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > @@ -56,6 +56,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
> > >   			  3300000 0x0>;
> > >   		status =3D "okay";
> > >   	};
> > > +
> > > +	sd_vcc_reg: sd_vcc_reg {
> > > +		compatible =3D "regulator-fixed";
> > > +		regulator-name =3D "vcc-sd";
> > > +		regulator-min-microvolt =3D <3300000>;
> > > +		regulator-max-microvolt =3D <3300000>;
> > > +		regulator-boot-on;
> > > +		enable-active-high;
> > > +		gpio =3D <&expgpio 6 GPIO_ACTIVE_HIGH>;
> > this new GPIO has an empty GPIO label, please add it.
>=20
> The correct name would be "SD_PWR_ON".

Noted

Regrads,
Nicolas


--=-dgDR5QAIQKj09tBjjIOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5iNeoACgkQlfZmHno8
x/5mbwf/WiSmeHldOn54HB+wF+evWnAjtmflOLsTqDqnZaOLL0VOeXvz7UGWsswn
q/ZIPlXJQouzkARdn07BoVLFuc8C+D6Usl43V9yL0My/YKQaqutF4HoSP59mT8Sx
Wv/NehTBiih9NWjMjvbusnbPWLmwvLawimwHtuZei+c+DhgyXWM5XhiPCMGR3ILK
JmyN8XwFcSAYCLXF8bJoQhIB90wcNCtekIHl4isyF7hT85+HX9pfwzJC5efHfwQR
avdQJZOopFUAE8SKgSrN2Qngmk/z8RhOQO5jzh2qFC7918S/oSnmTAu46/V24Zej
klgahEJdegIsXTyKg9kG28oPN0PIJg==
=PsYj
-----END PGP SIGNATURE-----

--=-dgDR5QAIQKj09tBjjIOy--

