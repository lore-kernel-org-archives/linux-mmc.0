Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C88468;
	Mon, 11 Nov 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357332; cv=none; b=DFDcrbc2moFDu23Hks6zckeIZz6afI0dXM7Dkb0FXtnfGvZ5Hhav9nJ6xHPp4j9Ks/A879SqIqOXtb91nk8H7ipXBgxyMCms73ps/DfxM5dM6qXwmARGL52zToPVwQx0nGx/WfZtTnnwgMcmwd9/GyABXDFgOPqY+zQeOnVBLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357332; c=relaxed/simple;
	bh=SJUgRBJXeIpWfWL2A4lNrZPzQEHHoj5ONqPuy+LPT+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+CLCrH99CbNMZY/PDwYM1xtcjIc4ocY+ABTO0Pi1pUYJXpb+vJoJ7438tsswNXBm18omOLRuSJUoiCVNkJsP7xGCSSSpJDSiMHdOR4uIoU4RAnqhZkwtXCnoMUK0862FczrWb2/z7QmtkZmcmtvg//0729japIxzhGnlFeMoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndAD+MHf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndAD+MHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA2C4CECF;
	Mon, 11 Nov 2024 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357332;
	bh=SJUgRBJXeIpWfWL2A4lNrZPzQEHHoj5ONqPuy+LPT+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndAD+MHfRHSBbSaHozkXBdf6jY7I3VmQYwnQ9Bn5xXa225IXvEFASbd+rbiNMSOXn
	 GtZiESzjmpXWGAZcdHnwWDCI0GHXIaEWrxdVB/CsXwDZSmi1pxNElsF3CQ/MX+l1/c
	 3F+d/QeC6Q3tJ1nnYbDvCV5qx23sN/NSwjyT/SfB+gb6kTl/EMWoXYGrkBQa33fOIz
	 5y+MUihepVu1V+YIssK8efiVws9X+LlEfkQbl8JFWx2CxX2zR2/6jXWzAsLRnt56iM
	 ZctfPOOSwNh+Hl+CC8JiYrJpcC09di75QC7vIgkJbxfV1ccHExI1RFw4Z15X+7Nqea
	 DcX01mW8LZKtA==
Date: Mon, 11 Nov 2024 20:35:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: mmc: sunxi: add compatible strings
 for Allwinner A523
Message-ID: <20241111-enviable-caucasian-0bde133c7ddf@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P2tUd8xoLv9YzkgD"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-3-andre.przywara@arm.com>


--P2tUd8xoLv9YzkgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:21AM +0000, Andre Przywara wrote:
> The Allwinner A523 uses the same MMC IP as the D1.
>=20
> Introduce the new specific compatible strings, and use them with
> fallbacks to the D1 strings.
>=20
> Also it turned out that the A100 is not compatible to the H616, instead
> it is the same as the D1. For compatibility we cannot change the fallback
> chain, but any drivers are from now on supposed to match on the H616
> string directly. Mark this fallback chain as deprecated, to avoid new
> users to be added.

tbh, I think this should be split out into a fix commit of its own.

Split,
Acked-by: Conor Dooley <conor.dooley@microchip.com>



--P2tUd8xoLv9YzkgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJqjwAKCRB4tDGHoIJi
0hyMAP9ZGAHS/FCK9zdjUAX2svq725gONsDtrgBRvMElf9rRlwEA+fVjQ2wgl5wW
kbFO0vy7b481xik4eOPVjVc/KhxN6gw=
=V6hC
-----END PGP SIGNATURE-----

--P2tUd8xoLv9YzkgD--
