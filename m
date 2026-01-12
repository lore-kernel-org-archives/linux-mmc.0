Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A72C028B
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258687; cv=none; b=Oq8+wrN9vpUIitqlsofkScq8lX2N6MFu39+FdzGbgNq5sgoo3DbhWCvnqolLdzRQBIqfEoRB4cZOJeg06awZ+G7ieqrwmA9rd9gAqhFvcM4DkJolHlmkfTrfVc2LyJjwUNq87gTBg40giRAr5P9djxHUZm26nxyUvM2G7Igan7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258687; c=relaxed/simple;
	bh=rGR4ZRN/eUN4de0udno9CMQ1JKZLoES5FgqCMPiLzqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0u7pxEOtKKCtFAPBUyTVtTl/2AksY/sIoX/gDWde5P0VWOCYCv1mOcSCYXZZHesuJkg8q7nYNpOiInVoWCVO7VrzqZpC0gMPe8k73q3qLqvQLbVP/ZzBrAtzaI2SzYsRKOZBJvxdokMZ9ULjBqHMq/nk6jUWTl9EWztz71gORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF1A2oSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF1A2oSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0744C2BC9E
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768258686;
	bh=rGR4ZRN/eUN4de0udno9CMQ1JKZLoES5FgqCMPiLzqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZF1A2oSwK1WsbWs/HUBcLdTtmiUbK6URLC2b/N/uRpduXWfNWd7sFJHylH1WBFPGl
	 4W0qbD7+vI9ygSTKuxXub3hNW7e1OIABaHbvYwbMe1ze08bnQOEEeoYfB68cbMoZT4
	 t67BRBrPgRvrAJE9u9zTWFlb/F60evXfpOPf++hM/o6hBw3aSuKfcMvBGTetT6KeKP
	 QVOleN8aFaTqWZvRKkG6U13zjX8OYXDZDZOi6QHouEIPkJGHxnUt9q/x82RH815ikV
	 TjLUQA5zdmbV8F+L7qyGbJfx//yFgmhG46XYsjeZN8DO4O5jXhEpEuN5jtVf6u/Nc4
	 7naZe4GyxLteA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b83122f9d78so1101690366b.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 14:58:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWclzmo0AtsyBGxQCuBwvo2RQBxBgGQi9+xWbgpJLl5iKutcZrrX5PFn+15VEY7//KBXlJ9zEkABf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxCdPoxZ1SrHJtbzqJrPiei7GjliqfY61/k1zzRpeBCPt3Vx7
	P52es85DoPAY1QErvQR6K8ziWCsl+TXDCgxDiRTQ4Jdrw9g6gu5uMICWAecBrwE3mlnFxsvtsfI
	FuT39dH8Uq5qOAi+cgf1Tk1ayL8KlAg==
X-Google-Smtp-Source: AGHT+IFvZMR6ZXQzmmWssKqU5VU1/QG0Dy+4mHOcf7yoi13by1s1GpP8Cl1/EvHF9RRVm6QkOUCvmPjShbd8Q2d+EvI=
X-Received: by 2002:a17:907:1ca8:b0:b72:b289:6de3 with SMTP id
 a640c23a62f3a-b84453ff014mr1934265266b.58.1768258685308; Mon, 12 Jan 2026
 14:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-6-124a53ce6279@kernel.org> <20260109-bright-purring-oyster-8c9f0b@quoll>
In-Reply-To: <20260109-bright-purring-oyster-8c9f0b@quoll>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Jan 2026 16:57:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0NRHx5JVvcZZC1PX0UByFq7PmvZbH6QoNn3kBZgrbPg@mail.gmail.com>
X-Gm-Features: AZwV_Qju7S_APdjvo6ENgv2SSZg3sdeIvTR8mamw1g2_RQbQl5m7gRsuwu8q2uU
Message-ID: <CAL_Jsq+0NRHx5JVvcZZC1PX0UByFq7PmvZbH6QoNn3kBZgrbPg@mail.gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: mtd: partitions: Drop partitions.yaml
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

On Fri, Jan 9, 2026 at 3:34=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Jan 08, 2026 at 11:53:15AM -0600, Rob Herring (Arm) wrote:
> >  patternProperties:
> >    "^partitions(-boot[12]|-gp[14])?$":
> > -    $ref: /schemas/mtd/partitions/partitions.yaml
> > +    type: object
> > +    additionalProperties: true
> >
> > -    patternProperties:
> > -      "^partition@[0-9a-f]+$":
> > -        $ref: /schemas/mtd/partitions/partition.yaml
> > -
> > -        properties:
> > -          reg:
> > -            description: Must be multiple of 512 as it's converted
> > -              internally from bytes to SECTOR_SIZE (512 bytes)
> > -
> > -        required:
> > -          - reg
> > -
> > -        unevaluatedProperties: false
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: fixed-partitions
> >
> >  required:
> >    - compatible
> > diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documenta=
tion/devicetree/bindings/mtd/mtd.yaml
> > index bbb56216a4e2..e56dba83f00a 100644
> > --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> > @@ -30,7 +30,7 @@ properties:
> >      deprecated: true
> >
> >    partitions:
> > -    $ref: /schemas/mtd/partitions/partitions.yaml
> > +    type: object
>
> I think you need explicit, since we require it for incomplete nodes:
>
> additionalProperties: true

I put what the tools required me to put. :) We only require it when
properties get defined because that's the case we don't know if the
schema is *all* properties or not.

Rob
