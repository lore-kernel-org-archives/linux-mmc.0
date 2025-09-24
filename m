Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F130AAC2;
	Wed, 24 Sep 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743001; cv=none; b=hF1VwH28TOYQZnfy73Vb1JYUJdjX5vjDJz2YZTyw4UjxXHqPZjJzii2WAmWMJbQSLzAcKFyVAUq7HnZ+9ahpCzJmRmTrfkWzBafn+zfZSqobgIUjssOaMaQ3Cuh3GnN885Ne6awDH1hyIaie/Sz3GvOGoOBwjQD3Ykq+LIBMEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743001; c=relaxed/simple;
	bh=eiRrQ8nJJ65azKvRRul53rh53CF5MIRAC7TRyWYYdE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/be7dHvlhDmpJqBMXG1W9PvX77y4mQERtz6d1KO8jXX63QLNaPJYwFyGxHbeL0wPp3+/3p7idnC5OIAhJtcLzxX+Wze5d7IIJZDJb00rcnt7DIB+h8Iut8m7ycsWkbJ6obc/YMZe9UwcahiW16FUQxsGiQEwQ4v+QJ3UF9WwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJvdvOeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJvdvOeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55209C4CEE7;
	Wed, 24 Sep 2025 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743001;
	bh=eiRrQ8nJJ65azKvRRul53rh53CF5MIRAC7TRyWYYdE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJvdvOebZJTBsgNeFehV1s1UWntKLNI7oNtE0dFZXMxaVXw43z3sXa6+keYbEa7kF
	 S0ei9qrpPrYnsx8+6ggUbJdneSeCsEnBOLn9iyZZ4r3q5az7Uo9F1DN+bkfuJ2pHNY
	 IEfOmHHn3zKBtuPuxGCthh0jkM1i3vfOC5+mUgJWa0XDmAg7A5biAGhQHygwTOCPrf
	 ftQZXdASS99LqF5jyg1Fw3TkZWeqcy+lW6ALM9WHELEFJxIvTeQSRMfUiev/nwvYbk
	 jiApDW0AmR7rPXRNn/CxEokZvWu26y1X1G5XLeT2linr4PC5Q+efritpYAyU5BmBf3
	 L7DfpPaFliceA==
Date: Wed, 24 Sep 2025 20:43:15 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?5L2V5qyi?= <hehuan1@eswincomputing.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, adrian.hunter@intel.com,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com, dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com, weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com, caohang@eswincomputing.com
Subject: Re: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20250924-visiting-sasquatch-c58f782ff686@spud>
References: <20250912093451.125-1-hehuan1@eswincomputing.com>
 <20250912093713.142-1-hehuan1@eswincomputing.com>
 <20250912-pork-oaf-3480d3d0ef67@spud>
 <674372d7.16fd.199751b489c.Coremail.hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V6cj8PXmL5zES4xt"
Content-Disposition: inline
In-Reply-To: <674372d7.16fd.199751b489c.Coremail.hehuan1@eswincomputing.com>


--V6cj8PXmL5zES4xt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 01:45:46PM +0800, =E4=BD=95=E6=AC=A2 wrote:
> Dear Conor,
> Thank you for your valuable and professional suggestions.
> Please find our explanations embedded below your comments in the
> original email.
>=20
> Best regards,
>=20
> He Huan
> Eswin Computing
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Conor Dooley" <conor@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-09-13 03:10:04 (=E6=98=9F=E6=
=9C=9F=E5=85=AD)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: hehuan1@eswincomputing.com
> > =E6=8A=84=E9=80=81: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@ke=
rnel.org, conor+dt@kernel.org, jszhang@kernel.org, adrian.hunter@intel.com,=
 p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, devicetree@vger.kernel.=
