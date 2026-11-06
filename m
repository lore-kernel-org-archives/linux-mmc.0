Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963715;
	b=DXKuXHYovml+AS5p3bPLeC3IGs0n2NpUaV2qmS73kvOFDkG9/nEKKDSbXOmt9S6w+Y+q
	 dvl5J14nTb28nshsOqIeBeztUWutnc+mKYNMoLS2Lbx76PBHCDun7w6z0qxlTDsoeSNds
	 UmxVGRCkfNJNVS07Azf5HjcoTO4CmY7WAAVbb+etVwERzLsSgnBBwUKCZYTmtGijpE/im
	 YUPXRlirC6YSUjstsviC8mLqhFzRj51VJ8FIb87yCaB3v01WVtX2ycPrzV4AeqeC6Ig6R
	 V8cC9b+B+dum/qSnFuPRUKb0YP5YzlGNXa/78HcEP48ovNzUIKiCfXpl4CbQnhmj/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963715;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=dVDv9rKtKm3uc/SRgdflJogWFO4h+MZZZBsSymmU5Cs=;
	b=Z9Bg3jaZKN7ReRy2lWNutxrzQ9IICn7k6iZq1krlHqwduw8Z/03Hp/b8LFW+AQ6mq0XM
	 VB+uoiDMHaW5AFnC16DAxF7Jqbbw0Uf+oeDSBRHERg0/MSCLdc52h5DV/fg5gyM/mo10l
	 WubYqv4f05tvVIl5WUA6fGNbXuxSMA6Z5D2ezCfR9rK3BnSjsItzbP63/aAg0zkOAoLjJ
	 ekMHl6QS0TUmQQuMgON1JG06K+fKZ14ewcaksiYe5fhPAu72idlhkaK8cY1h4iAan25ja
	 AGym4ojspWwzrectOkDyEHJ7xtDbkHMX7L4UBztctvybqLqFTNFSwsLrX89+IsS0S0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A02QhSiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7206606EEBC;
	Fri,  6 Nov 2026 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A02QhSiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399231F00901;
	Fri,  6 Nov 2026 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963714;
	bh=dVDv9rKtKm3uc/SRgdflJogWFO4h+MZZZBsSymmU5Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A02QhSiNE4NGPTUQCuGzj1iVBhYgM6BX6b8C1BIi1P8xENfZS5qBw5xYcHmUU7yJP
	 QFiY3BpNAKalSkeV6ypjfhFpcaz30JAR4nzP1PSqb9v8YLjXnULCpKqSXLMBgN0a6E
	 +xX8B0Bl8zinzI1WnT5W9ohsnY7q6YagJ1Fy6yRVzgnbY7JmhZKsCg6PJFe2dsggRX
	 9glf8NfRlxGp5aI9VRxmURiWvXy47HuWg9e86W8yQJgePIoPguxJNDYdFzi2rf4zTa
	 CqYqM7X8GaDsWXsS4wG1R/+EufT/LXMzUPt4Rr+2fhTzNvRr12X0jGqRNusji+xoVT
	 VbYMqHs96NyZg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id D1AA127E856E; Fri, 06 Nov 2026 11:15:09 +0000 (GMT)
Date: Fri, 6 Nov 2026 11:15:09 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jun Chang <jun.chang@metanoia-comm.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	CL Wang <cl634@andestech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/25] riscv: add support for the Metanoia MT2824 SoC and
 MT5824 EVB
Message-ID: <f6bb6461-c9d0-4685-8c93-7e62691a93b8@sirena.org.uk>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="ZXWeqLAvAJo/GorL"
Content-Disposition: inline
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
X-Cookie: Whoever dies with the most toys wins.


--ZXWeqLAvAJo/GorL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=EEt Monin wrote:

> The series is organised as:

> - patches 1-14 add the device tree bindings, the Metanoia vendor prefix,
>   the RISC-V board schema and the SoC block compatibles
> - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB changes
>   needed to build and probe on this SoC
> - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> - patch 25 adds the MAINTAINERS entry

This sort of thing tends to work better if you submit the patches for
subsystems as separate serieses, it avoids enormous CC lists and keeps
the individual serieses a managable size.

--ZXWeqLAvAJo/GorL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau22vQAKCRAv73Ows9A4
iSNTAP4rU2Xrvxi8fy+eP8UEYNGho+uarNFSdWt9hM96/9EozgEApzMYGgxBMFYZ
W99aAqcYjlf4CTh09AToNdhaBlDyUwY=
=kTKE
-----END PGP SIGNATURE-----

--ZXWeqLAvAJo/GorL--
