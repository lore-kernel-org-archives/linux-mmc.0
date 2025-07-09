Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CA2253AB;
	Wed,  9 Jul 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082507; cv=none; b=rohU++IQ6s2ip2CHGMLC2KapL+6mvfJfYlOPnMiaE73pSdK5ydKYIqN7PGn5skRPVT7e2w4hnIueU+66pfG8w2ZwtlkA44Jqt6YghMgkJyNXberUSCLpPIVK49rDRj0Og2rpSFeI2kyrkb/6XvR6St9DVvsCeUfJEm0v/0deIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082507; c=relaxed/simple;
	bh=+64fnXIXSgNnCIG6if9Uadk28NbjJVWxSfgeT94QG74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF6q8gyTZEBXhwbOFTwHIYcQIUqMcTZ9JIFM7bddx/WOxV9RL1kRBxapVSUvYzGlM2RsBz98u90FyPPGcefcIQpyXdduzwElpETeoPkbmf+ety9S9Ta1nWHfpiIj5k8CJ9m6efEDq9+y+AWXKZGFj/WZWVSBzvPFQTiIYbD1cF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Ot9uvKj8; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Ot9uvKj8"
DKIM-Signature: a=rsa-sha256; bh=+64fnXIXSgNnCIG6if9Uadk28NbjJVWxSfgeT94QG74=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1752082383; v=1; x=1752514383;
 b=Ot9uvKj88SCNKZXhCwSLc7Mlc+19lqQn3riLUfvGUlHkwpR12dYtzxqtfXX5WgIcETyoHYb7
 3zAcaawntNY5dakJuNcoE1wSv36nxkOGQeX3JcxmCalOcx9b7noP7k3FmYytVXu75jbrtsusvQ2
 B9ukt85xBF8QA8e7X0pQZTdQF37Slb82WPUM6haiBwPokSNNZNNYi6g0qG2RJnAia1gg02HeNAc
 +bbAWjg+znV+Km5vvE31WZ2KBKK/w0Pm3p/T8N4WCbfgnvTkBlbC/NoAmYOng2vON81cbUVH5ma
 4sWmXdFHX1qlpqj/hc2csN530rcCW308NmGI7SLoylq9A==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 66672483; Wed, 09 Jul 2025 19:33:03 +0200
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
Date: Wed, 09 Jul 2025 19:33:01 +0200
Message-ID: <3379810.44csPzL39Z@radijator>
In-Reply-To: <20250709-spectacular-goat-of-tenacity-ced55a@krzk-bin>
References:
 <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
 <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>
 <20250709-spectacular-goat-of-tenacity-ced55a@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 9 July 2025 09:32:06 Central European Summer Time Krzysztof=20
Kozlowski wrote:
> On Tue, Jul 08, 2025 at 07:09:46PM +0200, Duje Mihanovi=C4=87 wrote:
> > The current pinctrl properties apply only to the pxav1 controller.
>=20
> Why they are not applicable for pxav3?

state_cmd_gpio is used for working around a PXA168 SDIO erratum. That SoC u=
ses=20
the pxav1 controller and no such erratum exists on any of the other PXA SoC=
s.

> > Adding one default pinctrl node to a pxav3 controller therefore causes
> > a schema warning.
> >=20
> > Check the existing properties only on pxav1. pxav2 and pxav3 may add
> > their own set of pinctrl properties if and when needed.
>=20
> This should be rather made complete here, because properties should be
> defined in top-level, not in allOf: block. Strictly speaking pinctrl-xxx
> are defined in core schema, but still the binding should follow same
> rule - define them in top.

Would it then be acceptable to declare the pinctrl properties in the top le=
vel=20
and define each controller's respective description: and items: in the allO=
f:=20
block?

Regards,
=2D-
Duje