org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswinc=
omputing.com, pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com, l=
uyulin@eswincomputing.com, dongxuyang@eswincomputing.com, zhangsenchuan@esw=
incomputing.com, weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com=
, caohang@eswincomputing.com
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-dwcms=
hc: Add Eswin EIC7700
> >=20
> > On Fri, Sep 12, 2025 at 05:37:13PM +0800, hehuan1@eswincomputing.com wr=
ote:
> > > From: Huan He <hehuan1@eswincomputing.com>
> > >=20
> > > EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> > > Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> > >=20
> > > Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> > > ---
> > >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 81 +++++++++++++++++=
--
> > >  1 file changed, 75 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci=
=2Eyaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > index f882219a0a26..e0f34bc28e0c 100644
> > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > @@ -30,6 +30,7 @@ properties:
> > >            - sophgo,sg2002-dwcmshc
> > >            - sophgo,sg2042-dwcmshc
> > >            - thead,th1520-dwcmshc
> > > +          - eswin,eic7700-dwcmshc
> > > =20
> > >    reg:
> > >      maxItems: 1
> > > @@ -52,17 +53,51 @@ properties:
> > >      maxItems: 5
> > > =20
> > >    reset-names:
> > > -    items:
> > > -      - const: core
> > > -      - const: bus
> > > -      - const: axi
> > > -      - const: block
> > > -      - const: timer
> > > +    maxItems: 5
> > > =20
> > >    rockchip,txclk-tapnum:
> > >      description: Specify the number of delay for tx sampling.
> > >      $ref: /schemas/types.yaml#/definitions/uint8
> > > =20
> > > +  clock-output-names:
> > > +    maxItems: 1
> > > +    description:
> > > +      The name of the clock output representing the card clock,
> > > +      consumed by the PHY.
> >=20
> > You have one clock, why do you need this?
>=20
> Thank you for the feedback.=C2=A0I will remove it in the next version.
>=20
> >=20
> > > +
> > > +  '#clock-cells':
> > > +    enum: [0]
> >=20
> > const: 0
> >=20
> > > +    description:
> > > +      Specifies how many cells are used when referencing the
> > > +      exported clock from another node. This property indicates
> > > +      that the clock output has no extra parameters and represents
> > > +      the card clock.
> >=20
> > This description is not needed.
> >=20
> > > +
> > > +  eswin,hsp-sp-csr:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - description: Phandle to HSP(High-Speed Peripheral) device
> > > +      - description: Offset of the stability status register for
> > > +                     internal clock
> > > +      - description: Offset of the stability register for host
> > > +                     regulator voltage.
> > > +    description: |
> > > +      High-Speed Peripheral device needed to configure internal
> > > +      clocks, and the power.
> > > +
> > > +  eswin,syscrg-csr:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - description: Phandle to system CRG(System Clock and Reset
> > > +                     Generator) device
> > > +      - description: Offset of core clock control register
> > > +    description: |
> > > +      System Clock and Reset Generator device needed to configure
> > > +      core clock.
> >=20
> > This reeks of improper clock tree description. Why can you not just
> > request the rate that you need via the common clk framework? Likewise
> > for reset. You already have a clocks property that has to include the
> > core clock, so I don't see why you need another property to get around
> > it.
>=20
> Thank you for the feedback. You are absolutely right; We've taken your
> advice. In v3 of the patchset, we have completely removed the=C2=A0
> eswin,syscrg-csr=C2=A0property. The device tree binding now relies solely
> on the standard=C2=A0clocks=C2=A0and clock-names=C2=A0properties to acqui=
re the
> necessary clock.

Okay cool.

> > As a result, I'm also suspicious of your hsp-sp-csr, but these at least
> > appear to be internal clocks if your description is to be believed.
> > I'd like you to explain exactly what those clocks do and what the "HSP"
> > actually is. What other peripherals use it?
>=20
> Thank you for raising this. Your concerns regarding the hsp-sp-csr
> clocks are valid.
> The functionality and purpose of the HSP (hsp-sp-csr) were explained
> in our previous patch series for the USB module. The relevant
> discussion can be found here:
> https://lore.kernel.org/linux-usb/17731a13.1cce.19974dfc64d.Coremail.caoh=
ang@eswincomputing.com/
> Please let us know this explanation has addressed your doubts. We're
> happy to provide further details if needed.

I'll address this on the usb thread, thanks for the explanation there.

> > Also, your driver turns on this hsp clock but never turns it off. Same
> > for the power.
>=20
> The writes to hsp_int_status and hsp_pwr_ctrl are not enabling clocks
> or power rails.They are stability assertions.

Do you still need to "remove" the assertions if the driver is removed,
and the clocks get disabled? Or is that not a concern, because the
hardware can't do anything relevant without the driver loaded? If it;s
not a concern, then that seems okay to me.

> Assert clock stability: Write a value to the hsp_int_status register.
> This signals to the eMMC controller that platform clocks (axi master
> bus clock, internal core base clock, timer clock) are enabled and
> stable.
> Assert voltage stability: Write a value to hsp_pwr_ctrl. This signals
> that VDD is stable and permits transition to high-speed modes (e.g.,
> UHS-I).
>=20
> >=20
> > I want to see the full dts for what you're doing here before I approve
> > this, there's too much here that looks wrong.

Okay, that doesn't look too bad, with the updates you've made to remove
the sysrg-csr property.

