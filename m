Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683232;
	b=WTNe/x+OBbKh+KeNtthE9owJZ+cu8LIS2dkbodqZM0SuN75sp7zkMPNnourbYXLV8EYV
	 8Y4jK3vo16sbBgCm33ohpkiJY0OTYacswe71Wdot/+mPtMGgzGM89FxN1EL/LhMMtGonB
	 a3Nbx0FEAEY0S4g19krApsmboPdv+KFJOmNnlHGYh/eqpWM0VbN+FDxX2A/MQtx6Y/9tp
	 tP3x3p+FkWhAYNIOwmO6D54aagThxN8L6+BR2K3hDJUA2WiW9qRT/CoR7Te30ExDUMsmo
	 bPIUkqs48oXT3NxETGLmAXLqDPn56oomtCO7/P5bBqF9X9BkkCSnc9/+3uA9o27xtmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683232;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nzEKGWM8XJphHX6pI/ArHGtfH8d9j0dSK2RH8XdKPD8=;
	b=3iy+iSi/PUTgyE59mV/p5KBtulFVDTrYvGh4ofxuzkXHzynaLVZbjVFG02LU+xYMcH2v
	 CptE/dwzyKS1xQe913cGxyJlyS67HXM/2bQWdStsTUL9mwNQ+xtuUXYuYXyPN4Ix3yQ2s
	 8TjEqIR5QeMTi9EXF+cRlTfbNoRqjGB26elOwuIKIh8QLiY2cqxaBlibWuJeKAU5aPz80
	 nK7oHl6UmsFH/XGPrIbAzAGzi6HRzdSX3yAg0tliRgdBm9qItyfmfNjkGYYrub7z6oxXs
	 SpqANxxjG2/vwLOqLMj6D1b9dyvHOhj/MQSJZWgDvUxdN+g0OHZkqS2fKmF1m6XpG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGbB2D8d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00D606A31C;
	Thu, 26 Nov 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGbB2D8d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D431F000CA;
	Thu, 26 Nov 2026 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683231;
	bh=nzEKGWM8XJphHX6pI/ArHGtfH8d9j0dSK2RH8XdKPD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HGbB2D8dDi8WEhaIq3D5hivqa4ok6pf476MsWCWGtQf5SRgtyxnAWKscKqkY40j+o
	 84oHtK2D94U0vboMk/gXQV6IHfJ37g1xEV0SSahxoUFBzBreEJSVlWbslpzGLbC6kS
	 3x7cGKmzYUvdPnuxOW+Wz51xGtSZ5uYpWT00NJVv/7S1wEZKGhaooAWvTO7PFdqm79
	 +JZrNFvQcI6N1lgA8QVMHfukPEmtY9TfArBzQmHKU6ayesucR0KBNoXDrxIiTOrZ5y
	 /6nNJwhLQ4yJnyZhvOOEZ5Y4TuIAy9SxYtBtlYKXGGlMgczNEUe+HVQsKgvZudyiUX
	 2T0CTuapbNqMA==
Date: Thu, 26 Nov 2026 08:53:40 +0000
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mmc@vger.kernel.org, Hiroshi.DOYU@nokia.com, aaro.koskinen@iki.fi,
	adrian.hunter@intel.com, aidanmacdonald.0x0@gmail.com,
	alcooperx@gmail.com, allen.lkml@gmail.com, apelete@seketeli.net,
	aubin.constans@microchip.com, bcm-kernel-feedback-list@broadcom.com,
	chenhuacai@kernel.org, christian.loehle@arm.com, djakov@kernel.org,
	drzeus@drzeus.cx, florian.fainelli@broadcom.com,
	geert+renesas@glider.be, hkallweit1@gmail.com,
	jan.glauber@gmail.com, jarkko.lavinen@nokia.com,
	jbrunet@baylibre.com, jh80.chung@samsung.com, josua@solid-run.com,
	juha.yrjola@nokia.com, kamal.dasu@broadcom.com,
	khilman@baylibre.com, krzysztof.kozlowski@oss.qualcomm.com,
	lars@metafoo.de, lgs201920130244@gmail.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	martin.blumenstingl@googlemail.com, mirq-linux@rere.qmqm.pl,
	neil.armstrong@linaro.org, niklas.soderlund+renesas@ragnatech.se,
	oakad@yahoo.com, paul@crapouillou.net, pb@handhelds.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, pramod.gurav@linaro.org,
	riteshh@codeaurora.org, rric@kernel.org, sameo@openedhand.com,
	shawn.lin@rock-chips.com, support@cavium.com, tony@atomide.com,
	u.kleine-koenig@baylibre.com, ulfh@kernel.org,
	wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Message-ID: <20261126085340.GC38590@joneslee-macbookpro.roam.internal>
References: <20261123191703.179283-1-lee@kernel.org>
 <bc602723-07fb-4af9-9201-272dd0fe759e@web.de>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bc602723-07fb-4af9-9201-272dd0fe759e@web.de>

On Wed, 25 Nov 2026, Markus Elfring wrote:

> ...
> > Lee Jones (13):
> >   mmc: cavium: Remove MMC slots before destroying slot platform devices
> >   mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
> >   mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
> >   mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
> >   mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
> >   mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
> >   mmc: tifm_sd: Synchronise timeout handler with request completion
> >   mmc: omap: Shut down cover timer before disabling cover BH work
> >   mmc: renesas_sdhi: Disable internal DMAC BH work items on release
> >   mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
> >   mmc: dw_mmc: Disarm central watchdog when ending a request
> >   mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
> >   mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe
> ...
> 
> How do you think about to sort (and group) desired adjustments
> by affected software components?

This is new to me.  What guidance says to do that?

Making your own rules up and spraying them at contributors wastes people's time.

-- 
Lee Jones
