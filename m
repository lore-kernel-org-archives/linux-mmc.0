Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8040F729
	for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274384; cv=none; b=tbrHo2LHq6kVJ+2TSbiN4C4tE3To9MNWD6dnBxMEX0dycDGhUI22cqyCyayWog1zCrZYYFeXEyl/l/r4oVm4pE0BiojEuAviFyba5E2c7TVeWYFhdryM6nN7hqdMaCyCoJgZRPjYIViXRh3jw0tWa5vZcyEDb6d2sV50jMwxEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274384; c=relaxed/simple;
	bh=6BUYdVMTejCMDUJ7SK4i1QipFIFH4EaButRLSjTQdX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdla3/hehJO8OAIO2Q59BNlLNgxE0toJU37fqNQ8vVP33N/uyKkjUDc9SLW/StnhHymtMyK7pVhIYU97erdchht7dsZ02TS8SpyPBmJbVDOdx63yK8+nbsV/Sc1ZmmHXPW4Jxl6/pBb0i6jY1lJZeHso0hCBuxQX3mmhgizxEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FLs0R5Te; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FLs0R5Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=aUvE
	XBRC4ZmRy6hWIvY2WPKuQkjp7w2L0wgzITTJeKA=; b=FLs0R5Te/bqxhrhIdm1i
	LroIFjj7iisxZwH3ZIeUs30MGpUV1bFpwoDgJQzFe2IQ6suusiEVVT4q9ckDtC9c
	1IilJoHk7VX8giKtXSFVqaCJtFEDN5JMeLX47YyBennCIdjwp0NEfKCeLv1xylqo
	MnpuNXqXuVhZnFfamWX6cFnPu7QmYoGTN8uFgji2E8P983M/fWzs/QOMyu5QgyJW
	ed1j55mtwkMNrh0LjbQAIO7i0vX9AoY3mJ8z3kz4SvraKFCRh6czRE0bNWQE42+Z
	aca9tEaBt7y7NWxLRX2PWA+CEAcaEvJ+jAuPKL95PE7MRh9Uq4+1rpZnJpV6/Reg
	2A==
Received: (qmail 292799 invoked from network); 1 Sep 2026 16:52:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2026 16:52:51 +0200
X-UD-Smtp-Session: l3s3148p1@wGuoEm1atNgujnt1
Date: Tue, 1 Sep 2026 16:52:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
Message-ID: <apbmvJts9XYZD10v@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/rkE9LV9lVzhGLcd"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>

--/rkE9LV9lVzhGLcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Biju,

I am starting now to review this series. Probably in batches, though,
not in one go.

> This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
> rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards

This plenty of testing is really good! Hihope boards means you basically
tested it on R-Car Gen3 compatible versions. I will test this on a
SparrowHawk board, so we have R-Car Gen4 covered as well. I don't expect
any problems, though. Gen4 is basically Gen3 when it comes to SDHI.

Happy hacking,

   Wolfram


--/rkE9LV9lVzhGLcd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqW5rwACgkQFA3kzBSg
KbZyFhAAj5nuX/tRgoTByraE3jx1VkD9sKsPL9gmMb8012A3Up6aZC3ipiqbyXBV
C1U8l2QjYA1/XnKiGkDJExUL+2pMpr5TL5NXBehDobCg/Ci3hgyPGKjRPYo/n4Qq
R2nlyG4oDJw8vs5hMg0cr39fqRpzfZg5LNaVOKGYcflKvThLZYoAC+2lvRP9Lu8H
65av62gxv/5rhW/xQndrtoqf5dLsGbA8r5rnFuEKPAbqpp4mkrFIHquYIMXf4Buo
ddeLD7N3K2XU2P8FGPpXPdS4biQUuVJ50aLwFJqsCPDU2lfeHM2J2XIkD+zJ1MCN
Qh2SHUGhgFCJc+JPhbR4maJcNUBPtIj4LyyV9+610wkkMqo0XZ+ZBboPP1elEJOZ
lXhUCFCIrAETNYYRcBmU/ooyR4oPd6VquFfeWNPhPk0s9nug3ho6Pa65W87Z+iYc
CBKuh6sbxvmQr5vnIYOX98zCYU0gAhZg7S58ZQDsvF80l87Skr09051hIlTUN764
TzIzTsuhcgEP6Wk2BXnmmB2sGnAQ9va51XHRbUDRCzkaN4TksCt8mr5toSi9IxBI
0Vp6vN7JCYA+4IPEiZHpWDbgSt0PIQKVEpSVxgP89a1H7tINCAlxmMEv3vCN/eXv
zQ5cdAYPm0x7li2SWuqKGP+jZnBpegG+6cwRe/4RIXbTGSC4eIM=
=lytQ
-----END PGP SIGNATURE-----

--/rkE9LV9lVzhGLcd--
