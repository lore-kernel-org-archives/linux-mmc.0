Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696284;
	b=kSEb0+WKlbrfGuNExdXeTMCc0ShlPeYzlSl4NmjJ2v3eqgWCcrsv/h7S09aflUqpf0iz
	 52aT2hPxy+dNeRHZOC0zoETnm5iPcyrShgMm8aUqjKNP/Bc3C6XdnUazlXCwLD8vGerVq
	 e84nxByqB5QRVSFSlIpBABGf/t+R/B7CCXlf+DonVwYjRswtkLz9maIhvTnL906kfGKt1
	 M0mNehOKkQWVoOzBWxxsvuPb7Gn2sTtxAQqgbm+IiO71JOjhu+vkSTqacp9RApra4FTtn
	 W2WZK0xKUoXG8zg4GYybIuoSQDNPt2wCaA90CfAmlnUcdpz8DGy+fOHHWc63W6QSECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696284;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AUgj7ybzOrbdmhNXXkJnAoh6ZouzAZL90keqraEO3nw=;
	b=vqlqz7rmswM9VA3VU4VSbaizxoN2lTI6LBwJCYnrrRxehIubw59r7ZNDOrQ7pZd2NQ3R
	 IhgKchoJyxR/KfZBcIluU5RFciRsBndlv2RmescZSbVmtaWbJ29f/pFjUQ4xBcfefyjdh
	 NbQy3/Wh6cmUZw4yDEQphfqo2PN6xvt+zilMNQrXR1Tokxk6IQ0n5oP31lvTxzs4SStt0
	 +/dNqSoTh/3Ddv5NXt4SoAOUdaxhXOV2uLWPEDu2X/cYPjHDciUB0OA/CR95e2Vvjb4MX
	 404+RtNQeNvSQu9AmZFRwz8rnSPTTiWvky6PzIkt9WPjQ4ATJ16X/cBONCMmZXTj++Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjFKDjIJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DE606A32C
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjFKDjIJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C066E1F00A15
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696283;
	bh=AUgj7ybzOrbdmhNXXkJnAoh6ZouzAZL90keqraEO3nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WjFKDjIJEA+bvQq5UVn7x5MxjjLIWhQscCNd94OnDDvq/EATAgJAkxNwykHjG9aTJ
	 APMiBitUjbRauW84B1eUmRsYt19y/Wh+E8xAuFe5y1uaQ1Y83+3Y8l8inhu98hZ4kq
	 RfaBDFc9dETiActHyzP5iHPEuQy/rJHVf6ewu3r32ldAZY0z9SRtlLTXVFXydhc75m
	 Znzu9gGPiKd2VRpcwJs9KdW6SWf9og1BFKZdXKQCe7LPjm4nVxTuHWsThKhi3KFKuN
	 QW7nKvFOd3XbPjCdfRdfMvnMz2v39pyEy37dmOfUeeMchGyJ+DZKCFvJSh08KXyD43
	 y3xHIrZ9AGDlg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3acd304b5fbso11367451fa.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 00:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy8glGL8qZWvGyvKfVEYG4GfUWtx6NmVI6y93LX7ecHWKT7N+tudzoEoKxRwhs66xls36COUVNdeKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a7aXDiFLQLTSkAsEp4smVRyCspd35fMT3cW9iTwQMqsAM5A/C
	Xobsx7HPXruDbraoznHqQh0PxtI54rZhMigqDj9P5stWrswHuejrsv3ELCre8vgC5tFT/ijzX1H
	yYQh0momgMZIMVyhdlMuajY/KbLlAu18=
X-Received: by 2002:a05:6512:b84:b0:5bf:dc30:93a5 with SMTP id
 2adb3069b0e04-5bfdc3094a3mr4560521e87.4.1793696282130; Tue, 03 Nov 2026
 00:58:02 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 09:57:48 +0100
X-Gmail-Original-Message-ID: <CAD++jL=DvHOGWpYYudhG-EhxTk3iUhtfz7OBS0mFgurvnCmb3g@mail.gmail.com>
X-Gm-Features: AclHuK-LEcFutZHI-ID3nCMC-9st3AveCqqRSTzeXkI5ke3GTM3j4j9Kq1OFBKw
Message-ID: <CAD++jL=DvHOGWpYYudhG-EhxTk3iUhtfz7OBS0mFgurvnCmb3g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>, 
	Alistair Francis <alistair@alistair23.me>, Julius Werner <jwerner@chromium.org>, 
	Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko <digetx@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:53=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
