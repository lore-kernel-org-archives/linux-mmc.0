Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749E3E8C7F
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811068; cv=none; b=aFUOwezbhPZAfijldUv94fcCZqtJ2ehxFoYLj9ucwZAozKsfzBXeMU227daJTPv6elO33JNmqTubWNsjipGQd4dGbGZX9Pds3kRcUgq3oiM4mk2+eRwcBBwXC+2F+06ccFEeljnbulYFPOJUekXay55h3ROiIJKs3Q+704Aa674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811068; c=relaxed/simple;
	bh=XGQ7NHF+XhOzwfBH+iiUL60sLkik4Blj2hd4+Hh0ya0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLKVjOzx6GHIxEm1GrnzcQR7Wan7dK02uiFar76S4VqLFTANTnUmMC7uaBXpm4lkY4QHa/AQgP5EL9YpwX8Hfq6LkPCGwONWPp4M5S94292bi5W8NHqjp8OqyNtwXTQGablSXj9cIpy6NE0Amo/VZ8Tyt8EKqHhrYkwuVAWGjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Hp9zMUGa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Hp9zMUGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=2xBC
	PCY1//ahnI0fG3RQjzgolV6AYohc9sJR49R8JDI=; b=Hp9zMUGaEQw/Y0zAhgZB
	g3/abp8N4nuIyBrNkuC+Odz+ySkpJcgc6C7iegcc9YGM4bMqXWiLoF1n1lDaOjF7
	rsBzGqzbHOwOuGqj0UdSLS56fAFCFu5O22fXkoNQEqInqbOBHw1HcbxLfGlOdGoZ
	o8Q2qgoczRnIPNajVyynIzDMoS2WHKULD9CtlzP6x3+NgewvIk/3CS8UyerbPPTM
	pgFukS70n+AOsxWnwN9OLx3pV3sGMd+G4GyCoBqfyb7cU7vOXjaxlZrvvENT3STY
	ihEbm6COvn5F9SlIstaDpwU/frNr+gvtX9eGflXqf9pg4hvMx0CkYMAUe9FfFaer
	zw==
Received: (qmail 1688655 invoked from network); 6 Mar 2026 16:30:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Mar 2026 16:30:58 +0100
X-UD-Smtp-Session: l3s3148p1@0a5ivVxMlsQgAwDPXzF+ANZpdrMKUeLI
Date: Fri, 6 Mar 2026 16:30:58 +0100
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
Subject: Re: [PATCH v11 1/9] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <aarzMtWd_GYqQhVz@shikoro>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
 <20260226-rz-sdio-mux-v11-1-c2a350f9bbd3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-rz-sdio-mux-v11-1-c2a350f9bbd3@solid-run.com>

On Thu, Feb 26, 2026 at 03:21:09PM +0200, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

