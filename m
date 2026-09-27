Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBF3CBE8B;
	Sun, 27 Sep 2026 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531343; cv=none; b=FuCeaS1RgEUA+ghEMajimKCUZzPXDdmh3ucJIoK9z9iiDA78ZWSmwek6Rdr6zD+0Qjm+Twv9c9v9Y1+QBjNXotMTADzWwYEAmvSCNvXtLoH+vCYzJNq18Zt0UX2H51uXLZi4G3JSEq3OCHIRPLLKHsurKkxyLJHj8WW63aDkfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531343; c=relaxed/simple;
	bh=OU7OA+FOKxv35R57xlb8NImK9wSwsXMREPWbhb+QSew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJyyz2bYZla1eTS8T5koceJh3ey+vJvyoQQdxqMIC46GEDxUV2asjfX/jiuO2wPXcevShJUPJtGxeQVR5DJx3+/efnthJ64Ba6+Ww2fRLyUM8j6el9bwUvVhWvQeIhBUaCx44L9w6N5qarFKFJnQ/gNsky6KKKK0rian7tPxZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD5/LnnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD5/LnnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447211F000FF;
	Sun, 27 Sep 2026 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531342;
	bh=K9h/5RxU0hJME9D2m1g4TBHB7ZhNLVcOG3T74Sg7/Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PD5/LnnKiPbq6JxutjQNnR+Yr6Y5n/6JQffhauFiGBHWLu9ipwy+ylcQphPuxgLH9
	 nmG/vduAZKUFxF3kczx9PtT11XO4vqwmllTwZNbauEAtZbzM1eLCMfzV9mlApt4Wfr
	 dpniAZJ8+EYT6G1bsHDQ9APE6UCd1P6rPcSawluStey7f7+wjY3uDb/OcII7AaN9rr
	 q/Nwmj8EyfaLyWcxi+ufuYNSDqy5u1/1IZtcxrLy+Lc+0QaZLxEdpINf+KeA3WC+0K
	 WrHrLF/MrNAopsBJfcfBGoBMlpIfOTl+xc8w0jcsopMNTbVa+eKswz/Bdt3+lcfGPI
	 Y1rMUXsp5b4GA==
Date: Sun, 27 Sep 2026 19:48:58 +0200
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
Subject: Re: [PATCH v3 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8952
Message-ID: <20260927-exceptional-origami-iguana-4decdc@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:00PM +0300, Muzaffer Kadir wrote:
> Document the qcom,tcsr-msm8952 compatible.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

