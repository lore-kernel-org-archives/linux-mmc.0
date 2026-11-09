Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210021;
	b=a6oNbqXDm/WTPxRqMNC5i+Ap6WCum+E/kpTgMcELBobSoWn+Xa5T3e2c6bg3KA6h/BJt
	 vhnKcT92cU17nlLAyOG8mNcjOLm80nCwsAgyrS8PpvwmP3OUmKZRH30K5Xzz5Tyx8D3+o
	 sPHrElsFMoU1fSrLvgUcz2WYPBKZA4wJ/KijijIkMfCJiVLR/j/w7mJoooeDaqO+rA/ru
	 /r1z9szrM8cwsBQcQKH/yOnRocFS2x71ci1ZHA9mD9Xccz7FAPGB/JEPlEV1otKBsLW30
	 SG+VJ9zaPjZ1BfMN9O3gD6Mq5F62SxV/mqIWF30RmUgpKHbsPQUgqJ3nuq95brkn+Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
	b=fU/Otlac+1BTz909aGBh0bCyqJ5qzFJAwWRjHQcHlMaI4NYZPNcr48K+heI5S4vw1fVH
	 GcD5pOEKtU9rFwevBdluppXsHdCxayBR4ye7agW/azIawNiw+AsVm2tJRvCHgBTMb2A7y
	 3GXogdCrjfFrh5dIi754HXCiZy/JFh0GZRiN8NDaL4/4KqWuENA4/vWroTZUrnI5Xhe5h
	 1udU9ezwt7qge1JVJaW9KH4aLVP1IYcDNxaqK0Do7wFZyU9sZgRKpqUeQSrnCadsz/Zjz
	 Vh3ZXwAR6vewxbs+fFXgF/01eYp1nRQ/JRznFgF2w1NIZI6yC4GGoht78UF2EXvmThA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A3606A31C
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B8A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0a2a44a0cso294148a91.1
        for <linux-mmc@vger.kernel.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
        d=google.com; s=arc-20260327;
        b=eNgyD2j2AcU5kia8LWmdtl8RomsZF/9ymSGznklENbFA6HopCOd5P7n0yNCLc/cis6
         ZY9bFNCanoEcgA5MPmH3HETbpX0s9f3yzpXzW5JPNPhwho/7FNOEP6hkydYfndMq4k6Z
         QY7/4QASCkS3BDYynGSyDxosg0+vrBKEdzAfjpHR5qQYDbjXE0T6tSAyHEF2DrUkZ2d0
         Fyf1gIAjF3yd4yvgCy/YJN1L/jy8gEjf6G1DaO94/se+QBRaQja7uL9gxfG58FW8by+E
         Rs+2xRzuoxUor9utMbdnlL4Eh2skZ5U3Ai7eH8Z4ZOnz6eznKw4GNR+dlfJvOFnRnAm+
         9evA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        fh=tDsKFNYSM0LoMuPYAOEKlBW3X0YzmPCiqCpT+8Qgzqg=;
        b=Nr4onuXBqTG0dP67TxyuAg90Kj2caOE/wZ5yABmPp8YtsS6PLEBhXqQsDk1ydxpmy7
         NTcP9F0jvBiVChwvD8VM+RITP4jBCdLrMrn3Y6UqkTH1dzCoWBe13M5H6prdAAlahX09
         Gpy2rgUtTC3xPMwSa9d6uWF97z9cvNelWf7pKFz3xXJvE1ilQ7f9DxPp0eC2iXLjZdEy
         H+w/7DSCPf5ej4dvft4Ah1S36wryASEr/CHHlx/AlnnzyGfet5XIq9sq0CTL1UnHJ3ll
         aC7KL7gPuSFAZZfptPd5Z7e0a7yS2rU1YZRUUOTCq3UgpIwtuTlDG9kkFsYXxwuLw4O8
         tTlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Fw1HJ3eBrEG+YcG2OfXIKNyXLbtxL6pFyShNR64xnTBicLVJTLcqI70PP7XlmXPNx6
         VWmQ662eksYGc8vJo+lcMpjTIaYcJB9aokKPIxavS8OWhjpOs8W89bix1ozwYvKeb3b4
         M7C1Y4n+R7cdsAeFDh3I3fT0WNvzf0CnRZWDlQZYC+5M2rSyX8wMQx9uS+vQs8QSo0d/
         2FLip2Uo0zLuYIubK7TNTBZ4sl8ZrZ+JeHk7SDm/ZlHHFtWu1M3YyNEi+YttPBGWC2RM
         X/hXAhXzRlZNf20NwByFmIPl+GnzmQCqAB4nehLzmm3jWxLA5k3xC+msTg/JbR6XvUqv
         ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210020; x=1794814820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=GrhBZNWch6ivUWGMeSHQfxDFoTgw5lIPzoUbsoVLT/PIMNSxycyaiTljzXM1m3ZVP5
         SRef9zExRzT33HuAix6ubmNEJ5cNc3B4gX2wUylkU+aPWAhMiMeHiJdRK42UwXsMQDkQ
         vuVE9alMW/HYeq2n0WgLAWb3449d4bccUgxAyi/Fq1Y+JhZ6yjLjNmGUiF7Qa4EBslo8
         wDn+lzR6HiW8rkk+rmUMRr9Lp72Luo0kMgVIQP3tpJy3lyTn6d/8t8WOd21hMUGH2xXH
         6+BmoFCy/PfbsVAeh3Sq0hZuc3pxQ8ZnmUudy3bgmEkRytwWPaUWlvo+MtEObpic3Mhl
         k4RA==
X-Forwarded-Encrypted: i=1; AL+hErHtlfDAt1VGNNPTrhl7EKMfK2Imu62VBq52Z8eGgTl/tfPcatzmADBEZ38U3ctxKQjPGr/XeYtMRg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bbpAVuqMaIKBRGrsRUgpk2SSSGuE/jgNv6ki9SQIeHETL8FsK
	aJbJAVPV1XDN6XKU6RmFoOWRd7McXFuq/WbpGzZ2Ka2xZBt5ecROsdulMW/RbN/i6UpeZaiK+4Y
	aRIx96aki4TTYq1qU3zu0u2BRxz3Z9kc=
X-Gm-Gg: AYBFou1SS340tl6pV5s+CBH8gMxBN9MF4rMHxKcKOiJhcTjfeXdNeHWNT0enw4copt3
	C8w3cx4qXg4cKiqJnlNmCEx9OhRptuhCudmoqtqpPv6e7Bg9WKOK/ht2OFlZizi22USc9prM3zJ
	Bb2wa6m/HmsHTUQqXolUXGB4fYs6A0MfHs21Vy09NAvcaNzD66PN6wDvxZGZiZLfUAWX8aVD8o1
	ESD+6RKa0gQ0I3wTkx5VJ0mM81DeCa1ROsPUOsdwK3ZtOmonJ7u7/6Z7+UsoI6uXa1agCohCiC4
	WLLDgrwUAWopqzDKDrUyy44pZGgXgCfiJ+cHBu/dtcT1qD/ELaOg/Uj/ntyh5g9M6YkLW2CNXFd
	5QU2apPFwh8SD8jf+4/xvahckmjjYV3IAFvY=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org> <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
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
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
