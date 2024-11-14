Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A11A9B5D;
	Thu, 14 Nov 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614528; cv=none; b=oayHyQrF58mfZpJ0Mr8+JR2jreTtVzhUzNSj4STFY1V1gOLyFeWtF0CC5QWssMgbdIMy3cwvN9r4ZvCELqYn5QX+9FyniymhzZpIC9RRWy4Sk9EV2dwstP9emYiDW4h3ZLjS2xdReoE10b6mzRCIi1dNxrHpnW9cPqJcc1E91tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614528; c=relaxed/simple;
	bh=auoc4ZrJwWyRGVgjJ91XJHLkDL0xnsczcr/Vf5AaaFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjADE2hAFQweUsc03hwhheg1ckvcvGV6ViIKmUhOpup6w7TP4TLhZ5ftRbY5E60oDXnTY3ZrMJKoH44a0XIFyhPiigsx3cI+gEZ6OQ0wxPT2Co6lTBxSzOEWFyw5W6uP2egRz/sFpJVuW6mb69f9m08hdcxeqGOamCkUjSWWJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XagZEoLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XagZEoLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB900C4CECD;
	Thu, 14 Nov 2024 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614527;
	bh=auoc4ZrJwWyRGVgjJ91XJHLkDL0xnsczcr/Vf5AaaFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XagZEoLDsNmIBMmoDdK3s1W6rRQ5uVK11EF+XlMFPDM8vAHvBj6oHcBFJfCaHurO/
	 ZxA+s0/WAusFGdNjCLRi6dqJC/D0x0vC9yD64by03zIdmRmzG5E840vw5gRTuq5Ki4
	 ISMaPwBt54o7i4J3Mfz1mRLCmEwm2Uu9HWs8162lpgB3LVzDRSjFeIWt9oKgcEKj9X
	 rg0JHMm/PI53HxGzQz38PQbBxAJFzk3AKKkkS1lmXwawBvusi7WIbVtMsMGTll7fjw
	 jxdtOVkYh50JVKZc0jz/uvoivoAFoXZ4nBc/wLhKkjmnwfQ52ahewahuqbluvrvEmK
	 JcJ3qxUwhm9sA==
Date: Thu, 14 Nov 2024 20:02:03 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: marvell,xenon-sdhci: Simplify Armada
 3700 if/then schema
Message-ID: <20241114-recopy-statue-06319ae02aae@spud>
References: <20241113225602.1782573-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5qukpDwkUqs8Ipkr"
Content-Disposition: inline
In-Reply-To: <20241113225602.1782573-1-robh@kernel.org>


--5qukpDwkUqs8Ipkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:56:01PM -0600, Rob Herring (Arm) wrote:
> Properties are supposed to be defined in the top-level schema and then
> disallowed in an if/then schema if necessary. Move the "marvell,pad-type"
> property to follow this.
>=20
> "reg" can also be similarly described at the top-level with only the
> number of entries restricted in the if/then schema.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5qukpDwkUqs8Ipkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZXOwAKCRB4tDGHoIJi
0jghAQCT63EB2JH4sM7pk08Nhs7YzXDJ8cKqhP2Lv9527Dd4wwD/TA2e+uEgoFMU
S1tJgEGnDVpCz5YrwaP8NIk5YRX7vAM=
=cIzo
-----END PGP SIGNATURE-----

--5qukpDwkUqs8Ipkr--
