Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8243A6B76;
	Sun, 27 Sep 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531437; cv=none; b=DPZh6A/84r23eSoZQAgRjE3cnTO0ZjgTKgfXXFOnUFBaRN2nM7aCpB0k6lFFORazG94smf+io+Dd11ipDEGUSN9rwv1Aqx2+GCdxXeBL2GhXvxmO5RuoR+N+fr1jd1ljIUQs2x2P3Icw+/KKZKdRpBpV7L7rL2gBIuS6axbqGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531437; c=relaxed/simple;
	bh=jCG5QDjJR5XoALHE2uaTx9FzsUteI75pCYFnUlqbFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv9ZDb4Uwrl1gDWq9vv79k3npyusjHBry4CzEkLclkkxEls92pqN5wRiU7fwrdYP5CukGC/cSwSfCMkvr/5Zu7pUo21zNqcaXYVlG0zWesj1umqxAUeHKzAZP4L10pTRbN5Ft0e/N3ks9oh5/RWE4KJeXVdEAjr0ZMCE3n/bMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgL5SSxl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgL5SSxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E31F000FF;
	Sun, 27 Sep 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531436;
	bh=/vbm5QoeycSWTloWQxB0kK3Em/as6Fxxdtxh7/akDAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgL5SSxl4EIHtpk2EftozLFVQvL19d3Yksi4Qybvo/uVVVu2mM4yhNRU4nTTcVCZA
	 oMz3NGKIDQvdnO5IpJjWjRCZZcJHoU1yStMmrU2lrzkqw9gts0nAYGc48SLADiEiLG
	 uiVizhCyPO57ui43xZCoo8KlCPtwHU35UVu1kEI2NWmjAaBkSDYarmohJ/RzlYhPT0
	 ah2wimxJhD+Bl6+zfoOJNsipF+aDTezlLBJ5au+LhOdLmvayiO2aoolMacvuG1hS6l
	 xBKe9wjveFD8MoOSOk85CTi4IQKfjPP+Luav/rKHouK8mqsm9fqG4Y9S3evyuI6M6e
	 9JADdWrSLLIUA==
Date: Sun, 27 Sep 2026 19:50:32 +0200
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
Subject: Re: [PATCH v3 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Message-ID: <20260927-statuesque-energetic-cheetah-dad592@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:03PM +0300, Muzaffer Kadir wrote:
> Document the rpmcc found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 17332aa55886..aa532f208f5a 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -56,6 +56,11 @@ properties:
>                - qcom,rpmcc-shikra
>            - const: qcom,rpmcc-qcm2290
>            - const: qcom,rpmcc
> +      - items:
> +          - enum:
> +              - qcom,rpmcc-msm8952
> +          - const: qcom,rpmcc-msm8976
> +          - const: qcom,rpmcc

This block should be placed rather before one using qcm2290 as fallback,
to keep alphabetical sorting.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

