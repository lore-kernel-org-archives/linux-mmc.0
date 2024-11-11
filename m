Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090408468;
	Mon, 11 Nov 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357250; cv=none; b=WLl34ZWQt5xff14HNoOmKFasuIeA93UE/ng0tMbmRxL5Yb/JtRGOD+Zdw0SyQ4IYV5z2Bp2/sFFnHgCevE7HtN3pbkApFp2RvMKu7T7x33o9YOnKv5x7wuxqaCMjBLvgJc7lPkzReKKILfdDiv8LDt+9XGW3FJdVdwatqOYpYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357250; c=relaxed/simple;
	bh=yNH9MUi4qYgXiGu/EuVAhoPFWjEADM5lRSlyLucnBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI6lY5VLf/PVRbsLttxRWUbadw1mJMssqs0/h0kJfJ04VHFZhYHIB2qXICzLcv4FPkHLsBnvIsn9NiLgm8MWlMv0ieArHcr521DW1EL5HH1b4VVxob+EXU1cG2qyE3z5DHzNDyDuhbYaog2dptyohaEpTyFjmvUP3tDyKQDA+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgHTjlKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgHTjlKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A5C4CECF;
	Mon, 11 Nov 2024 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357249;
	bh=yNH9MUi4qYgXiGu/EuVAhoPFWjEADM5lRSlyLucnBBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgHTjlKkpDILfn6UqnjXHrvQrZG9RGKG+PLoaoe+90n2yszscZLzFgFmYzVzIRCAx
	 hqgDGpr98WHnW0Id6TFC7P5UV6lxofchF/Fi4/vRe/GJKESFAJDY5DsxR+hmgvCoSz
	 i4+dX8wXHpN/QZPlGQKMpL//1N5waBK/hAIr4wV+IC30y1jLEd5NDVIE+HO5MszH3I
	 CnGE4+AfsdxyXiEMFIpLRWParG7x6nQeFZCHfnb7Lr5FwSHGyqfcuexgB9mzlzff+S
	 chL3IZg2Bai4X5RUBYF/qCPvIM0zO6AFk1fm04JLjEtPKRGCxur06awrwSSKryWf8c
	 6LH6eMO6jHyUg==
Date: Mon, 11 Nov 2024 20:34:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 01/14] dt-bindings: mmc: sunxi: Simplify compatible
 string listing
Message-ID: <20241111-backyard-trilogy-689351a7b7c8@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bi9CJ9Ktd17cmVcT"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-2-andre.przywara@arm.com>


--bi9CJ9Ktd17cmVcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:20AM +0000, Andre Przywara wrote:
> New Allwinner SoCs only occasionally update their MMC IP, leading to many
> pairs of compatible strings, though there are sometimes a number of them
> being compatible with one particular SoC.
>=20
> Collate the compatible string listing in the binding, to group those
> being compatible together. This makes the list more readable, and allows
> for easier addition of new SoC's MMC devices.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--bi9CJ9Ktd17cmVcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJqPAAKCRB4tDGHoIJi
0iHXAP9EcNoCqzLUGX5OQORzuun1EQHRd1pLIuOGCnT6MOyAEQD/Vg47EKqZS8A6
ACsoCxmUuDqebYVmgDM0dEE7bBKowgM=
=xb+W
-----END PGP SIGNATURE-----

--bi9CJ9Ktd17cmVcT--
