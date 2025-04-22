Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92C28FFF7
	for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337563; cv=none; b=u22R8qNW7OfzQ1rDbrqd03QGegfcdwxs+hRreTNs7LTrVDxktiKtdiKUMtnPnKeMNZmQtTZ7pWEpwTRyIgp4jM/mhitk6Jn0cg2nGYMkCURq9MVCOle2LBtnTUYVIRD+L2H2IfvwfAi0s45yJCAGHjDSkEwJ0c8fqmpVb1GgP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337563; c=relaxed/simple;
	bh=Nv5ZHOSP/f5ixivAM83D6o/lF7DqehbfQFCWynDQaHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKgQ+lnNsA8wUs3r0s9f9jKf6cvQRqbXNycxSQ73mU/+5Yv7AIQ/NH+YSWoiMKMGENW2FTcemmKhnH0FgqY/Ue6w1/ID0sozcl/i/vUT4kguiLzzoEABkl5yfAyG9j1Pcn9j+NXKfXogx+RgnpPSPpugrApEOJaLhFJT0aIhwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dtySHXAi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dtySHXAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GLtR
	cMZJ7GdJBzq4F9WQ5E5IDVZT7HsFPyMMVnjfT/o=; b=dtySHXAi8zFJZOW9AmdH
	O6OUAUuSRNYJDFRHl3vGnDTA2Gj81WLnlP+6yqpoVHokt3itSzxIM+U+9jJ9kZUi
	AcpihKzdUW/qoezYM8ZciFWbJNDJyVHC+wtYE3qInbxxzwVv749MVqIyk2UQGIEq
	CU42iJ8DfOQzIZxK5TL1YpagjkfZMW5/OliJnTD08I3QYOqxukcy1wq3EVpF8mV7
	9OwkpGyN/XF2uu0pGN3ANgaPtfY8uKiuPwFFOWLQKMKpU7LTNCIo6TIZEevOwn7j
	hpF8xAmM2AALxHBd/iZeNSlCzM4zhIZj+pMBjLvfVvTH7+rBCBpM2AdrE43hrHw6
	0A==
Received: (qmail 2786636 invoked from network); 22 Apr 2025 17:59:07 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Apr 2025 17:59:07 +0200
X-UD-Smtp-Session: l3s3148p1@hS6AEGAzloEujnsE
Date: Tue, 22 Apr 2025 17:59:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] mmc: rename mmc_can_* functions
Message-ID: <aAe8ytnffzaB7830@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGUcWC1BnO+zsjwP"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com>


--MGUcWC1BnO+zsjwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note that there are still some inconsistent naming of the functions
> that correspond to the host's capabilities, beyond this series. For
> example those we have in drivers/mmc/core/host.h. Would you mind
> sending another series to rename those too?

Do you mean the mmc_retune* functions? I had this in the cover-letter
because I was unsure how to deal with it:

> > * I intentionally left mmc_can_retune() out because it seems more
> >   consistent with all the other mmc_*_retune() functions

But your comment now tells me I should convert them all to *_host_*,
right?


--MGUcWC1BnO+zsjwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmgHvMcACgkQFA3kzBSg
KbaJcQ/+IDg9wK0LDGFlU0p4Z8MXMLx5BSCAiaJZIGGKM+Dl8dY9f3MjNbYyHfVC
qbPwuecMU2IGipvdga1ON76uEqZATscTrHfXcWRsfoFhfW4lgK+so7tJ2Ikvfpb/
Bt3u+mtB6jwqZPCtbTTr/rA6NWZ4EW4gy2iJGe7yGlEWpLpfwFFH1UKAYO7RMOKt
zwBuib36UgMZi8VSgxrypHa4EY9y+xFEC8/kM+23Ftd8GGjWRPuABEa3xQSJNjug
DwjYFA7uI9lDwbeBJBcT960bk9GprLfs1e2yKwCNvXA2UCgtN04mGRvkp/FAdz5x
Y+NGKHcXLtbX3LTUz4T49ibpykvdMuALhfv3uMV1u9R+4xbJYCvhZ8GkKvGxZ45K
IL9cG+BfXq5IuqT3KCtYm2wAHMeMoXUasPeSsnw6tlOjbk4VlLDr9R3MA2P2J8wc
CbbkFs3ux+Nv6Sddi3pblWGx8SkOFu+9+6hsxOb+WIVSnTQexRLN6nrt/l+Lxi0K
uDOWBBegZELr4aXdptgS7p8wALKiY4kwK0u89q4UexR2HOLIpe8ATZQHarla/Mzt
9ntFnbh87pTV8yx3HzCb88pe5wh9kZYC0KRjeLnpFxkUUmywKNTl/L2FDLSHdMZf
gHDr4MiatrtaDiOVKNYJeNn6yL+nPb5H3Rw1f0Bam/jj3Ek6Rzw=
=cyke
-----END PGP SIGNATURE-----

--MGUcWC1BnO+zsjwP--
