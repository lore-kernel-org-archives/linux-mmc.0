Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631552248A5;
	Fri, 24 Oct 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761344562; cv=none; b=EBqrlbeRKqIr67QHQ8roxjl+akztY2Yx2hxqF6iKu0HjVS1xjLdOgRJksa5nW7Xoutj+t0nJ3osnSZbOdRt90g/1/DHrd5SeNKqpZrURE8GkaErSE1miVcW7CfNaE5v5lYtohztNdEqwanCyJRHKhixRRMDj5k/FlGLQEiCl6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761344562; c=relaxed/simple;
	bh=x0eiuXrdmTl6hh6U1I+z1v6iUg7ks7RxigDFkDZWKbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLDPU1XmqnbgoQ58iainDa0HQLKhzHMvucM/us1YmQhT2apHQt0uWdrXeHlYtWs6k6oCcBRpOheLB/h+khcdJjYl1WEbiSradq2uBVeSacpaAwJ32Pz8pg4cw91qEKuZlW6+iTTA1u9oEmXYtuodGGzrym5/OOyBkIq+dFLTKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbHTXBsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbHTXBsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F373C4CEF1;
	Fri, 24 Oct 2025 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761344561;
	bh=x0eiuXrdmTl6hh6U1I+z1v6iUg7ks7RxigDFkDZWKbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbHTXBsIXMb6emK76hDcATn+fSmBmiiQuVccYbvGBtu7/wJZuAsixrnMSPui1bXuB
	 hvuLm1UHbXY68wuMBX94ZrI7r03On5Bj9kUyr0lXHU8azoIns2kQw+UsI1XnbbNECj
	 1TIv3cCpoFGUF0yAJPV+LGfi0UJUBPtuMiXNZIf/aTEeFPSHr+B326vjKDpQZCAVTt
	 s82D4TcOJ4DEVnBT/fT9IvB2svXVymb1WEFTSJLimZRJeFDqGrBqS8SwkoZX/IB2rN
	 LH0r65oLfsfTBw+e76G4BdjGL6qUxjBC4VTsyODZ+cPA353GUBdv7d1Yc6wZu59dQ+
	 Yr3LjJfQVu/bQ==
Date: Fri, 24 Oct 2025 17:22:39 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, hehuan1@eswincomputing.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, jszhang@kernel.org,
	adrian.hunter@intel.com, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20251024222239.GA2902515-robh@kernel.org>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115238.320-1-hehuan1@eswincomputing.com>
 <CAPDyKFqGwTF2w2JfqOuxMt6m_YJOYhqoUaQXyZALRu94W3fGkQ@mail.gmail.com>
 <20251024-aghast-poster-82ee7aa7fdca@spud>
 <20251024-polyester-gatherer-e7f5e4300262@spud>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-polyester-gatherer-e7f5e4300262@spud>

On Fri, Oct 24, 2025 at 10:47:34PM +0100, Conor Dooley wrote:
> On Fri, Oct 24, 2025 at 05:37:59PM +0100, Conor Dooley wrote:
> > On Fri, Oct 24, 2025 at 03:57:33PM +0200, Ulf Hansson wrote:
> > > On Sun, 19 Oct 2025 at 13:52, <hehuan1@eswincomputing.com> wrote:
> > > >
> > > > From: Huan He <hehuan1@eswincomputing.com>
> > > >
> > > > EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> > > > Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> > > >
> > > > Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
> > > >  1 file changed, 51 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > index f882219a0a26..7e7c55dc2440 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > @@ -30,6 +30,7 @@ properties:
> > > >            - sophgo,sg2002-dwcmshc
> > > >            - sophgo,sg2042-dwcmshc
> > > >            - thead,th1520-dwcmshc
> > > > +          - eswin,eic7700-dwcmshc
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -52,17 +53,30 @@ properties:
> > > >      maxItems: 5
> > > >
> > > >    reset-names:
> > > > -    items:
> > > > -      - const: core
> > > > -      - const: bus
> > > > -      - const: axi
> > > > -      - const: block
> > > > -      - const: timer
> > > > +    maxItems: 5
> > > >
> > > >    rockchip,txclk-tapnum:
> > > >      description: Specify the number of delay for tx sampling.
> > > >      $ref: /schemas/types.yaml#/definitions/uint8
> > > >
> > > > +  eswin,hsp-sp-csr:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    items:
> > > > +      - items:
> > > > +          - description: Phandle to HSP(High-Speed Peripheral) device
> > > > +          - description: Offset of the stability status register for internal
> > > > +                         clock.
> > > > +          - description: Offset of the stability register for host regulator
> > > > +                         voltage.
> > > > +    description:
> > > > +      HSP CSR is to control and get status of different high-speed peripherals
> > > > +      (such as Ethernet, USB, SATA, etc.) via register, which can tune
> > > > +      board-level's parameters of PHY, etc.
> > > 
> > > I would like second confirmation from DT maintainers, to make sure
> > > it's reasonable to model the HW like this.
> > 
> > If by second confirmation, you mean by someone other than me, obviously
> > ignore this, but I think this is "fine". It discussed on a previous
> > revision that all is being done with it is setting a handful bits that
> > signify that the peripheral has been configured correctly.
> > 
> > That said, I don't have a clue what's going on with the warning about
> > the dwmac device. That's definitely one for Rob.
> 
> Apparently it's just as simple as there being more than one definition
> of the same property. I had it in my head that that was okay when only
> one binding was applied to the node, but clearly not.
> 
> I'll have to un-review it until that error is sorted out.

This binding is fine. The error is in the eswin,eic770-eth.yaml binding:

  eswin,hsp-sp-csr:
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      - description: Phandle to HSP(High-Speed Peripheral) device
      - description: Offset of phy control register for internal
                     or external clock selection
      - description: Offset of AXI clock controller Low-Power request
                     register
      - description: Offset of register controlling TX/RX clock delay
    description: |
      High-Speed Peripheral device needed to configure clock selection,
      clock low-power mode and clock delay.


The issue here is phandle-array is really a matrix and an outer 'items' 
is needed to say there is 1 entry with 4 cells. Like this:

items:
  - items:
      - description: ...
      - description: ...
      - description: ...
      - description: ...

Please send a fix for that.

The tools could handle this case better, so I'll look into a fix for 
them.

Rob
