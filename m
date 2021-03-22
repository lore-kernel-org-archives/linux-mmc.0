Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD8C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0926199E
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCVTRN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:17:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhCVTQt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 15:16:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 050B6AD80;
        Mon, 22 Mar 2021 19:16:48 +0000 (UTC)
Message-ID: <be8d74e1808c622af5c76418c389eb15b2196023.camel@suse.de>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to
 json-schema
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Scott Branden <scott.branden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        alcooperx@gmail.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Mar 2021 20:16:46 +0100
In-Reply-To: <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-2-nsaenz@kernel.org>
         <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2khgYsUvNQwKcBap9LFl"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-2khgYsUvNQwKcBap9LFl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-22 at 12:11 -0700, Scott Branden wrote:
> On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
> > Convert the brcm,iproc-sdhci binding to DT schema format using json-sch=
ema
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > ---
> > =C2=A0.../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 ++++++++++++++=
+++++
> > =C2=A0.../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
> > =C2=A02 files changed, 58 insertions(+), 37 deletions(-)
> > =C2=A0create mode 100644 Documentation/devicetree/bindings/mmc/brcm,ipr=
oc-sdhci.yaml
> > =C2=A0delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdh=
ci-iproc.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > new file mode 100644
> > index 000000000000..19d84f3ef9e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom IPROC SDHCI controller
> > +
> > +maintainers:
> > +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> This is already covered in the MAINTAINERS section via "N:	iproc".
> M:	Ray Jui <ray.jui@broadcom.com>
>=20
> M:	Scott Branden <scott.branden@broadcom.com>
>=20
> M:	bcm-kernel-feedback-list@broadcom.com

Fair enough, I'll drop it.

Regards,
Nicolas


--=-2khgYsUvNQwKcBap9LFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBY7R4ACgkQlfZmHno8
x/5oNgf+ITHsfr+zjrmSWml+16IzFPn9PMt03XxCum4AkgYKOoc5c8GcteSD+l/J
BoToSXSety1qu0mJygXEUh5ViGaGt1dkmL/Vr0Lg1jr/plqb5RPgKPAcexVS2xl+
ZbLWncSDBcgDqPpWvrHZhIKigt421gCSHBCOLODWhnACwOTIsZYccSPoUsLt27Zu
BDsYbOjwjZm9cSfqAdveRTTYXHXOiL8q9Zn25POGoNc+Pc3bTibNWJQq21XvYpJY
cQvBh5kTqYpP7vIE9EZWn1qEBmBDV0/aYKXvyL/tD/W8UcZKlroHDpC/9Bqbz2pM
AK994tJlq5EK0OMauGG16esyX9WoEA==
=I3xy
-----END PGP SIGNATURE-----

--=-2khgYsUvNQwKcBap9LFl--

