Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936668;
	b=rsqb8spjgy8+N09jLGGqu6QqhPQnBcXqz1U8q6gJjDKnVvGPtEkvdNLGtIfcEYAtsWoQ
	 SL2QnxVaasNtSZ+vv5HhiGqIikMTrgqeQzqQ7a+xCP0ZPRGtocq7bGdxHLf7ZdmabN7es
	 /CtRUy81UfjkjOufiYXBTPiF7t/ORQKx3EKN1KgzxM53rHCSthsoWirPV8xv2nQZ/zhjL
	 SbY3KWOtdU7FtIUd/y04zeuEuXhjYPz3tmAXrsOMrZzqOLPSTYc7ueNBEoRKc1VIJu1co
	 yNwRDKLRhHHZqiJoBesjwmMMsOKrCIHA/t7zzCavLSZTln7wkr3pgaZoEKgwQokPa6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936668;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LkTA2fZGKt54LgX0tsQgX09c7+dqTc8gL6HA9sc7mLs=;
	b=P7hp4DQ+BOMELTWoGKN2MJkiTVEC3PPSp/Yqy8ECaFsQUSoVlWPAlWtDSumiRg1Z40k1
	 TonhbplKcJ0LoXeYgnp3sdjMq6V1+ipCNYIqel6bMIAary8OqZh55ZX9nSV8S8NBtbCzI
	 yzVK5nmWU8+E0QYTw14xjB4y1HjzggRj2d2SoQVAY/129k4v2blzZVf3OAMKuj/z1WQO3
	 1P+hi3OfFn+AvHI7xPHh7HqQ5JRcsmC5kZWCYkeYaTlfWKRDgRNaxfEtG2MFawRCE9GPw
	 XmUP3mmtHctnHq4cFKhU1fti1ctP7rOAHAMrRBsVGEsWIvxkvsI5WEzG+sJXpsBAxZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcnglDbx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23A606A31C;
	Tue, 17 Nov 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcnglDbx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB61F000C4;
	Tue, 17 Nov 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936668;
	bh=LkTA2fZGKt54LgX0tsQgX09c7+dqTc8gL6HA9sc7mLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WcnglDbxvWNx3BawIBmbTs6ZXBzryxbYuU6EJEGAOGS8UPG95ALzC/8nC5usZm/fM
	 CIPGNaq3mNpdS3+L+IsX/68xcqFYhrR3+lOmCzvON8o1KJRoXCIyh24u/znihbQUlO
	 G0dw42LOnRdcT5FM1u4uZ//DVzxUAo7c5d5pYgnjsebmEdw19rRvfcoWp2CeTbCCjn
	 4QARIu4ZhvQ9wGj6PO4AKN1JfWnBdHwUmwjdd5X9sQTAdo98vw32OPf6vUoJRX4XUc
	 hshP4bXmOKi05J1SyuJBd0sYRWpyIpRyrhNB2gxRky7p2usScFTOcjPlbXm+cBSaGC
	 HGReg6oO5EyRw==
Date: Tue, 17 Nov 2026 17:30:58 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20261117-calamity-quiver-96d0d568b338@spud>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <f6bb6461-c9d0-4685-8c93-7e62691a93b8@sirena.org.uk>
 <_koitdIgQPmk89LDhlUlJQ@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="BcuOzLdY9wrmX3Fk"
Content-Disposition: inline
In-Reply-To: <_koitdIgQPmk89LDhlUlJQ@bootlin.com>

--BcuOzLdY9wrmX3Fk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:41:52AM +0100, Beno=EEt Monin wrote:
> On Friday, 6 November 2026 at 12:15:09 CET, Mark Brown wrote:
> > On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=EEt Monin wrote:
> >=20
> > > The series is organised as:
> >=20
> > > - patches 1-14 add the device tree bindings, the Metanoia vendor pref=
ix,
> > >   the RISC-V board schema and the SoC block compatibles
> > > - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> > > - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB changes
> > >   needed to build and probe on this SoC
> > > - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> > > - patch 25 adds the MAINTAINERS entry
> >=20
> > This sort of thing tends to work better if you submit the patches for
> > subsystems as separate serieses, it avoids enormous CC lists and keeps
> > the individual serieses a managable size.
> >=20
> I agree, and I am reworking the series that way. Version 1 was intended
> as an overview of the complete SoC support, but it ended up being too
> big for a single series.
>=20
> So version 2 of this current series will be only the platform basics
> (2 patches):
>=20
>   - dt-bindings: vendor-prefixes: add Metanoia Communications

>   - riscv: add ARCH_METANOIA Kconfig entry

Realistically, this does not need to be a prereq either, because you'll
have "depends on ARCH_METANIOA || COMPILE_TEST".

>=20
> It will act as a prerequisite for the following new series, one per
> subsystem:
>=20
>   - reset: binding + reset-simple support (the separate reboot binding
>     is dropped; the RST block is described as a single node)
>   - SPI: optional DMA/IRQ binding, MT2824 compatible, atcspi200 IRQ
>     support + Kconfig
>   - watchdog: compatible + Kconfig
>   - MMC: compatible + MT2824 support (split between SD, eMMC and
>     auto-detection) + tuning/HS400
>   - PHY: USB2 PHY binding + driver/Kconfig
>   - USB DWC2: binding + params
>=20
> Finally, once the subsystem bindings are accepted and the drivers
> are queued, I'll post the SoC DTS in its own series: board schema +
> cache/PLIC/PLICSW/PLMT compatibles + the MT2824/MT5824 DTS and the
> MAINTAINERS entry
>=20
> Thanks everyone for the reviews, I will integrate the feedback in the
> next iterations of each series.
>=20
> Best regards,
> Beno=EEt
>=20
>=20
>=20

--BcuOzLdY9wrmX3Fk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavyPUgAKCRB4tDGHoIJi
0u31AP0dJRd3avDcA8zq/be2KJLowwp03Bx+1e11P7wMqhKhSgD+NGQuQVH14+ta
vo0nqDQxea6EE+XzXZ9SOeXFMg+dqQ0=
=Y40v
-----END PGP SIGNATURE-----

--BcuOzLdY9wrmX3Fk--
