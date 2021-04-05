Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31006C43460
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Apr 2021 08:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECBA613A1
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Apr 2021 08:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhDEIpi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Apr 2021 04:45:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231979AbhDEIpi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Apr 2021 04:45:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 163A1B12D;
        Mon,  5 Apr 2021 08:45:31 +0000 (UTC)
Message-ID: <4d4e3de99dbee711cf47878bf98a7cc34c3f1e65.camel@suse.de>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Alan Cooper <alcooperx@gmail.com>
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
        Scott Branden <sbranden@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 05 Apr 2021 10:45:29 +0200
In-Reply-To: <CAOGqxeUxOA_s6=KUh_XWFtRF_EWZgQH_y2MEdxUeDQTYMeb+3A@mail.gmail.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-5-nsaenz@kernel.org>
         <401100ea-90ad-57b1-50da-967118a090da@i2se.com>
         <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
         <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com>
         <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
         <CAOGqxeUxOA_s6=KUh_XWFtRF_EWZgQH_y2MEdxUeDQTYMeb+3A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-38waL8wK1Aj1RRmL0Xy5"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-38waL8wK1Aj1RRmL0Xy5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Thu, 2021-04-01 at 11:23 -0400, Alan Cooper wrote:
> Nicolas,
>=20
> Sorry, I just noticed this thread.
> This is a known bug in some newer Arasan cores.
> The problem happens when the difference between the core clock and the bu=
s
> clock is too great.
> Limiting the clock to 200KHz minimum should be a good fix.

Great, that's what I was hoping to hear :). Out of curiosity, can you share
more details on how the failure occurs?

> In my experience, it's only eMMC that needs the clock to be retried

> below 400KHz and not SD or SDIO. That's because the CMD signal for
> eMMC starts out as open-drain during identification and the size of
> the pull-up on the CMD signal can require the <400KHz clock. Once eMMC
> is out of identification mode the CMD signal is switched to push-pull
> and can run at much higher clock rates.

Fair enough, I need to do some tests, some of the compute modules use an eM=
MC.

> I don't think that SD and SDIO have any open-drain signals, so they
> shouldn't need to retry at slower clock speeds.

Noted.

> I'm trying to get more detail on the bug, like the exact ratio of core
> clock to bus clock that causes the problem. When I first found this
> bug I was told that the failure would not happen at 200KHz, but we
> were using a 405MHz core clock.

That would be nice to have.

> One other question. Why are you using polling for the SD card, this
> newer controller supports the interrupt driven "Card Inserted" signal
> and avoids wasting time polling?

I believe the line isn't routed on RPi4.

> Al


--=-38waL8wK1Aj1RRmL0Xy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBqzikACgkQlfZmHno8
x/5vvAf+LwODH29W1eKi1mUblY7T8nHOw5yF+PQbXyMex7hzFkTJYqotZkZnT4RS
+RAKLLEH8r+drFB3D2hz/TJEazqr6fvhiJMQlE5mZMsAY4fUhDJUcKuuPLgXidXM
vDNEVEFnoshhZnX/cTNVaxdNBKEzUPCD85kbqZNScQFifR2BtiTFMcebavyVJHP2
ELOLaKtx1XaqEmtfxufzh6lFAHR9WTIRZffL4c+b8a90kdiApV8NV9RLILO5KIzx
XNA+Zi0L0vfAGEGrNu397g9lkZPYq6VKOy/cwB9hmI1yiJOxLLeqaY5yQb96NtaY
sZwwA0sB1TKPJXGdQVsX1Kt1+1SqIA==
=H6cA
-----END PGP SIGNATURE-----

--=-38waL8wK1Aj1RRmL0Xy5--

