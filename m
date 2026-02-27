Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F7368947;
	Fri, 27 Feb 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200369; cv=none; b=pzoRPFUsVBiWGWxYejiE5PA6mhHZFVkyhvw7s3LxHwZFw2V4dBCwbcONCn2/dFml1z9kwiqxgKbCl9S0WEGHOag2frSTD/oOo3BqfB87hQ6TNivQzmuBTrNBVY9AsU1IKmTs7w6bzRs7QhmzWMGNtqgugC0LyuWJ36xHpFPjRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200369; c=relaxed/simple;
	bh=1aioRZsT/x015BhRflc0NizKTzba3nmZZdRjXLysTLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6s1dQnQ5SLRgzMGgr7xfXqCuYuSdVmRYr758gwZoGj8r/xLWLSRA17w8YECXjuMDxwshO9FdaBBxxDOW5+p4bG1YdFiNEj8AS+Tleu1Fb4D2Xa9TvLkBHtMHdFtoDNpz16/v3m8KtR3fX6dwJclScI7mPfRC4+2Bd/bZqO3B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9u+RE+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9u+RE+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD974C19423;
	Fri, 27 Feb 2026 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772200368;
	bh=1aioRZsT/x015BhRflc0NizKTzba3nmZZdRjXLysTLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9u+RE+GZYJcdLan0zaWClwn6F42IEr07BRaJgqY5Mj3B9QCIoyhEfxIP8lhKvSFx
	 /P8blzbMtsST4PKq2w0d8KQ3RUV9OE6bMDSfEEsAAxhQgA6+EQ1HTrmsEocJsrB13T
	 UtBgDxK1E+HQEIICMcVUyv/afIdZmsLPAonvignBo87bmlB48jIFwqzjviRQN7ag/4
	 ePJNQ1XlKerWQKRxVWBEoH6F9hLmStbNidKD+AcQ8rm9n5YUEoWIJvQlB4bUBqYbCJ
	 dJbaB77eJXyRhcGGAkR44ykLnhqgCblK+YnLA3wcQzFn+EK+6AK+iVOwbXFUhoaTd/
	 U8SEKxgUOfeMw==
Date: Fri, 27 Feb 2026 19:22:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 2/9] phy: renesas: rcar-gen3-usb2: rename local mux
 helper to avoid conflict
Message-ID: <aaGhrecAflaK8jcY@vaman>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
 <20260226-rz-sdio-mux-v11-2-c2a350f9bbd3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-rz-sdio-mux-v11-2-c2a350f9bbd3@solid-run.com>

On 26-02-26, 15:21, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
