Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D646C840
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346048; cv=none; b=EYuOzgFSpdK0eJKaJynmUGVpT0YEyf9sHYimsbBMKJ9ZfDDeh2vbbW9Efka1JHyRS6mjkbCLWmwB5amkD6U0OZ4IgH43zgTHTyIMe3zZmgFzw2lfUxLQMdig27fBXn7HmfYuGxxHQSDlFdvx6GzP72lJgGVlTnxTClewccz9Zd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346048; c=relaxed/simple;
	bh=3NXgDAM6X7ufNmQeHJM/b8Ioo2uj0aZZ5gWb/eQ4eJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2EqsEvQGdU/CVRc8IKOLljQ4R/2xiuxDn2El7q+BjzAkB0P5G7plCBTkvOJKI/6g0e6RGMr83jNH31nt+7dgK/n4awLpyhHoENtJ1YcWEq8tY4VSdTgzDhtuw0CIc92RrHbJNQbrK1kLsJeV222sT9P9RlKbx2j/8ey9Sn2odQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=kJp05MZu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="kJp05MZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nbby
	bObcL4ujd+0a7x0/LfEWoOFg2vW3ANTr8SnrMdA=; b=kJp05MZu0Ye9vuUcFMJk
	5tcUZZMXKvbJ1/Ls9vLnN2ML+48HuADq7MhXVbMtKd2oel4KYI4ch7WPD2vLlaID
	Nwkxzor/dwt5z7j3I4MnWLTzvC6XL4DI020RQZ696oxIECA5Hdk4UVMUFV5/mwiY
	7WU88gqK0juqJdVa1GuA1004zuJDQzH3UuDZv5y2JC++qqttpCU1vLgdbUcL8edY
	SjVqKtu92PLEZNz3aTbJSwz0/F0ouLhB+XuecRW1PU2dhg0+aMIodA5rDKMPQVUJ
	H9HYrXYHyujk3Fwd3tbl9q2KYJvHTF0l6zWq7vsMs6Ypp4nkzeD5IkLXbYWFtROT
	Mg==
Received: (qmail 601074 invoked from network); 2 Sep 2026 12:47:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 12:47:18 +0200
X-UD-Smtp-Session: l3s3148p1@61BQwn1aOoYujnuD
Date: Wed, 2 Sep 2026 12:47:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and add
 OF table sentinels
Message-ID: <apf-tTkYstvbe9YP@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7EE1SMXBVZtMZWHm"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-3-biju.das.jz@bp.renesas.com>

--7EE1SMXBVZtMZWHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  static const struct renesas_sdhi_of_data of_default_cfg = {
> -	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
> +	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
>  };

This one gets worse, or?


--7EE1SMXBVZtMZWHm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqX/rUACgkQFA3kzBSg
Kba87hAAmMVpoQEKrUptoNRG8N08lSYup+QCg1P7ZKXtW6fD9ts25U7HWfZfrLL4
W3CiDaC5uluog4yYhFdpL2eca+JUWiKQqo5NbDRy2x5+8CM/TXPzgSoF5IYDw87k
7qvuOuv6qvXKRJVqiud+B6Oq5ZE33hkv2O1Dc+ItvXt3vgzH7UqYAT5gGXZxGMNg
YuQ1Y7tRoL/Qb1jmZGyvfsRghkJHfEDA2ir8uOTqXmeqIk6BHf/Rz7pe6D10xOMD
gdacXXs7lXORPhJiz0eF+rUP41mKWW9XYNwBlF1C2pLniANDfwCiPKfBwG+8c5Qw
AQRULyZzTxrm1ebzLUNPCX6IOv9kLvguJS8wBlWFHJHSiQpJ+gHJUQcr6csQ43OE
1+JwyP4KFgTimTnadGYZHKzQjjCl4mruBM1UikzK5dLV3/7ttcfG4NgsGSyr6J0K
uObeYIpICv9EQbsj5h3fkL24+RVGiuIKonu/LnkPxPbzqHgRaFjHJ6Mjo/Q6QHXi
OE8l7uc0dXF6mjQ7Rd321yTmPDC3W0ZUHxPUKF4EeyBq0igMmcSyQjK3LYNMZe8n
yO4D3P/6fivUjK/f3H/12JL7R7QG7VVCYxTrcJ2GtmLU65C7t1Qqd/cPpwq6GT6w
8rn/U7w9kIBCpf0/HCRpraB/lgty8ozFcJVdphWXkj6AMO2RtNc=
=XGHI
-----END PGP SIGNATURE-----

--7EE1SMXBVZtMZWHm--
