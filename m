Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813567;
	b=OG4FThYxbcgKrcTUs/6t6I66RSL4wlgKQvdy1FX43Kc833hDGEyRKyQd2jRTW3DVxT8D
	 Hvbnns89kZD7z0kKcUg2DARTZgH8lomNuqld5wROpLQ2YqnLbBvx+BuX/WwoOdirgVwZg
	 A8ZTzoOMT6H/7A6+fUKBRyaxTrlhnqVroQnNSuhdpwLdO3492e1DeCM0PB7gpXuHfLHnx
	 +1yJzsCyettmnRaOE4JzLYk2GAHRQaMUS+tjHEGR24FWU0lXicnM/WbSmGEO2vwcOGizp
	 4QMDVQGyo5c8R5bPVxvqtJp+VC9a6fafeGdXrpe4T1QnmxdOOcBpuxkdDVCcHrfzoHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4KWh+pCjEY3BH9ZXJBW3B3/Mt0CuTTrjLcItJI+O2b0=;
	b=LGKzGTAo4SGnH3OPaA6NQ/5xryuvPIiKTcAJrx3bP+3N30nqjZt6NPIqXKmLV9+mK6tj
	 tYM70qVb2sXiGN8fmEnRNCYBy30yIva6Sw1OQrgHTMSGau+YKiBqhH55Qd9NhGzKO+vL9
	 XLfPs09dY/eD9r5nTEOSubC67yDIGWIiHDL8rtfIsAPf/TDAorHSemmk52wqK5XzpuVoG
	 f0JC4dpV/SRj7XjrqsEFqOed90Y1EQpbj+tcRYyfko1q5zskmnYU0GwTMwXpvQ18/EdHO
	 Y7hIrnbEC6GK5m7y7oVus3eg6v0P5OQnSLmNAqcpmaLWoZVp7mXQDqwT+eWdKmE7bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmoIkpga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A0606B903;
	Wed,  4 Nov 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmoIkpga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDFF1F000C1;
	Wed,  4 Nov 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813567;
	bh=4KWh+pCjEY3BH9ZXJBW3B3/Mt0CuTTrjLcItJI+O2b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EmoIkpga02mtSmXYZVQn9du3LHYfYYz+585s/PS+UgjsXg/FCvOmrZxU5rFUHZ4Kc
	 RW4rhqpS4n3dFfRKO8x+a/rqSXZeMNtqoJk/PAMvtTPHidldiR0RNWuPhkUl5Udryh
	 K0OZRedSeEqK4PfWHQTrv308SVTAoSNO8pALhkzOLoGRqIxAXKmzlYLtjaaWK21Afk
	 g9ZdhfQJD7HMHHghQ3kYgQdyrMOv9/7V31ENvoFGNFW4fLM8UomjBlAwSX6CbB6Whr
	 eQxEIfy92LUpsJv+hK5fIokNxiCsnOkTzS6xufVPBmdQ1YFlhlqo+6SIaWZWwTuraz
	 PbT3jpG2TrNIg==
Date: Wed, 4 Nov 2026 18:32:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>, 
	Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <20261104-vigorous-flat-dingo-3e5bd2@quoll>
References: <20261102135330.2493332-1-robh@kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
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
>  .../bindings/input/touchscreen/cypress,tt21000.yaml  |  2 +-
>  .../memory-controllers/ddr/jedec,sdram-channel.yaml  | 12 ++++++------
>  .../bindings/memory-controllers/ingenic,nemc.yaml    |  2 +-
>  .../memory-controllers/nvidia,tegra20-emc.yaml       |  4 ++--
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml    |  2 +-
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml     |  2 +-
>  .../devicetree/bindings/misc/qcom,fastrpc.yaml       |  2 +-
>  .../bindings/mmc/mmc-controller-common.yaml          |  2 +-
>  .../bindings/net/cortina,gemini-ethernet.yaml        |  2 +-
>  .../bindings/phy/brcm,cygnus-pcie-phy.yaml           |  2 +-
>  .../devicetree/bindings/phy/brcm,sata-phy.yaml       |  2 +-
>  .../bindings/phy/socionext,uniphier-usb2-phy.yaml    |  2 +-
>  .../devicetree/bindings/sound/qcom,q6asm-dais.yaml   |  2 +-
>  .../bindings/sound/qcom,q6dsp-lpass-ports.yaml       |  2 +-
>  .../devicetree/bindings/thermal/sprd-thermal.yaml    |  2 +-
>  23 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> index 76b804b7c880..3dd54636d23d 100644
> --- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> +++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> @@ -123,7 +123,7 @@ properties:
>          const: 0
>  
>      patternProperties:
> -      "^layer@[0-9]+$":
> +      "^layer@[0-9a-f]+$":

These two lines are looking good.

Andy, it's okay if I give Rb tag?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

