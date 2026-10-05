Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57742494805;
	Mon,  5 Oct 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208828; cv=none; b=Fq59kSst0yL2hGcavFgC8DFuEuzp4d40yYhJksR9PyIdbnYtlZhXQyYR5AUpaOklDH9dpIP9MKQoGbHdqs5Qwbad5kihU5mXFEyq/nQtrwasVgvpAFWURKIfe3gWwdDPbYO/L6/KTpcmbomwaJccRwJb6/9rgKHqM6U4IxJnksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208828; c=relaxed/simple;
	bh=ZX5xUToHuWaNOd+bCaQzYXpRy+E8h/GxkuOaBVGHj2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzp3QYWlQ+RQTv1PfIEDNvVXtUo6z7q6zfPuxCwM5re+hkCyCA5zx5GKUETs3mQPs7L9J0w9prxDk0CQrscUR/XxwRZ5LRlb453tMtDTUDYTcW++hHm0iHPlgVgGIAkXZlmf77PD8UpBhix7z3Yk2YmxjscXQvPxU/SoEzQzQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Message-ID: <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
Date: Mon, 5 Oct 2026 17:00:05 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
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
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <179098834078.3641559.798772743228949994.b4-ty@b4>
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Content-Language: en-US
In-Reply-To: <179098834078.3641559.798772743228949994.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 03:46:52 +0300, Dmitry Baryshkov wrote:
> On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
>> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
>>
>> Ported without uart connection. ramoops and usb
>> mainly used to debug.
>> USB is not enabled in this series because it
>> depends on the not yet upstreamed (and not developed by me)
>> pmi8950_smbcharger.
>>
>> [...]
> 
> Applied to ttt, thanks!
> 
> [01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
>         (no commit info)
> [02/19] clk: qcom: Add global clock controller driver for MSM8952
>         (no commit info)
> [03/19] dt-bindings: nvmem: Add compatible for MSM8952
>         (no commit info)
> [04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
>         (no commit info)
> [05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
>         (no commit info)
> [06/19] dt-bindings: vendor-prefixes: Add General Mobile
>         (no commit info)
> [07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
>         (no commit info)
> [08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
>         (no commit info)
> [09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
>         (no commit info)
> [10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
>         https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
> [11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
>         (no commit info)
> [12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
>         (no commit info)
> [13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
>         https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
> [14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
>         (no commit info)
> [15/19] dt-bindings: thermal: tsens: Add MSM8952
>         (no commit info)
> [16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
>         (no commit info)
> [17/19] arm64: dts: qcom: Add initial support for MSM8952
>         (no commit info)
> [18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
>         (no commit info)
> [19/19] arm64: dts: qcom: generalmobile-shamrock: new device
>         (no commit info)

Hi Dmitry,

Thanks for accepting MDP5 patches.

The message lists all 19 patches, but only 10 and 13 have commit
links, the rest say "(no commit info)". Does this mean the whole
series was applied, or only the MDP5 ones?

Best regards,
Muzaffer Kadir

