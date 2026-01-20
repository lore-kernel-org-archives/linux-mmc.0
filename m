Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD143CEF4
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933230; cv=none; b=d4X30pb0VFon7ak7qouKTSbHXbuWKHLf5KnKWPh5n5rkhKoK46X3lWYFLEy/mg1JCq9VONWdOqV2S2wBfsdzISdo/wEFGk8qokOvexc41R1SBNnCkwQRyRTU6nBc91KERsjb2musAFIWbSdg+uhaY872iGu4igAjmKsUB//s0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933230; c=relaxed/simple;
	bh=8iO9X24WNf+b/ZqILypVRhAtLKW2GNEsE317PhISvII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeLYwMzI+gYJsdTXt3mH6R2UQ0O0ih6+r/p0WheeK4Tl5CG8Em6q0kEc2vcrW5oyUdrwtmqFenuxOjCTR/MBLu9S2iTJAElYi7HV805zKEdyEZ6gk4pm4VZCL81CQpKzqFGUQKeORGmAvwX82LcRNRr8E85vzRlkYITiuD9NPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqG2B3WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqG2B3WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C4C19421
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768933230;
	bh=8iO9X24WNf+b/ZqILypVRhAtLKW2GNEsE317PhISvII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OqG2B3WU+Z4fD0gfU8cJI6c/Z52wM0jvStPnU76E2b2gx+LA4c9y9EiBIp91puWNr
	 H59O8NLGNSoydAPEnj+D7QCWNK3BTjxBssD/OGJnNjqeKNyFbBJuKTiRQkrLG0BP+s
	 GLjjYIScfmz+fzUAgZFrTJqKYwou4K3cvv537LlOSvpcAw9gUFVKC1Q+iImxI4CB0j
	 EpiT/xTNVFs1tx3/To4RhH2Nr7Ir5JsSepNjp4wAwAePM50X+OltrjyuSM1jgWqGOs
	 2XKJCf25J7N4VjOyjuoP1RJ8eCxNJrzT195CD6ora7w0XdBQYXO14bOeWq5sJC2kDW
	 EQVDakJM837iA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b874c00a39fso19408866b.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 10:20:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwHuT+AmYrICCrkgwPMJ3xStJan33PmQNFhcRsi9Yr4/CBYyIre9QDatEdnh0KfuhI9Y7KkFklAH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXA0/PQ92OWFtHr63QaDcvgYAQEwsd7vTq0u3VdhmzOetmhnh
	/63+U9G5EtY8XB5qxmITiX5His0YOtXDrE8waebfQoDbxD0CwVQHU780YbrFOB4GKNG2mEl7hVb
	PwEBjO+xCPsRBB16gahKqr8zR+eDgvw==
X-Received: by 2002:a17:907:971e:b0:b7c:cc8d:14f4 with SMTP id
 a640c23a62f3a-b8777a09915mr1649298166b.4.1768933228493; Tue, 20 Jan 2026
 10:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-10-77ebb958a312@kernel.org> <20260120-origami-lori-of-genius-8fd944@quoll>
In-Reply-To: <20260120-origami-lori-of-genius-8fd944@quoll>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Jan 2026 12:20:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+pO7fQp7gYe4AvX9G-cOykreU3xTieUw2Q2PAZf4NUQ@mail.gmail.com>
X-Gm-Features: AZwV_QhKFpVtz-Uqzq0wFapMdB8t9l7NvlfaSwcJmbkHLKd8OZ8fsyVii9Phizo
Message-ID: <CAL_JsqL+pO7fQp7gYe4AvX9G-cOykreU3xTieUw2Q2PAZf4NUQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] dt-bindings: mtd: partitions: Combine simple
 partition bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 3:04=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Jan 19, 2026 at 07:48:31PM -0600, Rob Herring (Arm) wrote:
> > Several partition node bindings are just a compatible plus properties
> > defined in partition.yaml. Move all of these bindings to a single schem=
a
> > file.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > -        partition@200000 {
> > -            compatible =3D "tfa-bl31";
> > -            reg =3D <0x200000 0x100000>;
> > -            align =3D <0x4000>;
> > -        };
> > -    };
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4=
908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm=
,bcm4908-partitions.yaml
> > index 159b32d12803..a6edf145df57 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-par=
titions.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-par=
titions.yaml
> > @@ -29,11 +29,7 @@ properties:
> >
> >  patternProperties:
> >    "^partition@[0-9a-f]+$":
> > -    $ref: partition.yaml#
> > -    properties:
> > -      compatible:
> > -        const: brcm,bcm4908-firmware
> > -    unevaluatedProperties: false
> > +    type: object
>
> I think this is not specific enough now and you should have here $ref
> (e.g. to simple-partition.yaml) with unevaluatedProperties. Otherwise
> schema does not report:
> 1. bogus properties in partition@ nodes without compatibles (like the
>    first one in the example),

Yes, it should be "$ref: partition.yaml#/$defs/partition-node" rather
than simple-partition.yaml IMO.

> 2. partition@ nodes with some other compatibles (non-partition like,
>    e.g. whatever I2C device stuffed there for which there is a schema of
>    course)

We don't really enforce something like that anywhere else except when
the child nodes are fixed and there's only 1 possible option. I don't
think the schemas need to check for obviously nonsensical DTs. We can
put I2C device on simple-bus or vendorA device in vendorB SoC. Trying
to combine all possibilities is what was tried in partitions.yaml, but
that doesn't really work well when there are multiple combinations and
nesting is possible. Maybe "brcm,bcm4908-firmware" is the only one
used, but there's not really any reason others can't be used. The
other way around already happened. "brcm,bcm4908-firmware" is used
under a "fixed-partitions" node (in bcm4906-netgear-r8000p.dts) which
wasn't allowed before this series.

Rob
