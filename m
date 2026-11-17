Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912133;
	b=O/ZPzRgQOdtzzcKgXG6USoaFc+zKV2Jzq8EEmvbQnqqk7FawdtDZGYxpCeROsnBfHbej
	 SLMaQXH9+nGHfEYNCDtvyWCJ0l5gq52iDH+1J//i8WPKztq8ekxO5RZJ3f05SI0OMOCIH
	 8Q/QC+qvnJvghf9VSci6m3ZBc30wnMaVdcBo5sHtf3lkmFfrRi3MTwLoLt3BQ1B44SIkx
	 1t9nFFz3lJJDYW3U7TisWN+gQyQKBD1eoKWzvxPwsj9312mshMv6CcK7s2UKi3qWsm9WF
	 UAyyoEAb+uUp4iPrytZfTlrXHTGT5c5P7XDH0JIZQL7d9lxjepupCv+VABAWhWesccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912133;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=wceIsHyc0JJfV1Tp3tL8VGdKFtx5ifQ7EH/SXRMWvMs=;
	b=nmmBdQNCkXxgMSbdRmljKWXtuTqfv0QpuBAU655r6wlrLvZIIlZbz4bIp9nDjjNTTmBY
	 1n0UUnPADDVkMTQ4Sg7AaYcIH6VCz2OBFiytPXAYkgff3MaqGlTslkQkwOMBWcx822KGh
	 koHZAJcKgLWh/wnnp64NpOpr8ZH+a+AIKPTHJB7NZk5n1Hp2sd16EZ+R4GhaBKVHI+1xe
	 1ztke3KONd8+g3rtHcEJW2YHq/APZvsOqhkC0ERv2f/+LClUGNaHDpgBrdrw5aOidoKXu
	 H+nwtzbFiH3V33an8M0AB6g1mv8cASLZWZ45P8i+wQrAcqD3niSpHZoZN54k52ot36A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=a26lEPKG;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584E606A31C;
	Tue, 17 Nov 2026 10:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3584E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=a26lEPKG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AD1191A1605;
	Tue, 17 Nov 2026 10:42:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61C145FC81;
	Tue, 17 Nov 2026 10:42:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D08311BC05B4;
	Tue, 17 Nov 2026 11:41:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794912127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wceIsHyc0JJfV1Tp3tL8VGdKFtx5ifQ7EH/SXRMWvMs=;
	b=a26lEPKGpRLbN20V+Guhv3+Ri3lgmGzYvJ9lhcDbnoztwv8hrDn+FB4Wm5cL8Gq54hX4LI
	Zd/Zx/RRnC4xEEEZkSBZIY3E0VChxBDnl2qBszN/EpA8qomHLNGuZoi4h1mKqMjEeM57RB
	IgfkmPfTFxq1THD6o9kLLC1nehFx22DVjHITXSbV6kJy/1MskOp7pEkNeO8aCZRgve6liv
	iUXR2/+qBbBKrzLeD21mY0v+KPhOZEVl1opMjW1aTG+ZGaaaBInvMdB1XRbGlklCCCrwUB
	dTwnW0TPclaOwwjY9QmOmvSSZKdpJpXlXQ4AiibFZx2eouDgjXeanClktsboyg==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
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
Date: Tue, 17 Nov 2026 11:41:52 +0100
Message-ID: <_koitdIgQPmk89LDhlUlJQ@bootlin.com>
In-Reply-To: <f6bb6461-c9d0-4685-8c93-7e62691a93b8@sirena.org.uk>
References:
 <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <f6bb6461-c9d0-4685-8c93-7e62691a93b8@sirena.org.uk>
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

On Friday, 6 November 2026 at 12:15:09 CET, Mark Brown wrote:
> On Fri, Nov 06, 2026 at 10:29:57AM +0100, Beno=C3=AEt Monin wrote:
>=20
> > The series is organised as:
>=20
> > - patches 1-14 add the device tree bindings, the Metanoia vendor prefix,
> >   the RISC-V board schema and the SoC block compatibles
> > - patch 15 adds ARCH_METANOIA and selects the AX45MP errata
> > - patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB changes
> >   needed to build and probe on this SoC
> > - patch 24 adds the MT2824 SoC and MT5824 EVB device trees
> > - patch 25 adds the MAINTAINERS entry
>=20
> This sort of thing tends to work better if you submit the patches for
> subsystems as separate serieses, it avoids enormous CC lists and keeps
> the individual serieses a managable size.
>=20
I agree, and I am reworking the series that way. Version 1 was intended
as an overview of the complete SoC support, but it ended up being too
big for a single series.

So version 2 of this current series will be only the platform basics
(2 patches):

  - dt-bindings: vendor-prefixes: add Metanoia Communications
  - riscv: add ARCH_METANOIA Kconfig entry

It will act as a prerequisite for the following new series, one per
subsystem:

  - reset: binding + reset-simple support (the separate reboot binding
    is dropped; the RST block is described as a single node)
  - SPI: optional DMA/IRQ binding, MT2824 compatible, atcspi200 IRQ
    support + Kconfig
  - watchdog: compatible + Kconfig
  - MMC: compatible + MT2824 support (split between SD, eMMC and
    auto-detection) + tuning/HS400
  - PHY: USB2 PHY binding + driver/Kconfig
  - USB DWC2: binding + params

=46inally, once the subsystem bindings are accepted and the drivers
are queued, I'll post the SoC DTS in its own series: board schema +
cache/PLIC/PLICSW/PLMT compatibles + the MT2824/MT5824 DTS and the
MAINTAINERS entry

Thanks everyone for the reviews, I will integrate the feedback in the
next iterations of each series.

Best regards,
Beno=C3=AEt



