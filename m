Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C42E2EF1;
	Wed, 22 Oct 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155887; cv=none; b=UAHANhH7yYxJDK5NCAiOqafb1oFhbPClk2A3g4JvWkAdmYWwRlTWPBVtR+XLevlsyPVjC8GPURUKGr59+5juWNJLMR5EyP205+79Y8ZTbF/zl8E557RgFyEd4v6DDerbaRCixxYIhrUM5/3fOaYmE9cRGEA1FhcNyppvQBXGyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155887; c=relaxed/simple;
	bh=jr9JB+acUWFLl0PRQSeU+Vdvre5khnKT1FDyCMV0CLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK0/Zfzzcy47HEh4WMOnAQi1zL4P0D/WhEfeW/2aPD2tDhcW3NpT8WwiIVAy6gD55yMJ4F0XGEncDSnp9kvF0iB+PWDPx/XRXL9Yrt2LwUkQmunmFZOEN2D0+6wTYljukKFyiCeh29MtObt/5uwkbOMXfisfdWJECuAYczDi6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7h2pCjU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7h2pCjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23184C4CEE7;
	Wed, 22 Oct 2025 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155887;
	bh=jr9JB+acUWFLl0PRQSeU+Vdvre5khnKT1FDyCMV0CLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7h2pCjUS3QZ8ZD5neVd3YErybx5CULzDQ9huY8d1OH4XKhvNP3nHfVBpAAh9/oax
	 +4/gpP0B+2p4/nslO+zsJQgiMv+ET/v/3bTEPbI8mmgmpmUyF2pEjoC9pK56lKMMJN
	 k7p1SAaWcz+EhNOCwegklcmbGEVCQATBr6lfy12TnAgIX6DZb4mc/NCOYDuMkiTLKA
	 Cy2hgwbE+AHxG+pfGcb0nyN7PzIDMljw0DPsPWWFGXCzFijBPW2hrhMRHjdDE47omq
	 xvkkL1LmzuK1K3t99lQpWyLMVK4+C1/6SWqCEHKI+cu6Z/PvLDkDxnrqAuK8ioxVDn
	 1mXhSBZD7WNnA==
Date: Wed, 22 Oct 2025 18:58:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Add compatible
 string for RK3506
Message-ID: <20251022-selector-matron-e1c0331f821b@spud>
References: <20251021222955.193323-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Keo+0uZWAkw8FPLF"
Content-Disposition: inline
In-Reply-To: <20251021222955.193323-1-heiko@sntech.de>


--Keo+0uZWAkw8FPLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:29:55AM +0200, Heiko Stuebner wrote:
> The dw-mshc controller in the RK3506 is compatible to the one first found
> in the RK3288 SoC, so add the RK3506 to the variant list.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable
(too late I know)

--Keo+0uZWAkw8FPLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkbKgAKCRB4tDGHoIJi
0qQFAP9rodx4+UEvE9Qi13OZz2yDdQL3rr3ZChSxpq7Kd1E2IgEA/+4ccILN26B0
FgWsR2Y7VQTJloYNoFuSVSBTnwzILw0=
=iD8Q
-----END PGP SIGNATURE-----

--Keo+0uZWAkw8FPLF--
