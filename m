Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C07311946
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700708; cv=none; b=AGnCE0fqlvH0cyDdHENBbz/yPRoo8aFHOzedUhXfOSvTDc60CetvxlsgkS3bP4FjQwRSPR9+On0Li+cmKFW0XvJf6EJuAhWNdOSO6f2jitEu1cZnMCCnhC/PFIdfHsIHuchb331lgAVMF7tkQH6v9eQDnfA5AJaF14uh6wM+a+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700708; c=relaxed/simple;
	bh=3OMSbXXSJBgJuS2aSfLGI/X7EKZScaKZ7Tm/2ckn1p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYvtV1LrnfmE1WKPolZkKOCsseDs51ExyhIfhdCtu12ya6RnQ69tkB2qMbf0sHdwVUQrXqvDxVLsyiezr4DVRazdUxcsIFopQs27ggFIjtoXiz9+Z2dzyk7+yyWRKuUM4DqZKUV21ZmIJsraVL5cGXsGIiBkFbdGPYc+4TsVfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IGqZm2ZI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IGqZm2ZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3OMS
	bXXSJBgJuS2aSfLGI/X7EKZScaKZ7Tm/2ckn1p8=; b=IGqZm2ZIg4DNVVxt7wQd
	r8zalYr8nYxgGWiTip2z8TgF0nrt2TLevSZOOnx7B6sWLpEn7KoFr+udMqvc9Zly
	p3i25pNp5Oa7zOv3fzfqPTIr04f1s+bfTah8STbvawzUIRizRQHpX7Y14x7T/4Q8
	kjlzWuv43EqhJ3ZEYWdUpcA1ebtSXUTQJMSGDcoQ3pCxWjslve4MxAtQoWpLjF3/
	PeYp+l0vZsqWJ2zp2ZSw0LwEcBQtsOPgzFUljGK8sGE0JkRG0yl3l/9aoLB+XOyZ
	jpaU3Guoe/pU8smiBZCFeYY6ovBd1BjdatesKmCX2KttBtDCcYF3CX02Akx1nLn/
	pA==
Received: (qmail 169906 invoked from network); 17 Jun 2026 14:51:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 14:51:45 +0200
X-UD-Smtp-Session: l3s3148p1@sW+ghXJUvtMujnvI
Date: Wed, 17 Jun 2026 14:51:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 11/17] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Message-ID: <ajKYYMFV4Xpwq0AR@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-12-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ATTgMl+jhbh88ko"
Content-Disposition: inline
In-Reply-To: <20260603065731.93243-12-biju.das.jz@bp.renesas.com>


--2ATTgMl+jhbh88ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 07:57:11AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add support for the RZ/G3L (r9a08g046) SDHI controller, which has a
> new hardware version register and also has different tuning registers,
> internal clk divider, 11 bit divider, 3 resets and 5 clocks compared
> to other SoCs. Similar to RZ/G2L SoCs it need tuning delay.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I need to get myself docs for this one and stop here. But as said, I was
focussing on high-level stuff for now and we have already got some
points to discuss.


--2ATTgMl+jhbh88ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoymFwACgkQFA3kzBSg
KbYq4w/+KMWsmEEeuDE/2Yw95FpmeQmc+UiL3oSO3c6H+ZiMk9/oLR8w9hP16EyV
Ba/1GSmkgLukiqEHxqdppE7N500xNpd+h5of6G7HkCFtBicfsFQfoyOD5oxEYCY/
2JN+fwIzrF9aOYF2SUPO0w9quhZnWZh9/3xMHuf5Go/1Cy4Keic3R9gduW9azku8
SuvxrCj7/5zmwKvAg8VWAQ9M8XTklMVFZQ3R8yjI36QgVzDSh+a4oIi39P/mbEX0
wAWSgzQ/8aeqc3v+AsK92MBM9DxcnZlF+WGHYAvbrQP8Vg12DZnbuKnoYBedzuRr
sWJYKlnDYqxakVArhlWMaRbWVbllHnI3QiGTuEFzv4/iWVnDKHeRoXZhgajRUM9Y
azgbdbiQHPO6Khwr6fDlwla4157PvD9eroeVnEoRb7BltMKKXp4lzbZrGFFWEOWB
nqgEpZeP+dpTsVi81a45t/taZzO09ebXf+qQyjHaaMNEyUw8dGONzCc3xSR6bjFS
4mRfYOHnt7TtOMxzvaFybMlUe31ZsjiRB078EfvW5ziS9A0nrRLY2MtiboND6tWH
kwDe22grN3d7XUs6kHBk05hJKhEdtG2cA9Vh+58Azruzvf6TI/bULQHXwQfwZis1
GqxgIOkzJoN4uKOPUujIlFS27SmE3bT5BTPap2VxCljtvMOQVZg=
=2yYm
-----END PGP SIGNATURE-----

--2ATTgMl+jhbh88ko--
