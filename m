Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230ED43636B;
	Fri, 18 Sep 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725727; cv=none; b=mkOZA0NN0doPFp6xRQG6UnP37CzO4K5XfEmoUzby4KswsDg+23IDf0zymXRPsCWijdv2IsCf4uLmx8pkbzYosyAdRZU0zsM23oHA9LoeVfDP5m8jB5SH0YrNAATosbXeVFcZ8SJHKbM9/+mXj/IIfFJv5gz4rQwOLODCtQsexGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725727; c=relaxed/simple;
	bh=MjTIy/1+ETtO0uZOFMBhngVP/dUp5evvwxVHEIrK9qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGLW1p6KU/r6OCeTAuiJyLlJjbdZz+mOKMY3x2Qk0rvU0s21Jce+Y3/bCORHCLyQpauVM/EAb6oHPesrszDh044xg8U0c6WNOUI+QiHdt9xww9Wqe4Pz3wRYzYTNBKCYRr6VQEdNNkHge8AO1ozFQfZL7AglnRFsWcXnNI1lu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr2R9JGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr2R9JGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978421F000FF;
	Fri, 18 Sep 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725725;
	bh=TuKf+se4/WQhc7yjH9EKqYLRLWGTVuMIsQ21THLKRXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hr2R9JGF/xDMykb6xXJ/HY2vNaL30WQN270YcxZWsFioZ+5jNX5otawhZ4HtttciR
	 foJIpz69Ij082Xs1NJZ34AUBeedRwe3iOb+knGoCJHkfWJRFbVtZK7V9FzuqzV/kpR
	 Zs9tRpThIWo7B2Ywo+nGT37X/h5Qe6+qhJ9DsRG0WYuV8qfgosMzceChbch8Xt5mRz
	 TFYW5ygTEEzs/JkYfRvRL/iR9Mo16+wyVBi11KB4rifB4Kv1kHU1R9Mg/NGrz3uwvd
	 UK9Ybbyf9woUgYX0HpulpVpHQCROT1hQ66BlEUPSEKD48YiMruzGl+uhlWOdvmum8P
	 UNeJMPdCVKuhA==
Date: Fri, 18 Sep 2026 12:02:02 +0200
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
Subject: Re: [PATCH v2 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Message-ID: <20260918-liberal-significant-crow-f1e66f@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>

On Wed, Sep 16, 2026 at 05:22:06PM +0300, Muzaffer Kadir wrote:
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> ---
>  .../bindings/clock/qcom,gcc-msm8952.yaml           |  56 ++++++
>  include/dt-bindings/clock/qcom,gcc-msm8952.h       | 217 +++++++++++++++++++++
>  2 files changed, 273 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
> new file mode 100644
> index 000000000000..274dde633e17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-msm8952.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on MSM8952
> +
> +maintainers:
> +  - Muzaffer Kadir <muzafferkadir@mainlining.org>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on MSM8952.
> +
> +  See also::

git grep "also::" -- Documentation/devicetree/bindings/clock/

I asked you month ago here:
<e3fb3794-ca7a-4794-8036-b69e563aaa57@kernel.org>
to not work on old forks.

Old fork which you should not use is postmarketos, lineageos, whatever
Android fork kernel, and whatever other tree which is not upstream from
kernel.org.

Best regards,
Krzysztof

