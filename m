Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B733C1963
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218438; cv=none; b=Vo9FRnUyjPokHrVqs+qtjs68bhrs1bwD4pcDpscyLI7Lt5yoBl25b0EIpNBbBaK6r+5tSi+c8q1m3kbvZMFEmL1DkVzadychZtC58zWD1yhB9i4m3xxqh16dU4zmfQu7APk8vZWvJ2ZrRDdSflDG5cer6ITZrpsiE2nF68CgV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218438; c=relaxed/simple;
	bh=uCboFlE+8qHAPP2MtseXJMci7sYVqDsyI+p4lw5qvHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TljN5T8W9W6Z7N6829mDyJXODPDCpoI/Kzstu5tnp+1rA4qkC5bzR1vk8krZRAm8uGSi8rUvsm6LhlC+yUrH7YofEaArTu4ALNwT1uWv0mmSLPSWyGgrRub6uY/+JTLy7m6nAaz1tDXFD12/YVjtTnjqOnuOwlhaNorpfhTHH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FkWh0D0k; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FkWh0D0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fc34
	n9S8gHg/bFfzfbYnlhO01VSJ5IxePNrddiLXj/c=; b=FkWh0D0kw/qC3v+/UbmF
	7mMaA/bxdwtXpSZKKmb/h951YfqaZyuCprDndlZPbwOHCS6t3CDElsyLcal1iJW7
	+mEQJQkDmqm80X6EK3Y12/mdGJAo5sZqxM0rgTEbEKr00OQRWmc7TKt4x4uQ+094
	lWO7bC7pEu+okdJdXu/vdGNJJ0mPJ9qv+ht6k6Y4GOaqsWnkANcBMVQdLSpiBLrK
	4s/mgntmNdEtvbLKfJICmBXycPMzDCBnOP1SvY+9XALC6iHaL4ArVWWNrZDaxg/W
	SFD476xD76amT5DzeTkLhzDEdGw3VXB1SjKr76GQC5UVTuF7Uc64z+nN0lY//5o8
	DQ==
Received: (qmail 2409243 invoked from network); 4 Feb 2026 16:20:35 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:20:35 +0100
X-UD-Smtp-Session: l3s3148p1@Uyn7GAFK0oYqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:20:34 +0100
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
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 7/7] mmc: host: renesas_sdhi_core: support selecting
 an optional mux
Message-ID: <aYNjwgS6M5hCmEeL@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-7-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-7-024ea405863e@solid-run.com>

On Tue, Feb 03, 2026 at 03:01:40PM +0200, Josua Mayer wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

