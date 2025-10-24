Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D2226CF6;
	Fri, 24 Oct 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342461; cv=none; b=DOp54BCCl+cJymJshGl2zA0kcIrRodTdSE2BS7PoJB5rhPeyP6/yrw8N+Zg6gOdt7+XiRjtoAOpBSYb2KLCZRG0qsoqMOTfyayDMPIqBqOzzL5ejtCvg+GLI+juLnCC9cMO24xMj1pi3qiNYuptY+cJH9GCLaqL5itC5creLQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342461; c=relaxed/simple;
	bh=xQ+PTIXP2X5uq3SBND2adD5W0BgWSSBdUexICDpqUgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amELuEsNvlXd1vvIniTFaPc5coftK7NA41qReUmSCNPIsdEFrsFaMRL0k4OjgIbiyEsqgezyVkN6KXMZjRXcgq2X9zuP3Ap3AodgSg9xdpzbF1qLzcRQ5wqe4CiYJp7WSXR5qUGm+OQuzUyc2Lx515vwdfUvUliehe6GM/JsOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/TOWZyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/TOWZyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2CFC4CEF1;
	Fri, 24 Oct 2025 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761342460;
	bh=xQ+PTIXP2X5uq3SBND2adD5W0BgWSSBdUexICDpqUgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/TOWZyUblLMad7sewcZG2ZDAQQcnXZqVShW6N70fogXq1+i2u1GtsIpTFTXZBngE
	 GB/fo3OFOQLLi7gbDuUBm3i2Q+U76H05pFFk3x7mdRXjanCqXu6OsM58la3b/sn2Lu
	 x4TC7b9MA3zWsLHqMNHca/PvPitTZQ5SfiSvz8NF+uEO1Muxz2Lu9Ev+y6R8xp1FFj
	 pzVXUaA26pDUtWyvm/9yTf1WfHF+iHfvjGXciuzDsrZekZh006iAeZATIBPdLBPOcB
	 /Cid234ovpie5OeDEk37rj+u65ZFFLBqN3od2qd+j1gGRIcIe+KOMcL3DqT7hUz4ct
	 jVSdcGf6MfZnw==
Date: Fri, 24 Oct 2025 22:47:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: hehuan1@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, adrian.hunter@intel.com,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com, dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com, weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com, caohang@eswincomputing.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20251024-polyester-gatherer-e7f5e4300262@spud>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115238.320-1-hehuan1@eswincomputing.com>
 <CAPDyKFqGwTF2w2JfqOuxMt6m_YJOYhqoUaQXyZALRu94W3fGkQ@mail.gmail.com>
 <20251024-aghast-poster-82ee7aa7fdca@spud>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A4UDR8rMG+0hoqyu"
Content-Disposition: inline
In-Reply-To: <20251024-aghast-poster-82ee7aa7fdca@spud>


--A4UDR8rMG+0hoqyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 05:37:59PM +0100, Conor Dooley wrote:
> On Fri, Oct 24, 2025 at 03:57:33PM +0200, Ulf Hansson wrote:
> > On Sun, 19 Oct 2025 at 13:52, <hehuan1@eswincomputing.com> wrote:
> > >
> > > From: Huan He <hehuan1@eswincomputing.com>
> > >
> > > EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> > > Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> > >
> > > Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++=
--
> > >  1 file changed, 51 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci=
=2Eyaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > index f882219a0a26..7e7c55dc2440 100644
> > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > @@ -30,6 +30,7 @@ properties:
> > >            - sophgo,sg2002-dwcmshc
> > >            - sophgo,sg2042-dwcmshc
> > >            - thead,th1520-dwcmshc
> > > +          - eswin,eic7700-dwcmshc
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -52,17 +53,30 @@ properties:
> > >      maxItems: 5
> > >
> > >    reset-names:
> > > -    items:
> > > -      - const: core
> > > -      - const: bus
> > > -      - const: axi
> > > -      - const: block
> > > -      - const: timer
> > > +    maxItems: 5
> > >
> > >    rockchip,txclk-tapnum:
> > >      description: Specify the number of delay for tx sampling.
> > >      $ref: /schemas/types.yaml#/definitions/uint8
> > >
> > > +  eswin,hsp-sp-csr:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - items:
> > > +          - description: Phandle to HSP(High-Speed Peripheral) device
> > > +          - description: Offset of the stability status register for=
 internal
> > > +                         clock.
> > > +          - description: Offset of the stability register for host r=
egulator
> > > +                         voltage.
> > > +    description:
> > > +      HSP CSR is to control and get status of different high-speed p=
eripherals
> > > +      (such as Ethernet, USB, SATA, etc.) via register, which can tu=
ne
> > > +      board-level's parameters of PHY, etc.
> >=20
> > I would like second confirmation from DT maintainers, to make sure
> > it's reasonable to model the HW like this.
>=20
> If by second confirmation, you mean by someone other than me, obviously
> ignore this, but I think this is "fine". It discussed on a previous
> revision that all is being done with it is setting a handful bits that
> signify that the peripheral has been configured correctly.
>=20
> That said, I don't have a clue what's going on with the warning about
> the dwmac device. That's definitely one for Rob.

Apparently it's just as simple as there being more than one definition
of the same property. I had it in my head that that was okay when only
one binding was applied to the node, but clearly not.

I'll have to un-review it until that error is sorted out.


> > In principle the phandle above gets translated into a regmap via a
> > call to syscon_node_to_regmap() in the driver, to allow some registers
> > to be written that are outside the controllers address space.
> >=20
> > > +
> > > +  eswin,drive-impedance-ohms:
> > > +    description: Specifies the drive impedance in Ohm.
> > > +    enum: [33, 40, 50, 66, 100]
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -110,6 +124,37 @@ allOf:
> > >              - const: block
> > >              - const: timer
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: eswin,eic7700-dwcmshc
> > > +    then:
> > > +      properties:
> > > +        resets:
> > > +          minItems: 4
> > > +          maxItems: 4
> > > +        reset-names:
> > > +          items:
> > > +            - const: axi
> > > +            - const: phy
> > > +            - const: prstn
> > > +            - const: txrx
> > > +      required:
> > > +        - eswin,hsp-sp-csr
> > > +        - eswin,drive-impedance-ohms
> > > +    else:
> > > +      properties:
> > > +        resets:
> > > +          maxItems: 5
> > > +        reset-names:
> > > +          items:
> > > +            - const: core
> > > +            - const: bus
> > > +            - const: axi
> > > +            - const: block
> > > +            - const: timer
> > > +
> > >    - if:
> > >        properties:
> > >          compatible:
> > > --
> > > 2.25.1
> > >
> >=20
> > Kind regards
> > Uffe



--A4UDR8rMG+0hoqyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPvz9gAKCRB4tDGHoIJi
0oaWAPwJhXX+0f4E4cqnjktuqI+rP+B6prN+//Xe6GXZOEu5aAD+MVci5SdSMsyF
N2vJNTicnWywHQV0HOwF/E6r6amqsQk=
=ipWf
-----END PGP SIGNATURE-----

--A4UDR8rMG+0hoqyu--
