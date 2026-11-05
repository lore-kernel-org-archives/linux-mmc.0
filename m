Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869959;
	b=KPBRdp+YjHgEVVQlGgJyLBMrwt6/cNYLjJgEk4le5qziRDwhfdRQl+IIX1jh0hUWPH5+
	 YSizgYbaQ3nQGmiaVeb1Y3snst4y26pyH7xq1Y93c4+BpoCI8DgW2Wrk6OFU88HttLK5Z
	 6Q/jPR0F3UKhyXILoNgdecFssFz5VWw+7YJrcCFx+XCa3GVB3LhE2yBXiPDHJRdGa6zSD
	 u6r4Xqvh76rvnGQye1fW7iLBzJjPObatg7q6RRwjbVwy35uB9Xr1G27xMsh3j5465j0cr
	 t+XjEop9JyANrE8RpUwfDbE+TEUsisEmBXW9wum2PVRYHBjx8UEO3g4tyrmJMNVk4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869959;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=90ShHs1UBpoe+W48ldmcLOPXtu87EtyXaSj0QmGFSfY=;
	b=3YKMNEh62eZjRqhcM/PENilclPavP9/BkFmR7IlPJ0M/8CJDQP/OVbzrwzJkBMOfoO6s
	 qepMPvCM8u00KfQowDVhs4+r9J0p+qMPVwdvsiN/LcFDZgmmVGbI3/35JYUmJoieli/Sm
	 minZdOxM5DpMoD2CQLjLccHp/7rVMslbKTOLIy8N3JvluATGS42k33tVHRnAFf+VkBcqL
	 RVb0hDH5lwAcfLf/ycVPBCtGB/RLCyu7svrskG0LpiSub6E02FvPYSNLLH7+Fm80G0clP
	 qEVh1l0LNN/JB1tcDs+TTX2RKZ8/LXXyqgxGWEdZDSMPe7L06JTLSqNTBAc5Mm5q9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L61cYoga;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C7606A32F;
	Thu,  5 Nov 2026 09:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739C7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L61cYoga
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869959; x=1825405959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dz++69HapeENA57zHJBnq0oJ2fOfutZ9NHoiO/H6u9w=;
  b=L61cYogaRBCqW6JsudCWRsfJL2K3EA2eal08XWtETkl2MOuIByhgzI6F
   FICIy5UJJzOeLCUOBgNS86CWVfvWs7hN81mGTRhpBvCu++fjWC6fYPYwp
   CH5v1ucJToptDJk4tqDEVfiNVeGwqAbfqcKqI/mdfqrdu9IEUh+swhlmd
   M/0MvbOdE0Ce/Q2wA68JQknbJKHFehGAC9Zt5ta8hO1bmZKvqU7jdJayb
   6HZliQHikfYbPt0pRTceSnrwvVyxGmh7Df37PhZhgXEtCukOpvnriC+k/
   K9UDh7v+46805hdkP+N5tyUBtcujiFAAhZRy2xsno8VdyOfPY1dSxUJtl
   w==;
X-CSE-ConnectionGUID: BlDV9IZPRdeq25QMniSSTA==
X-CSE-MsgGUID: 839hhwR2THyBco2kofCNHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2549131"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2549131"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:12:38 -0800
X-CSE-ConnectionGUID: lR6z4GXfReGlu3/EPN36EQ==
X-CSE-MsgGUID: lPmvdfNRReaL7TajpI3RKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7123499"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:12:20 -0800
Date: Thu, 5 Nov 2026 11:12:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
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
Message-ID: <auxIcruDKIYb9I33@ashevche-desk.local>
References: <20261102135330.2493332-1-robh@kernel.org>
 <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
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
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 10:39:06AM +0800, Chunyan Zhang wrote:
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.

[snip]

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

Yes, I agree with Krzysztof that this tag is ambiguous. Please, mark precisely
what have been reviewed.

-- 
With Best Regards,
Andy Shevchenko


