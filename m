Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37041EB1A7;
	Fri,  7 Feb 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944200; cv=none; b=SZd6v0vN0PBCgN7enmY5tOyI6OxIC7KpU/lKh5TJGElbXc4Mj4WQlH1BVh1hdcg8Q9zOo8vQWIAtebFjisnlFOncHFkpGDr+bAXvgSD1tICLMypGuQr6VuyqRQdcX/Ib6NG9gX347jSyRprZ0rYn7IVdNQBMpf8lFfMOKtb1JyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944200; c=relaxed/simple;
	bh=OZqExQTgpVnAcofXSl/4YJt3huOhFICvFo1TvD+B5MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0cHaspm/JfC+OTbrhVcvWeNX18xH5YL0Me4RElRSeWPVmBZBS6dnX08Sl69/1MdJWjIly1JuaFBFHDVp2mmZrqj9nOpUaiYknZgXHMTuzMlpbJXMsqTIBQda6sC+1nV8PQvLxvfBn5HHzuV7iu9HjwylXiAjdShQw5pL4sC+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCc+goyw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCc+goyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C931CC4CED1;
	Fri,  7 Feb 2025 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738944199;
	bh=OZqExQTgpVnAcofXSl/4YJt3huOhFICvFo1TvD+B5MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCc+goyw6gWdvp1Fsdw0g39SFhKTacSn3FidfRixezuSDjWxq/NjnMkQeAkCo3tEK
	 QY5ha3hGNWuf8c05mPnoACbSSwhk9Wv1MocEhcAkL7X0G4KEL4yrQC05D5I66LTrYZ
	 Yjh3HHNmjzmDngt9fTeZQITzVQZP2K+qpV8twbkTgWCh4jYP20FLf1ZLhFzcZJ0JEF
	 4qmVOHbLszGngwpHWMTncxaouw1Beqru1sthhh0T6Kh+DrUKsEbUivPcPA3S4wY8Vm
	 iBRfwPwSTmVrxJfRg5co9gh6AtyTxOYSLTMPJmBZsBniauB9pMt+EZBpHdh8zjNLxs
	 GNd5+DeGkrv3Q==
Date: Fri, 7 Feb 2025 16:03:14 +0000
From: Conor Dooley <conor@kernel.org>
To: neil.armstrong@linaro.org
Cc: Dharma.B@microchip.com, ulf.hansson@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Message-ID: <20250207-cheating-winking-1dace55a4341@spud>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
 <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
 <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pz7qrlCazOFTDsBh"
Content-Disposition: inline
In-Reply-To: <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>


--pz7qrlCazOFTDsBh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 10:17:29AM +0100, neil.armstrong@linaro.org wrote:
> On 07/02/2025 10:02, Dharma.B@microchip.com wrote:
> > On 07/02/25 2:25 pm, Neil Armstrong wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >=20
> > > On 05/02/2025 04:48, Dharma Balasubiramani wrote:
> > > > Remove the compatible property from the list of required properties=
 and
> > > > mark it as optional.
> > > >=20
> > > > Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> > > > ---
> > > > Changes in v2:
> > > > - Instead of moving the compatible string to the other binding, just
> > > > make it
> > > >  =C2=A0=C2=A0 optional (remove from required list).
> > > > - Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-
> > > > dfc747a3d3fb@microchip.com
> > > > ---
> > > >  =C2=A0 Documentation/devicetree/bindings/mmc/mmc-slot.yaml | 1 -
> > > >  =C2=A0 1 file changed, 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/
> > > > Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> > > > index 1f0667828063..ca3d0114bfc6 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> > > > @@ -29,7 +29,6 @@ properties:
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > >=20
> > > >  =C2=A0 required:
> > > > -=C2=A0 - compatible
> > > >  =C2=A0=C2=A0=C2=A0 - reg
> > >=20
> > > If you remove it from here then it's still required in Documentation/
> > > devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> > > so please add it.
> >=20
> > If moving the compatible to its specific binding isn't appropriate (as
> > per Conor),
> > and if removing it from the required list here doesn=E2=80=99t seem rea=
sonable
> > to you,
> > then adding an unnecessary compatible string in our DTS files doesn=E2=
=80=99t
> > make sense to me.
> >=20
> > What could be the solution then?
>=20
> The solution is right but you modify the meson-mx-sdio bindings, so
> simply add compatible in a required list for the slot node.
>=20
> Something like:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.=
yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> index 022682a977c6..0d4d9ca6a8d9 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> @@ -60,6 +60,9 @@ patternProperties:
>        bus-width:
>          enum: [1, 4]
>=20
> +    required:
> +      - compatible
> +
>      unevaluatedProperties: false
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Conor, Is it right ?

Looks about right, ye.

--pz7qrlCazOFTDsBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6YupQAKCRB4tDGHoIJi
0lR7AQDXPOIB/dOY3/s7IOG1B+gKdzycmLoO1kXUzVZl9O+qDgEAvw94V1PMPp2c
Ws95nHufVdgDH1bM8gATFJfYPq295wM=
=tzxl
-----END PGP SIGNATURE-----

--pz7qrlCazOFTDsBh--
