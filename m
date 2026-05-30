Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154683955D3;
	Sat, 30 May 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141602; cv=none; b=nQR4puWPSeE3hQXmgYiXB7QbsG937N1z27MzMdcaRtD1gnnf4YEaVfP76YfHI1I//eRXl7AvtcX2YKx71KJ84oiF2ZI9KibVyzdhj9N5Xikm02N+xFCnUOjWKOaW1ZjzJpfgwm+blcS4u9ZankObmua3S3OqjeadvLB5eURlKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141602; c=relaxed/simple;
	bh=wHsOlKX63fgfP92ymKm5m+IAIs4eZcPGWPqvtwWUA14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU566kstJRK0WD7KEj4FUNJc/4n22M5MNlfMGbkTxLGyhqJ6OU0SUJU8E0Yxca0u9RWJPhn9mpQL7MG4eO8wd2e5oFh++lUpuMtndFkt9sDXCro5dex9QLi+oIulbKjwIBHwzVp49UDTqfpm6xHehXdUXwyS+lwzx+veYfMr7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVc9T7+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVc9T7+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F2E1F00893;
	Sat, 30 May 2026 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141600;
	bh=4w+pGBw8aB7TTsd8Ahao0ApeXWwKjsPmyYUKP/TztV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVc9T7+I4XrfBA3fB5JQ4uNDa4CqnLFuUeUUZWCIYqZk7LCh1dSf8HrKmiVSn9ALC
	 ExkJXGTCjpjYeZ02T63fDjcMYUlFoPMMcs/PXQxSb75JYQujmyNfANXjaE8HlSxoi1
	 W0T1tpwxzFQ99mSKX9GHHCR6xpIiehhF6cQyCBx1FqkatObrXMMiYHetziXubeMBmU
	 6M057OmAq8cFp5fNruIGVFGIIT6ePOt2JXNbHXZKMkWESYGuKicprRHSgprc06wfX8
	 Yh0lVOCga6lM6VOLNrNFPnAaZzTHv7fistBMyIX1vksHikbioVbG4EaLlkicZuzh+R
	 BcdndSAvTphyA==
Date: Sat, 30 May 2026 13:46:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Rename the binding to
 include 'qcom' prefix
Message-ID: <20260530-prudent-whimsical-bull-7ef4ff@quoll>
References: <20260528135342.11678-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528135342.11678-1-manivannan.sadhasivam@oss.qualcomm.com>

On Thu, May 28, 2026 at 03:53:42PM +0200, Manivannan Sadhasivam wrote:
> This is the only Qcom binding that doesn't have 'qcom' prefix in the

One of few. Definitely not the only one:

dp-controller.yaml
dpu-common.yaml
dsi-controller-main.yaml
gmu.yaml
gpu.yaml
hdmi.yaml
mdp4.yaml
mdss-common.yaml
ipq806x-dwmac.txta

Plus there are such like leds-qcom-... which also do not match pattern
in MAINTAINERS file.

> bindings name. This doesn't match with the regex in MAINTAINERS file and
> the 'get_maintainer.pl' script fails to list the 'linux-arm-msm' list:
> 
> Ulf Hansson <ulfh@kernel.org> (maintainer:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
> Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Bjorn Andersson <andersson@kernel.org> (in file)
> Konrad Dybcio <konradybcio@kernel.org> (in file)
> linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)
> 
> Hence, rename the binding to include 'qcom' prefix so that the regex
> matches correctly.
> 
> Reported-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20260526151003.p4kn2vek3hpv4gzv@hu-mojha-hyd.qualcomm.com

Suggested-by, please. No bug here.

Best regards,
Krzysztof

