Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC4C10F00
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B282070A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFKw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:52:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:55560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgCFKw0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:52:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3F1DAF21;
        Fri,  6 Mar 2020 10:52:23 +0000 (UTC)
Message-ID: <48c3673241b500077f6bbc6502cc9808110697ca.camel@suse.de>
Subject: Re: [PATCH 00/10] Raspberry Pi vmmc regulator support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 06 Mar 2020 11:52:21 +0100
In-Reply-To: <b33aadf7-d481-10db-c290-6e53b696b2d4@raspberrypi.com>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
         <b33aadf7-d481-10db-c290-6e53b696b2d4@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9UhjfUc8RYzzqakH6eEx"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-9UhjfUc8RYzzqakH6eEx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 10:46 +0000, Phil Elwell wrote:
> Hi Nicolas,
>=20
> On 06/03/2020 10:38, Nicolas Saenz Julienne wrote:
> > The series snowballed into adding a new quirk, as I reliased
> > sdhci-iproc's behaviour is not that uncommon.
> >=20
> > Based on Phil Elwell's work in the downstream Raspberry Pi kernel.
>=20
> There are a few typos in the commit messages ("reliased" -> "realised",
> "trough" -> "through"), but otherwise:

Noted, I'll do an typo sweep for v2.

> Reviewed-by: Phil Elwell <phil@raspberrypi.com>

Thanks!

Regards,
Nicolas


--=-9UhjfUc8RYzzqakH6eEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5iK2UACgkQlfZmHno8
x/4M7gf9EZ0Cv5CEcpHtF6lShxtR/jvIMxJIC1qU2ejjg9BOn/1cwcRQPzFs0VHI
186bNu4WSIUcv6cJHfJV5zW1lFliXoC4O6ecM0PHvvdDjcVWaoEihNPNpJFJVoEU
hYPo1VWm0+yHZLuo5sBcCcvVvDQ/gjFcw5btIwbVSxXKlOIwpzowL2piUR28u0wB
bkXtHzGC7rnPhWDG8MKfiiU5hEX9rZNSVUOv4yTFPk/uDtHYBOFzp5svA0OuNfs+
Xo/4xoIkoILs/GeZ7qftmSq7VzoUa0qiFSDvtrtH09AjzeUXuSQmV17z/ninTZSQ
Iv+4C7i6MfH6ePKd09WnGqyjQSq7yg==
=g6za
-----END PGP SIGNATURE-----

--=-9UhjfUc8RYzzqakH6eEx--

