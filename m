Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB6C1975A
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC94206BE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCLNNv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLNNv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 09:13:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16749B210;
        Thu, 12 Mar 2020 13:13:48 +0000 (UTC)
Message-ID: <a51badd7ba6fc1938a120b8a3b8a423ca9a3613b.camel@suse.de>
Subject: Re: [PATCH v2 00/11] Raspbery Pi 4 vmmc regulator support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phil@raspberrypi.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>
Date:   Thu, 12 Mar 2020 14:13:45 +0100
In-Reply-To: <CAPDyKFp+XwGog_w+8Sv1hYA-Umi6Rt2LYR1fyMEEb9abdb9nGQ@mail.gmail.com>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
         <CAPDyKFp+XwGog_w+8Sv1hYA-Umi6Rt2LYR1fyMEEb9abdb9nGQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dHp/NTMIYot5p5695p1B"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-dHp/NTMIYot5p5695p1B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, 2020-03-12 at 14:08 +0100, Ulf Hansson wrote:
> On Fri, 6 Mar 2020 at 18:44, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > The series first cleans up a common pattern, which is ultimately needed
> > to integrate the regulator with bcm2711's sdhci-iproc. It then
> > introduces the relevant device-tree changes.
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Use helper function istead of quirk
> >  - Add GPIO label
> >=20
> > Nicolas Saenz Julienne (11):
> >   mmc: sdhci: Introduce sdhci_set_power_and_bus_voltage()
> >   mmc: sdhci: arasan: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: at91: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: pxav3: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: xenon: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: am654: Use sdhci_set_power_and_voltage()
> >   mmc: sdhci: Unexport sdhci_set_power_noreg()
> >   mmc: sdhci: iproc: Add custom set_power() callback for bcm2711
> >   ARM: dts: bcm2711: Update expgpio's GPIO labels
> >   ARM: dts: bcm2711: Add vmmc regulator in emmc2
> >=20
> >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 13 ++++++++++++-
> >  drivers/mmc/host/sdhci-iproc.c        | 17 ++++++++++++++++-
> >  drivers/mmc/host/sdhci-milbeaut.c     | 13 +------------
> >  drivers/mmc/host/sdhci-of-arasan.c    | 15 ++-------------
> >  drivers/mmc/host/sdhci-of-at91.c      | 18 +-----------------
> >  drivers/mmc/host/sdhci-pxav3.c        | 20 +-------------------
> >  drivers/mmc/host/sdhci-xenon.c        | 20 +-------------------
> >  drivers/mmc/host/sdhci.c              | 24 +++++++++++++++++++++---
> >  drivers/mmc/host/sdhci.h              |  5 +++--
> >  drivers/mmc/host/sdhci_am654.c        | 17 +++--------------
> >  10 files changed, 61 insertions(+), 101 deletions(-)
> >=20
> > --
> > 2.25.1
> >=20
>=20
> Patch 1-4, 6, 9 applied for next, thanks!

I think you meant to apply 1-4, 7 and 9. Patch 6 is one of the contentious
ones.

Regards,
Nicolas


--=-dHp/NTMIYot5p5695p1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5qNYkACgkQlfZmHno8
x/48GAgAi6d1UCzPYCwsj71N7+l4MLbwJlBgYMPOcNnLon8xik24Ay4PhalmwceJ
BSNQoqNVBL7IK/xKzVQfLZlGs81Pi4Dmh/AwAwhliFuZmB0dPcZFxnjRL0qk+wja
pjU1xyVgCce9tLMKOKLdvDt22ivtDd4SO1/dp+MKhJ5+MFhdYdTTFa0KiGkq5F7P
E3lJshWnP0/8ilwO2J0yNaKZ3SsjQwgLLVYyy56t4oLL24Dt/Jt+JgQWdTvHY+1a
B4ibgW6C7j/FbksXEUDAtETYKcXyhSGnuxJJxU2SFYXvYLzX820BisWwxxw+XdJP
kwEo+Mk6cui89Y9Vu6W6D7UegdvPBQ==
=k11V
-----END PGP SIGNATURE-----

--=-dHp/NTMIYot5p5695p1B--

