Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A993E5EDB
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811224; cv=none; b=odQhQ8ooVMXqVFjBFhmCEFk95e34z4qoW6Rhw5oO/7Sz+nFpzPNzrbInFV5zglB4i61H5zxTGnuRZt1GICHU8UYyT10NVBo6sK092Wy7vOX31krHHInO3PSCrFbxeDh1r8qMTwAY4W8IxbKX/5CtM8JKWR7cchMcop0rm2bth+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811224; c=relaxed/simple;
	bh=NOPbRrbjpQ8Fe20m190BRndmWKRH5k1dxekpIJ87UZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvAE19HklR5RITogz5EAOHKk17UQtT8qoY1Uxf+w6j8V7yasJuq4qSKhPrEw9mCzro9/1nEWst6ttHFifxTO/J1a8tkTjaybhIb+E5MdV8icKX70XHoV+NXjVjHgnq/O+MCBR2EJcSdQ5tGeDudMX7q7A6ESVCkPn6AtuW/4Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Hbxka07x; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Hbxka07x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KBd6
	sAoIvc/ReQGblbOAHX8AXDUJz9fRBaxG9r07VOs=; b=Hbxka07xb59E95jigF6r
	YNwjNCepu5JnygW4H7r0FYklcn7864U1OYPO8kHihdpMNZpNpFH/D4MMU8jdIUmK
	WTwECChK7cUTnffvbwPhP6t4NZVoNC9ZiCWtP99aniFMO93VFlSbWWtC0ppzDDe6
	UjfpVbScXGeJ96x/jPbv+byHe/naA91rOtIbyOeIjAGaMfoEaaA1pxS0Sws78Uef
	xrv67lTd/HW7HtSeBQhIOabOmS+2522zKIpukLY8x1FELzkp692Ddu6p5OAqJl7h
	NWqLqsBTWSfwpv9y5oTlaOirx44bT9cZ97PkE4pF4fDouilIGgQxLSoFgR1eaqHG
	Gg==
Received: (qmail 1689921 invoked from network); 6 Mar 2026 16:33:39 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Mar 2026 16:33:39 +0100
X-UD-Smtp-Session: l3s3148p1@mqj8xlxMOIQgAwDPXzF+ANZpdrMKUeLI
Date: Fri, 6 Mar 2026 16:33:39 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 9/9] mmc: host: renesas_sdhi_core: support selecting
 an optional mux
Message-ID: <aarz0wSQG527Eofx@shikoro>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
 <20260226-rz-sdio-mux-v11-9-c2a350f9bbd3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-rz-sdio-mux-v11-9-c2a350f9bbd3@solid-run.com>

On Thu, Feb 26, 2026 at 03:21:17PM +0200, Josua Mayer wrote:
> Some hardware designs route data or control signals through a mux to
> support multiple devices on a single sdhi controller.
> 
> In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
> switching between soldered eMMC and an optional microSD on a carrier
> board, e.g. for development or provisioning.
> 
> SD/SDIO/eMMC are not well suited for runtime switching between different
> cards, however boot-time selection is possible and useful - in
> particular considering dt overlays.
> 
> Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
> it during probe.
> 
> Similar functionality already exists in other places, e.g. i2c-omap.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

