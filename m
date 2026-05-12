Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867A306B11;
	Tue, 12 May 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607199; cv=none; b=GP/nDJSh5z12FG9oxavUC1VXX9Zq3OOmVV3dm0/Lik/gXQAGoFwjL3y/0qL4+lfTISiBg79LRdlSnHktIyv/61jAMlOWDLr1UcthYvsbYJv99roQHcpgEMnkBpYRtruyNWopzmz2YSley17WuPoHr8pd/R3loB2bHbeDFDjgXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607199; c=relaxed/simple;
	bh=NER/n3PylgoZy4QHupluAU3Two6S7mgE/ZuS3413C7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6S1Op/Fotobm31+WnRWu+dwAspiFUFyjQF9ODgVD0bqscICmsWnGUWKqAYBHbV55LlKyAvwjpzKmpSCAdafw9zPqwqU0Uxh6p7tkyJ00I6GRxWZVY7OfsLniGTts6pclfZqTPvfmNLMdZLp8pdIIM9wq5U2KNlrhf9L4M0HCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX9eoZW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX9eoZW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECA4C2BCB0;
	Tue, 12 May 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778607198;
	bh=NER/n3PylgoZy4QHupluAU3Two6S7mgE/ZuS3413C7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aX9eoZW86j6HbaYO6tX7ajRb95wkTofrrre76EkSI3grnIFYp1LJv++7ffzJr0RMX
	 NifNBx36VYY94QEiCRmMoZtvE7m0UdZCfRh3GilokAIvScTcSuhK79A3d9sU+JfFjy
	 h5wkbai3mVgQvEipIbFAA7LDXoBwf7FQzxCk8PifZAU3gGAgg+tGnxL13PAfygjo1h
	 A2eLIUlDNHFDbh2ByspxmAX/pGdr3yc1wjxFCYjkqLSULQMJ8Dw7NCZ/D23o9Drkdh
	 wYFuZjOZP+XZn0q81eOGRqrBuv2fahjK8bZLRyPiT953V2uqAASdqACfoW4OviGwwF
	 yw5edoN/r1wyg==
Date: Tue, 12 May 2026 18:33:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] dt-bindings: mmc: cdns,sdhci: add SD6HC support
 and PHY properties
Message-ID: <20260512-clamor-matchbook-976861571cd3@spud>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-3-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tJQ64ioGOph7YH8"
Content-Disposition: inline
In-Reply-To: <20260511202132.5597-3-tanmay.kathpalia@altera.com>


--3tJQ64ioGOph7YH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 01:21:24PM -0700, Tanmay Kathpalia wrote:
> Extend the Cadence SDHCI binding to support the sixth-generation
> SD6HC controller. Add the cdns,sd6hc and altr,agilex5-sd6hc
> compatible strings, clock-names, reset-names, iommus and three
> SD6HC-specific PHY timing properties.
>=20
> Add per-variant conditional blocks so SD6HC and SD4HC each enforce
> their own clock, reset, and PHY property constraints independently.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3tJQ64ioGOph7YH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNkWgAKCRB4tDGHoIJi
0lR+AP0Z1pFrE/vKNsWkstmTycUCNeIAU2Wd4tQXuY4idCDqOQEA+P0bQjRvvgMP
v139Qp+f2KqImLbMX7sKsPakY8akXwU=
=uilU
-----END PGP SIGNATURE-----

--3tJQ64ioGOph7YH8--
