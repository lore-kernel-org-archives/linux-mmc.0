Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393181;
	b=pXsTp/c7AIgi0krmDmnKam0nobp2Xe6Xgu76BPjLdOelanXeyYZ5AlF5IfO0k/ViLRgF
	 ELnghM0QB9T9/ZrQIeJlKNaVi9AlLnTDYlDC431KkWqcOqegYzriuREFPqrvHcOWMx8lu
	 HT5mR52879rTS2PhCFNAyB81P5gi8YX8orkNdDdxANz7rJMVBSteYjRad5HOaV6fcoLW2
	 qFzhex3+7zIvkCeFI8G15tGWYZkSbKJ6D5/56A5g2KHeLIRFN8brMR0zcTwT8AZdpxQ4f
	 6g/bmHVuUhwAXFFEyNMie7yvYg069oIc+NrSA1+izNw8QZgMcSVj3zuVJVSHlCeqUQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393181;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1a2CtR8JxmoelHHjl5muP6NMwoul1o/ElRxIx5HOCyM=;
	b=3L3sMp2tlubVvWweIF0CJIhfpb1H1LbOq6l8OaeMFtwr5vZ8wg56hhwSrfoP3IdZXgB0
	 LeoeCYiOWq3SDMETl8n7Y1oFKXc0RFFk29r8TTiPZk452zx6MfnkzaxRVn6suBfIkWUjM
	 DBnozxldKhqEQf4cpvSC5+cN5CaxtR7BFt9O+Px5iOPLzT2aoQj+9jmd0zExrgz/YVxFX
	 C7F8IAGoP/T2cMbaDkvyPkUTg7Xs+4OLOYv/1WM1XsJwWq2YZM7hj0rBzoOk0w1+1A75p
	 rsKmEB70pLL/Oaa5jwrnVT7xjtRm7Zy1eZ+BK5bMOBgBg52RxlJSoheLjXY/V1dYN6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="VK9/tqch";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA3606A32A
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BA3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=VK9/tqch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1a2C
	tR8JxmoelHHjl5muP6NMwoul1o/ElRxIx5HOCyM=; b=VK9/tqchzYbevShFFs4t
	vRv5K6tQ7keH5esVT5gvjrKx775hI/lXDEuJILdkExehah63twdJNV50r9FgtAaP
	zjjrGt+DQakgMuY6YcZmC2dBI5BJi6ItQEPvICrYGGmGVIblyG9jX03zviViOEyv
	0KiHoR04Hrlj7zQPrCIzAwn4T9GUdIbXefhZtHEsio3gms7KQmPbhjpDuDrdcwqj
	Y96SM/Bklorg5rks3w/KwlrU+SXKqamFud14fLZMHs1qE1nSCkdQ9TJ6ZN2Jwn6z
	x+NVppAIL5g2PPGjDK35h2Se5Di7Q6VevRxZJyfpTNKFuSiMnOohqdZZRwYcyKbb
	kQ==
Received: (qmail 571814 invoked from network); 11 Nov 2026 11:32:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 11:32:57 +0100
X-UD-Smtp-Session: l3s3148p1@sAXwt/1f6JIujnun
Date: Wed, 11 Nov 2026 11:32:57 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v25 08/11] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Message-ID: <avREVcauIMrumfiY@shikoro>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
 <20261028-rzg3l_sdhi-v25-8-57f16691c2ed@bp.renesas.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KWbUZnbI0l9JpoUn"
Content-Disposition: inline
In-Reply-To: <20261028-rzg3l_sdhi-v25-8-57f16691c2ed@bp.renesas.com>

--KWbUZnbI0l9JpoUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:51:25PM +0000, Biju Das wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> RZ/G3L has a fixed internal /2 clock divider active in all bus
> timing modes except HS400, where the divider is bypassed. Add a
> TMIO_MMC_INTERNAL_DIVIDER flag to mark controllers with this
> divider.
>=20
> Add renesas_sdhi_clk_get_rate() to fold the /2 division into the
> reported clock rate when the flag is set, and use it in
> renesas_sdhi_clk_update() in place of clk_get_rate(). HS400 is not
> yet supported in software for this SoC. Adjust clkh_shift for the
> internal divider case.
>=20
> No existing platform sets this flag, so this is infrastructure only,
> with no functional change for current SoCs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +	/*
> +	 * The clock driver may not know the maximum working frequency, so it
> +	 * should come from the 'max-frequency' property. If it is missing,
> +	 * assume the current rate is the maximum. SoCs with an internal
> +	 * divider can't do that, because the current rate is not
> +	 * meaningful for them, so the property is mandatory there.
> +	 */

Good description!


--KWbUZnbI0l9JpoUn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr0RFUACgkQFA3kzBSg
KbZ8IQ/+JQDoXdLga1QEmjWuNKg5MxFaXkOMhDHYzcYkviBTerkDsT8bwVkLmwXY
qPvHmkekBwsj8sonpNklm13HMg/rUJ3i1OWyilgQtHZxsnW5HilA6/99/kmRvFhQ
vS/oz7c3tufBKq9EuAkwWcbrQGpqkJJ79ZQ3rBfXVunM42w2Kw1dO+ORCm4WJbZQ
COmfTzOn61y4cpA2RhblEeQzN5yMIZTmI6KWZdu3zGG5Hwf1PPWRT7UEEGY6iO7e
IqAzReu5hUcDEkpnSFE3g++BRdf97bwPuvJLOCNhsyK31ioG/zk9CS2SBDpEF8mD
f71+/caM9Jds4k0qIya/l2yQuhSCyL8F3gxkd+5EzfKG8Gc6B3ZNL4JgzywbZKAH
+Szwt60da6ETz6oY6mb9Ml1/rbNsvld23+ZakxtnVWCUS0Qe2oodvKUGW3+5RtC7
pzXoSg5MCFDAGQxfVqbwXK5z+5cMV/aArVLNrX/3ZDKU4tFbzRX2JA0Ngy9kCIKj
ZMP6O9K/TfCrYxhDd63/jx57fY9M01IQcJ/OxCjIHnfWnRgo3a9jtavV0OtT/dLD
RR+Kt/ehVCtjEcOggh9NTUBu9cEJ21/GQ5pciIpikvUIzHRPWinrkSyCo5oNfvwf
B7QSUJBLG/xM1gHzX+k9qGGoyPPuNZ7OVU2MXjJeDOpHUsba848=
=QL25
-----END PGP SIGNATURE-----

--KWbUZnbI0l9JpoUn--
