Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0563FB055;
	Tue, 14 Jul 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066329; cv=none; b=ZE1XBnWtgsgH7odbE3QVTmMFHdIuBQwh3MENIDUaRMYLl3Ent9Hsm2D5O/49FL9+YnwrD4/e5B3sI6L44R8tXcKVF0c7df6sLbW+ChzD9M8qrpH/T4dTYlAIluWxhYEmGnL4EUlZrWzg5S4H77Dd1s/T8+V8Ynh1kIR+NiSualI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066329; c=relaxed/simple;
	bh=ouy4npV4LYbEkQl2h2wNkvuTixT3WVi6+ilKYKx4Dbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilLJoLjir4570P/TbRRBNWm99vUBDd8ugAUfdyRVyOFX7+/yLB3ToUZ0s8Mk6q5GCd6IcgYb/PxXEq9F5G6kIAIOyHFcPwOP/aNNrz44NDZclTyNaz6PcDxuzM01yJBGIVhxW69cwsaQ/xEvs1beVV5Nqo1fVs5wThcsOBf4OLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt4jxkA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt4jxkA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8307E1F000E9;
	Tue, 14 Jul 2026 21:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066327;
	bh=jIilpnqGzj8khC1MQLy4UAKt3Fn3dMi3MkFbuxyLZ9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dt4jxkA4TwqZ1+6gdpqQXr0td3yEo2ANQRTYH4pFYL/oWQgZtzgthWkPKSwydZG14
	 hu360Yk5Z3QM4gFEYxmrmJh2wbsiWQb8kcUPaO/RUPNv6ljfTE+TNgVy2gLCOUWWBk
	 +0eWrDG+UJT3sGaUT+YJw6/sYBEC0D/8Z0InhL8k7LDIQ/w041PIu/5S6b8SK+wbg0
	 cNlK0N79w9kBiOwmOy+HCaYGi3/C7pIcu+bbYn7hGw2IATAAoM2XHwrbnRwMfaBw92
	 YkrAl4N5tIKo2dj04VmE/gGR/BsaiG7JIr6iUd9PFDZpw0jKi6kzGFE1ngSzI/TqdP
	 ReYiWXDcJVTig==
Date: Tue, 14 Jul 2026 16:58:46 -0500
From: Rob Herring <robh@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
	monish.chunara@oss.qualcomm.com,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Monish Chunara <quic_mchunara@quicinc.com>,
	Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
	Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
	Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Xueyao An <xueyao.an@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/5] arm64: dts: qcom: Introduce Shikra SoC base dtsi
Message-ID: <20260714215846.GA2932445-robh@kernel.org>
References: <20260708-shikra-dt-v7-0-977b65a300c1@oss.qualcomm.com>
 <20260708-shikra-dt-v7-2-977b65a300c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-shikra-dt-v7-2-977b65a300c1@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 05:47:31PM +0530, Komal Bajaj wrote:
> Add initial device tree support for the Qualcomm Shikra SoC,
> an IoT-focused platform built around a heterogeneous CPU cluster
> (Cortex-A55 + Cortex-A78C) with RPM-based power and clock management.
> 
> Enable support for the following peripherals:
>   - CPU nodes
>   - Global Clock Controller (GCC)
>   - RPM-based clock controller (RPMCC) and power domains (RPMPD)
>   - Interrupt controller
>   - Top Level Mode Multiplexer (TLMM)
>   - Debug UART
>   - eMMC host controller
>   - System timer and watchdog
> 
> Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Co-developed-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Co-developed-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Co-developed-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

So none of these people nor the maintainers managed to run dtbs_check on 
this?

All of these show up as undocumented in linux-next now:

     'qcom,scm-shikra', 'qcom,scm'
     'qcom,shikra-imem', 'mmio-sram'
     'qcom,shikra-tcsr', 'syscon'

Please fix or drop this series.

I'm tired of chasing down new QCom DT warnings.

Rob
