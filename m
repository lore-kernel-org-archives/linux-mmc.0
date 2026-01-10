Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E112B93
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768004746; cv=none; b=auhxG0/9WXghMdTX52rzoJSgvMAfMbJ8I4KTQNowuGx7NEe4G38KPkv5XPqV+MRlfuWc2vK9IK39Q9/zSQn9LIWFdMNwM4NpOBkDBlAviPfGlVXETTAWwYBjQ9rH0NdW86jVKs9mXUXlYuwjHNQEuwth+hI2hEhqqhSYNu1GP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768004746; c=relaxed/simple;
	bh=xCsdq2/YpqNCz0nEsnCCHEidLPsRpz/Me7ujRVjz1Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po5+Dn9sq0d7DGgaOf39OLE6Q1v3Kzy0zIih0kPTwDS8QSvOgEKWUQEciuRewSMZuFZARlq9/0c6cX+eG+rV/Zh1QI0Pg3Vdd+Ms8pgpzD5hFkcL/0Ob/Ew0AaRpo/XIdVMhylOZ06jezSdSnu6L+mGsDvvg6EfUiFvPrCEXGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL8FoZiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL8FoZiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A25DC2BC86
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768004745;
	bh=xCsdq2/YpqNCz0nEsnCCHEidLPsRpz/Me7ujRVjz1Yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jL8FoZiUxBsDffXxxhvI0Toz5694fbx3yllTIPb8VjtO9aVhWiRpRLV3Wvr+XKZxK
	 aRe/kUasV5MaJImSoVBW8LgK60JsfPUCJ1fou4eOIdH5en6XmAX9cQjYngV5wh96jj
	 g7RdQjLnq9gqEm0QoWs+3DuuObs09oXGtAygE0kfMbl4hZinsX3uiRKA+U2Pg0JKuQ
	 dzUyci+OEVoIvGC+KTUIvOyaFITUZPkrCiCq6QQTwW6rxMLf+RdIev1rGV5dWyWC2R
	 CBI7y54ffgQ7wA/90U8GMzoYRbLafusbZFv6XK8FgyN1Tu7S/Gun/9K36spYRPzv4j
	 ScCAPScfluBUg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7a02592efaso782713466b.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 16:25:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU05tBPYAVwnb+1xs3jTSr/BJG6pVbpncOit2lDj5qHJoIxG53Y6ytJhLeDkyGE344xmNLFlRmQzko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fvm+zifCIOzmxR6dK5HW0SHkDhU7puBNz/Nc1TzugLOwl53U
	+U/Il8XHqA/6CrIixepUHLTUsYDkHtreDkjI+NtdVICONMvVyJIMDZ62kFPDgm6+2DXNEsNsX29
	LWqXQHUBMjDmhw8zyrXKb3zZ8S/Bg4Q==
X-Google-Smtp-Source: AGHT+IH2kcyT28zPJ6scp6ebqDGJc2zumrCICLwucitli+zofZLqRYPfOa2gqyx1ueknJkxerSM9/WLfKBC2uSAi/LM=
X-Received: by 2002:a17:907:8693:b0:b7a:1be1:822 with SMTP id
 a640c23a62f3a-b84451a1f3cmr1192133566b.63.1768004744112; Fri, 09 Jan 2026
 16:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org> <20260109-affable-poetic-albatross-ff7fcf@quoll>
In-Reply-To: <20260109-affable-poetic-albatross-ff7fcf@quoll>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Jan 2026 18:25:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcVUMJqTKnYpP_r4Z16Sw1pVcQ=HCFJG0bY_O=q3psVQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh7LipR_5wdGhuBSgVEhZFQa5ZRYILCErh5TeL0Qy91vSKljpYk4n02SgY
Message-ID: <CAL_JsqLcVUMJqTKnYpP_r4Z16Sw1pVcQ=HCFJG0bY_O=q3psVQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: mtd: Ensure partition node properties
 are documented
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

On Fri, Jan 9, 2026 at 3:36=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Jan 08, 2026 at 11:53:16AM -0600, Rob Herring (Arm) wrote:
> > Partition nodes without a compatible have no restrictions on additional
> > properties. Fix this by ensuring 'unevaluatedProperties' is set when
> > there's no compatible property. If there is a compatible property, then
> > there should be a specific schema for it which will enforce
> > 'unevaluatedProperties'.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mtd/mtd.yaml               |  8 ++--=
----
> >  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml |  2 +-
> >  .../devicetree/bindings/mtd/partitions/partition.yaml        | 12 ++++=
++++++++
> >  .../mtd/partitions/tplink,safeloader-partitions.yaml         |  2 +-
> >  Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml |  2 +-
> >  Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml   |  2 +-
> >  6 files changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documenta=
tion/devicetree/bindings/mtd/mtd.yaml
> > index e56dba83f00a..5a2d06c96c0d 100644
> > --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> > @@ -36,12 +36,8 @@ properties:
> >        - compatible
> >
> >  patternProperties:
> > -  "@[0-9a-f]+$":
> > -    $ref: partitions/partition.yaml
> > -    deprecated: true
> > -
> > -  "^partition@[0-9a-f]+":
> > -    $ref: partitions/partition.yaml
> > +  "(^partition)?@[0-9a-f]+$":
> > +    $ref: /schemas/mtd/partitions/partition.yaml#/$defs/partition-node
> >      deprecated: true
>
> This makes partition@ deprecated. Looks unintended or needds commit msg
> explanation.

No, the only change here is I combined the entries. "partition@" is
deprecated when not under "partitions" node.

Rob
