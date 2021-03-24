Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87663C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E6061A15
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhCXQfl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhCXQfa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Mar 2021 12:35:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B282AC1D;
        Wed, 24 Mar 2021 16:35:28 +0000 (UTC)
Message-ID: <9de20a5960e029b8842dc026be3be85295647175.camel@suse.de>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to
 json-schema
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, f.fainelli@gmail.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.com,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 17:35:26 +0100
In-Reply-To: <28a133d2-c713-4bce-271c-5fa228d830ca@broadcom.com>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-2-nsaenz@kernel.org>
         <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
         <20210323210812.GA1318204@robh.at.kernel.org>
         <c1989e31501ccfb6e1350d467d4f26089bfcfb64.camel@suse.de>
         <28a133d2-c713-4bce-271c-5fa228d830ca@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ViNOE93gnirGk1EY9hs7"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-ViNOE93gnirGk1EY9hs7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-24 at 09:27 -0700, Scott Branden wrote:
> On 2021-03-23 2:24 p.m., Nicolas Saenz Julienne wrote:
> > On Tue, 2021-03-23 at 15:08 -0600, Rob Herring wrote:
> > > On Mon, Mar 22, 2021 at 12:11:29PM -0700, Scott Branden wrote:
> > > > On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
> > > > > Convert the brcm,iproc-sdhci binding to DT schema format using js=
on-schema
> > > > >=20
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > > > ---
> > > > > =C2=A0.../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 ++++++++=
+++++++++++
> > > > > =C2=A0.../bindings/mmc/brcm,sdhci-iproc.txt         | 37 --------=
----
> > > > > =C2=A02 files changed, 58 insertions(+), 37 deletions(-)
> > > > > =C2=A0create mode 100644 Documentation/devicetree/bindings/mmc/br=
cm,iproc-sdhci.yaml
> > > > > =C2=A0delete mode 100644 Documentation/devicetree/bindings/mmc/br=
cm,sdhci-iproc.txt
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdh=
ci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..19d84f3ef9e6
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > > > > @@ -0,0 +1,58 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Broadcom IPROC SDHCI controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > > This is already covered in the MAINTAINERS section via "N:	iproc".
> > > > M:	Ray Jui <ray.jui@broadcom.com>
> > > >=20
> > > > M:	Scott Branden <scott.branden@broadcom.com>
> > > >=20
> > > > M:	bcm-kernel-feedback-list@broadcom.com
> > >=20
> > > Maybe so, but still required here. The problem is there is no=20
> > > MAINTAINERS file in the DT only tree[1].
> >=20
> > Well in that case, if Scott and Ray are OK with it I'll add them.
> I do not know what the "maintainers" section in the yaml file is used to =
indicate.
> If it is maintainer for the driver then please add the duplicate of what =
is
> already in the MAINTAINERS file.  If it is for maintainer of devicetrees =
that
> use this driver then no need to add us.

=46rom the dt bindings documentation:

maintainers
  A DT specific property. Contains a list of email address(es)
  for maintainers of this binding.

That's the maintainers for the bindings, not the devicetrees consuming them=
. I
belive it makes sense for you guys to maintain it as it has a strong
relationship to driver changes. But if you're not interested I'll do it mys=
elf.

Regards,
Nicolas



--=-ViNOE93gnirGk1EY9hs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBbak8ACgkQlfZmHno8
x/7auwf/XiiMWtXMCFAncrVyJbJGU9nIKnVNg3g4XCQqTXHbYDcZ6bf1OIk7/Xst
dr++njCcrrXqXUyT0gersWwdU9Bhk3tBJ1BPzUjIeieD2GrbdzAm2bs/9WNVkFjg
4mf8DAx0Mhj8aWa4SKRBZL//2L3QzlbQmmHj6hJPpHWcR5CbYxMc4LSEPQMyD1Tu
+t1TfsHckWyMfkwCfzal/7Tk0H1SW7wXRVM0xzOS+2t3gqZZYn4L1+Va0/NNgsQ6
qoLIL9qIIPxMpCLgCNsXgx47pFozZTvGvM08fxe5I92ZDQ+6Bx+5joYutjk53xS/
wtLTUFS4dCSrLkj2joyZdr7A0sBbYA==
=w+e4
-----END PGP SIGNATURE-----

--=-ViNOE93gnirGk1EY9hs7--

