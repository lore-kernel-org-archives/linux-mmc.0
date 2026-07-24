Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10148345CD0;
	Fri, 24 Jul 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911909; cv=none; b=VCJ0Mp1+U6im8/yveMUD3UVcNLCqnvEPF+75xrzg8M4QnUgASHxesbY79oKjUoYVDEKjxykkcaOLlGnUNy0DDkKJ4KSu30wpIdfcq3blJAs5PFeit8fY4y+8drazsFlibIJv/Aye66SzLWWu+BeUZyM6fgflgAp+1h/6zQp8erk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911909; c=relaxed/simple;
	bh=mXfpubb33GTwUghEKTjtBFpq4NY7lJrUvfAh/upGi5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBXTsDCpWkwwFRhC5U86D02LhjZ3sau0wro+0sieGivsbnlRbodEMwN0aJw7WYgQ1wKm/Evo9L9osQsXhgwt+pLdo3OiEds+dpfBywqGf3OQgaqJR75nthfk9LlHnrTRS0+sFdzHUB7yzYGZ4jTFjyTOyU/X2dv6ZYFGoFnA2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUEPPyQn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUEPPyQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BDF1F000E9;
	Fri, 24 Jul 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911907;
	bh=mXfpubb33GTwUghEKTjtBFpq4NY7lJrUvfAh/upGi5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUEPPyQnm1tr0N7Zq8cR2tcoNKtM4mvx2/iJ9d5n6QJvP6wsLTJ9AOBZeNvuaTt8B
	 TdCcEJZwI73NlixfGonlPevhWiCvhDDVOThyd1Zu6fXQxPx8EDHUjkkC568QmdOb5N
	 SsN4C5Ny2Td3MmzkAu0J876L9KQZwIi1GGMZJ+RipBfJA/xONT7ROuA4CX5Ldil99R
	 iVNtFTJ8ps+MyxsCQhfhkRN8QLgqXxhcuQBxBgJmojaluuvtF1vPFAaXxv3E21Moo2
	 j1mCtqJSo5XhS2e4Kty2JLF0m7i9kCPYEUsjUTp8OGC4/xI1oHyyz2ZEP3/7OO4S9h
	 CTnw3Zw0bP9Fg==
Date: Fri, 24 Jul 2026 17:51:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC
 board variant
Message-ID: <20260724-calamity-basin-fe1c00457fe0@spud>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
 <20260724145009.7456-3-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vl6kr/NIStq6hugj"
Content-Disposition: inline
In-Reply-To: <20260724145009.7456-3-tanmay.kathpalia@altera.com>

--vl6kr/NIStq6hugj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--vl6kr/NIStq6hugj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamOYHwAKCRB4tDGHoIJi
0qoFAP9wPxQldDL5x2Nv86dBXolcAaBmad3MpCbn4BYSEynrqwEAkNxbFsa10ZGV
+UPKUv1p/kJDs8YNJxj9KYMeCRtWlwo=
=lD/X
-----END PGP SIGNATURE-----

--vl6kr/NIStq6hugj--
