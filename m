Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EF2E718B;
	Mon, 22 Dec 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369534; cv=none; b=B/58u4ajU5sqdSd/79NeIf8+Q4d7YVrQziDniOV1BepUbRktyTE0IEDR6qJ8UzBYL7T/Wpy7jk3Yi5mSXR5swerQS24TDNGPlRSZihnonbXmbqjJce03JN2VvdE2XgY2k3TLOSfgfW4L2F4fsTVC3D5LTYof+P6BCV+LOMnsm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369534; c=relaxed/simple;
	bh=lJuG42Ox4SLBY4XTERA9sLRaFwJoWEs0Ltsa02k4+iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp7npaWZacA4OQaH1XKiDCKFoq9tjqTWYtPHT8syBDgXKAZlPdQj20GV+gTCNspx0QrPDUmj/AOuUss87AlgIthKNI7yMA05PN4i56oqS0wztUd5e+NWfAsTkxx0hs1fsra0u6jDYxmaQRxAVmN+f1kfdt73V2WWSwbdkq+w3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7A841340F4B;
	Mon, 22 Dec 2025 02:12:12 +0000 (UTC)
Date: Mon, 22 Dec 2025 10:12:02 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: spacemit,sdhci: add reset support
Message-ID: <20251222021202-GYA1977180@gentoo.org>
References: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
 <20251221-07-k1-sdhci-reset-v1-1-6780af7fa6e7@gentoo.org>
 <20251221-unnatural-resilient-trogon-7b20a7@quoll>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221-unnatural-resilient-trogon-7b20a7@quoll>

Hi Krzysztof, 

On 16:09 Sun 21 Dec     , Krzysztof Kozlowski wrote:
> On Sun, Dec 21, 2025 at 04:20:26PM +0800, Yixun Lan wrote:
> > The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
> > which shared by all controllers, while another one connect to individual
> > controller separately.
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > index 13d9382058fb..322c69b056f4 100644
> > --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > @@ -32,12 +32,24 @@ properties:
> >        - const: core
> >        - const: io
> >  
> > +  resets:
> > +    items:
> > +      - description: axi reset, connect to AXI bus, shared by all controllers
> > +      - description: sdh reset, connect to individual controller separately
> > +
> > +  reset-names:
> > +    items:
> > +      - const: axi
> > +      - const: sdh
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - interrupts
> >    - clocks
> >    - clock-names
> > +  - resets
> > +  - reset-names
> 
> This is an ABI break without mentioning in commit msg and without any
> justification.
> 
Indeed, this will introduce a breakage when combining new kernel + old dtb

Since in current case, the eMMC works fine without reset line operation,
I then would make this property optional (drop it from 'required' section)
and switch to use devm_reset_control_get_optional_xx() API in driver code

Does this looks good to you?

-- 
Yixun Lan (dlan)
