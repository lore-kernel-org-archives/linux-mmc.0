Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36C27A93C;
	Fri, 24 Oct 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323886; cv=none; b=Fcbqfk70xeEt+rG86EgqKdNUmW0ed9CJ5oVi/009oG2inbi/ABlTzBWPSQpY0tS0MjfQH5UbR6BrFtp0UQkd2Ws2tlOtdmU2ITYIdQsarmNm5l8P8T21QLLabAp6utuwQFGDgJiV8TXAaR6MBVtvzM4+YybksPClqHTThwQQ4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323886; c=relaxed/simple;
	bh=zzrhl6o8RsTAafMLaghm1EM3uMYuu4ka9jAUS31RumY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk5q+LROR8opxgy6ucxcQnfMXvLeGF/BfMDOJLcJv3wipcrnqAqtrd11WMD5413D2pYoQHTZL2syOKu5ssAQwZu9PLo0X8BoRwgc8rucQSge6GXuHXBs5xQQEbk5bcjhjcBfu18TgMKDTH7bSMR3XrXG5/ox+rLRfC4k+AAgk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6OCH6NU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6OCH6NU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC8C4CEF1;
	Fri, 24 Oct 2025 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323885;
	bh=zzrhl6o8RsTAafMLaghm1EM3uMYuu4ka9jAUS31RumY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6OCH6NUXsJcfM/ajl56po/PgeN0xGb2xTBAVLd2hp1T9qVhKjUVZWn7xKeZpFSwY
	 HUMl92F7Kd3DpFoCc1YTOpguUjpOD5HtG7iKZNQvf9tpHiOAk8n8acHie134419Wca
	 n+T5VGayb/dQuVFkLfrGg9AeosDWIv9RebhqY8+d0EKmXb4zwGiMv84Lz3+qohpn3L
	 kg5MUBsZRVKV+uXWTkp5UPP2asVWb3/K3L1okBnhy0t+7YgVJD+phL2xSa5iCGsnjB
	 4746uzkogwP91G51zOVGStbW+9RiSsutlV/dwa+Yd1CcywtCWwURfGkBHCCjS74QM5
	 UvxKp5V9vb/eA==
Date: Fri, 24 Oct 2025 17:37:59 +0100
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
Message-ID: <20251024-aghast-poster-82ee7aa7fdca@spud>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115238.320-1-hehuan1@eswincomputing.com>
 <CAPDyKFqGwTF2w2JfqOuxMt6m_YJOYhqoUaQXyZALRu94W3fGkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T9okXr0D52bwp3p1"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqGwTF2w2JfqOuxMt6m_YJOYhqoUaQXyZALRu94W3fGkQ@mail.gmail.com>


--T9okXr0D52bwp3p1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 03:57:33PM +0200, Ulf Hansson wrote:
> On Sun, 19 Oct 2025 at 13:52, <hehuan1@eswincomputing.com> wrote:
> >
> > From: Huan He <hehuan1@eswincomputing.com>
> >
> > EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> > Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> >
> > Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
> >  1 file changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.y=
aml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > index f882219a0a26..7e7c55dc2440 100644
> > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > @@ -30,6 +30,7 @@ properties:
> >            - sophgo,sg2002-dwcmshc
> >            - sophgo,sg2042-dwcmshc
> >            - thead,th1520-dwcmshc
> > +          - eswin,eic7700-dwcmshc
> >
> >    reg:
> >      maxItems: 1
> > @@ -52,17 +53,30 @@ properties:
> >      maxItems: 5
> >
> >    reset-names:
> > -    items:
> > -      - const: core
> > -      - const: bus
> > -      - const: axi
> > -      - const: block
> > -      - const: timer
> > +    maxItems: 5
> >
> >    rockchip,txclk-tapnum:
> >      description: Specify the number of delay for tx sampling.
> >      $ref: /schemas/types.yaml#/definitions/uint8
> >
> > +  eswin,hsp-sp-csr:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: Phandle to HSP(High-Speed Peripheral) device
> > +          - description: Offset of the stability status register for i=
nternal
> > +                         clock.
> > +          - description: Offset of the stability register for host reg=
ulator
> > +                         voltage.
> > +    description:
> > +      HSP CSR is to control and get status of different high-speed per=
ipherals
> > +      (such as Ethernet, USB, SATA, etc.) via register, which can tune
> > +      board-level's parameters of PHY, etc.
>=20
> I would like second confirmation from DT maintainers, to make sure
> it's reasonable to model the HW like this.

If by second confirmation, you mean by someone other than me, obviously
ignore this, but I think this is "fine". It discussed on a previous
revision that all is being done with it is setting a handful bits that
signify that the peripheral has been configured correctly.

That said, I don't have a clue what's going on with the warning about
the dwmac device. That's definitely one for Rob.

>=20
> In principle the phandle above gets translated into a regmap via a
> call to syscon_node_to_regmap() in the driver, to allow some registers
> to be written that are outside the controllers address space.
>=20
> > +
> > +  eswin,drive-impedance-ohms:
> > +    description: Specifies the drive impedance in Ohm.
> > +    enum: [33, 40, 50, 66, 100]
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -110,6 +124,37 @@ allOf:
> >              - const: block
> >              - const: timer
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: eswin,eic7700-dwcmshc
> > +    then:
> > +      properties:
> > +        resets:
> > +          minItems: 4
> > +          maxItems: 4
> > +        reset-names:
> > +          items:
> > +            - const: axi
> > +            - const: phy
> > +            - const: prstn
> > +            - const: txrx
> > +      required:
> > +        - eswin,hsp-sp-csr
> > +        - eswin,drive-impedance-ohms
> > +    else:
> > +      properties:
> > +        resets:
> > +          maxItems: 5
> > +        reset-names:
> > +          items:
> > +            - const: core
> > +            - const: bus
> > +            - const: axi
> > +            - const: block
> > +            - const: timer
> > +
> >    - if:
> >        properties:
> >          compatible:
> > --
> > 2.25.1
> >
>=20
> Kind regards
> Uffe

--T9okXr0D52bwp3p1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPurZwAKCRB4tDGHoIJi
0qKiAP0RGk+BsqOlcKKdVVbn+HknCcQ1/EQJfCUTs/iQIgM0YgEAktfz5VmfBqm1
CzDpQLxxVGVyMeygJYWGjgbwDYuQ7AA=
=jf3G
-----END PGP SIGNATURE-----

--T9okXr0D52bwp3p1--