>=20
> The full dts is as follows:=C2=A0
> sdhci_emmc: mmc@50450000 {
> =C2=A0 =C2=A0 compatible =3D "eswin,eic7700-dwcmshc";
> =C2=A0 =C2=A0 reg =3D <0x0 0x50450000 0x0 0x10000>;
> =C2=A0 =C2=A0 clocks =3D <&clock 264>, <&clock 546>;
> =C2=A0 =C2=A0 clock-names =3D "core", "bus";
> =C2=A0 =C2=A0 assigned-clocks =3D <&clock 264>;
> =C2=A0 =C2=A0 assigned-clock-rates =3D <200000000>;
> =C2=A0 =C2=A0 resets =3D <&reset 75>, <&reset 72>, <&reset 88>, <&reset 9=
2>;
> =C2=A0 =C2=A0 reset-names =3D "txrx", "phy", "bus", "axi";
> =C2=A0 =C2=A0 interrupt-parent =3D <&plic>;
> =C2=A0 =C2=A0 interrupts =3D <79>;
> =C2=A0 =C2=A0 bus-width =3D <8>;
> =C2=A0 =C2=A0 non-removable;
> =C2=A0 =C2=A0 mmc-hs400-1_8v;
> =C2=A0 =C2=A0 max-frequency =3D <200000000>;
> =C2=A0 =C2=A0 #size-cells =3D <2>;
> =C2=A0 =C2=A0 no-sdio;
> =C2=A0 =C2=A0 no-sd;
> =C2=A0 =C2=A0 eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x508 0x50c>;
> =C2=A0 =C2=A0 eswin,drive-impedance-ohms =3D <50>;
> };
>=20
> sdio: mmc@0x50460000{
> =C2=A0 =C2=A0 compatible =3D "eswin,eic7700-dwcmshc";
> =C2=A0 =C2=A0 reg =3D <0x0 0x50460000 0x0 0x10000>;
> =C2=A0 =C2=A0 clocks =3D <&clock 265>, <&clock 546>;
> =C2=A0 =C2=A0 clock-names =3D"core","bus";
> =C2=A0 =C2=A0 resets =3D <&reset 76>, <&reset 73>, <&reset 87>, <&reset 9=
1>;
> =C2=A0 =C2=A0 reset-names =3D "txrx","phy", "bus", "axi";
> =C2=A0 =C2=A0 interrupt-parent =3D <&plic>;
> =C2=A0 =C2=A0 interrupts =3D <81>;
> =C2=A0 =C2=A0 clock-frequency =3D <208000000>;
> =C2=A0 =C2=A0 max-frequency =3D <208000000>;
> =C2=A0 =C2=A0 #address-cells =3D <1>;
> =C2=A0 =C2=A0 #size-cells =3D <0>;
> =C2=A0 =C2=A0 bus-width =3D <4>;
> =C2=A0 =C2=A0 no-sdio;
> =C2=A0 =C2=A0 no-mmc;
> =C2=A0 =C2=A0 eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x608 0x60c>;
> =C2=A0 =C2=A0 eswin,drive-impedance-ohms =3D <33>;
> };
>=20
> >=20
> > > +
> > > +  drive-impedance-ohm:
> >=20
> > How come this one has no eswin prefix? Also, the unit is "Ohms", not
> > "Ohm".
>=20
> In version 3, we renamed the property from drive-impedance-ohm to
> eswin,drive-impedance-ohms.
>=20
> >=20
> > Additionally, any eswin properties should be restricted to eswin devices
> > only.
> >=20
> > > +    description: Specifies the drive impedance in Ohm.
> > > +    enum: [33, 40, 50, 66, 100]
> > > +
> > >  required:
> > >    - compatible
> > >    - regsdhci_eic7700_dt_parse_clk_phases
> > > @@ -110,6 +145,40 @@ allOf:
> > >              - const: block
> > >              - const: timer
> > > =20
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
> > > +            - const: arstn
> > > +            - const: phy_rst
> > > +            - const: prstn
> > > +            - const: txrx_rst
> >=20
> > How come you're so drastically different to the other devices?
> > Also, putting "_rst" in a reset name is pointless. These are all resets
> > after all by nature.sdhci_eic7700_dt_parse_clk_phases
>=20
> We have simplified the names as follows:
> reset-names:
> =C2=A0 items:
> =C2=A0 =C2=A0 - const: axi
> =C2=A0 =C2=A0 - const: phy
> =C2=A0 =C2=A0 - const: bus
> =C2=A0 =C2=A0 - const: txrx
> Regarding the functionality of these resets:
> prst and arst: correspond to the resets for the bus and AXI domains.
> txrx: is used for the reset of the internal transmit and receive clock
> domains.
> phy: is used for the reset of the internal PHY.
> This will be corrected in the next patch. Is this correct?

I don't know if it is correct or not, but it looks better than before.
Can you explain why you aren't using the "normal" 5 resets that other
devices do?

--V6cj8PXmL5zES4xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNRJ0gAKCRB4tDGHoIJi
0k1UAP9e3TiD0Nl0I8BcmGnki3k7pltR5alB/B0PxAW5pp6o1QEAnr7muT+6843N
c3oUTeRpcCgWHtJ+SI4nCGmuBbpG7gA=
=FT3q
-----END PGP SIGNATURE-----

--V6cj8PXmL5zES4xt--
