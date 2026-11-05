Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846394;
	b=hEGgkSkJGIKqXlLJjbfF4KPJPMsiBZskgrYkmDDVPQ5OBpUn24eZIomHDpyQs/W6DSVg
	 JgEJEnSBFr3avpge9WHLBP7Kyp8XYZl4sR+QP2lckG7N6slS7JCTem/o8/4BP/K2/i6ui
	 Q1wt/ffmDKX5hIupCtGTmBcITJKNH3ZeqZp4boFdN61tQXRL8Hq92oYhJTq77uiAg7h42
	 /QV6q/PdaRF+ogkealsHS52bcdGN4nfK4Ss0wxGL9YpYdShd11sdoJWLy7dVDXGFe8FjV
	 vSgyr0o2yW2dg0jMqELxU5oNb+o1QA4SCh9sdL4tkK/9zDyR8XjcYrt959cpqu9lRKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846394;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	b=ov/Eo9lvEKcrLIf8L13gCDlIqoUJYQLCzK0gIfPuibF80cNwf9Suzcgn1Bvjp3lFL+Fj
	 B+/n3N+VqwI+BGxgx0sTwHHDLM+U1D1lt5DxJiWUJRs2Mcs+gGohuUgqoaVFl9wxK8Wnu
	 g+hhVUywN25VH0T3EpsaxSz7JFGBiktgdGOOisji2BCn8lmYnoEpVu6AmlQXffgnaNSVQ
	 FKOkAYOqKOAItarqJlE6hfEsbYT1KrOAXCxMrjli3lBBDGH6i2JGzfkoqba33Jf25buTZ
	 gqwYVOUV4gUXT7dcKOPPCKdTce4EVKOT7MXqxSGYyBB5KOrxrk6oSJPXgdDV/99IMhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=CQnGzt4E;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB6606A336
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 02:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CB6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=CQnGzt4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793846389;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=CQnGzt4EeAAhH/jwaRdpQJnd6r1AQ8SOk2uk93YTZ3teRIvNdW4uYlmwAXhG7wYFS
	 d6IiLv4hUfLnFd02MWzgJjb2zGh1Wt6Sfa6yv9Uz/F9j7vK1vUB6thl64r+Ubn1laK
	 jfuqPzwsb86Uc9U7Je2CFhCWkO4NNj2gj/+Rzc3w=
X-QQ-mid: zesmtpsz9t1793846385t352cee6d
X-QQ-Originating-IP: xZhIJze9Fel9ZaeE4at0oG3vLMtjGfDqnhsl0hfYKTs=
Received: from mail-pj1-f52.google.com ( [209.85.216.52])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2026 10:39:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10315641731782962756
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso697642a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 18:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxkfAQfpKN2HOvGZO6SdvJDULinR2o9D9pau3EQIwE8Mgsb5rkKzEgq2OGF977sJmRZheg11t0t/QQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XR/zvmZ2ECljVRZ0iLKZyK9l0FaozVqohFz5HrNehJxS5jMJ8
	zaGAFR1lgAOE8/tZmITHJRLmpBxWa7UDyyjKG2uqgXUY3LPlsQ0/MgNlHxVo+Q+k3lpXuPUzJSg
	Z588Wq91krMRNtyo9/OQuyCx64rfZvEo=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
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
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mp831pdh2MvzqXsx3U2Ku+P69w2eEibPjhr17i7Cnrc93DtlN4QUGvOt
	pPxw1ApeaUF2WaOMw8U9sKMO1OqwxtXnsRakkYh8yApC3Re3lg2TDh3hJQDXfDUIjUgtmb1
	M3YV1QyuB9y8eVAMshpg5NnxYnh6VDIi8Y0VdLc/9M8Q54R2H26USXsIbhSzb7MdedQ/KIn
	NwDyrtgugPlJmvYnnD4SNdJNsi4zbmrh1AOGD7V5YbWVorgQkT/T3duzQn2Dr3n8sSG9VN7
	MDmIiidHyv7FAn0g922W+SJXEOaOjwT3wf7Ozz+muBPAo5akCJUKrlIGgYRRgT6q8lKp+Np
	ngJN3YdkABlDmP6x9zp2yxrBTn21SRitJKATz3727JbvQje2J1PcBmrhWTrOZ+hPC/1jEIi
	jqrN04nLzrMA8SNy6Pf/xMth6dGAuKMZIiuXRm7Af4S8rox53nsb+VpJl5wrRoQKOdP3pCS
	Lf3NTq9Wr1CaAY4fVbamXLga2rEDlWEozn8FXE9dcfvmqD0q8TBV5b1i7p0tdf9hBo2VNwg
	mdI/SRhSiHKRSyAObcTq9fW96JMBv3Br6eSWAmVJtyek31gKwBHgG6Dt4JcVmR7VuV/u2Q6
	DhGccTxchCIIeTV42x/21GjlSxqOOgNQkJmoeidEQz9PL4CEEHutv0XNpOCL9Dfcmz0eOnV
	HP5SYRVc9mIm29YSCmJCnDIAglXpcyRnVT8ETA2d3Y9/mYVCyC2EsTMIJQsITgYub/hk5i3
	1/mkBHKm1LeZOopTVY0WzxeAfen2J7zZId3Qef2/w2rCEqa/7qOC+0f1kGPEVet/Ejxz3T/
	M7dqeMuj9cR+epsWj4XxudOMiHwUgn14dIvCEdamhKZG8pkMwkEhe8Cm0nStQPJJG89+y8W
	Rsn8sXz3qAO/yk7u17POHJ7FMtByy+3gbSLcyuPRxla3XoWPX4utOoRjSoKpuoPHAMuGN4m
	9TVJ1trh0r10VqMSQAOz9zbTW6QYjUb5EVfxpckLoq0zDxFKpE0CBDkRUo5KatclAXOe0v4
	UW8RB7k4IBL04manZqTHHCuqQ4bLE9n43YepCbQ4ynS7YxJ78X
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
