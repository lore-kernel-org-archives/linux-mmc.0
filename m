Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B115C12D;
	Fri, 30 Aug 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027393; cv=none; b=Ydkjm8EvcNOD+9aVZainFqI+VHDTSdkdm9HqiXKvc3m17+nRW/ibIQ9BZfWDz8Zi7ckFAPqa2u4NFpIk3ISNUYB1bDqjDwJ0+TdaREcEbZdSp3PRBhTw7lYSEOKZsKQIa7SzKfgWSYYQRXxKbruqgol8YDi10V6RlVF1TEVSEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027393; c=relaxed/simple;
	bh=6k0EBPAToTHacrO5Vk2++06yO8LBCkYLbbqyVIV3Nyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg7f8vWrP1+VoPvkyzCc2nR5Kvd0oUL+7IvuIhRv8eM9Ipzszahnu8KFmp6GRU0QKID1ZRLWyIX/4GQ66xURY+2Ns/7CzqIjKBTmn9/5VTF5j8C5j0Lm3BuMY7hwRzeZqcYhU2MGduHrWknLehqZBMa3Bu19kUD5bgnN2CGhTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugd9ODmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugd9ODmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C51C4CEC2;
	Fri, 30 Aug 2024 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725027391;
	bh=6k0EBPAToTHacrO5Vk2++06yO8LBCkYLbbqyVIV3Nyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugd9ODmX3NVQo5A8dl6N88A1o4+8y5g2DAg1agAi3/pD61gFqNz85A9VVD4zYj548
	 Y69GIOmUjRuIHTzbp6r+lGhS7tuBMTJ2uVoeSJzdJhS+MrsyLLopTzbpa8eWFL8Mhu
	 ZXz0Jc2XtZLMqfT0r2blTRUGpchkG+U0geSIMWU0XyizzAsSBK+g8lqmAbTpJaTXig
	 CkSNNlO9TUYZWxu5vEL4HlvHLpTZyh2rL6M3gi1IWXkoxF7C6T0lQg+O/x30ovl7i7
	 VBUJS+VI3zVmMUuJ+ksBqLdTVIegnqBJAHAdXKcu0Atat794rh0dfyfDNyGKpdfW+8
	 YXExgpd0UttPA==
Date: Fri, 30 Aug 2024 15:16:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	Aubin.Constans@microchip.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Message-ID: <20240830-retry-ranger-fdd01812a120@spud>
References: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
 <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>
 <20240830-satisfy-dislike-27ed075138b3@spud>
 <9e9c8274-6bf2-45f9-8b65-ddc73a0802bc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s794SldV2zC1SmKv"
Content-Disposition: inline
In-Reply-To: <9e9c8274-6bf2-45f9-8b65-ddc73a0802bc@microchip.com>


--s794SldV2zC1SmKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 02:12:48PM +0000, Dharma.B@microchip.com wrote:
> Hi Conor,
>=20
> On 30/08/24 7:18 pm, Conor Dooley wrote:
> > On Fri, Aug 30, 2024 at 01:49:42PM +0530, Dharma Balasubiramani wrote:
> >> Convert sdhci-atmel documentation to yaml format. The new file will in=
herit
> >> from sdhci-common.yaml.
> >>
> >> Note: Add microchip,sama7g5-sdhci to compatible list as we already use=
 it
> >> in the DT.
> >>
> >> Signed-off-by: Dharma Balasubiramani<dharma.b@microchip.com>
> >> ---
> >>   .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 98 ++++++++++++=
++++++++++
> >>   .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
> >>   2 files changed, 98 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci=
=2Eyaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> >> new file mode 100644
> >> index 000000000000..91d18b2545e1
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> >> @@ -0,0 +1,98 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id:http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
> >> +$schema:http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Atmel SDHCI controller
> >> +
> >> +maintainers:
> >> +  - Aubin Constans<aubin.constans@microchip.com>
> >> +  - Nicolas Ferre<nicolas.ferre@microchip.com>
> >> +
> >> +description:
> >> +  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - enum:
> >> +          - atmel,sama5d2-sdhci
> >> +          - atmel,sama5d3-sdhci
> >> +          - atmel,sama5d4-sdhci
> >> +          - microchip,sam9x60-sdhci
> >> +      - items:
> >> +          - enum:
> >> +              - microchip,sama7g5-sdhci
> >> +          - const: microchip,sam9x60-sdhci
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    minItems: 2
> >> +    maxItems: 3
> >> +    description: |
> >> +      The sama5d2 family includes three clocks: `hclock`, `multclk`, =
and `baseclk`.
> >> +      For other families, including sam9x60 and sam9x7, only `hclock`=
 and `multclk` are used.
> > This should instead be an items list, rather than a text based
> > description.
> Sure, I will update it like this below
>=20
> clocks:
>    items:
>      - description: hclock
>      - description: multclk
>      - description: baseclk
>    minItems: 2
>    maxItems: 3

This shouldn't pass dt_binding_check, because the max in this snippet is
redundant due to it matching the size of the items list.

--s794SldV2zC1SmKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHUOgAKCRB4tDGHoIJi
0mRbAQDWBI8NgkX+ksGcgXOabPePzRu6PCDTAOkCM3/F9x0RbQEA26WvR+3rxxKM
by1bfuJKmyiFwGLR2bZj041Nr82IjA0=
=4oBx
-----END PGP SIGNATURE-----

--s794SldV2zC1SmKv--
