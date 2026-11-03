Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696521;
	b=z/VZsJGeyB/inKIpNhLxwNf6RksVOtNqWIIRYWYyi0mz24/fKNHjz1OpbEAoHuK+BdD/
	 BlH/PZloM2SoipPNDN8ogj7u+rqQ+xCmaP5o0LokEKuFLYvhfqGiX/HitTpiHxGLKQ3Xb
	 nXDje9ZXRrofxHzgbWYcZjw3EkVUCwPz9TVvkIvB88JGPKqswZYcRAEN41bOEOWhSuyqE
	 b7TkN9iH8O0k4JmiS8HUT6+RH0HJS+Wztkktr+Mv6wkIqpNlkknmmAQ/aOdSPBnW/DMgJ
	 p33pJEBmJ7Dh1aDeHdcJlI46A98A1JY1VArfDMH8mOVZ0LhxnT7BH/TkyZes1f4qwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696521;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gRmsv6wYjLEKSbJo7laqPxMeUO7+qbOgDtXmMnI1ci8=;
	b=RnChG/T07SJEN7vaWw1PCGdBfjEJcuQsU6kgGcPFEiedxXuvL/WW+GOLCxGgAcf5Fl9L
	 DNa4pRB0l9AEdbD1udqDYO/rL2MoN08x/CXVv+yYJWBmada5TUDUknfsJQ3GknQy+TqRF
	 RcfZf6EhwVntjEPC0a+nD8UHQiujeHmUj2pjLUM8P/wNGOaRMHO8+apOcFutgZwofQv65
	 0bv5zlWnCicxuOSH5+FfvdZF4iaXRy7Yn6nTyxYCu8IkF9p0SGHwE7C/e+CbCytXCLbcd
	 n48UdeCC1ZtGdoGz2/ip5d/sP4Ff8Llh860S5ZKxcVXAc+Dr1GYdsGA0TMGB769bWSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOod8gK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF86606A324;
	Tue,  3 Nov 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOod8gK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3111F00A17;
	Tue,  3 Nov 2026 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696520;
	bh=gRmsv6wYjLEKSbJo7laqPxMeUO7+qbOgDtXmMnI1ci8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOod8gK4JSK2Ag27WxT99LyvRofFK9DbXWyzfXSQIIf7Xg4koKKnrNIso/kNNwiYI
	 hmcdBHH6VNgX8n8QapIRx8MWsoreYz0pOWior4BagJt1cjt9iC1CJs/m5IMjQ+bAV1
	 /NO67C3tkf6pejfDtujB40AmVq/aD/6G/+eRwueRluYlkviCRpoxqe13QaSpF2/5/7
	 LOfPT2uonKdxlTPC5I3idwrAuTvq1sdJQG/BtsbRH7zGF98qTtgOQub64SgjZk55T0
	 W8umapeltmRUFwlt6Qw1H+iwErchf2tc6lKWZugjBLMEQQh77uuj93BS+mMl09mB8x
	 L/EstnUikfb6w==
Date: Tue, 3 Nov 2026 09:01:43 +0000
From: Lee Jones <lee@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Alistair Francis <alistair@alistair23.me>,
	Julius Werner <jwerner@chromium.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Dmitry Osipenko <digetx@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <20261103090143.GF13023@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>

On Mon, 02 Nov 2026, Rob Herring (Arm) wrote:

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

Acked-by: Lee Jones <lee@kernel.org>

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

-- 
Lee Jones
