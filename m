Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B1C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Mar 2021 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C0F61A44
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Mar 2021 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZQSH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:18:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhCZQRj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Mar 2021 12:17:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D57AAC6A;
        Fri, 26 Mar 2021 16:17:38 +0000 (UTC)
Message-ID: <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        phil@raspberrypi.com, Tim Gover <tim.gover@raspberrypi.com>,
        sbranden@broadcom.com, alcooperx <alcooperx@gmail.com>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Mar 2021 17:17:36 +0100
In-Reply-To: <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-5-nsaenz@kernel.org>
         <401100ea-90ad-57b1-50da-967118a090da@i2se.com>
         <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
         <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Zt3yxDeLYD9K7yjMoxO4"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-Zt3yxDeLYD9K7yjMoxO4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-03-25 at 20:11 +0100, Stefan Wahren wrote:
> Am 24.03.21 um 16:34 schrieb Nicolas Saenz Julienne:
> > Hi Stefan,
> >=20
> > On Wed, 2021-03-24 at 16:16 +0100, Stefan Wahren wrote:
> > > Hi Nicolas,
> > >=20
> > > Am 22.03.21 um 19:58 schrieb Nicolas Saenz Julienne:
> > > > From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >=20
> > > > Force emmc2's frequency to 150MHz as the default 100MHz (set by FW)
> > > > seems to interfere with the VPU clock when setup at frequencies big=
ger
> > > > than 500MHz (a pretty common case). This ends up causing unwarrante=
d
> > > > SDHCI CMD hangs  when no SD card is present.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > > ---
> > > > =C2=A0arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 6 ++++++
> > > > =C2=A01 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/=
dts/bcm2711-rpi-4-b.dts
> > > > index 3b4ab947492a..9aa8408d9960 100644
> > > > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > > @@ -257,6 +257,12 @@ &emmc2 {
> > > > =C2=A0	vqmmc-supply =3D <&sd_io_1v8_reg>;
> > > > =C2=A0	vmmc-supply =3D <&sd_vcc_reg>;
> > > > =C2=A0	broken-cd;
> > > > +	/*
> > > > +	 * Force the frequency to 150MHz as the default 100MHz seems to
> > > > +	 * interfere with the VPU clock when setup at frequencies bigger =
than
> > > > +	 * 500MHz, causing unwarranted CMD hangs.
> > > > +	 */
> > > > +	clock-frequency =3D <150000000>;
> > > i don't want to bike-shed here, but is there any chance to solve this=
 in
> > > clk-bcm2835 in a less hacky way?
> > What do you have in mind?
> Sorry, nothing specific.
> >=20
> > All I can think of is adding some kind of heuristic to the clock's prep=
are()
> > callback. That said, I don't feel it would be a better solution than th=
is.
>=20
> Based on my limited knowledge and an old SD card specification, all
> possibly connected devices could have different frequencies. So my
> concern here is, that in case we limit the frequency to a specific value
> we could break things just to suppress a warning.

SDHCI should be able to handle up to 233MHz IIRC, and there are divisors
available, it depends on the implementation but the worst kind provide /2^n=
.
Not perfect, but good enough for things to work.

Now, I've been having a deeper look into how clocks are handled, and found =
two
new clues:

 - First of all RPi4's sdhci-iproc needs SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
   that is, the controller isn't properly identifying the clock frequency f=
ed
   into it, and defaults to saying it's configured at 100MHz. I'm not an SD=
HCI
   expert, so it's possible changing frequencies also needs a special opera=
tion
   to recalculate this variable. But this was making all internal calculati=
ons
   wrong when paired with this series.

 - With this flag set SDHCI's core now properly calculates divisor values b=
ased
   on whatever clock frequency I set in DT. And guess what, the issue reapp=
ears
   even when running on 150MHz. It turns out, as I had some debugging enabl=
ed,
   the issue only happens when the controller is configured at 100KHz (that
   only happens while running the card detect thread).

So, I can now do this (note that for card detection try to communicate with=
 the
card starting at 400KHz down to 100KHz in 100KHz steps):

----->8-----

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.=
c
index 536c382e2486..e5a5de63f347 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -173,6 +173,11 @@ static unsigned int sdhci_iproc_get_max_clock(struct s=
dhci_host *host)
                return pltfm_host->clock;
 }
=20
+static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *h=
ost)
+{
+       return 200000;
+}
+
 static const struct sdhci_ops sdhci_iproc_ops =3D {
        .set_clock =3D sdhci_set_clock,
        .get_max_clock =3D sdhci_iproc_get_max_clock,
@@ -271,13 +276,15 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops=
 =3D {
        .set_clock =3D sdhci_set_clock,
        .set_power =3D sdhci_set_power_and_bus_voltage,
        .get_max_clock =3D sdhci_iproc_get_max_clock,
+       .get_min_clock =3D sdhci_iproc_bcm2711_get_min_clock,
        .set_bus_width =3D sdhci_set_bus_width,
        .reset =3D sdhci_reset,
        .set_uhs_signaling =3D sdhci_set_uhs_signaling,
 };

----->8-----

 Which is rather nicer than what this series introduces. But I can't still
 explain why configuring the controller at 100KHz is causing the hangs (whi=
le
 having the core clock setup at 500MHz), and I'm not sure if excluding 100K=
Hz
 from the polling frequency list is going to break support for older SD car=
ds.

 Regards,
 Nicolas



--=-Zt3yxDeLYD9K7yjMoxO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBeCSAACgkQlfZmHno8
x/5RLwgAleM4SzPVpZZVff99Y7DvLl81vOMya3W5BxzUM+K5zSlWx3ICg79A01KZ
ruxfEP4X7tmbS6TsjQemKN8lzTXErmkUxH7uHVhVLP13AQg4gIbmgvk0oSTEKKx5
iglhU0VMURq+BzGEF/Uc6+kenKfQ1zf3U0USNQCRQTUx7d6mY//ToSWLkNNPwJ+T
GPWLWk/ieEjoUzQ0XqZPRSXNfMYqdsXXSWlOTF1zpvuO4zGlVBuYcpP7tJZXjQ0X
pIAbwmQdl6ikoNcbhLNT9mT/r6CraPF1Wt6cGRvV1d7EUyYJGb6A9i73EScXVO6o
9591pHhkseO3d7kdp7MCAsG6ccyZhw==
=Lzpt
-----END PGP SIGNATURE-----

--=-Zt3yxDeLYD9K7yjMoxO4--

