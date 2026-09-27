Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9D3B388D;
	Sun, 27 Sep 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531288; cv=none; b=maIgnMp1STzjT6NZWxK9kHiRCDF+giU7atGFrK2QS+TQvlmPCuIH5Q2iUgzxLVloWkepmA2D5jC0xi++4rbQmQ/p5Us2MraK/9qsA6BpZWXUMNBMGnrpUwILR3sj5Mc8RAHfrJy6XLhLZzET9tsBWsoJBUqIMsZXJQmUqHn3PTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531288; c=relaxed/simple;
	bh=g37YmeLs7usJYF9K2MiwzWaZf0wwo8+l72XM8pQC96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz65bBR+7/b4f3nLN0QS6BnEuEIXzDwdb64dAQ/kJfJJ777c/bJXYCh2Mji0x3oLQ31aqV5hGqRWiwPDrJ4XvMP88Rl/oGc9Lc+N6StThB4vhP49M3R5rq20+fid5h0QnW91RVZRHwEJpkoM/uU17Jw7wFjx+2m1oAkP9pvOnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKZm7n7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKZm7n7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D571F000FF;
	Sun, 27 Sep 2026 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531287;
	bh=U0Su57S1gJn8p2u4Qvg4csj4H6HZGb30J6Qy3zYfB9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RKZm7n7cGIhjycrt3lUV3YV5bCDfvaZHw/TULzTkrvWBcwy7ck4IzNrhiroi0yTgT
	 I/r+g+hOnGxcTnCvycIeSo2zoPHbhFmto6J61E2NXm7ewnSEPRNa+ionkQKDs7wvHj
	 KQ9G7cvZUK1edrvfitFX3Pax967HV0+CdFm8JO74l+Eq5EY/RHdRHQl9rLXPxdaCW+
	 nDtUbrD+TYHHbbJwLcjiTPU6EJxzLU4x3LwqajifPR6UHJwW1UFjj/Q6Fb+yfqS6I9
	 0LB5lSCLJuEDmv9OR3kz9FOLVy3jl5T6qiQcbgTirkCjrDz44B/M7Ej9vQagBP8B7q
	 dxEEQbkVDYXow==
Date: Sun, 27 Sep 2026 19:48:03 +0200
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
Subject: Re: [PATCH v3 10/19] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
Message-ID: <20260927-daft-rose-petrel-e1dd11@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:01PM +0300, Muzaffer Kadir wrote:
> Add the compatible for the MDP5 found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

