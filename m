Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798801;
	b=xRsDMmZ26SYFt1ye5HSKf2LPz/7l57tUv7DoEz09WNVnmxUJCeT73EfUUexo+15avyzJ
	 2nV1tTu/DiX2jJ34VFp/5N7VDT+WHHglOKk2NaWDzGGnwgqJRzt/GJqEpJlYUiHKNJl5o
	 9mKyYVCTItEwhSuDomMqGMZw6qdZH5CsMECoM7PWlLPV+xyivfwMDQFHbROENyh/jMTEA
	 +1VptgjQFJKa2XJ5d+ARJ/VeF5qlr9CexSCC0NmDD4v5wV9eYXmlwyby17TWG9SAXY5FC
	 D8aBvOH6iVHkvoV8+cnkDBhktJvfsFEGA7KRsQJ1zwo7vNd3ANm5EkcLTmB8irBJmPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MPUiLFnTBdf7QRRqKCZEZSjQLoEuxmOxaBmyWSCYZVk=;
	b=xZHBqtPtr1fuZBYOjohK/EV2gfimgZjWPwEacWR6xQpqDAbhNGZ3ZAXI8JU5MGohXma3
	 9V0mcAYl8392fx6kM9HDu/rVFm3kgQhgP3Ggds10u+Lm2iRlvi3gj7wDAgGgmN1JURZe5
	 HmqbCTSVimIPXSltvx/FBzrDnwMtXTbHR420+L2H1BN6hOSiPAhHchZbVSxxC8igKFDNu
	 gCrOEgBAG3ATOOB+dW0cmrdNBWYCmI66ATgPJTKrxVFciDzw8P8IXpCgrc3fNsH4QfwTw
	 TiXSWuh4rydalndKMhcWr/8Spv4y5c+yTNls61IUB1WBWd0GJpFzQAk+jL6qrbOb9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGP57dCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99B606D82D;
	Wed,  4 Nov 2026 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGP57dCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24C31F0093A;
	Wed,  4 Nov 2026 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798800;
	bh=MPUiLFnTBdf7QRRqKCZEZSjQLoEuxmOxaBmyWSCYZVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GGP57dCQEvsELH0NCmMeNo9OYSLBlBr1CuaxanS9gitq0f13zE16Rj4HEg912BA3a
	 jHAi0xgnf5mbwOvcFAqnxoTWo/uFCPp17dN+EOptGveLGJja2ISTiRvaAZqFzjXV4f
	 jy+F3e4iKr6uWbeNGs4mnwgP57FbK+kogGG9a3Wto4Rt5KD5bug71IQBxB2F8xsD2p
	 VFh4oL1WG13peDWe+KFd7Oh2xSJbJ5/uxq0pdKCYmBN5/K54Ak8t/uIKlzxPQP03lr
	 kspb/xXqgBTpLDcB5XW6w5IsrQjlO6ZsLq2PjV9K98Wx6vv5U0To5OAyVcKfhN8ki3
	 vuQeMPtWatfww==
Date: Wed, 4 Nov 2026 14:26:38 +0100
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
Message-ID: <ausydkb2etcFJbYf@orome>
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
	protocol="application/pgp-signature"; boundary="3alpfpswkxhlvmej"
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>


--3alpfpswkxhlvmej
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
[...]
>  .../memory-controllers/nvidia,tegra20-emc.yaml       |  4 ++--

Acked-by: Thierry Reding <treding@nvidia.com>

--3alpfpswkxhlvmej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrrMo4ACgkQ3SOs138+
s6EKABAAqndqQDSMCzJ51pelaVEYbun/pEAy9SCFq/gar34Nw6/PUqr+4Ae8fNKG
58DhWW5IKP0zFCmAz4Lg7vzWcf8pcqjEqor4P/6uGt4Sa/keBlY96dhT7fXB7vUU
+Y4/cAb5vN2M+cj5QKI3/N2xjmH4vcTgMxzpR2oZINWc5q3SpBCYpH4dHWdZX5ON
NU3IkE+IwIuBt/lTX256XDA2qocpbqk4PfhDPXDEgwHzw1KUGjW9mngNi7ReGJ7X
h58XLcmeowbjEg3418OfZogzqIrg1IowSD/1kTwDb/BONZtAFXstReG/03FgHBDC
TfXFyQRuzQpC9ry8hSrTY3AfmVE+br7dxxhHl/mTpK6xVTnygAdFj7r2eOEtKQuZ
/71SgGxHyuMPxVhqWntmrNQe5bSouxg7K1qTjVERnNG/43QDs1Ak2ELHBVD2RsBc
lh9RUpYN+TMPms8D1jVgFsj0uOeeTEniDuXCWH7B32tqyyYPNEue+BzP/MsSMMIB
xNFF26OqFEjYj3sHYR6s5D7EjwvTEHxF3zkNRgMSbeRpfjQKQOGIJCfPKP/Chrf9
nywLoaWqGVHoNzEGQdjjkR6VQ0RTmBHnBGjoUU8SgFesfF0+0UT3lvASBsDH8VJ5
94axmWcy8Sg7LmNOo7vOf7+TW7Fumpqu/30f4HiRtFAecTTqHJQ=
=MRzn
-----END PGP SIGNATURE-----

--3alpfpswkxhlvmej--
