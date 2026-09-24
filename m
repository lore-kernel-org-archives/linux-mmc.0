Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF5379998;
	Thu, 24 Sep 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260116; cv=none; b=HuhshssmcjTAil56nNf1WENOz7GIvYFaB5l0ycv+lWeDOSfuh2/0V4oI6VsuE6NZC9uaXsOSVZwMmHfBuE2EJlHxNjwX1TNoVDu0dvQ/evf7i3CqedSOx+Uz1eGBFtzdrIeRMK7RMIp1L/uLh4ulOVOyKFpRe/6E+kK98fiuumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260116; c=relaxed/simple;
	bh=4aCUQy0hWo8IdaDKDTYMyFJ7kry/jltOSeuRCSB2Cb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ilYRrGUtSnb3p7FscXGs022Kn6hsnIWJEMfN3hL7giDTvatdDdGNF/SarEERBsOQ9heZP9jVxk66E6k634MfuvLvure4zV5KCp7R1BaPrnUFY56e983mZtLNFz50c86w83rp8SCzBb8WDP54Jw6JHSfT1c8u8EXlQKaywl+Qx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAanq/HC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAanq/HC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010121F00893;
	Thu, 24 Sep 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260110;
	bh=IL6ClCwIjkZWXa+/sikAWRTuWWNCeUnK+ge6atvO8+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cAanq/HC3J8+Nv74HWHMMsnf0HUL2z8Yx0G3QNxBFsbIJXebsZOfmmG+sNEdqzh+G
	 yhzVjJZbm4dPGZFF1NpUrCnE4NXRu5SAmuyHWYfH1Qw1SnIlH/sdao7pzGHPcjdtso
	 hhh1ah6O8YA9dzpCrnTkeCCZ74NP14gr62drZeCVEybtrl0JLnx3O8ikowIk3TdeW2
	 IQPmDqkmQ76fHJpzkKiiYzpN5sD7jS+f9jUf+7oMRUMtRlRXx1qH8l8d3hMowJ+Jf0
	 vhKdEBC1+V7wAqzLHB7OhZy7p2zEWkPk7yi6zn8uSo3DhwifnZplpvIiJUK6JIDQSw
	 c9g3Tm7I8atOA==
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 iommu@lists.linux.dev, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
Subject: Re: (subset) [PATCH v2 09/19] dt-bindings: mfd: qcom,tcsr: Add
 compatible for MSM8952
Message-Id: <179026010074.638531.9042726679993021271.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:28:20 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 16 Sep 2026 17:22:14 +0300, Muzaffer Kadir wrote:
> Document the qcom,tcsr-msm8952 compatible.

Applied, thanks!

[09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
        commit: 319633b06ff2bfc2a7a60d2cfcab2e681a343b27

--
Lee Jones [李琼斯]

