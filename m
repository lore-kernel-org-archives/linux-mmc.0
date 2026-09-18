Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30F3A9618;
	Fri, 18 Sep 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725791; cv=none; b=jgi0twOt+IgYYl07Vh9aSZ2zoO+/B99cB2zy0fyIb9vqNiV9sMHBhw9UkQ/z+wAOE79vc/vThVAvzpHIC/s/xG0K72x0bYTb1W/8H/TfLI2v7aFD/Kbg/DM173vxtPY8xGp1zIBDleHHw+KwN3NTQrAJKam3tyV/PNDG7V2Tuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725791; c=relaxed/simple;
	bh=TdNYXAYUV9FHNGtoMSe/Np7+t/AHRfyYybjepLwFF5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXt9uEGFfLcVZJTmbE4wc2c9r6HlQhfdMxCtc5ZS//h3tOcuv4SRfKMaUyseRZimUbQ8JsYXVjdvyn7O/6WnRPSvXnklGm25E+Al7PjYV7TCs0IELI9BpxVu+4aJ99OKYhH13trFqIera6fU5Pra1cfkVUqM7rPE/1HRi52J21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0rPo6nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0rPo6nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D51F000FF;
	Fri, 18 Sep 2026 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725789;
	bh=m+kqKJnO8xx6EaG+eu2tJnKPZxO0X2dKDXSpHvQ+rhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A0rPo6nq1WqCyyKQA0jpNXoAt9ibIizz+aqA0zFGxiHaue7h0djSha/rygE/IO/iD
	 /e4a+bOMqhs+m94aE+dWjY3Wt4fHqi22vcu9ES0XXf6B9SQj5cGTtB5Urrvk05DEcc
	 6N5BUEoKRKNJlWcWWbAWE8dMDDd9YVjXjw522XVSDCqAtmYSPupGZ4N/i7EYfOoFKd
	 TZZ+1ZVpqsEjj/PXsT/BmAim3P1R8rhO7v/CTZF3750i2EqUz5+M0/+YXIK5rSfe4+
	 u/pdsqTE+v3QuHWHM0I9dMs7peaYjvyNDpXdYHGwWOI4zhdkM1HhWTXo0+4mlqcMxY
	 jJDPvHksi45nw==
Date: Fri, 18 Sep 2026 12:03:06 +0200
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
Subject: Re: [PATCH v2 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Message-ID: <20260918-complex-bee-of-serendipity-cb6157@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>

On Wed, Sep 16, 2026 at 05:22:12PM +0300, Muzaffer Kadir wrote:
> Document the MSM8952 and add General Mobile shamrock to it.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

