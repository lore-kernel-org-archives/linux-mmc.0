Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870017;
	b=b/crtCc+FoCP4aTzfoZEtghaMSjd4VRAOJOuJBo9c0fwWlr1UMyFZLjBG7TTrQ4pOm6k
	 2J1IxvTb6m75hItnbF9vs143Uudww3wiJCP1p1g/ijZSqY3KA1p7YcBH3Ate5kCzavuOk
	 lfh+JHulDAWUPcsXQRwgWQDi3ySN4hEl0qHqbV6Sk9pmrEgb+EY8Bq2nJ+XY+BaIhPmnn
	 qaeKuFPcqrB+BxJ4RBayExTc2m9fOSktQLyIS0IHanTzs1vPDoD6vxU326Jj4+aNiWN7/
	 fDM8+EAL1vmx4BkSlNanZIdN8YXqVPkIy21bddInDPFJviipmEfH+97KAQ/vHlfjxbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870017;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0dcn9KBmcJzqAJpqRsW5Hqpu3HAEMph5/rktghtkFts=;
	b=KUeUFT0EYH5ok6h3SilnjlqGz9DNEcqlOhk88czBAFF61W7eNzAl1HPVUA6OxPZBn1zS
	 9MTgsh7vDBRoxf/Ke5OQSm8+WGph9z4fmNFmtrcJqOejjKXY0ONLGa8YmyE5TSZEt/b26
	 +VcCUwi965wTZjdbfZu87CXVLDaKZgpRR6KEO3+EdCP3Tu89DMhRIf0qRORFLGFA5J2iA
	 gWXiMSQoaDEyYt+Tja9rstDjnk8Q7J6uAy1ObHaVu6gNjxJszUAEEZHfMxCcQZZg6DKiD
	 eN2Q93IicOYY7zcg+lpp9WT511OLQmIqJaeCmdvn4R/TKnBgq5WEhRCBMfVAQ69vTrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lxtG33HQ;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5B606A326;
	Thu,  5 Nov 2026 09:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lxtG33HQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793870018; x=1825406018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2W6MRtupdrj020Uh4UEb5zyJkRA2+AjPQ8ugIRouE4A=;
  b=lxtG33HQrgNuuQe0k8D4J2vK5NAhwyNjAcnfGaXuOiDz8EoPZvRkfbIs
   QlPNP+dlydhxC3bM/WsURI9SKVMGBoF4LU6tebFMgY9jQFroWZcC1nPTY
   oarnc9WrLwVkEfZoKXto2QWMdXP9qMrOEidUkAgobnaMXWpAzZvOKgqTn
   cSlcxo4Fu4Aot8lFM4QF+WQmKvirkD8+IdXqweC66N8f8CSajAFZHqBPq
   JmzxWMjSnFWDAok8c3W3lK9c67evGqaEWK1B567laWGSbw0atxaEuXhYk
   1UKftSPK9DcKb5QHEhQr7PRjxza/CyUi9vPKO/0Q41CsNvclhAjMajrea
   g==;
X-CSE-ConnectionGUID: e9N8yMDQSeGfg2uI3uaBYw==
X-CSE-MsgGUID: nO29XHZyRQO8bPGsNCscGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2643775"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2643775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:13:36 -0800
X-CSE-ConnectionGUID: WHi44R+6TY6k/cxMKjfsGQ==
X-CSE-MsgGUID: sZYNWWPRQpShUCMMaIX5GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7295989"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:13:18 -0800
Date: Thu, 5 Nov 2026 11:13:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <auxIrJ0q9kxEI6-U@ashevche-desk.local>
References: <20261102135330.2493332-1-robh@kernel.org>
 <20261104-vigorous-flat-dingo-3e5bd2@quoll>
 <auuWVGsyb3RrOIfh@ashevche-desk.local>
 <e390de9a-b7ac-4fb9-8a0d-f6a4935dd665@kernel.org>
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
In-Reply-To: <e390de9a-b7ac-4fb9-8a0d-f6a4935dd665@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 09:09:00AM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2026 21:32, Andy Shevchenko wrote:
> >>>      patternProperties:
> >>> -      "^layer@[0-9]+$":
> >>> +      "^layer@[0-9a-f]+$":
> >>
> >> These two lines are looking good.
> >>
> >> Andy, it's okay if I give Rb tag?
> > 
> > Yes, again a pointer to 34d1e754155b ("dt-bindings: iio: drop unneeded quotes").
> > 
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > 
> > I expect to see
> > 
> >  Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> # xylon
> > 
> > or something that matches the piece you reviewed.
> 
> As pointed out in other thread (the SPI), only a few people use that
> syntax.

So we need to teach them.

> Also look here:
> https://lore.kernel.org/all/CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com/

Yeah, I answered there.

-- 
With Best Regards,
Andy Shevchenko


