Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC247253C
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347391; cv=none; b=uh+0Ifc5Ju0eyUcPiOD0djfv1ScRjjYnnEbtqLH3Z6DnApYG5GF9MpBacAidHf05XPUg2FPhyMe1eYYeWEs/1T8nIsdWi966lXuzlIXrgs3qJRUu4DKCdYGGHUz9O7Xby/yiBSsM3HtJnLpFJLE5/CGqQfkMx2ynUwSWLzvapUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347391; c=relaxed/simple;
	bh=mJAPrFdBG/15qJBxRxlsSufzns5xc3npADwUD8FjhB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmPHgH7mBKvyhIUC11+V/n/pYC0D1d8ztytpjHEBqINLULLm95k9wroXaDxwsPgioxMaxmHF+UxIJPQpTNLGLzFvwOvSnIebLekgZTo2Cx3hIS+/LRJ6LsEbtocH8mOMD9/iwUbZF0j1HKpGq/QKe2FWPeiBOFkYsGuotkJYvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aRsa8LK0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aRsa8LK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=URp0
	ws8RmnSMK9/P0CkXG1qYlwRtBAQpI7L4MpsWR5A=; b=aRsa8LK0waIjxv6KX/HW
	8hSD5/umVrFhCmNy8ZKsRf21bUdwM2Z1bcQFqQtk2SLkiRNxK5YNtJufN99/9oCQ
	68gG/+fRC6DNvC1LVtAWaTrzlfg7i4JeANKqqyObj00iu7K7YvXVyWlxPjwE8Xi3
	aGnykWwjkjgmE4fa2C3Hds3KSNBvEOIJgPJgBt+jUUcBwLj0huDnw2wXmaJYMaz2
	NKXVD4bwztbwjJYXdT4evU89PbMBqpyBv8Zk6R4mzkbcZsX4RhlHXzAPzCrd3/qC
	4JMqWu9wndmuGl4fiISvC0VMpXTdiUIYOB72nw/of5Ne6/qtomYYctdmPIXn7onU
	1A==
Received: (qmail 608901 invoked from network); 2 Sep 2026 13:09:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 13:09:45 +0200
X-UD-Smtp-Session: l3s3148p1@qeiZEn5a5IYujnuD
Date: Wed, 2 Sep 2026 13:09:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 06/15] mmc: renesas_sdhi: Make clock divider mask
 configurable
Message-ID: <apgD-Kn_Cz8wg0PC@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F9yXXAbmvjP/ALEl"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-7-biju.das.jz@bp.renesas.com>

--F9yXXAbmvjP/ALEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @@ -103,6 +103,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
>  	.max_segs	= 1,
>  	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
>  	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
> +	.clk_div_mask	= CLK_CTL_DIV_MASK,

No defaults?


--F9yXXAbmvjP/ALEl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqYA/gACgkQFA3kzBSg
KbalWA//fYlbkZWuCtUeA6MjiBwd0TlPIYTwrohmWcgKgEpc401DoMZFp9hpD7EI
HI8O14L4BwVK8CQ5h+TQIIYTs31UQX3YKzGONAeQkfR5/Sp1x2yMn2V5L7oATtqZ
7+7Uu2YCl6xsy4EyuRT41ZN6Ix96B+vP6KrNIgpzJnAFTwrd5sVgYJ5fxASxmTiL
p4qoXrMFqdECtsIcILf8cK1idAS6IK1M//AFmEj8GToRbTeigGkPHi3qPnG6rWg7
Ro+q1r/lekLZWuX4/9jz34TDmgOP8zI9rVamgKqCj/zLX4QDTGEhWT231RWO9VBb
FWY94RCdDjAh0wngEPqAmVuXzgjHBJY3hs6QW5f9PBBYu5aqEE+36WdyjIa9Ra0X
UT3l4sYxol5pemtxx1cfK2oJIDnPxMuRnhfe3oJjQgUBcEQy0BBtKgpFjv6+hMpf
s6Jjm6J+wx/oQNwPkyoMNcduoyQ+8UlB4Dqp1DmI5/1oWpBfL8rkgPb4weQBF7Fr
8VuWF6jXALvpb6fIaXd/57hdJdnMWf28CpEktOYavu+OytDkryKOPa7N/2o1r6CV
jEAM/55bJG8qh87ny8WpBBN7Y9QsT7au8yi90TlEy1me407IDk/g7oc61VjwTJ9N
9JVFwlSkF6D7TB1k803QI8cLYkXiBt/eb2CkifkjFjTiE3gq+oc=
=uZ7v
-----END PGP SIGNATURE-----

--F9yXXAbmvjP/ALEl--
