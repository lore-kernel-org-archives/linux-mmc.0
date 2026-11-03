Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749847;
	b=SJhQLf97HhapvImO0gEFvRObKsQrH5wHywmPY5pd1hdmdlDhDpCkRv6EeaXWCw6K9Uct
	 h0N9Q9aCHN7IIyMZbXIgqVsJezq7flhZIVRmwp1jkgr5TevXkBJosSHAPq4LJ/PV6cqM0
	 0ElRQ3BJDNTrbgD29PgwwqWW5bMeU81x+bvBIrtEDIq5x30l1s516hlyzHY2wLnY9yhyE
	 wXJTCmnNoMUBw3ihDEzquYQxG9qg2p9cCemz3H7cH+a0P1oMacy++SXbIC/B+Xgt5xrt3
	 GuXHkxC2D6CeZnTTz25p0qkaVwZlKLDS7oGWwHkEzrUvtwaSrF/t71khOkDUry0a7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0OloGj8iqKak18KyQuj2NIrdPY6e7xUKRD+nnxZZVqY=;
	b=leIIO2zkba/RdyP7fOshpJHXuHz9zCTcG2gXxX/OBrU3UWpE8V+5sdLD0OgEvsVrhunM
	 rPZnZQFBodcsTDSjCsDIO/owSOAfQM2jnWp07uYR3i0FUFaVj8aSobSaniHMnUXNc9jbI
	 BKDP3GTU18sUIQgMwLf7978J4ad0mBJ68ctq+yYX6IXUYwnpe3uBPdMBZjRnHtCfZ+L7O
	 fgPyhm6/AaV2KgBOry/eZT7/2vRR/Ywy3mk/PhPk0IPgOa5UtphTpnYOEJh3iF/OrZJTM
	 TEepabgpo7bZi7Zae/hutFwG8p0j1kgilM4oC6fe3tcP38+F3eUxtFGdMMGxuaWXY9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkNOS+n3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A1606A31B;
	Tue,  3 Nov 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkNOS+n3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E34F1F000C1;
	Tue,  3 Nov 2026 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793749846;
	bh=0OloGj8iqKak18KyQuj2NIrdPY6e7xUKRD+nnxZZVqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hkNOS+n3+2hTgtkaxcCoOXsqKeBibGisfXFzrpRmY7LplYQFpzrmZHBGX9uZamzEK
	 YIjrgp0RlH3L8+ZTpIXFWcKBVnKnqnQLdTPPdLzDV2f2TL5snlf5WELDPs0PLY5OG7
	 TJ0L5VSvgIIB3U7F4ngv+ca8WBjyPoT6ljkRm6uN1a2CYlSsDFabcGGmiXq5HGFsBz
	 OpXtK8CVAXjDBAlE5bL/EVWbXtP2bGQ6onIxxcOpUJC2QjJZrwvP6b4+MvSwrGPSvD
	 5RPka96oZUfza5XWX0mEM4pW6Pt4lJ0RaeSfVs/rEUjhY2vlB0o3KWGlXxzcntQ/XA
	 MdrsFZKUgSmgA==
Date: Tue, 3 Nov 2026 23:50:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Ivan
 Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, Srinivas
 Kandagatla <srini@kernel.org>, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>, Hans Ulli
 Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Ray
 Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo
 <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>,
 Alistair Francis <alistair@alistair23.me>, Julius Werner
 <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, Dmitry
 Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-gpio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 linux-tegra@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <20261103235033.3e508f69@jic23-hlaptop>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
References: <20261102135330.2493332-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 07:53:22 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/display/xylon,logicvc-display.yaml      |  2 +-
>  .../devicetree/bindings/dpll/dpll-device.yaml        |  2 +-
>  .../bindings/embedded-controller/google,cros-ec.yaml |  4 ++--
>  .../intel,ixp4xx-network-processing-engine.yaml      |  2 +-
>  Documentation/devicetree/bindings/gpio/gpio-mxs.yaml |  4 ++--
>  .../devicetree/bindings/hwmon/maxim,max31790.yaml    |  2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml    |  2 +-
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  6 +++---

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>  .../bindings/input/touchscreen/cypress,tt21000.yaml  |  2 +
