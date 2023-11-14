Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE322FC4B;
	Tue, 14 Nov 2023 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbOwQLkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F1C433C7;
	Tue, 14 Nov 2023 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699997267;
	bh=9ZG+AI0fj8e2HRbIkqu4+FdTFxFjv/se3KzEuXLYjE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbOwQLkUw5smV9aA4vlMU3nBnCLux1jYUWonswLnx/gA1I1q720MF1kd6lE0Qi8Ik
	 5Rz7sRRCZgM9XaIHOTtcibx1VkiTsUjmbwIZxRPab0tcQBm8Wr9LaxU/Bp1k0giRRA
	 E2OiD5RtqesBxSLMAhsZefkWnkSGmnVlFAuZHjJIiFv0T+nD/mltv2xS4u8n2UZL5f
	 YAeXfZB3cgkLAwFd6Krh+hGDEWL4CSXvDVLRZOnYofv4mRLNwQO0igm/3gxEJzKHJm
	 am9WSpEgVOYbpJuFOEzBQG9EjZvBa0saSwKXMgpYKVzAx1O4LbHgxe8EsAr1CLzq4E
	 35U4ARqDTtT5Q==
Date: Tue, 14 Nov 2023 21:27:44 +0000
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
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <20231114-starring-swarm-0e1b641f888c@squawk>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="luEG+7A6lTHoA2TH"
Content-Disposition: inline
In-Reply-To: <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>


--luEG+7A6lTHoA2TH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:

> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <198000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};

If only you had a clock driver to provide these...

Is someone working on a resubmission of the clock driver?

--luEG+7A6lTHoA2TH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVPmTQAKCRB4tDGHoIJi
0lBuAP9U7s7Dc8QCdpB5PoIv2t5+2ZksodPnAE+UTFB0b2B4iwEA/05GHKJqoHi1
lD5+SQ6yUh9/FlIek1FwIChWYiF72As=
=O9oG
-----END PGP SIGNATURE-----

--luEG+7A6lTHoA2TH--
