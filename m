Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E19C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD588619A5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhCVTRq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:17:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhCVTR2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 15:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6C7FAD80;
        Mon, 22 Mar 2021 19:17:26 +0000 (UTC)
Message-ID: <c6399e408848ebda5907253c4e1a3c07422a7d17.camel@suse.de>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Scott Branden <scott.branden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
Date:   Mon, 22 Mar 2021 20:17:25 +0100
In-Reply-To: <13a62975-23a4-60d3-a740-9ef44edc74c3@broadcom.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-5-nsaenz@kernel.org>
         <13a62975-23a4-60d3-a740-9ef44edc74c3@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JzhKUfIWA8LEu9EgkXW+"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-JzhKUfIWA8LEu9EgkXW+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-22 at 12:06 -0700, Scott Branden wrote:
> 1st line of commit should be ARM: dts: bcm2711

Ouch, of course... Sorry for that.

Regards,
Nicolas


--=-JzhKUfIWA8LEu9EgkXW+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBY7UUACgkQlfZmHno8
x/6hwgf6AvKW96MS2nupkCKQJS4F+Cmny5L1ZBHlZBSnvE+sUCyYeRT5y97+sowB
fAjyN+Ep7qXp5W6y0/rvArJvnA6yKz+nEKRVjc1BKOrwBj0bHsNx6NlmDeNcOoIZ
rITqQzBmLmn54Rbwhl5XsmJ0iUez9wux08d9q/WIt4QJGS0vNhC36Cpj51YYY2gT
/msNbvI1Eroz4uZ9B6QNrSz7zOJvGSz0yzBvNlBWmxtGVmnwIdNZmG+eMDADR/Xb
mHIDpBU0vr+/agjuEjRtNcWOS6IIGokKT/2UBDerIaydcmpPeoe7xhhfbNdr9PZ/
Ei4sR2fCTZ96OoOqipyj9Vfh9vtCwg==
=CySA
-----END PGP SIGNATURE-----

--=-JzhKUfIWA8LEu9EgkXW+--

