Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 15:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96C0619FF
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 15:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhCXPep (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:34:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236629AbhCXPeM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Mar 2021 11:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2AD5AD9F;
        Wed, 24 Mar 2021 15:34:10 +0000 (UTC)
Message-ID: <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
Date:   Wed, 24 Mar 2021 16:34:09 +0100
In-Reply-To: <401100ea-90ad-57b1-50da-967118a090da@i2se.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-5-nsaenz@kernel.org>
         <401100ea-90ad-57b1-50da-967118a090da@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FFEARCZYyZSHobHLGWfZ"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-FFEARCZYyZSHobHLGWfZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, 2021-03-24 at 16:16 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 22.03.21 um 19:58 schrieb Nicolas Saenz Julienne:
> > From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > Force emmc2's frequency to 150MHz as the default 100MHz (set by FW)
> > seems to interfere with the VPU clock when setup at frequencies bigger
> > than 500MHz (a pretty common case). This ends up causing unwarranted
> > SDHCI CMD hangs  when no SD card is present.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > ---
> > =C2=A0arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/=
bcm2711-rpi-4-b.dts
> > index 3b4ab947492a..9aa8408d9960 100644
> > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > @@ -257,6 +257,12 @@ &emmc2 {
> > =C2=A0	vqmmc-supply =3D <&sd_io_1v8_reg>;
> > =C2=A0	vmmc-supply =3D <&sd_vcc_reg>;
> > =C2=A0	broken-cd;
> > +	/*
> > +	 * Force the frequency to 150MHz as the default 100MHz seems to
> > +	 * interfere with the VPU clock when setup at frequencies bigger than
> > +	 * 500MHz, causing unwarranted CMD hangs.
> > +	 */
> > +	clock-frequency =3D <150000000>;
>=20
> i don't want to bike-shed here, but is there any chance to solve this in
> clk-bcm2835 in a less hacky way?

What do you have in mind?

All I can think of is adding some kind of heuristic to the clock's prepare(=
)
callback. That said, I don't feel it would be a better solution than this.

Regards,
Nicolas



--=-FFEARCZYyZSHobHLGWfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBbW/EACgkQlfZmHno8
x/67jAgAkEAjGxqXoq4Ga/ry0PqEcfUiGD4+CRAlqZtglOAj2WqZ5z6CRwxg6Xt5
LYDxIoLjBAENrkkjbMv4nQPdLLDvf3UjBeRTK70mfsON7Pt6HLk3fxAws/36/1DK
AAMprq5BVCTNY04+tjdQvV0A/w6o71aQF74ghlytDlP2fm7jS6WcEqRLIkuGqe7U
dXtOGwt7SPJGevPbktCQff7xLJ5Aw4W0+JHoM3nxDIdiA3hpOFvuQSQbn90OpCTf
P4O9cbCFQ4Am60dYBmGAIuV3jGpkB4PZk8wJms+ePiTGtZBso5eorU1jyqKbZAOd
kB4wrjXd1OrQbZB87A5SELjhUUa1FQ==
=qWwb
-----END PGP SIGNATURE-----

--=-FFEARCZYyZSHobHLGWfZ--

