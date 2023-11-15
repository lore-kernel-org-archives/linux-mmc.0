Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463141212;
	Wed, 15 Nov 2023 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJxc6FD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFCC433C8;
	Wed, 15 Nov 2023 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700085578;
	bh=e7gQ4gWEv2q/y7H4JMRa3DaY6ldkh+8LPwN+tAmFvQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJxc6FD94hnD45nsHcsyFzTNehlmAfHtPtfKHrcGxzCVFS+7ZOsWarllKIsfCuYST
	 3VJ8qiIUD5AeMdnMsWCvaH2b3JI4row2+NwsamEScyjoW4EYaO/aZr6tXQNRqWD5G2
	 NBBVxc0SNOFgQd8QeJx5XbgvtY1p9mI2b49IvpfSmUYwfz1sBkqgGUzZz1rMm1hgqj
	 tCsseP5SNCpqfI7sGZtulxr240ReTaJiTWI60qSodlOPxaDGuJXsQAN8V684J+CIwd
	 F7Vh+SZ2sGPoUYbhdlfKKpmwegqCe4kIoAJLY+EKSirZczd/MuL44V/WejMMeP1SJZ
	 BarhvaA40WM7Q==
Date: Wed, 15 Nov 2023 21:59:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Message-ID: <20231115-coach-traffic-0db115549fa4@squawk>
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AW5hnqxGKYIjc4b7"
Content-Disposition: inline
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--AW5hnqxGKYIjc4b7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 08:32:54PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--AW5hnqxGKYIjc4b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU/QgAKCRB4tDGHoIJi
0sPJAQDTRP45zgZCHxtCF7NmDhzc7n+VH4pJHNWPDy2ctVossgD/Yxv/FE3TMR93
/mVJgMKIDv1RwI1mA5E8HHChlRXO3Qk=
=nr00
-----END PGP SIGNATURE-----

--AW5hnqxGKYIjc4b7--
