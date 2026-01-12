Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AFE192B75;
	Mon, 12 Jan 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233002; cv=none; b=b+Nw+dYSkUHjZP0uzerctDNSPSTcjJt8IH6cqrKqm1w3/75wt4s6JOX5h4um0iF+oeA7fHuyerAfaehYkMDj4RALotf9eGJeGBU6rgPf2W4yWDsFmPTx9enwBiP3Bjoj9EsTucm+5Pd1fDc0bLTtrqUXlfolH7jADphgAVydy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233002; c=relaxed/simple;
	bh=3y5BREYF/LYb3rDpeAJoU0WEgkB1oXbwP7algjJkQDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH/LHEPDtsKSqocfGUgKBoEIcezg6HZ1IH2gHtnvEgVE/Grd809EMtHvcAjPtMkrTMlN1mCm2ElfzUc+xxU0Pc4xemJf1cKh4o2jghqWQ848cep5SZDUKsyx/yBP1331O6MCgwLr8Ph4laMbeoEQpH4aU/ZMRyFcgdMu5rno8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2g5FBlw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2g5FBlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE3C16AAE;
	Mon, 12 Jan 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768233001;
	bh=3y5BREYF/LYb3rDpeAJoU0WEgkB1oXbwP7algjJkQDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2g5FBlwTJ1Zs9ZBUVulpUZNEe0rSRbmb4mldfSTzAjgWNAyMUZemR6myIMqpyV3u
	 h/a71rRyiG0HZ1MG4FH0T22R5ZDCrPT55aBNmkzlItmqQgvkn3JWOF+BGcT4bHWP0l
	 XzbmR3aBXRtqEQjpyHqk0HvWX8Rkle0hl65S+ZUmqP+XzWTkKez7xW+1DzZ9xWe9G5
	 dNlF19AyZ3QKhZ7IeFVVeezaSt/fK7ERnmySP1lS8a5jJqD2EJVIeZxnDKWTgVWCgM
	 u8JTRPVDUK8g3RXb58pZ777uZtMT4g50pePWfmjqk1bHOF/gdtQNDZ3rvx2AnHr7GU
	 PJAXURnNwuTAg==
Date: Mon, 12 Jan 2026 09:50:00 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	William Zhang <william.zhang@broadcom.com>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Message-ID: <20260112155000.GA285243-robh@kernel.org>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-5-124a53ce6279@kernel.org>
 <20260109-crouching-alligator-of-ampleness-aca683@quoll>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-crouching-alligator-of-ampleness-aca683@quoll>

On Fri, Jan 09, 2026 at 10:31:03AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 11:53:14AM -0600, Rob Herring (Arm) wrote:
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> > index e3978d2bc056..dc6421150c84 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> > @@ -28,10 +28,6 @@ properties:
> >        device. On a flash memory with 32KB eraseblocks, 0 means the first
> >        eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
> >  
> > -  '#address-cells': false
> > -
> > -  '#size-cells': false
> 
> That's probably separate commit. These partitions never used child
> nodes.

It's all part of making the schemas consistent in the handling of these 
properties.

Rob
