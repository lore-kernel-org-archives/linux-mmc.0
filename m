Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D536324B33;
	Thu, 28 May 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954918; cv=none; b=MnERHMb8DA46pX+nhqj+bMCsBOK1HrjtuWv9yi+sXt4Y+azFK8fxy2EG6fd8Op7MPq7zc5xanyXfNEh5+Mk+Z31ujyHKJVu1ZPb6qp3Mu7MVvGIIEqvoy8miAE9UO1a/zeOjxOm9hR+lL7RgT2O7e6PXOZ5Exi8z3IgdeBZ3QRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954918; c=relaxed/simple;
	bh=y6fXIXlEI5Zvwv/XqTRCsmL6tO4YFp7h05Sc8KY4a5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvaAbQg7Q4+y93A9vLklF2Jpbhvo8HPvQF32kWDF2KkT5fQj4Tt75xdtQiCr0LBgJtoRWY02gStvvg1TUhIx46ZwWbou4OAOCW+CjzX4a/eqOtmZJk+lLRVqN+Z2d4RBHOSZ7ZbyV0Kb+S5b1MiDQZsEVsKBeBRFLWyeIGuHsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLgTiPl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLgTiPl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4601F000E9;
	Thu, 28 May 2026 07:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779954916;
	bh=Wibil3fYU7GUzl7PZD0V1fXrGP0RMfeghbY1bbCixbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLgTiPl1IgYq8aulOoCEBcZXX9yW26avJ91eMXfiFbNJQZ8j/bNMf7KYCCvRC0JiF
	 cxi/KnUQR1OvA+zv2aLzqHFi4icCyOyL+RXIOZQhX3c8PwlP91EwzU5Y+q7MjLYO6B
	 aafozRDfaeAORU8qR5f9aZkQTiHf73dVRY39V8RBXer8QIjE52D4dhxDJsJQWgV6rL
	 5v+6+RQAZfg4xX15qmpNHcrcqNPhcMBY0HfDMGogcW7DPOb66uS96gTKc+FqwtiYh/
	 okrUMTpz6nrTcg3AAXL+J1Bwc8AKr9Lg9aJRYdf0OJOB0BRN06o9Y8lmg4pptBaN3g
	 zqhI8SpFrMUhQ==
Date: Thu, 28 May 2026 09:55:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: qcom: Document Shikra and its
 EVK boards
Message-ID: <20260528-tasteful-fervent-cheetah-ced6af@quoll>
References: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
 <20260527-shikra-dt-v4-1-b5ca1fa0b392@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527-shikra-dt-v4-1-b5ca1fa0b392@oss.qualcomm.com>

On Wed, May 27, 2026 at 09:23:51PM +0530, Komal Bajaj wrote:
> Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
> form factor. The SoM integrates the Shikra SoC, PMICs, and essential
> passives, and is designed to be mounted on carrier boards.
> 
> Three eSoM variant are introduced:
>   - CQM: retail variant with integrated modem (PM4125 and PM8005 PMIC)
>   - CQS: retail variant without modem (PM4125 and PM8005 PMIC)
>   - IQS: industrial-grade variant without modem (PM8150 PMIC)
> 
> Each SoM variant pairs with a common EVK carrier board provides debug
> UART, USB, and other peripheral interfaces.
> 
> Add compatible strings for the CQ2390M, CQ2390S, IQ2390S SoM variant and
> its corresponding EVK boards.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

