Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0102FC27;
	Tue, 14 Nov 2023 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiJLQGDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D90C433C8;
	Tue, 14 Nov 2023 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699997145;
	bh=YP5kQ+OLq20lWVTIEgwGNCp7TX3MfqMKAJQPKo0uv4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiJLQGDmNl0LmFgP52njoysTZoYMcrSPUM5+6omnQS79QJ5hJZ6F/NultCjouljb0
	 DKqWxaQCSwNRynmUSCZISxGLqXVHDowtsGnf7mlJzLqr7aiwzYAxmaCT6fHqVpx07y
	 mPMuDdMD6UMg9my1wuQ/A2Rll0mOBkWhW7PqlCCnc6O+g+KwKKlf9MPrh7CbPDZ+Ut
	 nzD+LkJtXG67eBIku9zd88hyWWItlqufWwKgmnTpVFKW4aoPhC54S0/YLSGaDob5a/
	 gFKYezUBwWk7ZE/IqnsI30k09b2X+9dLQRX0dLQVw0CSjLAHySNcFSys5/qmtlhD7M
	 OWpvyHYh8x6bw==
Date: Tue, 14 Nov 2023 21:25:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 7/7] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
Message-ID: <20231114-unsterile-waffle-dca2696aa551@squawk>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-7-3273c661a571@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ca5HlNeiXV0eml1X"
Content-Disposition: inline
In-Reply-To: <20231114-th1520-mmc-v6-7-3273c661a571@baylibre.com>


--Ca5HlNeiXV0eml1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 04:08:01PM -0500, Drew Fustini wrote:
> +&mmc0 {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;

> +&mmc1 {
> +	max-frequency = <198000000>;
> +	bus-width = <4>;

Same nit applies here.

--Ca5HlNeiXV0eml1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVPl0gAKCRB4tDGHoIJi
0uODAQDCOj3IIM9ip5YRSOjAlTX71NZyKmVbuSDoS4Ga2+P0KQD8DAsV1YJ7XtAZ
xJ55DxwLnJ2876cNTRc/6SQBHbzl2wE=
=53XV
-----END PGP SIGNATURE-----

--Ca5HlNeiXV0eml1X--
