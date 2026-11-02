Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639450;
	b=PZXtBrSAnmWYq2LLXos+DKmtwvykCmU5Wv3lWjkBvy7E69gRpFF181urgPptMoSYF0/v
	 23EY9Qka3zTKfE/NEJ6Zg1MHD2zh6F8Ajg61/rgDwbRq0VieoGh+5aUPwgUtwrN900qYM
	 gbeNs3bO9DrW+aCtlsH2B+3bjwvh1Jxw8EiB0kweFbmI05ihmFOnsnnE2UE//lqCuSKtX
	 p9fzTvIvXAPm9vvVIIPr7Rz85nDpOnlu2kXgkIXCPdozyoMK6YFQ/2qjd6g089hBVOBtE
	 NZ23ymdqYvRNV4WvgJRMd12DcJFrOpcATW2vqGmKFeFBrnbzygIcNgdFZoFpCh2fGGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=1C1+XioTRX3xL6+y9qksFrookXeEiiwK+P4D7t5AbDk=;
	b=hbxSESaQQY9QiK5buivGqRmIhaNPfht9hnFyORkP9xe5nRypdoPgCnZgaWP0BLotVJ/q
	 wpxluOjPBYnjAG+lExuLy402xEAyj/am9/j2UkaeDk9hyuKmPWeQRav5IxFesppb32bta
	 Ex1ao5kpCBjLtP4PsRcgyxzAcG1bDD3Vug6ZBybcDq5hQevJjOi+ujKfixyShJ8lfO/8J
	 MMADaYa5RtvL39Yd+BiKemmMbLo7og8iAVpc1e5QLRyVW2XnJtFmeO6CyrHHZTtOn8cDR
	 7j5JuGp9gQ4pM7tPJT0ItaP/vAUarjGnOygYNKm9cuTUkI3E3K3u+ziI/6miKA4Ox0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABTVoPA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D290606ABA4;
	Mon,  2 Nov 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABTVoPA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9881F00A16;
	Mon,  2 Nov 2026 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793639450;
	bh=1C1+XioTRX3xL6+y9qksFrookXeEiiwK+P4D7t5AbDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABTVoPA11AcLWkMt2HA3NuaCz3TJC7cnr/HC+r5G6PR6a8aG7aRLuLyUHjoos4mk/
	 FGGhmGmyUFITYN4wcjdlul8/bi6GRsAoWVTD0LWhZh2nLhD8s0v+KJ34XdB/EcFA9p
	 bj7h1JmDXycwqk3fffJ3Bj+ZaOtvQy3ZN+fXGwU5Mo332EP6xDRRc1j/b8QBRPO3B9
	 oFKE/+K/1/DPAFHhIVomg/lZf/GTxFNzd0MGpxxzid2gzVdaV7sydbx6OYJHlUX2Ye
	 XkGrWyIsnCJf7w8Ms/IJbXTD8futWINJEtUKzY+znoX4p8/Hs89T1PQcag5KOTitM8
	 N4M1zDlFRxy0Q==
Date: Mon, 2 Nov 2026 17:10:31 +0000
From: Mark Brown <broonie@kernel.org>
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
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
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
Message-ID: <46a87ad3-5bfa-4906-8869-8eb7d0f7a82b@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="II/GuXYaiAd5/THw"
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
X-Cookie: Used with permission.


--II/GuXYaiAd5/THw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.

Acked-by: Mark Brown <broonie@kernel.org>

--II/GuXYaiAd5/THw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmroxAcACgkQJNaLcl1U
h9C0NAf/apisaJjoPaRQ3p+Tid6myUtq0cuOzuE2aVnPR8iumwTpFmtJ3R7zGJl/
bKV1H2FxfvCFDPI5gEFjBhoA8fFlBhCN/Xfqa/sNMOen6rihVDXtsCJ3Aisf4ZwM
mGBcOHHcpfbe9eVJQDGln8TNm+bohiDCmtUmzk5cavtLKRIfuYlv2ZDfsPWETWQb
FJUx3rlX/fOteFbygcgKXryK+yfNoq6072k6WBwn8O72yJdLDky6aGU5Y517ocKd
pBL+4J2d49+xPyb0zRTbVvVFip8kFWAIu/opdahAn7IDSZsmCzKDeEmDJgiopRm6
W/Z5ZSJpbXDiCuqW/gEK1TSrLjxzzQ==
=FFre
-----END PGP SIGNATURE-----

--II/GuXYaiAd5/THw--
