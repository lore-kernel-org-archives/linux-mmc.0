Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.248.49.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757175;
	b=37S3IVeY9u6jtA+9g/4oS46g3dDvWClW6JGDJLppZdktJvwt4FTgL5wMx61wDsUDSSg6
	 srqu502uvXG+IQ6cG2uktK4qhQTAJtX8PKWmsh3uvdVofhufjgDzmuD1Sd3LweXq5oUSN
	 iZ5jjJvw/wfw3s3KebVxG5qUqFcIz5GtnPMfDOAKpn6qm1sjtxunsIXMj7hmBSiUxnzcD
	 oqpJnnRn/PNol/9DRkUYftyFtJW0X/xQwsrg4u3NYN2PeC3TSD/+kW/yFuCOFEh4ILYGs
	 41Sngbod0C+CDPs88slCBTLJ4BFWMeFqrZ9le4D/4UGXA3F0fSzhy5VLMRd3YIyB7iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757175;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aBUzfbqJGUAOqn6BiTAhka2rR9vNeLJrDSYC3d9j5HM=;
	b=vfABauXyz3uUoQEv4c5XjTnKsD5rU1qryhsN/PrJTK7Wfgl327Pl+lH8Oo+ntYgjdMe/
	 M3AnvsaD/c0IVq15Y7OGUj9a3NEELrtw0et8Oy6leyJLF9E2Qq6pDlSSCvVCC8NTFnD3V
	 GWEUTju8OoGTta9SAewO7kkaSnEpeoZ9/+U4KfXoDGDYQMxRXOsgV6zr6nExmIyfbjdg8
	 JNVxlfaDPuNtUl6IzIjiY1ZxDjmqWqWfGA0XyV6ha48NK0qFNIk+AGqCFrpe6PNI7Duty
	 fJBhTN5LBe6ec2OO5rS74gwpOf69Ip7pX4wdCyblVOEaEOT02i6X5pnMHbfVAOzpPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=socionext.com;
	spf=pass smtp.mailfrom=socionext.com;
	arc=none smtp.remote-ip=202.248.49.38
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F0606A31B;
	Wed,  4 Nov 2026 01:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434F0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
X-CSE-ConnectionGUID: f9sY6K76SNmyuqXh2AHvxA==
X-CSE-MsgGUID: eqxYOLpbRY+hlrpxrvhbIQ==
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Nov 2026 10:52:46 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id F118120695C1;
	Wed,  4 Nov 2026 10:52:45 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Wed, 4 Nov 2026 10:52:45 +0900
Received: from [10.212.247.157] (unknown [10.212.247.157])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id AF32110FA4D;
	Wed,  4 Nov 2026 10:52:43 +0900 (JST)
Message-ID: <9593dc64-5629-4262-857b-a6a570b03230@socionext.com>
Date: Wed, 4 Nov 2026 10:52:45 +0900
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen
 <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>,
 Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>,
 Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>,
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
References: <20261102135330.2493332-1-robh@kernel.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/11/02 22:53, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

(snip)

>   .../bindings/phy/socionext,uniphier-usb2-phy.yaml    |  2 +-

Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,
  
---
Best Regards
Kunihiko Hayashi
