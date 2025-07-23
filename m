Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B80A31;
	Wed, 23 Jul 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281426; cv=none; b=EPfrrFYOBZHU0yH4/+31giU2IN4UHNADxg1jxM8dEYkApRj51F5rD9pbQyXsmLfeGgz7UNpSa58LKBJygWJeR8H6CGNg7PVsdqpRMZP3lJMlU93FXDSO729gQsCOXQOT1lwZWCO+iuqtEY1pvxMUi5E56ZzfboeFgU0x3hp1fdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281426; c=relaxed/simple;
	bh=1Eu6C66aJDQYWOYhxnwsTT2t5y102QgUEg4VToHlsTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOXFgC8hHNqbEltxSVezTCxRPEJep2Kc/XHnjBNZA323cNObuLmHimR8l9pniSoi/9i9Our/2tCh98yL2a7kly6GMBDucSLUznBSXcyGRVAtU3iZmuXltt7DlYhVnsez9b8iteqRTKor3wZEKwh7Xv+ZiN0JIHoMKBKS2XsdOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Qx+ki/g6; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Qx+ki/g6"
DKIM-Signature: a=rsa-sha256; bh=JE8x8JbxhqSBlVW6JXjbTPZwTk8sConJh4EHbajYP/Q=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1753281394; v=1; x=1753713394;
 b=Qx+ki/g60yiW5sNkfABHdiHKQSO3ov0lBjHTRMsMXXzn6RW2Q8f8jllh88wEI3vqgruy96k3
 vNr09IAfbXnhBPvOy0iI4A6N7YQKAwo+iLgKglW2RUr5x7AQNHVPMagV1t9WFJaxme5ReDKGK7S
 sMPb8suMuouA92EagbLFWoCXvEktZNVxbUpzhlg3mylMvsuaqdkNrFvR8obiwBxfV2Cv3uxotZ7
 I/Wka1IBZ1E3uGUseK4LEGFaakYH+OrcUivdxpFv9WNffn2pAjgEbQveq9s8rS7ksRQUbnnvD0W
 bOCnEpSyAs78mKNPRXbOLogHAIyqmycyotxUlKT11ihaQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 12094314; Wed, 23 Jul 2025 16:36:34 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Karel Balej <balejk@matfyz.cz>,
 David Wronek <david@mainlining.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject:
 Re: [PATCH RFC 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
Date: Wed, 23 Jul 2025 16:36:33 +0200
Message-ID: <5051937.31r3eYUQgx@radijator>
In-Reply-To: <20250721143541.GA593898-robh@kernel.org>
References:
 <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
 <20250718-pxav3-uhs-v1-1-2e451256f1f6@dujemihanovic.xyz>
 <20250721143541.GA593898-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 21 July 2025 16:35:41 Central European Summer Time Rob Herring=20
wrote:
> On Fri, Jul 18, 2025 at 11:12:38PM +0200, Duje Mihanovi=C4=87 wrote:
> > On the pxav3 controller, increasing the drive strength of the data pins
> > might be required to maintain stability on fast bus clocks (above 100
> > MHz). Add a state_uhs pinctrl to allow this.
> >=20
> > The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
> > it's unneeded on the other controllers.
> >=20
> > Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> > ---
> >=20
> >  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 45
> >  +++++++++++++++++----- 1 file changed, 35 insertions(+), 10 deletions(=
=2D)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> > b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml index
> >=20
4869ddef36fd89265a1bfe96bb9663b553ac5084..7a9e2a63ac4351aea10b2763ca250ce48
> > 89df1eb 100644 --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.ya=
ml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> >=20
> > @@ -30,6 +30,39 @@ allOf:
> >            maxItems: 1
> >         =20
> >          reg-names:
> >            maxItems: 1
> >=20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: mrvl,pxav1-mmc
> > +    then:
> > +      properties:
> > +        pinctrl-names:
> > +          description:
> > +            Optional for supporting PXA168 SDIO IRQ errata to switch C=
MD
> > pin between +            SDIO CMD and GPIO mode.
> > +          items:
> > +            - const: default
> > +            - const: state_cmd_gpio
>=20
> blank line

While at it, should I do the same with the properties: blocks in the existi=
ng=20
if: block?

Regards,
=2D-
Duje


