Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AD3A1BB;
	Mon, 13 May 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626694; cv=none; b=fl9+c3dwThbg68HkWamSgQ0oM1PilRG6CGHKWuMYz9JJ5Hps5Q9c2UwI6a1SvD8j7UZLDWKlyjmQAbTRh2u0J6gn0fxtPyMHis26qFYvpC+NAn5zZOiN0re/gUC07gLU/qC49QT9j+fTetEQ8YHazztDGJ2AMfLj1beFG64eXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626694; c=relaxed/simple;
	bh=57fZM2+CJ+hL4V48G83HQA+tgOjiimKWogurk2thYUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlTnLCCEmX5CaNp59ZwULR5i2XZ1mis1xhwQcOGgDHKFU2ErQW+tyQDi2M0B8XS7zH5macJ9MV0qFh0r3vUd561cY1EbKX9toL1yVa7YWTHdp1y8f4Qb4Ym/5A3ngkAT3HyOae+GWCbtlUoXKpDR5AWAvt6bdbdgRiCY2ly4Dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmsNO9zN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmsNO9zN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15146C113CC;
	Mon, 13 May 2024 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715626694;
	bh=57fZM2+CJ+hL4V48G83HQA+tgOjiimKWogurk2thYUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmsNO9zN1OA/q1Gq2nCgr0abq+WgVsthzfcBAOOEj4p0Kp2bZN88jyiYKI0GIwbna
	 Sbu32+V1CYQ6uhazji7m9MlROgolHRKycA4k9YG8aL/nOD4xNWOBH6BljBl/T2CO/m
	 9VkQ/veriSICNyyTUlQEEs2N79yjVkq+CFuTC1K2deygf0Fkhbet/9ix1ItTsF13wZ
	 8JgC92a61eYeIzyVK51ZhHKzAV7ejSZJn120RlMgGiCLrDQY+kYXgecJ9JdEmImbAM
	 jiN8aXyopVuvOTB5kjyJYk006jJUwoH1es1NX1e3G4yw+LTZhSyUh1Bd/n+hlk627+
	 33mEhOtDOU3+g==
Date: Mon, 13 May 2024 13:58:13 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, Eric Anholt <eric@anholt.net>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: mmc: Add support for BCM2712 SD host
 controller
Message-ID: <20240513185813.GA2931923-robh@kernel.org>
References: <cover.1715332922.git.andrea.porta@suse.com>
 <1f0c4fa62d6849753e2138cce5498693cfc3a230.1715332922.git.andrea.porta@suse.com>
 <01a7a263-9de3-468c-b438-c16f2c73872c@gmx.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a7a263-9de3-468c-b438-c16f2c73872c@gmx.net>

On Fri, May 10, 2024 at 09:01:33PM +0200, Stefan Wahren wrote:
> Hi Andrea,
> 
> please drop E. Anholt from the recipients. AFAIK she is not interested
> in kernel development anymore.
> 
> Am 10.05.24 um 16:35 schrieb Andrea della Porta:
> > The BCM2712 has an SDHCI capable host interface similar to the one found
> > in other STB chipsets. Add the relevant compatible string and relative
> > example.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 23 +++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > index cbd3d6c6c77f..404b75fa7adb 100644
> > --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > @@ -13,6 +13,10 @@ maintainers:
> >   properties:
> >     compatible:
> >       oneOf:
> > +      - items:
> > +          - enum:
> > +              - brcm,bcm2712-sdhci
> > +          - const: brcm,sdhci-brcmstb
> >         - items:
> >             - enum:
> >                 - brcm,bcm7216-sdhci
> > @@ -114,3 +118,22 @@ examples:
> >         clocks = <&scmi_clk 245>;
> >         clock-names = "sw_sdio";
> >       };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> Would be nice to have a short explanation in the commit message why this
> is necessary.

That has nothing to do with *this* patch. It's needed because 'reg' is 
dependent on it and the examples default to 1 cell.

In any case, please just drop the example. A new compatible doesn't 
justify another example.

Rob
