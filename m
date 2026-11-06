Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965204;
	b=P8L5VqXqptAMFwd91K8oXNfXtaZJLsoaH/lWdf+01DDqnAi00Ld9aG1/Cpu586uEYU3C
	 K0k7LkUtR9ZSPFR94/5pANBWqZ89QLWPoDgXNwspIZjkycYB8lPoynmMFbucbWDdX+p0p
	 mLdiANWn3q4N50HskTquD8BTMtGtq6H5WcCfKstQ35VM+G/gaGhD3MAh2yc94i4SZvUSh
	 awfoIwyfjJT36jwujdAcnLMJAQebCBjP8wvKlxydvmDmVAzH/aPj7wMS2qpFWHXnZVK9o
	 u0uLcePd1sZLeNvieMsqtBmJXS2X6mEx2nJqK5CsSDAlspZOuakssmHsB30VykgdVrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965204;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Imy96n3mofst6REH68Pim2J1L8h9RbLyJ5/t3nqBh0c=;
	b=1TehG3K2AfTlOxNsAz6uY3MSEOmteKk6u+QzchLyTbQKwfJhBWrc1Fn13ERLXcpqedZY
	 v0LzYJSt6sxEcZ8i0WHat6HbBMO6b6mzNmSpoLZBBeEgXVwKkL1PEMjhwkFQAXnq/CEzr
	 oI21VyXcKl7tPfsn3M8xe63D8ZwQ5NM/eGanZzeAoh/58fk1M+7NIEJJhCoGGqEBthFEJ
	 pIn094AZqJrqpVr8hYaDIVeodujxZ3dvUaI7xQ/t7ZmimTuvY4z09XMYsKlzUkIEQYssV
	 NwXMdBgOW5YdKbutOrOSxJA1sZxU01YT6sV6dF6glZRQ/954c1sWhPETmHatpe1OXag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnbNNrmr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E783606A914;
	Fri,  6 Nov 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnbNNrmr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE95C1F01564;
	Fri,  6 Nov 2026 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965203;
	bh=Imy96n3mofst6REH68Pim2J1L8h9RbLyJ5/t3nqBh0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GnbNNrmrJZr1EXhA6fczuX6JFcb+YECs2G+PhXagcPR6XFiRifzm/UVe/AWF8zDaG
	 Sae75TZH85AQ+7wPNeaJaz8FIZ9hIeaIFUTcgeuoaXsXBBKp+nMQMnKs9heiiLHEdG
	 zBciFaenaq/E3LSxKIGYlFIxsPLRR92PJVjNxixbzVsdzobsBag4sX2l0vfdjH3w5R
	 E3H22Qr3GcNcn2aTtLIk1yR6yr9vpS/wpgd7vqwPBK8VbAdJEii6fR984SknkL+4g8
	 w9uIl7I2ombovQsTaNdsCccEDyaFa9XlhtgqAjV+0hreoDytPoyhLGPaI/tgOsCRZb
	 9VctFN5G0ELNQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id B334F27E8CA1; Fri, 06 Nov 2026 11:39:39 +0000 (GMT)
Date: Fri, 6 Nov 2026 11:39:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH 01/25] dt-bindings: vendor-prefixes: add Metanoia
 Communications
Message-ID: <4bc702d8-6f07-42f7-bdff-e0ce3ffceb35@sirena.org.uk>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-1-86087eaf5af4@bootlin.com>
 <8c625e53-7944-47df-9b91-268d0cdced48@kernel.org>
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
	protocol="application/pgp-signature"; boundary="8nfF2+6VCmfv48fU"
Content-Disposition: inline
In-Reply-To: <8c625e53-7944-47df-9b91-268d0cdced48@kernel.org>
X-Cookie: Whoever dies with the most toys wins.


--8nfF2+6VCmfv48fU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 12:17:36PM +0100, Krzysztof Kozlowski wrote:
> On 06/11/2026 10:29, Beno=EEt Monin wrote:

> > Originally-by: Jun Chang <jun.chang@metanoia-comm.com>

> We do not have such tag (because we are not TIP). Drop everywhere,
> except for subsystems which explicitly accept it.

You might be thinking of Co-authored-by.

--8nfF2+6VCmfv48fU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau28ewAKCRAv73Ows9A4
id0tAQDOS9TiaPXjKxL5DtuumtSrZ/580roAZS7tEFRF113ZjwD/VYY9nSrCQvZC
HPSXOyFUJSaNLxctukdHGprNOTajWA4=
=w0do
-----END PGP SIGNATURE-----

--8nfF2+6VCmfv48fU--
