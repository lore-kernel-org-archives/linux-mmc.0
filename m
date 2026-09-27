Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B363438A1;
	Sun, 27 Sep 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531245; cv=none; b=J4dqQLiRDi4dwaxHeHKdIGKxu/7zKoP5LYFGvGGKY+KnnfDgRUVtEvSJ4QUcNWC86iCCoyzOMKKgvVUbtuScODFyjXfSBSk/n0HGumG4EyFDvsTeRhg47L83ahR3+LhjtTIln3b5/wdae1OIqhxr4mDHNGU5PwvEOb7pOXw1RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531245; c=relaxed/simple;
	bh=XQa/0FGcbV4DJZxulZm8xi2VEhQ/ECB89X6MiDGzHF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrCif4/SxZdAk4oBDG2XAFO7DTr4Jl+YiBan7H0ij+k3BANujtZQ/vEeI525XV6S2pl4tMgrBUlDUCpe0sMkTKL5sjMrSmKWzODRpk3prR6VezwUGS9pqKawDnDhYlYGdRMY8xdSyqxYVTt/wZCqLZ/Clcm8ZxgMXiQB7N/df+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTse6Bce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTse6Bce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835891F000FF;
	Sun, 27 Sep 2026 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531243;
	bh=4UGSD6QOqsK7x7bW27DoVdhw8/6KXu6nNsPGwCg+XOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTse6BceAe8HDezxUlWZ/5EQyZhJCydrkGIETRwb+qZoDQdid4eUZiet1e/6LE3XY
	 6CKwR/P9eRbDakEQpISJQc/muLW/BCSVfe4zjAVLXFGxOusx/kiSYwE5qIgI0fPQMe
	 50lAZXN82q1RRUocay1M/xuqzW4oj6d8R6/EuIVoamW9hCric6QoglU1YSKn9l1Qdh
	 Mc/7iKuoPES12gmICCMeolnpSPlEdQbw1tu7ur0q4A9eD04k+IX1T7QCXzcWN6pYZk
	 pKdB/DBpdjwqYBL3J+evETgwqzESxou2Q9F+n4zeUizvN0HH4yIwiaodfwhsA/zSjL
	 ybq1Rid6R5bmw==
Date: Sun, 27 Sep 2026 19:47:20 +0200
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
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Message-ID: <20260927-tiny-electronic-toucan-bcbd21@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:18:55PM +0300, Muzaffer Kadir wrote:
> Document the compatible for the rpmpd found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

