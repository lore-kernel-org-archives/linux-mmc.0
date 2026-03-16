Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39338B7B6
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654277; cv=none; b=HQyPGcCBFdmEHlsOYAg4ODilleT5dWgOH2AjcDCW3/9oX5w7JppIDIR94v/4XyZglONqjCpC2xV4R3dY9ObShav+sZPX7MU2ANdy7XuVEq47scIopNaBSM7SIVdJosZ17bKo1QyMkDFht9OquPlWCHlItddT4YqgjFdNeD5G8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654277; c=relaxed/simple;
	bh=TG2aJSvJZ/wcZSsKs7YKB7Qcw/hVMLmolL8FopI8V60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eb2RzZgwFinnDCwBvQY34Mr2ow7KwfPJF3v5AFK+4ZF2gnDVPOGdp3ys6hX4TeMWrT9ODT5ukJDhgRfRPxlNS0/XtJTEeDTrX4Yget3CJ20TJUMXxmFaBWKLAFPe0wTlWw1n/z/w9OnJIB0SI/qsO19XCwIdWBGx7HSz5l1EaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UX-0007e2-Tc; Mon, 16 Mar 2026 10:44:05 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UW-000Y09-0o;
	Mon, 16 Mar 2026 10:44:04 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UW-00000000hnW-0gS2;
	Mon, 16 Mar 2026 10:44:04 +0100
Message-ID: <618f82e69dab57f9ba335e2fc4bb62d2d601f7cc.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery	
 <andrew@codeconstruct.com.au>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen	
 <ryanchen.aspeed@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Mon, 16 Mar 2026 10:44:04 +0100
In-Reply-To: <TY2PPF5CB9A1BE6CFB3FA0165159C68D3F0F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
		 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
	 <352a522b5325e9db80c880dd7a3a052516f3b673.camel@pengutronix.de>
	 <TY2PPF5CB9A1BE6C2F2EFFA36CD917C623CF245A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <TY2PPF5CB9A1BE6CFB3FA0165159C68D3F0F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On Sa, 2026-03-14 at 01:21 +0000, Ryan Chen wrote:
[...]
> >=20
> > Thanks the guidance.
> > I will update use
> > sdc->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL=
);
> > if (IS_ERR(sdc->rst))
> > 	return dev_err_probe(&pdev->dev, PTR_ERR(sdc->rst),
> > 			     "unable to acquire reset\n");
> >=20
> Sorry, I review the devm_reset_control_get_optional_exclusive_deasserted
> I will modify with following in probe.
>=20
> 	sdc->rst =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev-=
>dev,
> 									NULL);
> 	if (IS_ERR(sdc->rst))
> 		return dev_err_probe(&pdev->dev, PTR_ERR(sdc->rst),
> 				     "unable to acquire reset\n");
>=20
> And add reset_control_assert(sdc->rst); in remove.

Only do one of those two changes. The devm_..._deasserted() function
will call reset_control_assert() automatically. See:

https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_opti=
onal_exclusive_deasserted

regards
Philipp
