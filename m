Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE042EDD69
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710509; cv=none; b=HpEyz/j4gMAkbKao1+SgZ42h/3wffwSOLf2zoe7y15+5yw0XdlcbGm0fBGuPULsg5LLrKUPJTinc+ORC/7j/QqZ6OXWTYKlgKsPLsF0TmaH4zRxP9PrHD1anZZKLpCM9eAg05Jm5O94o5MpwJJ/dLHvC4PcuOJII/w7AslVVzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710509; c=relaxed/simple;
	bh=4MJvj2+fHYfSWTC96lU3fBxhfU5kqQ0zRTEQY/NwItc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPOnAlMQhS9cytYLdbM/XBoLpcUapOxWGb6qn32vp/ErIlxdyARcy6Epf4TIWFPB/8sUUA6Y+Df/E4m0WlqCSDCLd2n67oEWvqy2WVlZ5gA8rNFRhbTZogFA/c1+IoglkQ7UarDyKv3AvOTAn5fhmvab9C+ARe9VaM+IPle6Lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mZrJQ+RD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mZrJQ+RD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kMwJ
	sRUTY1+8DlXqwrzudKGi67r8tcF8NN0fyMeA4OI=; b=mZrJQ+RDSMYjGwdVp2wP
	GzAkcvLuH78nOpPUuIN36eh/2nTSF5H9WVKg1Gmg98Jwk3KE3AUZoOaY9JBtHaGd
	Frd6gTcLDqOz5v1S0wcpf/bx9u4Xm+FZlru7a6OhVRjpeHbtFEry2iHyQJXKqXY2
	/B3zB2GINvd41izUXf2jojEJp70bEoY5c5ypI/7SNyTIfZTavHXwVYRki6HuVT7F
	aUZPwL1Kits1/RJUOAAJQGhN+NZ5MOjw+t/8xMuEaODY+opLGlWzIdKv2HTd98Tq
	3Gkv3tFwhSZKxdKWUNedaH5aHSJow2GI0M5IvYzVsb6SZgB2pxySgwEnEWqefkVf
	/A==
Received: (qmail 4159334 invoked from network); 29 Jan 2026 19:14:56 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2026 19:14:56 +0100
X-UD-Smtp-Session: l3s3148p1@5gh11YpJZEVtKXEx
Date: Thu, 29 Jan 2026 19:14:55 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Message-ID: <aXujn-jpKLcBeFPE@shikoro>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>

On Thu, Jan 29, 2026 at 05:15:06PM +0100, Ulf Hansson wrote:
> On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> >
> > Some Renesas SoC based boards mux SD and eMMC on a single sdio
> > controller, exposing user control by dip switch and software control by
> > gpio.
> >
> > Purpose is to simplify development and provisioning by selecting boot
> > media at power-on, and again before starting linux.
> >
> > Add binding and driver support for linking a (gpio) mux to renesas sdio
> > controller.
> >
> > Introduce generic helper functions for getting managed and selected
> > mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> 
> This series needs to go together in some way. If you like, I can
> funnel it via my mmc tree, unless someone (Wolfram for the i2c part?)
> has objections to this of course.

No objections, I even acked the I2C patch in a previous series. Since
the series changed because of some of my suggestions, I want to have
another look at it. But yes, your tree sounds very reasonable.

