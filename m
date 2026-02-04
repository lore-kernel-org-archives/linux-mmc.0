Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417B42314C
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218408; cv=none; b=Lj/ktfjK94f1nlejfoaDC4vSffA0JLZL9oRER0A+3bkcZ5AHNNbmLECaKUM7/OVUBdFccezg3hE68TD49ujwofCvAJFKG287cE79zhVJh9VIh/BWQEAtYSqckP/xzeFIQU+tJiPd7ud09AGJaf6rgIC4pakeVIbHY69Xd8V88io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218408; c=relaxed/simple;
	bh=zm0/NWf7aOzjoC3desMvfaYsOJUqbgd1rXKOILzE9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn+kzqMrxahtsa4qWgMgvoOr6hvGcq2+c0SSnIx0kLucACkBY0RO3ZoWfA5GAvhLqhI7aJuW2JsyrRuK9SAeVHkCa6K417spvax2YJCWR/yY9M6ks1SbA6DBDCxuzHlqwJgA5LMWaZbfnA0NanJ6fcbOh+yoJSGgYjeIYbVg32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TITSY7QD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TITSY7QD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WcYB
	VxLBzN05bdXXm58VZxYg22L2CN5+zoOZnZfZw14=; b=TITSY7QDqs41Sop+siRd
	1tho1l/9ahyccHqLCXwIZHSw2EG+FWoC3cF17Xrh6/1JwiADM5p62YTCUvLHvvmz
	Uv4tut+UaxTcxX1oYGZJmrOZuZMP41+OMfPOdATpFJDy/QFOyQxbLQPdDoUE2O+z
	sSYsXVQ3qjIywdhSs/hZGp3DnDYmTCx3/QRnpcSaI48107S4vlW+Bj6ko0g+iGQI
	z0tTofr3YylcIRA6RWZfyNxRtgKP1GZgSJaOKa9ZCT6fTLeR+FuX5inFdeY/KvsW
	5ya/d+f9BpkFJYy11kEkq0QZqhlOlK4O2r7F+dl3syMxTMWwP0DBm9lvmuL9VRsZ
	cQ==
Received: (qmail 2408822 invoked from network); 4 Feb 2026 16:20:05 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:20:05 +0100
X-UD-Smtp-Session: l3s3148p1@/YExFwFKwpUqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:20:04 +0100
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
Subject: Re: [PATCH v8 5/7] i2c: omap: switch to new generic helper for
 getting selected mux-state
Message-ID: <aYNjpO3uJqO4N4r_@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-5-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-5-024ea405863e@solid-run.com>

On Tue, Feb 03, 2026 at 03:01:38PM +0200, Josua Mayer wrote:
> Multiplexer subsystem has added generic helper functions for getting an
> already selected mux-state object.
> 
> Replace existing logic in probe with the equivalent helper function.
> 
> There is a functional difference in that the mux is now automatically
> deselected on release, replacing the explicit mux_state_deselect call.
> 
> This change is only compile-tested.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

