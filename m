Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F525A645;
	Fri, 25 Sep 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343589; cv=none; b=gVhBu98i1Y3tzg6UC1lkUgj2qX4r75iLWrTBM8tDjRcaZilto6lU3TWiLu6iZTRBGUsaiunB5tKccDRWpEw/+huNeKRVd1UkQ6UvdCOOYz1cgtMeLxP1eqopmYd6vMMbUD2RI+DIurbzFa/9gmDIVeyujKSw1dC0ugLXEvtJSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343589; c=relaxed/simple;
	bh=EJrogBOmykwU5YYDtuXLechUrczLhU0VXgU3OVOUboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2L373mmiHIiD7AJTyWKLFXeBJhSl/15+cbGo6G9NCX8iwpavDwjN07lQOKjlShgfir2+a+AdURGwpG7Ui6YY9RpsSRpVx4rRwL8+ybyZMVRzrPxKCBTmvn8baHuqK3yiQ8vervedjEa245REjgoSljgXKOnBjdtMARdldz2A5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoPGZI+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoPGZI+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8927D1F000FF;
	Fri, 25 Sep 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790343588;
	bh=7WSWlAyFgg3pyLPe2qxYT+aJudjYOWE9v/3Ty5fttX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DoPGZI+qvmnA7NgVG98JmBm1veQcfnBva7cD+HVyecx4coUifmCIYJCaeedvnCrkR
	 8ZBlTWXlMdoLReudAgf/4gLArsvXoM1GRJsR2qnecdj2u9Xzux9HdkiSKDIWFM86+o
	 THFn3aZ0nKNVqaJTBxOJ1gW4PA+rIwaMFuCqDoomDdX/k8KOm0FW1WXlBuzA+vPXRE
	 mQv5FvnmF8W8aJUv3/EgUxLv/zhhm2hQvXYb013c73i4twHYhZNkio749Q++lcdVv+
	 QUXfAtcw+uf4mpsbYZGlLVrfdSW8AE2eIuHng/oFMjBpEhEq0Fb44ChM33/m/o7gfx
	 cQWlN8x/E0KGA==
Date: Fri, 25 Sep 2026 15:39:44 +0200
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
Subject: Re: [PATCH v3 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Message-ID: <20260925-devious-vegan-buzzard-bffbb5@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:18:52PM +0300, Muzaffer Kadir wrote:
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
> 
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  .../bindings/clock/qcom,gcc-msm8952.yaml           |  65 +++++++
>  include/dt-bindings/clock/qcom,gcc-msm8952.h       | 215 +++++++++++++++++++++
>  2 files changed, 280 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

