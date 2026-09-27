Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20723431E71;
	Sun, 27 Sep 2026 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531541; cv=none; b=psUc+2N1jdInoLlwzsoleMWTFOskSbXHtQezWGXgBjb5Cpyv88s5p+FKRP2Qe7FiPSkEFp53GBQMg92rSWKxVCv2qLjaxgFbuApXLFug7Ehc6oexBpr5v3JvMGl0cXpITNzSFvYQABvCFl5rzlPsthrK7CAsA2NxnkHPvG6DVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531541; c=relaxed/simple;
	bh=6cEUMP31L4/CdlrVra674pnUkoxfmAa0lhY52HMvXT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glgdJU4qC0z3hNm1gI0zDq/URFViRKQ2x0PXZpQM2arEvWcsa3xSOQsCwAQpgFkSbf+Ae2jsbn3osNh5/KmBGSziwf7PJ4pUcBCa6lADiN8CYXl1ae59bLmNRnPyGH/GJ76OkKSFmuC+7gKF2PievsAE/0zqjjjtjnc70d0Ho+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPWVAc17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPWVAc17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4486B1F00893;
	Sun, 27 Sep 2026 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531538;
	bh=QazZ2O3eNUMlHmNoeOgTtKD8VMEf7NnZOMkD5FjrEGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NPWVAc17BwaG8NWnQglCsaYlwi54DrweQwn5HxAje9YeEh6A1HBC6vR4hKsbyNPqo
	 zcrpg9SzPthq6JeV7iWiIZW79p6G5bQAWFmUokFF+tewUOt1SVUzSZnZwazJ8iw/MR
	 qjOFObIx+NDDRKEIOIHkabBBFbQ2ELQi7JwExHR+KUdsJad0l33qIXFxYHbPEPVgBK
	 EtDrpZd+S16KxqFTJUSG8B0x8qBQm6dWckb+ZFi2XVC4O0eKW/MxAriCPKI56n6Udx
	 b9xKeeb7Fbu9sNt03/9rKoKUgcGITYqhAanEyBE5m8lksVsDBkdTaZIb70zIMaT6KT
	 B5PuKxI/xhofA==
Date: Sun, 27 Sep 2026 19:52:14 +0200
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
Subject: Re: [PATCH v3 18/19] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Message-ID: <20260927-acrid-labrador-of-typhoon-897f7c@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>

On Mon, Sep 21, 2026 at 09:19:09PM +0300, Muzaffer Kadir wrote:
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  .../bindings/input/touchscreen/goodix.yaml         | 35 ++++++++++++----------
>  1 file changed, 20 insertions(+), 15 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

