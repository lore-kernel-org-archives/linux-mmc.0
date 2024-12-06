Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0A20628B;
	Fri,  6 Dec 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504574; cv=none; b=EmRLG5VhvgeUBQlANG4XPV1MMqDKBkRGbY8jn+Lhr5R9DenVZjo+09HMIihwErmPbJ/WBfxHhU3T9tUzmcqQW3XyABBBTR22NQ7piwk3KrubAG940ghnfy5CUwHfNFapQB6Kj6bZcaq3IPzzpgg7r1Yk0+pDYQr3u7ikzGINmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504574; c=relaxed/simple;
	bh=49stkS5Jr0gbDKUcViWSMu1jZ0Ttci8yCgTnQYqEciE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvvkXfVK1Bp451Ib4hBab9tqtKMNLddrMr9qkvzSOLMdBtJMZ4+gtkzmpXbmHKPBWwfSq/1/JfcLTOWTeWxGO0G4EYkKJC5pOTkCkYZL5JJDf5QjqRNw7Kqgm0JkEo1YkgxK2OHjIsKyVykIobb8kGDjTjw29VQU0zad+IQccZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s95Pvg4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s95Pvg4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583CFC4CED1;
	Fri,  6 Dec 2024 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504573;
	bh=49stkS5Jr0gbDKUcViWSMu1jZ0Ttci8yCgTnQYqEciE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s95Pvg4hT1qOEsnoGUyCjcqlT8rFHJIecyBajPwtIJlikGvE804slOA25zRrwqQb0
	 tXt/X2XMt7XZ0YyBh96/pm95OBro70p9Cfee6m6LJivURqrimVPxtAvBgxdQXado9Z
	 6zZ42DBbu02ElICCwhfXUmmdipv/2TVTB2I79Nyr8Gzf7OKs+0INQywoi4jItZMw//
	 K/jov+IKTkQ7iPRQOOh7foyMJnRfOfR6H7J7kK9wP3zTjJm5RfY7LxrqCTK9/4Z50k
	 4G8I+vfuhjHp2Q3eHO8SGlv2eX0gNVubg9BY/hFCCzjVXpwiDPQDdFuR+p36VGdRR/
	 NSvZVwSc+0zCA==
Date: Fri, 6 Dec 2024 17:02:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	Aubin.Constans@microchip.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Message-ID: <20241206-untoasted-ripening-83ecf98bc42f@spud>
References: <20241205-hsmci-v1-1-5a25e622dfed@microchip.com>
 <20241205-trickster-rebate-d5e64bc29992@spud>
 <4e3a4154-9e05-40b4-961f-6d7e95ec0890@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ScKT+5iAjDgPbCZa"
Content-Disposition: inline
In-Reply-To: <4e3a4154-9e05-40b4-961f-6d7e95ec0890@microchip.com>


--ScKT+5iAjDgPbCZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 05:16:39AM +0000, Dharma.B@microchip.com wrote:
> Hi Conor,
>=20
> On 05/12/24 11:15 pm, Conor Dooley wrote:
> > On Thu, Dec 05, 2024 at 03:27:02PM +0530, Dharma Balasubiramani wrote:
> >=20
> >> +patternProperties:
> >> +  "^slot@[0-9]+$":
> >> +    type: object
> >> +    description: A slot node representing an MMC, SD, or SDIO slot.
> >> +
> >> +    allOf:
> >> +      - $ref: mmc-controller.yaml
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: Slot ID.
> >> +        minimum: 0
> >> +
> >> +      bus-width:
> >> +        description: Number of data lines connected to the controller.
> >> +        enum: [1, 4, 8]
> >> +
> >> +      cd-gpios:
> >> +        description: GPIO used for card detection.
> >> +
> >> +      cd-inverted:
> >> +        type: boolean
> > This type conflicts with mmc-controller.yaml, it's a flag there.
>=20
> Yes, I overlooked it. I'll simply remove the type here.
>=20
> >=20
> >> +        description: Inverts the value of the card detection GPIO.
> >> +
> >> +      wp-gpios:
> >> +        description: GPIO used for write protection.
> >> +
> >> +    required:
> >> +      - reg
> >> +      - bus-width
> >> +
> >> +    unevaluatedProperties: false
> > Do you mean additionalProperties: false here? You listed properties
> > contained in mmc-controller.yaml which makes it seem like you're
> > restricting to this subset rather than allowing all properties - but you
> > need additionalProperties: false to do that.
>=20
> No, I'm not restricting the properties to this subset. There are=20
> additional properties, such as "non-removable," "broken-cd," and=20
> "disable-wp," that are used in our DTS files but are not defined in the=
=20
> old text bindings. For this reason, I used `unevaluatedProperties:=20
> false` instead of `additionalProperties: false`.

> Let me know if an=20
> `allOf` reference to `mmc-controller` alone would be sufficient in this=
=20
> context.

Yes, there's no point duplicating properties from there, unless you're
restricting to a subset. I think all you need to keep (other than the
reference) is the required properties list because there seems to be
none in mmc-controller.yaml.

--ScKT+5iAjDgPbCZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MuOQAKCRB4tDGHoIJi
0puPAQDGnZ7QeA/JWBnu9hKRBgcjCLFYUU/RfTgFGpqBBbr0rwEAlDSML8gQFQC2
16Y1lIsu3uODoMdJwSPiOmNE7oFsdAY=
=XVJL
-----END PGP SIGNATURE-----

--ScKT+5iAjDgPbCZa--
