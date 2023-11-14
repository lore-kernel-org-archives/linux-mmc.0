Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5082FC27;
	Tue, 14 Nov 2023 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOMsLcbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B0FC433C7;
	Tue, 14 Nov 2023 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699997084;
	bh=rU5BTK7MCrWJgidozp4gErYmRVfFdOvPFsoWYPOMOVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOMsLcbIOCjcghFxtftq0kqj2pEDJqeoI+K/155mlqiI9bpBNLVkoDczf1gL/3qez
	 pwHe4gt4RQxNMNXE/A11+HHD/DoCKmLjdCmawX7D86TjMMWxN1bHyvWecsofMKf1+n
	 kl3SsV6DsuQyhFVcDU1/VVr5cdk6WkP6yOAh7I76LASv9baa8Jon3m+MyCdUvmb3iC
	 BGYE+dWzYbB5egrR4sKDSEijrtYnUur8PIAf5jHYz9ypYcJXGHY48Qk2ceVhcqMCDR
	 fWorUWkhm4i5Wd918ftpW7rd/r0wg4UFNeu8ElEa6gGJ6eiEH0dOCYmT+2i5Oqmdmp
	 CzP9L3xr6b7Ww==
Date: Tue, 14 Nov 2023 21:24:40 +0000
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
Subject: Re: [PATCH v6 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
Message-ID: <20231114-subsiding-tipoff-f3c15ef22985@squawk>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-6-3273c661a571@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qL6YxW9uEMvtG3Cb"
Content-Disposition: inline
In-Reply-To: <20231114-th1520-mmc-v6-6-3273c661a571@baylibre.com>


--qL6YxW9uEMvtG3Cb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 04:08:00PM -0500, Drew Fustini wrote:

> +&mmc0 {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;

> +&mmc1 {
> +	max-frequency = <198000000>;
> +	bus-width = <4>;

If there's another iteration of this patchset, can you use a consistent
ordering for your properties please?

Cheers,
Conor.

--qL6YxW9uEMvtG3Cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVPllQAKCRB4tDGHoIJi
0sbHAQCV9T84dReER590s82MvicWkpUR4l10x54e8/+ODO+eqAD/VSf4O8IzwsIw
xhsEnXZ9t0gQ0DPtoaAnudKdE8hG7gI=
=Nvey
-----END PGP SIGNATURE-----

--qL6YxW9uEMvtG3Cb--
