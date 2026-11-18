Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018135;
	b=WZq5LiIQESCP3NkV+Y+CxkRyJgztEwxpmeSSNyaRlFX9mOfN5ccrhXb8XWMxyGaDv/+S
	 UsWFn4v0wU99DzTX28nKq5wHIl45X3YsNHq7fQkKzZ5RBdk4MFNtjhydSVBD26W4wA6zg
	 iRJjGNrNBWkagBJEDH4l40hkRaw0jLhGmFAP7UaNCXbCnAS4nxwjJQYgaNuhsrhh+Tri7
	 2HHaxAe/CeXXjkZCT87ifaA+btDIMVZylwOTamvJz7TabNoVEwDpQMaYz7EyWMJyGJcT/
	 gssZCGxox9yecXICsjxGXy/jS6KL1iT/jbjH71t6A6z8L2jw7tMcWgIk+P79l40Ox3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018135;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=NyruYRmBJ333KKsYOsJfBubBYnjFdFekZpcsS68Afoo=;
	b=J4xZpVynxE7mjesYjl99fEZTmC0Jo5hzL+GCkIoC4aHffK3XdRRQ5GSKLw9dPbMwnvNs
	 Y2bgtgOdh2EhXL6+8B0icKt+rpQs8codyf8Kq9Z9PALGhgNS35HrEy0coyPPtgf86poLc
	 xFrL2XJll2VX0xDULxfvihKsVkU3G0Z6foC1u3NW++h3vPDbNRAi6wRfyvTHXAe+U6CYf
	 aQq/VyK7QzaEJbs+27uR6bTjgB8eba2hVH/WO/2J0nIAsUwEjSXGdJ5E1P9qmXbQRS0G6
	 o3MSzw8Hhlh4fqXMBkjARe8PK1EJ1nLjbPyWjHhgyrindR03hO1VjZSwNZcMbyv+uhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6cEgtil;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F835606A330;
	Wed, 18 Nov 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F835606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6cEgtil
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 14695C79A9F;
	Wed, 18 Nov 2026 16:08:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 299BD5FE9B;
	Wed, 18 Nov 2026 16:08:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD37011BC244F;
	Wed, 18 Nov 2026 17:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795018130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NyruYRmBJ333KKsYOsJfBubBYnjFdFekZpcsS68Afoo=;
	b=X6cEgtil8ijijO0rJLXA2fM6mfOKCqDSKEpQnIZl8O7QDvCmAFq44iTLtGiRg59T6tim+9
	BkfAmw+/K2LmZlkCdVN2sYKaDDdw/b0/mTAmoK6EDNyam9WvPm2KyqSsK6FFH80ZrBBRbl
	fOuG3P4fgquqDyFTbuhX5QPxzAzzTotAL3yURPLSCZ75iuwuF5fR7obk1dgbOVKjz5XyHU
	usLAW0L1/qdVNqF382CZu2aco6xcOyG4qofdf/C4tljy9+Ib67sXLpy0J5bWTKyaLMICZ9
	hf3TVLYsrb2HPg/gXOz12/t9aAj1TndcLvng+XJYM9BoHm2TlIq0tO3MLsgbzA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jun Chang <jun.chang@metanoia-comm.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject:
 Re: [PATCH 00/25] riscv: add support for the Metanoia MT2824 SoC and MT5824
 EVB
Date: Wed, 18 Nov 2026 17:08:33 +0100
Message-ID: <tSRWYJl8QRO6qpOrYOmeTA@bootlin.com>
In-Reply-To: <20261117-calamity-quiver-96d0d568b338@spud>
References:
 <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <_koitdIgQPmk89LDhlUlJQ@bootlin.com>
 <20261117-calamity-quiver-96d0d568b338@spud>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Tuesday, 17 November 2026 at 18:30:58 CET, Conor Dooley wrote:
> On Tue, Nov 17, 2026 at 11:41:52AM +0100, Beno=C3=AEt Monin wrote:
> > On Friday, 6 November 2026 at 12:15:09 CET, Mark Brown wrote:
> > > On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=C3=AEt Monin wrote:
> > >=20
> > > > The series is organised as:
> > >=20
> > > > - patches 1-14 add the device tree bindings, the Metanoia vendor pr=
efix,
> > > >   the RISC-V board schema and the SoC block compatibles
> > > > - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> > > > - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB chan=
ges
> > > >   needed to build and probe on this SoC
> > > > - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> > > > - patch 25 adds the MAINTAINERS entry
> > >=20
> > > This sort of thing tends to work better if you submit the patches for
> > > subsystems as separate serieses, it avoids enormous CC lists and keeps
> > > the individual serieses a managable size.
> > >=20
> > I agree, and I am reworking the series that way. Version 1 was intended
> > as an overview of the complete SoC support, but it ended up being too
> > big for a single series.
> >=20
> > So version 2 of this current series will be only the platform basics
> > (2 patches):
> >=20
> >   - dt-bindings: vendor-prefixes: add Metanoia Communications
>=20
> >   - riscv: add ARCH_METANOIA Kconfig entry
>=20
> Realistically, this does not need to be a prereq either, because you'll
> have "depends on ARCH_METANIOA || COMPILE_TEST".
>=20
True but checkkconfigsymbols.py will then complain about a referenced but
undefined Kconfig symbol in the following series.

> >=20
> > It will act as a prerequisite for the following new series, one per
> > subsystem:
> >=20
> >   - reset: binding + reset-simple support (the separate reboot binding
> >     is dropped; the RST block is described as a single node)
> >   - SPI: optional DMA/IRQ binding, MT2824 compatible, atcspi200 IRQ
> >     support + Kconfig
> >   - watchdog: compatible + Kconfig
> >   - MMC: compatible + MT2824 support (split between SD, eMMC and
> >     auto-detection) + tuning/HS400
> >   - PHY: USB2 PHY binding + driver/Kconfig
> >   - USB DWC2: binding + params
> >=20
> > Finally, once the subsystem bindings are accepted and the drivers
> > are queued, I'll post the SoC DTS in its own series: board schema +
> > cache/PLIC/PLICSW/PLMT compatibles + the MT2824/MT5824 DTS and the
> > MAINTAINERS entry
> >=20
> > Thanks everyone for the reviews, I will integrate the feedback in the
> > next iterations of each series.
> >=20
> > Best regards,
> > Beno=C3=AEt
> >=20
> >=20
> >=20
>=20


