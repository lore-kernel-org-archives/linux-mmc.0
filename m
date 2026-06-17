Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FA3EC2EF
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698895; cv=none; b=Uq0dqZ9tSqcloH/5LYq9m5WGomdR0i5otqe2nmC2fK7qGGqRsFRXZl4Ay10DphPFgMbV0VhWdMS4i1UQ3aQw8u0C43K3pGd+R1h/TyW5xFZvr4s9hwDcV2C5mLLQNTaxGtScF7BuS8V5DJ8eq7mjPweQYQLmlw+gtO6fmCfQZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698895; c=relaxed/simple;
	bh=TvGs1xYMMyeNllFhYN8S0bdscHxRJbItlrNVJfrh//I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGAhUWbUKaVLaFFF16UJM06sPakf2IQZvO407iLHacjx2rXf74QW1Lbnr/7l2sfSmgTjKKz7BEwVAAFSaaPSSp5qtI5IX0YExm2W++rVsWSq8xka9p2ATBqV2wIGhZ+Gq511coBJdL7sfHpaREkgt6smRkMFpBYJ0YmwFnsROQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WkefzqrQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WkefzqrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=TvGs
	1xYMMyeNllFhYN8S0bdscHxRJbItlrNVJfrh//I=; b=WkefzqrQFCJ6vVPGA0Ij
	9k/xQZmjG3B5FNi0Pe9WmyM3sfPMjpFWEkDo/vzkATc6qt+ZwcLKdx3ZvC5uY+xj
	KXevnafVXgRWVPeQ5ljcllFhtbHHh+VNa2rhExnqyyvxKfNCsu5OoHlzeT6cMOpV
	3TaXvggjPiByKiwN/3L4M24hcYt0EM2YPj9GkPl8UQ//asg9A3SBKTYhYefxy6/Y
	2K+XBbjNOaW/rodJfO7DC77DKnLyAfPWpO5oC3LoHuEht6caIlNWQ4EDsGENSjCb
	fuH6eZhz3f05O8VCNsg6XLUk+QkUmuYkMAcxt1msXVyoSvp8XVKKkYUBq3EhF+Iq
	Fw==
Received: (qmail 160927 invoked from network); 17 Jun 2026 14:21:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 14:21:32 +0200
X-UD-Smtp-Session: l3s3148p1@oj6RGXJUiJgujnvI
Date: Wed, 17 Jun 2026 14:21:32 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 05/17] mmc: renesas_sdhi_internal_dmac: Fix
 whitespace alignment in struct initializer
Message-ID: <ajKRTA6JunfWTACv@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PN2ULZANnQ+cyghL"
Content-Disposition: inline
In-Reply-To: <20260603065731.93243-6-biju.das.jz@bp.renesas.com>


--PN2ULZANnQ+cyghL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 07:57:05AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Remove extra tabs used to align .of_data and .quirks fields in the
> of_rza2_compatible struct initializer, replacing them with single space,
> consistent with kernel coding style.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Should be merged with previous patch IMO.


--PN2ULZANnQ+cyghL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoykUwACgkQFA3kzBSg
KbbvwxAAn+5JL8ajUK0ZH/CylTJC1KJo3SlfBtmkUE+FXw7QbmRSuy+JxPLFG0G+
FiV0Hu7Wj8sjZM5mDSwnRyCHMaxIrbozANYCMzmdZf/Kvpi5a1yPSsXxB70Jouma
PxOhWoN4VVlTbwd78Uibwj8Fl0PqDCMlvdw/CWq4KnfnmRK5HOgjhKR80PxudoMl
P9mO7LlqOcD6i6Bw7VtaiPnZTOA9EAvNR48gkxpoHIeg/KYkCdR7kLCJKtJlUT1n
/Q/+0k5EA3Js1dkwhMfTuObfURmSi4IYQcnZ2N1k62CnUIxC0qepzS1HjKbFMPTO
67ffudile8SXekiYzCyM0FiM4h9jBChwcQClSUmb5x4YnPMrfs0j5x+GKr+X+qHH
6+r8VsLsrF20HaJB+BStX7ctEukQCQ59G6PGdWizD0yJesPt/vGj3sWhnQSgpamz
NbTrUMRB3XB3PK0aURl4xSeUc597u2oUVJolU8sIV4u8/S351DZ7Vq9rJWJVsLrp
M5thkj1Uet1QDkzVpineGK64TiC/O6fO4lPc8JxGi1Vlu1a5u0wBKsPI65cPjnk1
teaApmaGHYveSiwwyuPWDjhbA1mZgvbVbh9JUkHkCyoD7W/QpcgNtG7nUz6bE+58
iV6MoAyC9LuMg8ZshVbxq33XNJt8YRVPRGUHwqT5GauJ/J0wmbk=
=0P/+
-----END PGP SIGNATURE-----

--PN2ULZANnQ+cyghL--
