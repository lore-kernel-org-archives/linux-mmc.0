Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA62C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA4610CF
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 10:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhDIKym (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 06:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhDIKym (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Apr 2021 06:54:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 875E9AF9E;
        Fri,  9 Apr 2021 10:54:28 +0000 (UTC)
Message-ID: <2dbb9e8c1f1e107712b05e36aa1b244329381425.camel@suse.de>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Alan Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        Tim Gover <tim.gover@raspberrypi.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 09 Apr 2021 12:54:26 +0200
In-Reply-To: <CAOGqxeWzjn70A_gP4Eh_ZLW0H3KkE_wA7QzeGRqU1u7xtJr-+Q@mail.gmail.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-5-nsaenz@kernel.org>
         <401100ea-90ad-57b1-50da-967118a090da@i2se.com>
         <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
         <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com>
         <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
         <CAOGqxeUxOA_s6=KUh_XWFtRF_EWZgQH_y2MEdxUeDQTYMeb+3A@mail.gmail.com>
         <4d4e3de99dbee711cf47878bf98a7cc34c3f1e65.camel@suse.de>
         <CAOGqxeWzjn70A_gP4Eh_ZLW0H3KkE_wA7QzeGRqU1u7xtJr-+Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KxZS3sx9rZTVwyYp0yY2"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-KxZS3sx9rZTVwyYp0yY2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

On Wed, 2021-04-07 at 16:37 -0400, Alan Cooper wrote:
> Nicolas,
>=20
> I got a better description of the failure and it looks like the bus
> clock needs to be limited to 300KHz for a 500MHz core clock.
> What's happening is that an internal reset sequence is needed after a
> command timeout and the reset signal needs to be asserted for at least
> 2 ticks of the bus clock. This is done using a 12 bit counter clocked
> by the core clock. That means a 500MHz core clock produces a 122KHz
> reset signal which is too fast for 2 ticks of the 200KHz bus clock
> (100KHz) but is okay for the 300KHz (150Khz) bus clock.

Is there any value in implementing this in a generic way? That is, will a S=
oC
other than BCM2711 ever need this? Otherwise I can simply limit BCM2711's
sdhci-iproc min clk frequency to 300KHz and call it a day.

The alternative is something the likes of:

	min_clk =3D clk_get_rate(core_bus) >> 11;

But it involves updating the bindings and DT.

Regards,
Nicolas




--=-KxZS3sx9rZTVwyYp0yY2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBwMmIACgkQlfZmHno8
x/7ntQgAiD7GcI2zPvYkkdlBBtohEpENZTydgEPLuTHhXzablbGyC/GT5EJ5Pr+K
iXL1Qlv5xpovPxWIx5hGdFLY/RbFSI4s4C7f2HYoPgRwwwn5AuCmuVwcL+tKkJ6d
sD1dmGUJo/uMQ/P3oT0G0Ea4yuz2LSIXeq/K8PEqWLEl+Aaw3ciINqYeUlWOuGcB
jPTJlSOgYj5rzYAskiRKcTiUp1fVbe9hiMi5ppft4fnJ1nYIU6wQcDxCo1WUUDhe
Op/DdFTTzW+JP3mSmtr/EzVp5ldrupNFTcOzQODhDb4lEsO/ALBMMiKKhAlJVh0j
0NofzFbS3vtJ0ffpD7TnoQlkKSIE7g==
=pOg3
-----END PGP SIGNATURE-----

--=-KxZS3sx9rZTVwyYp0yY2--

