Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692568;
	b=ceTpDI8XVXfGlB9txf/1ss89FU8doISPmp0WbKETeTCCL+ILnlFMYT+dMc6xxSk15R4e
	 /kf2tBoaLNwWu2SMi0hrtUu+LzuEoU26K6OSMgt0AbEgZiIk4EDj6Pfe2dv5y5aw78qsX
	 Ol2ymOEzazKxeLV9wun4tTmd8lbURAocmf5Jo8q5ImVEvkQMEWS1pBBrc6CmNtQCLAC6m
	 eUAza+mBneoShOd2Ob9txCkbHngY5OUQ030Pr42amM2DNYEfSoWZq/H3FfFwp3RXLgkQ2
	 ZeTcy7osTcmHDZr+TdPkSTdnt3zE2v3p9ICoFWY3tZqDDPtiMoJxyne2/RkI0DEZKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KzkXaWiJVAGevwCKGmXrszqK2VboCvPIQ4QmMjaaIPc=;
	b=iHs0haUhd/Hb3tVz2GYMxwnIUVVJ4zdtg+noGbXNfDNoXE0ySDgtXT/3njvYp9x8kFIF
	 3QKB2Vl5CWlj+uDHPQIO6H3MBHy1e/pmjuzT10YRe4fPVGx0X1k94Jg0gtsGn7BVhGoxU
	 wPQD4eAC6hfyko+1GP207imQYiN7Ba97PXgUIQ28xm4ZH4jeuAg1VOyRXl8thv0ELBTPq
	 fFURTsOOpp/uuyuBjZ54KK3paQ0qZ55Rks75UKJFDaocTgHx0U1mK4xvwGIwTVj1zBbgA
	 NjMQwegvuyRn/IUQSspDPXmCa/5uBzy64rUdDLw8gO08GYak9wo9XC54To0XQN2/LTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGLBP+Jk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486A606A31C;
	Thu, 26 Nov 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGLBP+Jk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F051C1F000ED;
	Thu, 26 Nov 2026 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692567;
	bh=KzkXaWiJVAGevwCKGmXrszqK2VboCvPIQ4QmMjaaIPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jGLBP+JkU2AJkwG9HWQna8c8E2ZvqeVoV5+VRg7CN6hd6tZtRBknL2TpTaNnOZLkp
	 ++wUEWQMUvtqiKaa0n7aHWor/sUtoYJePQ4+wk8KbuBx+y4dNsrrB1DzOLdxu/fd84
	 7nJ+qaZaEIdV/ui+bWcw7Y9XXykuYFkNX5usk+qZyoZjTWQ8jTuqdAK+/uvAfhfBYm
	 vLD1rwU46gYuEBsyZVKz9IY7OLhaa+QXs5xBMV4s82f/hBfe/3SwdDDBmdRgkcmTu1
	 ImNQEPC/1S4bLzmmUQWpOrLnIUoLzzMnK5BacdDhrKMn8QfcSOGBubn0/jVnTBv2cw
	 Qqj2bkOrMtc0Q==
Date: Thu, 26 Nov 2026 11:29:07 +0000
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mmc@vger.kernel.org, aaro.koskinen@iki.fi,
	adrian.hunter@intel.com, aidanmacdonald.0x0@gmail.com,
	alcooperx@gmail.com, allen.lkml@gmail.com, apelete@seketeli.net,
	aubin.constans@microchip.com, bcm-kernel-feedback-list@broadcom.com,
	chenhuacai@kernel.org, christian.loehle@arm.com, djakov@kernel.org,
	florian.fainelli@broadcom.com, geert+renesas@glider.be,
	hkallweit1@gmail.com, jan.glauber@gmail.com, jbrunet@baylibre.com,
	jh80.chung@samsung.com, josua@solid-run.com,
	kamal.dasu@broadcom.com, khilman@baylibre.com,
	krzysztof.kozlowski@oss.qualcomm.com, lars@metafoo.de,
	lgs201920130244@gmail.com, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	martin.blumenstingl@googlemail.com, mirq-linux@rere.qmqm.pl,
	neil.armstrong@linaro.org, niklas.soderlund+renesas@ragnatech.se,
	oakad@yahoo.com, paul@crapouillou.net, pb@handhelds.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, pramod.gurav@linaro.org,
	rric@kernel.org, sameo@openedhand.com, shawn.lin@rock-chips.com,
	support@cavium.com, tony@atomide.com, u.kleine-koenig@baylibre.com,
	ulfh@kernel.org, wsa+renesas@sang-engineering.com,
	yoshihiro.shimoda.uh@renesas.com, zhoubinbin@loongson.cn
Subject: Re: [00/13] mmc: Assorted bug fixes across MMC host drivers
Message-ID: <20261126112907.GE38590@joneslee-macbookpro.roam.internal>
References: <20261123191703.179283-1-lee@kernel.org>
 <bc602723-07fb-4af9-9201-272dd0fe759e@web.de>
 <20261126085340.GC38590@joneslee-macbookpro.roam.internal>
 <9e76edf9-433e-43ab-a748-8a71804e2b26@web.de>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e76edf9-433e-43ab-a748-8a71804e2b26@web.de>

On Thu, 26 Nov 2026, Markus Elfring wrote:

> >> How do you think about to sort (and group) desired adjustments
> >> by affected software components?
> > 
> > This is new to me.  What guidance says to do that?
> > 
> > Making your own rules up and spraying them at contributors wastes people's time.
> Can the following list variant be more helpful eventually?
> 
>   mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
>   mmc: cavium: Remove MMC slots before destroying slot platform devices
>   mmc: dw_mmc: Disarm central watchdog when ending a request
>   mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
>   mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
>   mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
>   mmc: omap: Shut down cover timer before disabling cover BH work
>   mmc: renesas_sdhi: Disable internal DMAC BH work items on release
>   mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
>   mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
>   mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe
>   mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
>   mmc: tifm_sd: Synchronise timeout handler with request completion

No.  Stop making up rules!

-- 
Lee Jones
