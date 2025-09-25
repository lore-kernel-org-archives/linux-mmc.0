Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55A1DF27D;
	Thu, 25 Sep 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828762; cv=none; b=eoEsDZ4pwWGiWYudfgtNg0Tk9LXLnV1RPlU9mIr8BhYOnPRRdLyu7YcsVsOsI1zSpbIp/mWbD1YZNSxsV4NP9NtG9h2SMTsfcug090pDvtun56HyHD6mKGQkIXiaGOQuz0GNPFCQu6CWzy51wjQ2o8c5xnOkAo/7JsGmKiY3ofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828762; c=relaxed/simple;
	bh=Q7zBrhkXL+QEFEwSrEBMPAMPNdfhwRLoImRblFYfg/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9IWwm4UrfU14LMM5S6OtKiU8PgM0POGk2XXAW/g8+ackQAAHyKQF7dmxqRfIkNE6xB4gW4LNn0Meav4N4KyKL2E0ufZlnO1fwcJ6Aa23f5Jpr10Too2uKp1sVJeAnHG0A329N+nmX8vCKK75OrdvHrdEGEsu/LdgJPteTArLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD4UESJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD4UESJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D24C4CEF0;
	Thu, 25 Sep 2025 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828761;
	bh=Q7zBrhkXL+QEFEwSrEBMPAMPNdfhwRLoImRblFYfg/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KD4UESJ+/d5OSgRCVG1EGR+DXMCKgVjDgZWvk9JK8gptv9FbN7TIfS0qbCFvNx1a5
	 FC5UhMvt4QCPz0f3v1agezp//gZUI30XLiXuzJSemOehNWFCSGP9mWw2X1n2NUcZ09
	 kji4fjuJyQrmnGLByzDakZrBU7Dl4+IGzkFLKk6D26xLDfphmYvW72H6PHyX7QKI0p
	 v+2Klz4AsuiastgKCGypqyOqgSOvmVuMbPlix7jUziROeV3hdzodfxMay6SMkmYr0g
	 fd+61eNjs0hVyKO/THAB1yCSret4M0t1L+X8PEx6ygkSazgSfs1bePzyWcHxXz+mHp
	 JASXtUtZRH0NA==
Date: Thu, 25 Sep 2025 20:32:35 +0100
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
Subject: Re: Re: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add
 Eswin EIC7700
Message-ID: <20250925-await-rotting-fe5d368bc2fd@spud>
References: <20250912093451.125-1-hehuan1@eswincomputing.com>
 <20250912093713.142-1-hehuan1@eswincomputing.com>
 <20250912-pork-oaf-3480d3d0ef67@spud>
 <674372d7.16fd.199751b489c.Coremail.hehuan1@eswincomputing.com>
 <20250924-visiting-sasquatch-c58f782ff686@spud>
 <7e07388c.187f.199803c99cf.Coremail.hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kuwu3IZdfqn/2FGR"
Content-Disposition: inline
In-Reply-To: <7e07388c.187f.199803c99cf.Coremail.hehuan1@eswincomputing.com>


--Kuwu3IZdfqn/2FGR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 05:37:59PM +0800, =E4=BD=95=E6=AC=A2 wrote:
> Dear Conor,
> Thank you for your valuable and professional suggestions.
> Please find our explanations embedded below your comments in the
> original email.

FWIW, there's no need to thank me on every mail!
> > > > As a result, I'm also suspicious of your hsp-sp-csr, but these at l=
east
> > > > appear to be internal clocks if your description is to be believed.
> > > > I'd like you to explain exactly what those clocks do and what the "=
HSP"
> > > > actually is. What other peripherals use it?
> > >=20
> > > Thank you for raising this. Your concerns regarding the hsp-sp-csr
> > > clocks are valid.
> > > The functionality and purpose of the HSP (hsp-sp-csr) were explained
> > > in our previous patch series for the USB module. The relevant
> > > discussion can be found here:
> > > https://lore.kernel.org/linux-usb/17731a13.1cce.19974dfc64d.Coremail.=
caohang@eswincomputing.com/
> > > Please let us know this explanation has addressed your doubts. We're
> > > happy to provide further details if needed.
> >=20
> > I'll address this on the usb thread, thanks for the explanation there.
> >=20
> > > > Also, your driver turns on this hsp clock but never turns it off. S=
ame
> > > > for the power.
> > >=20
> > > The writes to hsp_int_status and hsp_pwr_ctrl are not enabling clocks
> > > or power rails.They are stability assertions.
> >=20
> > Do you still need to "remove" the assertions if the driver is removed,
> > and the clocks get disabled? Or is that not a concern, because the
> > hardware can't do anything relevant without the driver loaded? If it;s
> > not a concern, then that seems okay to me.
>=20
> The writes to hsp_int_status and hsp_pwr_ctrl are just status indicators.
> They assert that clocks and voltages are stable. There is no need to clear
> these assertions when the driver is removed or clocks are disabled. This
> is because the hardware cannot perform any relevant operations without the
> driver loaded. Whether these registers are written or not has no impact on
> hardware behavior when the clocks are off.

Okay, cool. That sounds fine to me.

> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: eswin,eic7700-dwcmshc
> > > > > +    then:
> > > > > +      properties:
> > > > > +        resets:
> > > > > +          minItems: 4
> > > > > +          maxItems: 4
> > > > > +        reset-names:
> > > > > +          items:
> > > > > +            - const: arstn
> > > > > +            - const: phy_rst
> > > > > +            - const: prstn
> > > > > +            - const: txrx_rst
> > > >=20
> > > > How come you're so drastically different to the other devices?
> > > > Also, putting "_rst" in a reset name is pointless. These are all re=
sets
> > > > after all by nature.sdhci_eic7700_dt_parse_clk_phases
> > >=20
> > > We have simplified the names as follows:
> > > reset-names:
> > > =C2=A0 items:
> > > =C2=A0 =C2=A0 - const: axi
> > > =C2=A0 =C2=A0 - const: phy
> > > =C2=A0 =C2=A0 - const: bus
> > > =C2=A0 =C2=A0 - const: txrx
> > > Regarding the functionality of these resets:
> > > prst and arst: correspond to the resets for the bus and AXI domains.
> > > txrx: is used for the reset of the internal transmit and receive clock
> > > domains.
> > > phy: is used for the reset of the internal PHY.
> > > This will be corrected in the next patch. Is this correct?
> >=20
> > I don't know if it is correct or not, but it looks better than before.
> > Can you explain why you aren't using the "normal" 5 resets that other
> > devices do?
>=20
> Our reset naming is based on our hardware's reset design. Although we do
> not follow the typical 5-reset naming used by other vendors, the
> functionality is equivalent. Each of our resets covers the corresponding
> hardware domains. There is no one-to-one correspondence, but our
> implementation includes all necessary reset functionality.

Okay. It's just unusual that you have something significantly different
to what the other 10+ devices have. It's fine to be different if your
hardware genuinely is not the same.

--Kuwu3IZdfqn/2FGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWY0wAKCRB4tDGHoIJi
0h8KAP45iWm75QmtNcSKgVbZiDWVgmRSvDiADiSbvBTty0+RGgD+N8ETSimrVEn4
UMnPO87K8SCzSSn7LfGyL/myiqJmDw8=
=z2EA
-----END PGP SIGNATURE-----

--Kuwu3IZdfqn/2FGR--
