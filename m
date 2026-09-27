Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49203438A1;
	Sun, 27 Sep 2026 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531320; cv=none; b=N+RyQPhkEZLs5PqZFjyQpn780WGyCkzFuX9vUZ6+h7gJYNN2Uq4+PxoNaxNvetl0PDYYoGhC83E2sGIyXgaBdH3HjvBFYDhfM4VFpLwKXxHaZ7F15TNYHC4/5LHnvWi+P+tR+i+RnfHcFQISKl0imotkEGO9265i/9Gw6k8PeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531320; c=relaxed/simple;
	bh=fYc7PhGTQ1ilbpavtmI8h2LtaX1782G77xs4ib0rbWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrkllQM5vCdZAgqRrhMSIORwM8K57W4wdt1iihCy2Wi/Yp7ASISWJ0INsCVPONP2J8Qh7E9nw7FDfOvSJZmRDDw2SBZALCgY1ld0HyRha5GPL5x+vxt90lwlZnH1qbTvJFjOoxQgGsC6U8c467iZH46cIgD8RkvQwkpM4LkykRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM/tEn2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM/tEn2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9681F000FF;
	Sun, 27 Sep 2026 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531319;
	bh=27HyrJ7c6KyY9SKqa4yainl140c8VOvqnldobRP1swI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YM/tEn2XyrFT8BRZH76iSYB57H1P+27Ad7KkCUg6rnJl+RM0Dz6MuvwkzPMbfHxcN
	 wBGR/H2yckxdN0Gm0LquRXaBBbrbSqVtjLf14Ym+2S4a1oy9cdWi61aWszK/C0DmWT
	 132JSEv3RfTu0zs+PE7KHvcVmhheaIHPTkNDUfOVjSCNua/zw0q+aXxwgqbyuUwn2e
	 fqJERNPEc6yp2HX9gOGoLb6/Gho+HhFs9FyJDX46QjXCsp7qgP/Tx3pL4wM27VoDUn
	 vjep5LBFjU/5SXtk+dgCVmPmUseAbPT/6Kn/DwFwjVo9ybz3DoM2y2fQs1bYDeIqMU
	 8BW/d0BVa/x4A==
Date: Sun, 27 Sep 2026 19:48:36 +0200
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
Subject: Re: [PATCH v3 11/19] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
Message-ID: <20260927-vivid-oriole-of-warranty-18717b@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:02PM +0300, Muzaffer Kadir wrote:
> Document the scm compatible for msm8952 SoC.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

