Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFC396B6F
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391539; cv=none; b=qZthHzFxkOuZ7YZbON21AwiYvErzRKgBMx6Jm6TW7PXzoaTvmEOcGExAfhQZ7ZGIS4wF9YKcLk4aU4nsnApmRBXnftK96GCSSQ3lJsNN9uVMAk8M2TkLuVEJXG5wcLl6Mc1Cp4tTLah9Mr4weFVY517RhA7oLXZRKhP9fnh1CBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391539; c=relaxed/simple;
	bh=x41W9sfytGVKn5Dnw2ED9SlJy9/zuqHB/qFAvmU+OSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCPiNQfNUxlSz79Bdst3ITvwzpGNaQP6OL6c31YIa8izd/tQuwGxR6SwtDvmSegZyIlEfMuJ9Np6ciM/WEQyIxJcC/HtSg/ScLzCmCP4mdA8R3pmV2z5cOiCaqyaG7bcYy4rFopbK0vvGgKCqTXhOW44faLNOlTaso+6iSLWmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AA8cnIAy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AA8cnIAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BTPE
	LIS8djx1OvkVEDR+BzQIn/xiv3BxFTaCezloF98=; b=AA8cnIAylx1xeiFkNT4T
	ZIrmdY27f3LYoZO3GRgu9YyNYNLzRuyeH48q3dx+Ek0PAHENTGgXTSyzrtt7vTQt
	n5325scCcMepdnx/OYcgu8QMPQSzDguoUnV4dh34+BqqD2S4YDZqMbR6OIkqkT/v
	OxW4Fx9WoayurfG3rqbz05Td1BBdLEXFVfIIAbFtH8PATca+96Bbmfi0zb9+TNpu
	hIe2YYAbjs89/lwtJuw0mhom4UPGL0S9inZomLXBsrPNCCRFf76yHn2NmqF4popp
	LOTgKHK8dQS1+uPIIGLkxC7nZNlt4kjn1fXF2v+J4e2tCtpdmNZVwC6ISSxq5cpp
	Mw==
Received: (qmail 2114186 invoked from network); 14 Jan 2026 12:52:12 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jan 2026 12:52:12 +0100
X-UD-Smtp-Session: l3s3148p1@WQkZvVdI3K8ujnsM
Date: Wed, 14 Jan 2026 12:52:11 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Vignesh R <vigneshr@ti.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 5/7] i2c: omap: switch to new generic helper for
 getting selected mux-state
Message-ID: <aWeDa6o0fOh1pGW5@ninjato>
References: <20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com>
 <20251229-rz-sdio-mux-v4-5-a023e55758fe@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-rz-sdio-mux-v4-5-a023e55758fe@solid-run.com>

On Mon, Dec 29, 2025 at 03:27:29PM +0100, Josua Mayer wrote:
> Multiplexer subsystem has added generic helper functions for getting an
> already selected mux-state object.
> 
> Replace existing logic in probe with the equivalent helper function.
> 
> This change is only compile-tested.
> 
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Despite the pending discussion about the function name, it is clear that
the final patch will not go via i2c but some other tree. So, already:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

