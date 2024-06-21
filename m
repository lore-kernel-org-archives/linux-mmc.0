Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219E16DEA9
	for <linux-mmc@vger.kernel.org>; Fri, 21 Jun 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965330; cv=none; b=EkESjgFBcbBljHD73JPc8L224i8YhwtxXR6cET83ZvTJGiUwq9wd//TXz98c0RZJ4dVjQ9dFAyDamw/9Y1YqJCRnDjr6Xf3X/SXOjw8RhhRjfQS4xiU3HoqPi8DDk1FiKGlD7d/zbzIzVPViNZZkIKf0QY3Waph/YWfExYSGJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965330; c=relaxed/simple;
	bh=GZQdDzuyMYiU1MqMtTh9gbxdguRcBYChovGFHXSNTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhPUKauX5ouRlzaajW5mZrwD9FXUTFTkfRxJATC052KuZ7dty3pvSZyqtiaqQMJI9xPHR8WA4WnVuLwh3m1drA9ShuTwXef0/hJpp/NiumFO4WYJ7arjmi8a1ti12ZlGas0Ec7uPDDE8/0XScmF8DfYFGBSS1SuUesyVBmYQVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AECVoxhV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AECVoxhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GZQd
	DzuyMYiU1MqMtTh9gbxdguRcBYChovGFHXSNTcU=; b=AECVoxhVEoG8CJYfiT3E
	m2m/967zh0IB8d+ljWmgbHwJTEJ7yZ+3yPa7TPnHLkmeGhXSxEe50HAY+KNQo899
	4LwJmZI8ywDjFvsrAXC2JrNKP+EropcbSVrpzm7TXw1ugUpwwmKF6i2f7z3b5ym5
	0yJnyNv7uo4SpgadPlBAEEWpQe7kJW+sstKAYDZhW5PVG1ef9JOX0FbcI2DiCYe7
	3NPCN+WRmumvlJJf3D/maqpGeqNkIG6SHBBX5QpOLjwqcyBPAGrFJt5jGQyp9+U6
	r8fRu5pku0SNXQov/zsqERlZx65qV1qJnC0vpItxUdS5XtUDm5PnEIGu5b5X0BKg
	Qg==
Received: (qmail 1334472 invoked from network); 21 Jun 2024 12:22:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 12:22:04 +0200
X-UD-Smtp-Session: l3s3148p1@M6iNzWMbeoMgAwDPXzjQABqqX1QYyOSW
Date: Fri, 21 Jun 2024 12:22:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Allen Pais <allen.lkml@gmail.com>, 
	Aubin Constans <aubin.constans@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Manuel Lauss <manuel.lauss@gmail.com>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian Hunter <adrian.hunter@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Alex Dubov <oakad@yahoo.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, 
	Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] mmc: Convert from tasklet to BH workqueue
Message-ID: <lztlxgfjlln7owvr2gwge3apdmflyujahhfaxgh473z4l76ren@ex64f6pfbvwz>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Christian Loehle <christian.loehle@arm.com>, Allen Pais <allen.lkml@gmail.com>, 
	Aubin Constans <aubin.constans@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Manuel Lauss <manuel.lauss@gmail.com>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian Hunter <adrian.hunter@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Alex Dubov <oakad@yahoo.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, 
	Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20240618225210.825290-1-allen.lkml@gmail.com>
 <gw6adkoy3ndjdjufti2gs2gnk3xdgylt6tnia2zha76hsgdwtq@dr3czbxjij66>
 <fc2b8a80-373a-4049-bdaf-9970a1c1f651@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4enlaepeuujsmpq"
Content-Disposition: inline
In-Reply-To: <fc2b8a80-373a-4049-bdaf-9970a1c1f651@arm.com>


--c4enlaepeuujsmpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Obviously not, FWIW I noted this on v1:
> https://lore.kernel.org/linux-mmc/9c31b697-3d80-407a-82b3-cfbb19fafb31@arm.com/
> But hadn't looked at the patch since then, sorry.

No worries, but you should really remove unneeded context from mails you
quote. In this web-interface, I couldn't find this mentioning of the
build error.


--c4enlaepeuujsmpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZ1VEwACgkQFA3kzBSg
KbYr/A//V59QC0Jp/pGdqrZjAn0m8BaO4ipnNBvg06wdnJCu+JIuxTQO6/9j+MHx
2QN38T8swcxBJApUEIvyUbMZ9S/0XX7w3yLYVxJienMZJVkmMhWYVqtjoK4FZyjC
wrlxnDGvYO80E6yhwS6r8eC4sxmEhXYDWb1DfGiuHBNz1Wo3vwQMjCN+thxM0UJn
Ff49IQGx0Kdup8PrSvDWdIwXL0i56gS4HGTl9G+Rs49AJbdIu4t4YAmXGVQM5qd3
kQIj3NtjBTvdak6Ww/DMAMr98Sb+yg/N+znpfvQdHeulKOrErK0GeN2VUKJdEyUu
LJaJiilAWAQerh8/1iXNhL8coY9Td4pdZIlnHB3PeOrxZ22k4qm1wpTj5DKpVWs0
GL2EI1FEBdz33DNYTl34Dti/TtBE1NNSM3CYfugko5DEJlDTnOePYrbFvwgmhgd9
SgnzkE3/D5QestZcJyRxfA2owVbrY0i0zuc4h9LK5ZAM+POnQ8M3SOPLfgdHFh7R
TEj7IWeqiKnxsEjVyDnaSl8w4rl7UJPYTqqq7LtASUVQKEH5weAV6PEEw7Nl6tE5
B0uUGvIAJjYDajubp/OyAFeA15ogJpZHkj2EEc+HmOswm9RmR4K7b5O6scrKB0hU
FasSypwrVeQn/risfDtwy5JnAYRKOA8wpY16iDOSy48zFQaMH/U=
=I04c
-----END PGP SIGNATURE-----

--c4enlaepeuujsmpq--
