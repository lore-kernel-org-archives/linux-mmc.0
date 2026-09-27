Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FA184540;
	Sun, 27 Sep 2026 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531267; cv=none; b=meLO0lR6sWTxagGY14xWUicF8Whfz/dhhwPrRTOxCzsQPEYVZJdx1Mnu38pTZVxIGJcRg9deQpTzXjz02wUqIvDsWN7raVGtBs+1R0rQWf9pjjo+wl/sScHPkEx7RKBbizCCh2UUKxWDtoDBDro8E61nmf+dCuJT6qvZfOH2bhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531267; c=relaxed/simple;
	bh=yutUDTaYvq+EbHivJWQUEvHwV0VH+TGVv1nI/a2D9mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS9Tkai8xRz1YUYel7Wf9pF6COugVvU5mrqmuLBcOv/nfC57lCfDV0tkjX6gUFAJW1IyoGgBMceNafy4LHLquromY85/tLKPYE8NrrZsPuc1ELfObqO6YPd0ebKsO5TCDGoVaIeyL3DNqxs6lukwH2BYad+HmJ+2VnIyjvlJbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns6Dm6El; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns6Dm6El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1636C1F000FF;
	Sun, 27 Sep 2026 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531265;
	bh=DzR0jTnU51RcypYbL9BWrDBujbm6DjkMB1n09q08+6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ns6Dm6El+tTTIra6dTryY56ZkoBLSpubJGdWdGXd4BSBdvuh1nh9DtyIIlGJRnrYX
	 1+sclfjVdqxlU5gH20U6bI5Hh4vpzoxLMuRHUdcMUA4wm9ToBVdp9qcjsx9uTQBpRl
	 KG70Ot+FEzq5u04M/IbysA4cR58kJuZcgw2WtaRK7bB5JtWLeeJJo5k+rWbEkDl6Un
	 FjHxRXadLGoUmlKbFih+Hs1xKUG8VbTYyqVvq2OQCZDK88WwUQd160hI9YpQr8+2+s
	 smJxJTcbsGeQW8/3xWGaqdqfAY+QQ3n1iwU21A/QjRM5C1v5sS7QTahzr1pjR4IxZ0
	 ovM3Q3/Ddhy7Q==
Date: Sun, 27 Sep 2026 19:47:42 +0200
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
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Message-ID: <20260927-crouching-newt-from-avalon-4f0fab@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:18:56PM +0300, Muzaffer Kadir wrote:
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

