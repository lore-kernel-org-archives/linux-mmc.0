Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FB1E50E;
	Wed,  9 Jul 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046330; cv=none; b=l14/Ng1mQW2+RCpsZsrg9SORKbllUesT4rZCGpvQ0jgUIF/DV5WwfIuxWU4HeMynVwgdSMk1LPDbbRi5LpZd3hwvuiBSP/d6slLhMRmsjoxB/xxYghvgsLgZepbQ8S3tPADRCdfe9eUUNfaxCy2lvV1ei3rvQZ9V77l08L0NKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046330; c=relaxed/simple;
	bh=9O4wep8X80DnfmVYqTYuUTz8kwz/OoeOVVejGNflgW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcc4+b4QLVsl6M3J5fQdzO+QQsHZKhqYSGqkqXQBsltizWbpe6Yc3IrZZK2OVP29RELhRo/4BQ0prcAI8UYEzmlRuChySA0mP6aQIrPEaynKiX3S6WAw75QdRWMH1b7dvcp08R/GOFUAmyOhECyXIKq3P7XMAyd6JKQnfnWJNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9O01RLa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9O01RLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA84C4CEF0;
	Wed,  9 Jul 2025 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046329;
	bh=9O4wep8X80DnfmVYqTYuUTz8kwz/OoeOVVejGNflgW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9O01RLaIusvUqR/F5/lKlhbtGKqEdItzKwGaL4hISRhsf5Mhy3vHF/+UjRds0xZl
	 1GVNVlK5DEPm9psaU5Od/+qxB5DQWtYbxVInihuL8082el1hqwNRIMfuqCebnTU8pZ
	 aQA3wzK15XNOK1tVpfE3d01Wd+5+o1YyWeRZ+AKYTBrvFK5JnpfeURHIPyzRmN7kG3
	 CJJkwskmrqm2FW5P1fKNIbps2BKuIBU+aG4+aBkYWjrPVTOWWSGwSLi8mV1810tPJL
	 c87u/Phg/PE28r5b+PmWxGbdpB7JqrKJaydOEqQxx/GuqXP/kMotgvr3H7zAjn7hDg
	 DnzEBVDT/xRCA==
Date: Wed, 9 Jul 2025 09:32:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, soc@lists.linux.dev, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v16 1/5] dt-bindings: mmc: sdhci-pxa: restrict pinctrl to
 pxav1
Message-ID: <20250709-spectacular-goat-of-tenacity-ced55a@krzk-bin>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
 <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>

On Tue, Jul 08, 2025 at 07:09:46PM +0200, Duje Mihanovi=C4=87 wrote:
> The current pinctrl properties apply only to the pxav1 controller.

Why they are not applicable for pxav3?

> Adding one default pinctrl node to a pxav3 controller therefore causes
> a schema warning.
>=20
> Check the existing properties only on pxav1. pxav2 and pxav3 may add
> their own set of pinctrl properties if and when needed.

This should be rather made complete here, because properties should be
defined in top-level, not in allOf: block. Strictly speaking pinctrl-xxx
are defined in core schema, but still the binding should follow same
rule - define them in top.

Best regards,
Krzysztof

