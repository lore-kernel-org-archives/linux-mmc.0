Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D646A61A;
	Fri, 18 Sep 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725768; cv=none; b=rT9zNGvLxbl4YpvPiGfYn9EHNiD7VnoGphg+Y023ZaBvd4VDO3p6egytt0XORIVWRNps9J813YKMZ583RBm3YIfivad/UGU2uXXtGCk3hF1rBz5AWuV2+Tbd5efskEeAw4LPcQqRhWx7okIjb4oEI2fz/ROYQnOqksKnGoP6PUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725768; c=relaxed/simple;
	bh=/KGwPvpew6zK1r9I2Hy+yoDFpoK+0WyGm0dzp8j+meo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1/5snfGaC2ULXMhng8jEqE5aY9HZEFOQNBD577iGLlCfJCKfoys4dpjH7QGfyy/GhLONC24UPRbio7kE2ZIdJzeDC6tpBnG3zfCuhZ/PifhsUFq+xTtnTzhQrHE74W8QiJYoegJpSb1QXCAAhJrh/L2vn2oJ8F87EGLeS97gT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHt7uv2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHt7uv2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE991F000FF;
	Fri, 18 Sep 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725764;
	bh=nZVoCiKuI8Au9ID4VyOKfBtItjLpyaq4XhcSOZgOVBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHt7uv2crwGnia/V1dyUtk+6qsQDTMv69oFPPAUPArwNudEAE5lBcQNiHFwjEprpS
	 EmxddNgmK/ySBD7SBUsK2GvM5OdQkApyi0u0LY717w57xUwo5qd5qti7kHoV92a1W/
	 bGD2paGlpju7f8kY42DOwqUmfaaOtRyyO/7H+wp5tGPQ8DoT330UsY1HqW5HkWmARo
	 4H6rnWZNnu9e3ZHRCH0x+BHMzGyz3ToDzmsJ5bdYL+ZXBYZjurHrf63G6giEfR0CtK
	 5Vt28Jfwm5/VPJcTK31W9ACzjk/Ztzbcb2zMq7S18jAW3P76WYoP/KwEeSAG4+TViW
	 3IfYAYr7UBSZQ==
Date: Fri, 18 Sep 2026 12:02:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, iommu@lists.linux.dev, 
	mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 06/19] dt-bindings: vendor-prefixes: Add General Mobile
Message-ID: <20260918-amphibian-overjoyed-fulmar-c04cd4@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>

On Wed, Sep 16, 2026 at 05:22:11PM +0300, Muzaffer Kadir wrote:
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

