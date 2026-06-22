Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F792D73B8;
	Mon, 22 Jun 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125306; cv=none; b=T8I7S36sxErxyFkqXnCd7RRfVNG2dG/Of+JJXZmzN8K87aW3n3r7+WPXnXfqZJm1zfmY5oSfV67S8VjBlNTagU8CTG1UcLt1fWXgHNnR1iNjzdRsI4bq8B3KGGOj39h6NB9vxdkYaydeXRpBZeZfFO9kH8F/cCdKzPq22RkjBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125306; c=relaxed/simple;
	bh=p5o4wCL19SgZAJdahyUBE2YojNuLVqQsq/iL26YQhl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0tUvdEJkBB8LczzCeDGQ9YWtEul+F8aMhyFU3CmJ6DiCS4ljr29JbzzGbCWsjhnckvdc0uJEnEqMwmqT0WAxWy17bcNy60bNb4Gxw9j3jQtlKZayb284cbGilCz3nVUih81khTAVxxZyfhSQ0fntq7os4YKf7puPQp0m6YYLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJSg4XS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJSg4XS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC131F000E9;
	Mon, 22 Jun 2026 10:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125304;
	bh=p5o4wCL19SgZAJdahyUBE2YojNuLVqQsq/iL26YQhl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJSg4XS8+Ip5ViIYLpINFix30Jh2Lg+T0wZ1JeVTU+Ci5w5qX5eg7GLCkuYvR10/0
	 PXb7LoChkyHztfqXzyWDTWBpNc/3mK3OwSUvLZXURSPg5RAgs6Zh3VYkwmFyLMUXky
	 mlLwAhEdanGwHAdmMvjolMmSVUDpppuVIto1aUlyFmiEbfoiyDDvrmmkuonE2s2YcE
	 4oR5L09+nzr+J9whrjZUn6CNFen0rMpNXuCnmZJVtrpLfhzlIasECd3UXpry8g5Xhy
	 n7YOr3GAeiToyxbzJbFFnKYDdKR2O4dRg7W2Ud7I8oe4G+NvbmKFPLCoHGheNm2slK
	 aMY+ok/fv4Ntg==
Date: Mon, 22 Jun 2026 11:48:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Javier Martinez Canillas <javier@dowhile0.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Taniya Das <quic_tdas@quicinc.com>,
	Robert Marko <robimarko@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Adam Skladowski <a_skl39@protonmail.com>,
	Sireesh Kodali <sireeshkodali@protonmail.com>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Sunyeal Hong <sunyeal.hong@samsung.com>,
	Shin Son <shin.son@samsung.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alina Yu <alina_yu@richtek.com>, Andy Gross <agross@kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
Message-ID: <15b1fc6f-0bee-4d3b-a694-0b076566e3bc@sirena.org.uk>
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WS/yioW3EKfTwezB"
Content-Disposition: inline
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Cookie: Now I am depressed ...


--WS/yioW3EKfTwezB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 12:16:08PM +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.

Acked-by: Mark Brown <broonie@kernel.org>

--WS/yioW3EKfTwezB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5EuQACgkQJNaLcl1U
h9DdpAf9GJ2uDy3rgqNiOlKlstOlFjMqiN8oPWouLl8gDA1j1uulyqx1qYeFRe27
7fBwR08BkQbAvA5tr6ZGCawSCJBGn0heinD9Cs+f+6n5kx4bqWyaIjcKPwVvR4yA
Sbcw60tpnIxiaHkPNE0/6+c3Lt+3QAq7fJNWV81eMlnf5qpRt6S57epvBH5EXHn/
jbSw2rJ+d72s6xJHKyWzF0ZOlh4rdU8cyAO9dq1ws+6whq4RtgBCveCHVGktp/OY
yS+AG/1388ooc8EnTIKAz7vvlWq/BUgi+eqkN/wrhKf478kO4kCYtINPFInaOhud
RrbkzoT8TIb+1TCiBYn9KDHKMXEaFw==
=rXVB
-----END PGP SIGNATURE-----

--WS/yioW3EKfTwezB--
