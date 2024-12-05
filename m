Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE7218E98;
	Thu,  5 Dec 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420757; cv=none; b=gy218RT0SD9mnwGEr7jMN3QcXulCw34djWS8P0nKZI89urePx2PjZxKsRdqbrItqnOqY/iIV2gJDdyfI6TBzuKHsEXzVeYUSx1Lok0VoUuHqr2efyJ/f0S8wzErN9057ErLTK564VOMV6KWzOtfcvd0Vb6E5TxGrC4g35f/o6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420757; c=relaxed/simple;
	bh=nGiGDxSwpX5NzSRcfmeq622cRq3f8dYXZA6kZrnrbhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBsR1BbwPBYxWa3RagcSwE+mQQjhBomAYDx9U8zmJmSXYo/6waPkt0WZPnwbgndslaXYiibIoBUZ3i6Ri8QsiW2FMPF4kUfbZW3NyTbrYKqOtjaSY4FwqJ+Z1TBNf4N2DxijWtdJdAeyz2RnEaQF9rhZpervamQ+RKKGjxWIft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ratMgJlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ratMgJlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B403C4CED1;
	Thu,  5 Dec 2024 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733420756;
	bh=nGiGDxSwpX5NzSRcfmeq622cRq3f8dYXZA6kZrnrbhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ratMgJlhiLrVN4gLH4jqRX6FLHacP6HUeCoyVzobNhZrk+Tmwu+W5TTshdmFwm2TC
	 ha1i/hpxidOgqtCCFgUJCgsUxF3+ZKqZTl8eyA8C4NbZO9+nStt4GJjYfTxJrmusUT
	 L3mb1vSqbFm4miSRUXGUhxyay4C6ig20Jn7kZAN7KGK6YqKifAXxMHn0j2mcjx7o8T
	 ljfmhcZ4oMiNP/BqChgJwp+t0xDB9uwPR+c90iT9dP2O9GsFWboZYWovb4dohMe6G7
	 T9/34pWNuRYQlEOFrlurSc1mgqbdmOQyVmIlZ/OnN8OtZF17YsXnpk+Ht+LEQ/8BYt
	 4vc3JBlPTfkqg==
Date: Thu, 5 Dec 2024 17:45:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Message-ID: <20241205-trickster-rebate-d5e64bc29992@spud>
References: <20241205-hsmci-v1-1-5a25e622dfed@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a1zPdUEOUiPmOEQF"
Content-Disposition: inline
In-Reply-To: <20241205-hsmci-v1-1-5a25e622dfed@microchip.com>


--a1zPdUEOUiPmOEQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2024 at 03:27:02PM +0530, Dharma Balasubiramani wrote:

> +patternProperties:
> +  "^slot@[0-9]+$":
> +    type: object
> +    description: A slot node representing an MMC, SD, or SDIO slot.
> +
> +    allOf:
> +      - $ref: mmc-controller.yaml
> +
> +    properties:
> +      reg:
> +        description: Slot ID.
> +        minimum: 0
> +
> +      bus-width:
> +        description: Number of data lines connected to the controller.
> +        enum: [1, 4, 8]
> +
> +      cd-gpios:
> +        description: GPIO used for card detection.
> +
> +      cd-inverted:
> +        type: boolean

This type conflicts with mmc-controller.yaml, it's a flag there.

> +        description: Inverts the value of the card detection GPIO.
> +
> +      wp-gpios:
> +        description: GPIO used for write protection.
> +
> +    required:
> +      - reg
> +      - bus-width
> +
> +    unevaluatedProperties: false

Do you mean additionalProperties: false here? You listed properties
contained in mmc-controller.yaml which makes it seem like you're
restricting to this subset rather than allowing all properties - but you
need additionalProperties: false to do that.

--a1zPdUEOUiPmOEQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HmzwAKCRB4tDGHoIJi
0mIMAPwKQdE3NtmqK62QK0fY/gffw/1Vv38EcC2tMQW4KwioowD/SFG716kAPybn
xXpMRahY+A5Yq84OK3/ptAMO/gvGOg0=
=1UUd
-----END PGP SIGNATURE-----

--a1zPdUEOUiPmOEQF--
