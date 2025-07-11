Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEB1EC018;
	Fri, 11 Jul 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219119; cv=none; b=PGuyCPZzLZh9s2IQ4N94t61/7YdpAXQ1XJ9k/GwZ/8pwezA4xiHtyk/86IqfxsI1zBxNQpJW/XHT1e6On1eyFKwxBLJhwL5z7oo0+YQggTxaCzNxEAMqzs/ayG5mvtQcS4kzWvG1A7JU7/6QEjGR60GGuBPPAN6RgdYnVtN9PSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219119; c=relaxed/simple;
	bh=hVZTyegMOGHIfgb5zVAoq2b3YHNpgXqcGdsYOw+nS44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/vu2L9EATmtL4rnNBi9sjd2QyQgXWucB8cJ1E8QUrLKqVglbo2xBQ08rUxu+XPfZFWtriJEZKsaN53epls/MYPK15so/OUqwvcQcnqUgeiTx3tD6zy4cDeMeSog+xD1zVyZMdvOU3syM1igvFqxV2JPeCEcPZeDY0ioOd0/7y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSHD/9Q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSHD/9Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D64EC4CEED;
	Fri, 11 Jul 2025 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752219118;
	bh=hVZTyegMOGHIfgb5zVAoq2b3YHNpgXqcGdsYOw+nS44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSHD/9Q8xLGAYm9t0kngcck+7CL4v2e7cdoLWjILBqtSCcBC5RdsIN7I1WFAYm+GK
	 yl+AW+l0V/mLAZpZO06utBp+rUdqN3ufgSVqjxK0Xz+4nITgZzOWu6DU9ug9jLOcvI
	 bmx4dFNpeRv/VtW+C1OWY6eDKSFc9+DfkRdcx9qw5HoFh3BIvyg3XTARYpEzDgkPzn
	 uATVjVMJtGWoHCnilfze+nQPr1izPUphbLuT5c/kN+h1+quoL3jZMXjDkb2JUz3LB9
	 DjQipdLVktQUNyisCzjlNqAhXevWDuJIN3/7Md1QSLn1mlXGMZM5itLqUCjaCNYffJ
	 IzAKHNb7JaIpQ==
Date: Fri, 11 Jul 2025 09:31:55 +0200
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
Message-ID: <20250711-hypnotic-aloof-nuthatch-f3761c@krzk-bin>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
 <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>
 <20250709-spectacular-goat-of-tenacity-ced55a@krzk-bin>
 <3379810.44csPzL39Z@radijator>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3379810.44csPzL39Z@radijator>

On Wed, Jul 09, 2025 at 07:33:01PM +0200, Duje Mihanovi=C4=87 wrote:
> On Wednesday, 9 July 2025 09:32:06 Central European Summer Time Krzysztof=
=20
> Kozlowski wrote:
> > On Tue, Jul 08, 2025 at 07:09:46PM +0200, Duje Mihanovi=C4=87 wrote:
> > > The current pinctrl properties apply only to the pxav1 controller.
> >=20
> > Why they are not applicable for pxav3?
>=20
> state_cmd_gpio is used for working around a PXA168 SDIO erratum. That SoC=
 uses=20
> the pxav1 controller and no such erratum exists on any of the other PXA S=
oCs.

I really don't get whether you are describing problem with schema or
actual state of hardware, especially considering this patch. You use
here present tense, which usually means state before this patch, but
your patch is changing this. IOW, if current pinctrl properties apply
only to pxav1, this matches what you said about hardware, so job is
done. No need for this patch.

>=20
> > > Adding one default pinctrl node to a pxav3 controller therefore causes
> > > a schema warning.
> > >=20
> > > Check the existing properties only on pxav1. pxav2 and pxav3 may add
> > > their own set of pinctrl properties if and when needed.
> >=20
> > This should be rather made complete here, because properties should be
> > defined in top-level, not in allOf: block. Strictly speaking pinctrl-xxx
> > are defined in core schema, but still the binding should follow same
> > rule - define them in top.
>=20
> Would it then be acceptable to declare the pinctrl properties in the top =
level=20
> and define each controller's respective description: and items: in the al=
lOf:=20
> block?

just min/maxItems should be enough in each allOf:if:then: sections.

Best regards,
Krzysztof

