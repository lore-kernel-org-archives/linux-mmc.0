Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083EBC10F25
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 20:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D518E20578
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 20:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCIUBU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:01:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCIUBU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 16:01:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 188F3AC15;
        Mon,  9 Mar 2020 20:01:18 +0000 (UTC)
Message-ID: <c4f9da4d57374f90632c39fd1403c339a4ed299d.camel@suse.de>
Subject: Re: [PATCH v2 11/11] ARM: dts: bcm2711: Add vmmc regulator in emmc2
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, f.fainelli@gmail.com,
        linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 09 Mar 2020 21:01:16 +0100
In-Reply-To: <3bd022a6-922f-c20a-8d07-383817549960@i2se.com>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
         <20200306174413.20634-12-nsaenzjulienne@suse.de>
         <3bd022a6-922f-c20a-8d07-383817549960@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6KLHT23j0gCs6Gdp3wLG"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-6KLHT23j0gCs6Gdp3wLG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-09 at 21:00 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.03.20 um 18:44 schrieb Nicolas Saenz Julienne:
> > The SD card power can be controlled trough a pin routed into the board'=
s
> > external GPIO expander. Turn that into a regulator and provide it to
> > emmc2.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > index b0ea8233b636..a2da058396fe 100644
> > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > @@ -55,6 +55,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
> >  			  3300000 0x0>;
> >  		status =3D "okay";
> >  	};
> > +
> > +	sd_vcc_reg: sd_vcc_reg {
> > +		compatible =3D "regulator-fixed";
>=20
> i think we need to enable CONFIG_REGULATOR_FIXED_VOLTAGE in
> bcm2835_defconfig

I'll take it into account for v3,

Thanks!
Nicolas


--=-6KLHT23j0gCs6Gdp3wLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5moIwACgkQlfZmHno8
x/4VHAf/QZBKav2zxLbotNZcl2AuN7wPf98F0DkRScSdf/GHbyP5a/Zvu4oOFMyg
FELLHQSEsK0cO+2vYoTf+u59oT2m36XksJjMVBjU1diVaavrmOS7QruV9FnLlo7t
tfmbC5LMuLRnhFy2jFe4WAIFANIAi6EK8+G/z9QZemwupAIFn8DMmYDkm6xjgyKg
YIRR2/l7RQ9L1mfUXFWZrzA6gMdxGJQX8998BNNdWJktPrGC5ijdazJvmA+ceC1v
nptYWQqVxEl864u5eiy1rinVYFNXk4/XucTlFShMAHVdTi2nQvJN6bsDQXWeCDnX
cHm9lkUI0i1KDAQBCtcMflqwEW+fpQ==
=YTCh
-----END PGP SIGNATURE-----

--=-6KLHT23j0gCs6Gdp3wLG--

