Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021668;
	b=uYL0JzNcSkbi2E981jGSuxObHqwM5otrai4pd7qcoJDNHXCrrI5DavzThyTo7n4tdZ6v
	 rqVdZfBg87vVthLZXsY/H0SQ/TbcaCHcyMWSAYeT+hIC9XUO2xotM9MDU7fGpK/n0AToy
	 umM8MzVrpxe4aiwXBa/6Q5HE4zHxsw3ONYaSU+tAXrJQNXJgD3fTPnIH9XkzZmwtFaDik
	 JQ8c040ulOWNAfd+/mMgEoiZ5BKH+6olku+xboa76yWB3fDC9BZVcDbqS6gADe9u7A5RJ
	 qBYW7KGPCU8Mm4YHgGpFKDLGpvQ46fZ2qeIVA19zfwxqWu97j0wQDfLh7d05st6OlPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021668;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1082igN8AgArxQJ6WvmrNI+Gc7WS+2/LYjRpQ2Ge3Gs=;
	b=VvfeB1Edzq03VmidMcMgHRHKWBkChuLAmY98mxkeJQthDnxOECbqZzLWiGDlv+8g5+Cp
	 sFyrS8t+ImPtCV8DeDW6sWwUajFCWw0SVPNxO5INhF+XnUsAalmbdDOO9q9vz1geuNUxO
	 X6GnmoGovcWKDkjDx+WbZWDeKX1BrHvF4dDF1cUPGAaWlvg9URVBd9F7qlHgBCzjkr9ji
	 1sS2mtF3VABJFxwxn8vmkMgJjCaJgnvKNq6w36YjVzlV4Pe46G1NbpODw30cAQydQMhRi
	 cDnAGHS4dEKh04ddM6hGCh62Rfa/LOeNVxD61pbZ73VpbOaUAYU4JQy0C82+03iow0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCgNfw9F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607D606A32A;
	Wed, 18 Nov 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCgNfw9F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514611F000C4;
	Wed, 18 Nov 2026 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021668;
	bh=1082igN8AgArxQJ6WvmrNI+Gc7WS+2/LYjRpQ2Ge3Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QCgNfw9FgQK+sm5NRvdWobhMGhtjBzuObXQHEjX1yuhdiiBLYB0bTRTLmyx6fA8kJ
	 UHbkZjfg2xM6NV6Fx09wyv0Qw9cmOGqEbDfQynp0Xfyg3RI+neNW9r+ioVkyG+/A+5
	 8x6SbqumZKvLr+liTbgiCqHzllt++Dxv+YHm/HbjShj3gyfRl1pzdQOwAhqNzBovvm
	 f+PrOSIvLjHTBV0MzhK/eYbE6mY1kut9NlJ6uuMrjLdRizvupv1TeZDHBuSK+Q7zUo
	 Mibg2IC3WkhnVR7XiiG827juW4oPIHLCViYkj3mA0/csL0NMxbZRVcbTO19V3GeyAy
	 4FIPM3WQfqiWw==
Date: Wed, 18 Nov 2026 17:07:39 +0000
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
Message-ID: <20261118-unlovely-danger-3cab5aa87742@spud>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <_koitdIgQPmk89LDhlUlJQ@bootlin.com>
 <20261117-calamity-quiver-96d0d568b338@spud>
 <tSRWYJl8QRO6qpOrYOmeTA@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="qHjQ/oQFDRYJL6Ds"
Content-Disposition: inline
In-Reply-To: <tSRWYJl8QRO6qpOrYOmeTA@bootlin.com>

--qHjQ/oQFDRYJL6Ds
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 05:08:33PM +0100, Beno=EEt Monin wrote:
> On Tuesday, 17 November 2026 at 18:30:58 CET, Conor Dooley wrote:
> > On Tue, Nov 17, 2026 at 11:41:52AM +0100, Beno=EEt Monin wrote:
> > > On Friday, 6 November 2026 at 12:15:09 CET, Mark Brown wrote:
> > > > On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=EEt Monin wrote:
> > > >=20
> > > > > The series is organised as:
> > > >=20
> > > > > - patches 1-14 add the device tree bindings, the Metanoia vendor =
prefix,
> > > > >   the RISC-V board schema and the SoC block compatibles
> > > > > - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> > > > > - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB ch=
anges
> > > > >   needed to build and probe on this SoC
> > > > > - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> > > > > - patch 25 adds the MAINTAINERS entry
> > > >=20
> > > > This sort of thing tends to work better if you submit the patches f=
or
> > > > subsystems as separate serieses, it avoids enormous CC lists and ke=
eps
> > > > the individual serieses a managable size.
> > > >=20
> > > I agree, and I am reworking the series that way. Version 1 was intend=
ed
> > > as an overview of the complete SoC support, but it ended up being too
> > > big for a single series.
> > >=20
> > > So version 2 of this current series will be only the platform basics
> > > (2 patches):
> > >=20
> > >   - dt-bindings: vendor-prefixes: add Metanoia Communications
> >=20
> > >   - riscv: add ARCH_METANOIA Kconfig entry
> >=20
> > Realistically, this does not need to be a prereq either, because you'll
> > have "depends on ARCH_METANIOA || COMPILE_TEST".
> >=20
> True but checkkconfigsymbols.py will then complain about a referenced but
> undefined Kconfig symbol in the following series.

Do people actually care about this transiently failing in subsystem trees?
For that matter, do people care that the vendor prefix might fail in a
subsystem tree as long as it arrives in Linus' tree from another PR in
the same window?

--qHjQ/oQFDRYJL6Ds
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3bWwAKCRB4tDGHoIJi
0mflAP4mPyCBWxjRHa5hM3Th8QKGT/GcS2FW3txaiRkFbQ3zDQEAqGN5oVKdjCh+
kLDcm68sMAeSJ5Q0sGQa7uNSaVeIrAk=
=4VYb
-----END PGP SIGNATURE-----

--qHjQ/oQFDRYJL6Ds--
