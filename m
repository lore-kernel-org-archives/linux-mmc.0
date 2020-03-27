Return-Path: <SRS0=5iJr=5M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A8C43331
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B9D2072F
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0LV4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgC0LV4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Mar 2020 07:21:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A486FADF1;
        Fri, 27 Mar 2020 11:21:54 +0000 (UTC)
Message-ID: <a4c38810b7cb10dcfadd2844320d1c9e5b6bc6f6.camel@suse.de>
Subject: Re: [PATCH v2 10/11] ARM: dts: bcm2711: Update expgpio's GPIO labels
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     stefan.wahren@i2se.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, linux-mmc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 27 Mar 2020 12:21:53 +0100
In-Reply-To: <20200306174413.20634-11-nsaenzjulienne@suse.de>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
         <20200306174413.20634-11-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6dBBE0GB6iAO/vrk1/4W"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-6dBBE0GB6iAO/vrk1/4W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 18:44 +0100, Nicolas Saenz Julienne wrote:
> The 6th line of the GPIO expander is used to power the board's SD card.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied for-next.

Regards,
Nicolas


--=-6dBBE0GB6iAO/vrk1/4W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl594dEACgkQlfZmHno8
x/6u+wgAoZAyf4EZVgmQpaGO9pvDTSICjk4v7Buc27vRC/dI7eee8lpEKtHySjxS
ZFUZvrVtkH+1nI31qTADGEUvfLfGeZuhsl3PopdYT1L4Ajl8Wl/TgB2/jBwArPmT
FYjuPGIYtBXg4m9qzo/hWE1gPXZOTESW5dnu6zC2KkIadq4FtZl06U7PZTbQAggH
9REu3TOdgTvUwKmnOpTYRbfE2f5ei0Sjdem42mzLBDW5hy6i/I2zqL7qr+MT/v99
WaE0jbqdcRsAP7HwZRF2JGP63WiFWjkfNSpGd2/AE+ETi3BK+m3iufCX8FJBrgrt
Y+wvAAMZXkhGdHtI+fh9suxi1j+VKA==
=5tFi
-----END PGP SIGNATURE-----

--=-6dBBE0GB6iAO/vrk1/4W--

