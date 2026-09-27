Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1D42BE95;
	Sun, 27 Sep 2026 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531502; cv=none; b=GiF4P7I863XASJ1ZZJuwPYYdfY5DIDbt/Err5IrqX0wG5oIGJ6+Gf6wpyHBcJSeYC3LaWnBfnjVFxlD17A+gx4PbZxtDbohrEVTapvpvJcePfDVDF4kBR67Q0QGZTv2xB3FY4x9pDK/eD5gXO7MhZ1XeEeYhOPFkQ2MyfiSpMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531502; c=relaxed/simple;
	bh=Fg/R832Yu9hm9UhvjRyIMtHy+AIL/iz6wCDb4fRFB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4axmfr+tZuoPFB7LD8HuqsO14CZ+j2CXIm8wehKSHAjqqdZtGWsJTrjbrihFdNCecrVuNeirg9IvSvc23B/ZRDmWIZnC9JeFCOKXk2XQ83JQMAFfGFfCIvxHHunpuCBx9H0Ao41Rq3FRxgRQ6vtNnsh6rP1RP2Dnm8rkdX1oi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwtppmP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwtppmP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644501F000FF;
	Sun, 27 Sep 2026 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531501;
	bh=X+nDRP/emFRMtv32jkEurvBaO372Vfq1u5C7aL6qs6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RwtppmP6+lipHJN5l5AG0+XHAblrzGDODnr7nHlYmDDTkheMHWaAaHO4zGVKF2n4t
	 KO0PO2lz/+GJV86i3nxlxMR5SrTykxzPpykRGIBstMCEu95fe/lkqnJ3H2XbZxKP9Y
	 ITl7XomOXZqUIboicgXDCWUmhyxIuw3Dc4M/b+oT0QfMVTVC5c7N7uk0qkUO9bGXz8
	 pnOxqMUj5SWLpPrqxZO8qePkf66I5yGGAEFFT6r8gTCeK1BSUBPkFD/h9BkYkVHKQD
	 jcOCjGR60W8t2zWhKGh4DqxEwmhcI3J1J0C2/i5uVIbQgjC9V2b07f9U/fx4YxuBr2
	 3uhjQ2GR6iWqA==
Date: Sun, 27 Sep 2026 19:51:38 +0200
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
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3 15/19] dt-bindings: thermal: tsens: Add MSM8952
Message-ID: <20260927-mole-of-wondrous-feminism-292739@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:06PM +0300, Muzaffer Kadir wrote:
> Add compatible string for tsens block found in MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

