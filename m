Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACF230BE3;
	Mon, 14 Jul 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531917; cv=none; b=hg9xhNy6FJH9bNa3XOvYjuEYKBiJpjuaUO4SfRKJ2Cq1En0Iw2oODQw66TxRFoYWDrvt91+Xg4QPMl1hUkz9RsJBAqmfcO0OPdoHPoGUIpa8HxmZbrfV5FHo3bJFWCyr0OE4q3/LvvF6caC6RGsFyOSvX0PK+Mmw02qhl4zEya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531917; c=relaxed/simple;
	bh=4XuX/PYpEN8nAtv8oHkTyRtLKNxOjbkUhAeP/vk/0C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2cIIT/tcQrLI8XfWc9tnJTvmd1Hma5wKcG2HrxNwaRPZAhQcU9KZuvZ/pz01iNk8FR7kkMU/hLIxLuIuIRsqcHmbfeUayPMJff3SQ7VgUFH2+tuDa5YrBqaDKudzuCLUdG3eAfb3QL5wUYVBzq2wnDSNq10HeL8w4QbxvUAu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=uBtMImE8; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="uBtMImE8"
DKIM-Signature: a=rsa-sha256; bh=4XuX/PYpEN8nAtv8oHkTyRtLKNxOjbkUhAeP/vk/0C4=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1752531826; v=1; x=1752963826;
 b=uBtMImE8MkSWBszj0mA40VHczqtf8SMXQ+Djm8Dkyh0so7//byOoCXCmE9OkaVtPsNlGaeEi
 DkSO1G1RHzD3hG5xKWZyX6nhG/w4WlcGmHfsrI0K4Ll8fgKLRcF4TMnCnHzzAQbiP2QlxP3TjAR
 jyPutFkgO0QlnVBVd/OvljASXZB+pOsnQ7KZy8StpEBa4/AH2ui/c0eO7VWtScoT1COiJjCAuGk
 V3UIZqWWbSyGQlkPzClEB3duAVeBfjpgouVSPnbx7Y9P72J0KfYUJFsWuE0dFUbPJY05rphxsst
 iJ0hXcfiTtZgtrAKpukggmMvZPiarK78NijZlLIkM1iAQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id acbc0645; Tue, 15 Jul 2025 00:23:46 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>,
 Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, soc@lists.linux.dev,
 linux-mmc@vger.kernel.org
Subject:
 Re: [PATCH v16 1/5] dt-bindings: mmc: sdhci-pxa: restrict pinctrl to pxav1
Date: Tue, 15 Jul 2025 00:23:45 +0200
Message-ID: <3028096.e9J7NaK4W3@radijator>
In-Reply-To: <20250711-hypnotic-aloof-nuthatch-f3761c@krzk-bin>
References:
 <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
 <3379810.44csPzL39Z@radijator>
 <20250711-hypnotic-aloof-nuthatch-f3761c@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 11 July 2025 09:31:55 Central European Summer Time Krzysztof=20
Kozlowski wrote:
> On Wed, Jul 09, 2025 at 07:33:01PM +0200, Duje Mihanovi=C4=87 wrote:
> > Would it then be acceptable to declare the pinctrl properties in the top
> > level and define each controller's respective description: and items: in
> > the allOf: block?
>=20
> just min/maxItems should be enough in each allOf:if:then: sections.

I guess for now. Later however I might need to add a state_uhs setting to t=
he=20
pxav3 driver; is the method I described right for this or is there somethin=
g=20
better?

Regards,
=2D-
Duje


