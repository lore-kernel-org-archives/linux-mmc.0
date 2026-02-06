Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20F1DE8BF;
	Fri,  6 Feb 2026 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346597; cv=none; b=D3KOtW/yjsHGfpC8AOBpkoJma1EDmfXp/59U5Q+3m6LoHkjLrz8vUqPrDfCfXo7G6zPkrlei7hgc5sBdDZ6JAyl//2wDq5U3fJL4aSP5JsBbcnzA4oli/sVR8r353bSKKSrgEEnOTfsY/1CrdbBMgVT+PNJgubt18C+PJA/2z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346597; c=relaxed/simple;
	bh=5U4Aa+9ffX2aQoyRKD4XohbecZEdjm9gcxPHiYmriqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8WVxEIdTxaDjGCrEv9hW/rEvIzfIkXVx1FABcv82jOh6U73yUK5e1L+dKrLLEjl7TbjppF9jMXtEssrj/oqTaAEIq0GFLNGwZash/GIUvD/jgezc0fYMbG/OiuR8AyaAdbBw+b6wec5pI6e0AVInCNrQBm/L24M8z5WquCqVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [183.192.223.177])
	by APP-01 (Coremail) with SMTP id qwCowACHLmpTWIVpqMY9Bw--.33109S2;
	Fri, 06 Feb 2026 10:56:21 +0800 (CST)
Date: Fri, 6 Feb 2026 10:56:19 +0800
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: Conor Dooley <conor@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn, me@ziyao.cc
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add sdhci support for Canaan k230
Message-ID: <aYVYU5ZwK1pfhumY@duge-virtual-machine>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204082908.27501-2-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204-imperfect-blitz-55fe5a85590f@spud>
 <aYRC/JVvyI6znWS6@duge-virtual-machine>
 <20260205-choice-require-1794796b10e5@spud>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-choice-require-1794796b10e5@spud>
X-CM-TRANSID:qwCowACHLmpTWIVpqMY9Bw--.33109S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4kWFyfZw4UCF4DtryfCrg_yoW5KrWUpF
	ZxAF98KF1vgF1Yy34Fv3WkC3ZIyr4ktr1kXrn8try7XFsYgF13Kr47Kw1Y9r1xXF1xJr4a
	9ayjg343Gw1ayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

On Thu, Feb 05, 2026 at 07:19:36PM +0000, Conor Dooley wrote:
> On Thu, Feb 05, 2026 at 03:13:00PM +0800, Jiayu Du wrote:
> > On Wed, Feb 04, 2026 at 06:10:25PM +0000, Conor Dooley wrote:
> > > On Wed, Feb 04, 2026 at 04:29:06PM +0800, Jiayu Du wrote:
> > > > The Canaan k230 uses the SDHCI from Synopsys. Add compatible strings
> > > > to the k230. The k230 has two controllers. MMC0 supports eMMC, while
> > > > MMC1 supports SDIO.
> > > > 
> > > > Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> > > > ---
> > > >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 22 +++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > index 7e7c55dc2440..cab33da3af7d 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > @@ -23,6 +23,8 @@ properties:
> > > >            - const: sophgo,sg2044-dwcmshc
> > > >            - const: sophgo,sg2042-dwcmshc
> > > >        - enum:
> > > > +          - canaan,k230-emmc
> > > > +          - canaan,k230-sdio
> > > 
> > > I don't understand why there are two compatibles here, when the driver
> > > is able to handle them both identically, using the common properties for
> > > mmc controllers to differentiate. Is which is emmc and which sdio
> > > actually just determined by how the k230 boards use them?
> > > 
> > > Or, if there are pinout differences, would pinctrl allow each to be used
> > > for either?
> > 
> > Hi, Thanks for the review!
> > 
> > Actually, the two compatibles aren't just board choices. They come from
> > real SoC-level differences between the two MMC controllers.
> > 
> > From the K230 Hardware Guide [1]:
> > - MMC0 supports eMMC5.0 and SDIO3.0, usually for eMMC chips.
> > - MMC1 only does SDIO3.0 in 4/1-bit mode up to SDR104, and the manual
> >   clearly says it can't handle eMMC because of pin count and limits.
> > 
> > And the driver treats them a bit differently, such as whether there
> > is a phy and the initialization method. So I think keeping separate
> > compatibles makes sense to show these hardware differences clearly.
> 
> Ah, I didn't notice that there was some logic, I just checked the match
> data and I missed that. What you have is fine then I think.
> 
> > 
> > About pinctrl, MMC1 pins can mux to other things like GPIO, but MMC0
> > pins are fixed in hardware. In next version, I will add pinctrl node
> > for MMC1 in the board dts.
> > 
> > Link: https://github.com/kendryte/k230_docs/blob/main/en/00_hardware/K230_Hardware_Design_Guide.md#mmc-circuit [1]
> > > 
> > > >            - rockchip,rk3568-dwcmshc
> > > >            - rockchip,rk3588-dwcmshc
> > > >            - snps,dwcmshc-sdhci
> > > > @@ -87,6 +89,26 @@ required:
> > > >  allOf:
> > > >    - $ref: mmc-controller.yaml#
> > > >  
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - canaan,k230-emmc
> > > > +              - canaan,k230-sdio
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          minItems: 2
> > > > +          maxItems: 5
> 
> Additionally, why does this have a range? Why is it not minItems: 5?
> You've got only one instance per compatible, so the number of clocks for
> each compatible is not variable.

You're right. In the next version, I will change it to minItems: 5.
Thank you for your review!

Regards,
Jiayu Du

> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: core
> > > > +            - const: bus
> > > > +            - const: axi
> > > > +            - const: block
> > > > +            - const: timer
> > > > +
> > > >    - if:
> > > >        properties:
> > > >          compatible:
> > > > -- 
> > > > 2.52.0
> > > > 

