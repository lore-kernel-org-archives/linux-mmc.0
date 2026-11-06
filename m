Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989197;
	b=n6y8l1AJhWdW+hlZmVGakcdGebilWA+o3qYYSHbwbnMQbRXjDFv16O71JM73fN8JCAHa
	 qgjsfWP0WMQDOIb2TpCjk/R/uE+FDHaOMELiU6PnefMp5Pdvqo17Gdi4r2TZwAaKB3Aiw
	 tCN/KC2u66QVns8FqJ8AHgrwmxUrUDWa7RGawSf5mPbtF0Y/2ucNhsNLPBT38+6t5bziZ
	 en637b+G9S/DD55ID26AxLVOmZwrA2Sbrni7nOIOKO5il++hd3F7aEIaFPmDzxgRepNdG
	 UXhvcb2VdjrorOUEG8d3Kt5yAlSumSFgwekqw3E/SBCzM+5k39NYtC05rxKz+yXVoQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c/20RGI5WiHKKkpDTceQl002Lfa1bhsWYphTb3UDQkg=;
	b=mPZBs2TM14nLJc3wsov37lkZouzwbOeit0toNP8Q5HCgGxfEfKRBLCSKKt/oChnBC60K
	 STvGA0LZgdQgLi7xL9g0fgngKi/mQANLWsP2795FxAlXZLFXt/HXp8NMVpEGqYN/Xy4MD
	 kVG5kViWzeuzRgStwSUxiHQ3jAvQ+BG1Pbs1KVW66hX9qUVQ8+jkr93r9xf9daPJZXlaZ
	 6g1H/kadTaFO+X5bgQ5Zx45fWGnXzlfubvEB39+bi9kDvsAqT7HfhlPGmB+hZeROSaPgw
	 ldugFruwAUPwuq0968nYFDB5aQNIiXLa36oND3aa+lvGUzDd7FS9rnszpmquItS2emg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrBSVpvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8E606A333;
	Fri,  6 Nov 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrBSVpvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC2E1F008A4;
	Fri,  6 Nov 2026 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989197;
	bh=c/20RGI5WiHKKkpDTceQl002Lfa1bhsWYphTb3UDQkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrBSVpvJM7vkY1slHDjt9v9csvTLVw6DZE9OLBCH6kHBWwi/iB0GMO52uMbFZPMu2
	 aoxCVUIO3CfvqbM4ApUWQqMUyq7T507tTjGYhdLv9cHq0mKkBdnJcKicl10MAbOTO6
	 l2bPh4z/TPbXDyBRgQauffurjJJKfxnf8R5aSi4pzmXXl5IiGbbZX+1B8VF3IZ5rwr
	 0g7Tt8zM/nxj3oEc1nE9jrxUZVpbFdLHlwshhP4A3v/UkkQpvvX+reUCCcU7KAJ91b
	 dy37lW9arn8Wu6MQyOfyX701vpirgwBIQ4tvzJCyh+t3BrRDSXQUnDmZ8+xFdidOMf
	 sRqoiBHWy1upA==
Date: Fri, 6 Nov 2026 18:19:47 +0000
From: Conor Dooley <conor@kernel.org>
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
	Jonathan Cameron <jic23@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH 25/25] MAINTAINERS: add RISC-V Metanoia SoC support
Message-ID: <20261106-comic-cupid-a8a3c127307f@spud>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-25-86087eaf5af4@bootlin.com>
 <4f1e52d9-0788-4601-8f67-898256a776b4@kernel.org>
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
	protocol="application/pgp-signature"; boundary="EI85CRMW6gBoUvVg"
Content-Disposition: inline
In-Reply-To: <4f1e52d9-0788-4601-8f67-898256a776b4@kernel.org>

--EI85CRMW6gBoUvVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 12:22:15PM +0100, Krzysztof Kozlowski wrote:
> On 06/11/2026 10:30, Beno=EEt Monin wrote:
> > Add a maintainer entry for the Metanoia MT2824 SoC, covering the
> > SoC-specific DT bindings, the SoC and the evaluation board device trees,
> > and the phy driver.
> >=20
> > Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> > Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93abbb315065..310544f96204 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24072,6 +24072,17 @@ T:	git git://git.kernel.org/pub/scm/linux/kern=
el/git/iommu/linux.git
> >  F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> >  F:	drivers/iommu/riscv/
> > =20
> > +RISC-V METANOIA SoC SUPPORT
> > +M:	Jun Chang <jun.chang@metanoia-comm.com>
>=20
> So Jun will handle the patches? Can we get an Ack for this?

There's no tree listed, so probably Jun is not handling any patches...

I /could/ apply patches for this platform alongside the other one that I
manage, but I don't really want to and someone that actually cares for
this platform should be the one applying patches for it.

Beno=EDt/Jun, please see Documentation/process/maintainer-soc.rst !

--EI85CRMW6gBoUvVg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4aQwAKCRB4tDGHoIJi
0rbxAQDp+CX8P4FSxsxtp+sH+XOoVxSjimJET4S5CSWzGNHXFQD/b5cKyz3+v/zA
eq6hyBYC7BQX3uGp2UiAkQX4EfPpDwQ=
=dNYG
-----END PGP SIGNATURE-----

--EI85CRMW6gBoUvVg--
