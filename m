Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C835285C91
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811152; cv=none; b=gipsguuqqtoe8vUyxCyK9KcMaZonghVvFdoLjvuQHTRoXWJyxkk/nphyvbt0s5TrFLdwqIgaPe3fOTtTOByXSMMac+E2mY44fnmS0vclNtZyx43aSPZ7JD9E7hIgqKn/463AfWE/uXWnpRYuR+x9RPLvNmpI3KV2kmX5W4UIREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811152; c=relaxed/simple;
	bh=GIr3jypu7QluMGkMWOJb8rn+7biYycEWCoIpn3ZDbrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgVv6n2fvVqn11O445uK7Z/7m1/FtQmhym/Zq9dYDIekZTciPVC86xyMIEAc9lpXWRiJKXgLRoL3a+mn8iAdNruRYIrGf2IgPKRj6lvJ/vf6qfY6xTljCkI+Yf/6danpmLAMKQH8Ck9/ZToWPwZ+EGz1pWfYD4Vxa3rQOHoXNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZhdWF2Cr; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZhdWF2Cr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/plQ
	uPXVcBaLPypqZ33pHs6uD47hDeoGcKqm3CV4JKg=; b=ZhdWF2CrB1OCdDkJHZtA
	JfTOlvS0uOzPkyIa1i0YLFeRoTTEy66ZvFG/L5txZRNrErvg2+1wtOzYSPtKKrCk
	C8hx9u9Pq4vBfMbaxCXxbbIduGg8wMtMKP6cMeltFFUxyXsBi844LmD6t4E4shQC
	VyUjOJ0mTq5wuWMo1YCHvuyIcMjZXDbF8c4yWwTkIBvb8b2fXPWCbg+PduSSbtoc
	ELA/4zd3Z8i3BuCBbQJe0NS5pGRVNMwjwSH6nYTGQbQWwMxGVDzwLcQ+HzfHcgnO
	bZD356c/LZpupu7xNLulohpsR5xelk9GQ6jj3c8qHYBHsuyfZkTyMbB7bz7ojgyE
	ZA==
Received: (qmail 1689275 invoked from network); 6 Mar 2026 16:32:27 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Mar 2026 16:32:27 +0100
X-UD-Smtp-Session: l3s3148p1@zQSpwlxMYq4gAwDPXzF+ANZpdrMKUeLI
Date: Fri, 6 Mar 2026 16:32:26 +0100
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
Subject: Re: [PATCH v11 2/9] phy: renesas: rcar-gen3-usb2: rename local mux
 helper to avoid conflict
Message-ID: <aarziuO2KVlAydDe@shikoro>
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

On Thu, Feb 26, 2026 at 03:21:10PM +0200, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

