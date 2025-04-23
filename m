Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FC52F88
	for <linux-mmc@vger.kernel.org>; Wed, 23 Apr 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440176; cv=none; b=UhglN/DKq+MZqKCwLJGi4phK28a4yYuantJCyjsquTXnleTZ2R0pcyUVWpaW2H2zEozA2waB5pQLdQ2nJSJ2CAa/gKxrD8xFXeEbAMH1ujrRXz7vmdTS6sQ8lNAgpNki08ZYO2SeHSb8C5tely1xq7p55EJ7LvESuAYQZNGOLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440176; c=relaxed/simple;
	bh=vu0iEaYi9810SQbO4Mf756dmbYLblwEC0Cqu3p9BJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqwknOkMWsl5n25UDuzbKNCdlBzc5NpEhhjk8ietYmZqFmc6h4evBFGNZByzkHDBrM8EltA8s+gEmwngE9IzjADhxjb2NRrBryUj8w3/PIa8Nv4DBX9KUruPumKgt60zrbu67TAAJ0bMD/Q+rz1AOEOrhdqUEKwyyJ51y9qwKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GLNU49Oc; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GLNU49Oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vu0i
	EaYi9810SQbO4Mf756dmbYLblwEC0Cqu3p9BJ4Q=; b=GLNU49OcXDkbPRBPEtjS
	xibspu+QnAWl5OttN/k51N9lg5rkL4IPugzLhD7ds7HzazfCumuaTTNBBd60h3+2
	rMcZcgXLLJzlxpUWCkzurI1o7rkJidktNn/q5JjicrM7SarxCZbd55cGIYlrUtnd
	oeO2eCCy0Xe0nGcBBNO3eKscss+R94q6sO+II+Atn2Q45gilnWCPfqS2mZZt4yQ0
	UCJTzhS9W6mbgC63tjet3kW+s6bOfUTTHhnTFGC9xQbCVF3yHD9qxPCjhWRV+KB2
	gxcoXThYws3gfiX4Gv3mNW+yU9QgA2vhWPcfVKvXpsdqGza5PXM7ZOksPc0cdIxS
	pA==
Received: (qmail 3197352 invoked from network); 23 Apr 2025 22:29:17 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Apr 2025 22:29:17 +0200
X-UD-Smtp-Session: l3s3148p1@Q5uT9HczFoMujnsE
Date: Wed, 23 Apr 2025 22:29:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] mmc: rename mmc_can_* functions
Message-ID: <aAlNndIZKk4qB546@ninjato>
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
	protocol="application/pgp-signature"; boundary="GAU1ClfXG4SMM+Ji"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com>


--GAU1ClfXG4SMM+Ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> example those we have in drivers/mmc/core/host.h. Would you mind
> sending another series to rename those too?

I pushed something out which builds fine locally but needs more coverage
=66rom buildbots. If you want to peek, here is the branch:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/mmc/ren=
ame-funcs

I'll send patches once buildbots are happy.

--GAU1ClfXG4SMM+Ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmgJTZkACgkQFA3kzBSg
Kbbqjw//au7CgmHotprvAtQJ75xM4iT/pQv0ZOH0A4K2G8fV37lDM/xqWc6+sKcG
rEktf1EWNGYJygEPBgpK01WUdgSgFvEyHC5lWS9ocCK1eTtrU9U/YuFpYYC1O9cb
Gfzh3zaMWLEuFj49cP7QtMHnJqWi7kGi9fJqxo2mU2P7j7B2FtIBeqR6e1XnKlJr
pDhf/c0ugnEyDee1qxlBl7hm0D1T/PeMUfu6467pAX0wukyo8wNYJhXsijqo6hYR
wUzZauPFid7zTMfg5DFsQHxZQX96jasAe386yBGyv44FMZlRmHYox4SpCItjxP2i
QozcyBdLPQyj2+IIm7AyLS5czE4ixc51OUF3g3Plje924hfKez8t/at8x08YU51J
PYq8uywLry8qhKw7sz3v2eQBCqOXmNfHipp2zMY66WX1TDlGxIDe/3VK9zXKLAdn
ztZc1dPrHIyWcdN2J+psUavXsq4FIWnVQvXDW13enPru8Z8qPgxNYfp1dGWCWGd0
EchBXAs4d4Icj8emsZ9GZm5kw2/cAktrIPaSvEfQYD9y0Q4j00mcbhrYqFkpNx21
3D9wUWi3YwS2Ode0wy43GJ3eTriZqa3p9hxI1zOKR2uh3JBuvZzHtkv6xcqIqnZX
c0REnt5/am938gsOuS+uaATV7gcS3hcVeWtOQ3XL1AbryVvqJNQ=
=CZjP
-----END PGP SIGNATURE-----

--GAU1ClfXG4SMM+Ji--
