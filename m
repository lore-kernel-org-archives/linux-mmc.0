Return-Path: <SRS0=5iJr=5M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86318C43331
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542DA20675
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0LWX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:22:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgC0LWX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Mar 2020 07:22:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4467AADF1;
        Fri, 27 Mar 2020 11:22:22 +0000 (UTC)
Message-ID: <6553f266f3c2a3fe2bdded5d4ca31e3720ea7ee3.camel@suse.de>
Subject: Re: [PATCH v2 11/11] ARM: dts: bcm2711: Add vmmc regulator in emmc2
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date:   Fri, 27 Mar 2020 12:22:21 +0100
In-Reply-To: <20200306174413.20634-12-nsaenzjulienne@suse.de>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
         <20200306174413.20634-12-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vjSG4WH1xfhs1bTv2Qs6"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-vjSG4WH1xfhs1bTv2Qs6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 18:44 +0100, Nicolas Saenz Julienne wrote:
> The SD card power can be controlled trough a pin routed into the board's
> external GPIO expander. Turn that into a regulator and provide it to
> emmc2.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Applied for-next.

Regards,
Nicolas


--=-vjSG4WH1xfhs1bTv2Qs6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl594e0ACgkQlfZmHno8
x/7mUwf+JdWXfDc6pDlSApWDA195aytcdvKfmu7Wsn5Cofww7VPbRaCr6aXiLF6O
ir36AtHRiAlXnnhaAJDsriTs5FxD3VCQ7rDt9kxO9j1jSYCpsOlVTSY6MeoB4npT
XEpL7nAoqKoWTTl7uB/vwT1aCeFsFVURMaMHGbhDXtCxahjpiyl4SOHy/dJzZGYR
0LOn2gmk6DsKBLFuC0R0f1mDtVfLxyKOa27e7rGQS64bH4gQTc6DQ9Ta+FvZOSO7
OGUDpcnmEVpwuqoxwskwr/nmn6ElGWWOpN9HvIPDBeasUwBlErFyNzNv22Sr+40N
b0lEbOnZoX4UV1mMDWZXeaau39QZ6w==
=iJaU
-----END PGP SIGNATURE-----

--=-vjSG4WH1xfhs1bTv2Qs6--

