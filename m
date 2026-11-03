Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702063;
	b=khnUuRohD4M0V6/pqaA4fS8x9KBw5cPCR9kL0ABkH4Xmq0BBQ8MaQOnk1DtkoHY36WY+
	 Sn51AJCNarwJ9i9qlUuLkxwK2x+9OARXuhE4fdUSfxybbpSEMcY309T6/RyfhN8MSvWNO
	 QLIPomtjqBZMweo7s4eEKbARB3HH3AH/msNv4bfraUePcZ3+1XKWgC0HDuIpRPjiuskMw
	 Uh+2rAlLQ/u/ordi3/ehkktMrsEnSj6MOIoPXziIhMOYxC/Dve7+PrF9Vi4IxT9sd9FDO
	 JCO4/WNpVuv9wgvH9Wlc/27ScnQqWK32z2QI3OusKn8RHYhSU8rFVA5Bm1yDAGigvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702063;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GSqdOUTAGBHqvRwhBajLTqyzAy7NJSRaodL2JaKq0Eg=;
	b=kmryV12EUSr6u8ghjkhA+TPtl9PWc8xL9FrVdDRVFDZ0pAQ2otjh/LuahmPhzdy9LuOP
	 c7mpQ+Z4wy+/xAv8R4XqW96jx81Wc0A+7IopbVnLMSGhhDps2wJhsFHIsipebBfGlEduQ
	 Wd7xn+bJqe/kGZ4Ldxd8dzG2frnk0jIOCJ1jbUMhvX56GbpFM7PkvzsArF8GgIrGNN7nZ
	 r5KlgBTY339JOuSUmVxq7y8FuL3E9gWXuaqR7J3C1fbTcprGR2zQj17SOoN/hvBo5JFjS
	 mSr/sMZsi/WH2b8v1TAbYLKr7Yj4BbLuYQUSZHBjTi10fEQQsW8O0DpSH45pq96OYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apqUghqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBA60850AF;
	Tue,  3 Nov 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apqUghqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547A81F00919;
	Tue,  3 Nov 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702063;
	bh=GSqdOUTAGBHqvRwhBajLTqyzAy7NJSRaodL2JaKq0Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=apqUghqMhsHN4Trpoky2ktzmBWOFMhBOIk800IfwMCUvM+YfUWZXmYmUIfWw0Ny8q
	 M4rGo1Ztuy1Z+7b2SlYoFKvB8WsLBl7xem30ZQqpKKJG+npgYcG6UN0FEGIE7saLzO
	 w49oM1hEO+mtzHrUuXqu/NBMwXxgmHscEggqPEEqRXWaZcpKAY0YSDmsSLAqn6j15Y
	 Q+Sth//qr0f+bdqlGX/3j2FZdUUv7toc1V4V/dbIwjMRF+7XVt3f+0Gnu6DwiRIwxo
	 h0mdUIafykms+4IIO7psb9WuQxayavIhgMhanT99pe5O25qzj973a6Dvw0pf74CbOo
	 mYCN0dAg2vwAA==
Date: Tue, 3 Nov 2026 11:34:20 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
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
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <aum4oV6N8g32lr--@orome>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="trphfeiv2dppwi7j"
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>


--trphfeiv2dppwi7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>=20
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

Acked-by: Thierry Reding <treding@nvidia.com>

--trphfeiv2dppwi7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrpuKwACgkQ3SOs138+
s6GdNA/+IZX8Lk6Z0c9f09SsgYk1VvnUVRFPU0WGT4gY2GcvOdD9A5ow9mPdHAAc
EtBw40T/7BL3Fhk7+uhlr+V7FyVZUy0G5N/4tfMdekpeSl0hmPk6eNUZ3T6URtgO
dU6lC8r8USCEW3cN8XYrzm82EiRcUX6Pb+RLX4p4C1WruvonZi8XvwZFIKyD920z
XLF+bH/tVACkaHRY8G7btnFl/DKx31gutQbBPn1RuwO5CjpL0XqWowIgev7f7eRd
lOK1XJ3GITOI5t++ITd75skGT8DQvmJIbLnN1AIrdaTvua0qsbwIe7isv8fhkiwL
WcqzIJlLXxItYk3WIqMVtdis5wfA0rWHX0kCOYSDQhuuDx1cgxE5qy/S6UJwc22z
SlMtdhaJ2gotTfdWL/3/wHgf5dVcYCCGZToG3/JzMfZDxjC/bmL7YEJ4Os/Ywm2R
mG8PqJy88keVzu5pXohMH1tUyBS7AYXTLIOG9tKRGv37w8l2qILJAExv0GrT2bzd
bV3fMenc2qrgvCvgHxlE19oMzk/6BVP6Tw6jDKD5n5++y6qdZk/y0jadd3Aa79HZ
erpcvYYDqZpLqZNGgsqNjq+7LDIsiUnUJyXeWutYkkfejvToDBVoNfiwTpcIC9RF
z1tGodjD4b8kT4/zSnZ/wB4D8GV5H0Ep57UeyMjnWGLftrC1CzE=
=oYMU
-----END PGP SIGNATURE-----

--trphfeiv2dppwi7j--
