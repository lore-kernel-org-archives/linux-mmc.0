Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733604D0CD1;
	Fri, 18 Sep 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726190; cv=none; b=BJ+fLNG+3jHwI13u+xL/4E9eL9dIpYPqOQb39nBFtuL/b1r9sOZMO2dCrYDqq2QpXYSlTHAigAHFkP1yLcmydu5QWkGhyPuCgQQgpn4Datol+gpP9l1h3dhOswxl8elTSM/X0hkQrVXzt8FPBqoWcp0MWYGAD0iaNm43bv7NmhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726190; c=relaxed/simple;
	bh=PiGN16huOR7UZBg19IM0Hy1A8JY0pHkClaJQHPzPjpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMZURNdHEvW4kDyvPMiUlCkxYCG+RLrTJdw4dsMUo/3h89/jdhTHZGZInuo8YIXSX+mL2cBNLjS7hidyNATwKieEFxIp3A2Iri9sIdSTZi8IPfK+KkKpxUWoqGrFhpi0FPvTWxorxhl0vFMbG7tROJZ0+bAJV4Jhk4b9k6Vk168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmc3aV1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmc3aV1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369631F000FF;
	Fri, 18 Sep 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726187;
	bh=ldnhjGinl4eu4pR9zDJKuKw6fPmbARl0hSMqWh2pYUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bmc3aV1i24nMbRO7I0xJf6WGOSllIVEj/a1YQEqKBQkKys2OhpaNyRs54+f0xyeTN
	 IAr1T9lNAumI7NoxUoGKzOgh+TNth4OWXyQW43AeolvQCDYZjPMCZ4S/aKqTZBGkFQ
	 pVO+JVXiCAwhya04RBxZe1eijUveuVKl1XYFv2joaZJfUvKHeKKSnJa7v4ijPxOSuI
	 mFJDNO2ZC1x+lZBTcacF4FKQUI1neRp5CCRaoDiz195DbggbnaaIswmePylaH9l2ra
	 fuvieu3ySbYp/9nP8qi1XW61EHe+9U2z0wkKtaj4zZdW/zcEARybqQbHUHzJzc8NZz
	 3ZmbszfbbbwiA==
Date: Fri, 18 Sep 2026 12:09:43 +0200
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
Subject: Re: [PATCH v2 03/19] dt-bindings: nvmem: Add compatible for MSM8952
Message-ID: <20260918-tidy-rook-of-respect-deaaef@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>

On Wed, Sep 16, 2026 at 05:22:08PM +0300, Muzaffer Kadir wrote:
> Document the QFPROM block found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

