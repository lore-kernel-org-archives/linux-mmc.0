Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAA32D0DE;
	Thu, 15 Jan 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467909; cv=none; b=KjTPiynEXdHL+me2/erSEk3YCMbhuj4Z2ZV/BX/0G1seDwLJN+jPXtoWn/VtcLCUuqvc1GX3T6rCQaqpVLVBxg3icYwhyqIIEzXgJiPyfB/dFSC/WWJz8/tsmcItxNmLMeFsbIeGL/qkVBnGIIPfvBe3RUeTEFrNcLmLctVMeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467909; c=relaxed/simple;
	bh=92fnwA1YUaiWnVBZ5A+gGFaFWgKRCOGtEgN1T4WQMj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr7dFo/sx1rKFsE8D1d9Gbx+b5YVk3Lw+7wh5XSD6zjeE6pqPwhnLSA0IRzuKiqVf+1ZSNX7PZQrqUn5tVO0IDJi+V3IOw+B1NkcWYG5zguB7JbI3SYtCLi/hJGMIc7MC6HKVZRjj+bqz/sE3mDM8BdKzicm5uG8u6m6kFwSWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhvcZ3KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhvcZ3KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30E0C116D0;
	Thu, 15 Jan 2026 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768467909;
	bh=92fnwA1YUaiWnVBZ5A+gGFaFWgKRCOGtEgN1T4WQMj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhvcZ3KDZXpQ/KCGrnzdjToo2M/iSXWp/FYVsww/dzMvt38gyHkXlRI+394kbdlWq
	 ru4DLzZOOC8MXvU4Hu1yy5ZLz9lE8rVv08NxSmiFLbbJmez9fr7pyYP33W1huCf68J
	 niefh+2GBCuV/4R29P+jUOahrSUGcTeIuHWNPBjXH09Qed0y7HWHy86CAMxIhSBY6x
	 oRWTUSH0NwNUVv2UBTDT8CHAHFe1RTHvcpF5uUY3I2UNb0RCQqeX6uT6pQCU3ymNxe
	 A29JT2DRKibOw/lP0TlvvwtOkwt8qIyxntKpKuu4hVb8mAWLm6D6+7823cWacxU01i
	 5YXaQpSn50jwQ==
Date: Thu, 15 Jan 2026 10:05:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: kodiak: enable the inline
 crypto engine for SDHC
Message-ID: <20260115-versatile-bustard-of-bliss-059e5a@quoll>
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <20260114094848.3790487-3-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114094848.3790487-3-neeraj.soni@oss.qualcomm.com>

On Wed, Jan 14, 2026 at 03:18:48PM +0530, Neeraj Soni wrote:
> Add an ICE node to kodiak SoC description and enable it by adding a
> phandle to the SDHC node.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index c2ccbb67f800..fb2a9c0ea0f5 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
>  			qcom,dll-config = <0x0007642c>;
>  			qcom,ddr-config = <0x80040868>;
>  
> +			qcom,ice = <&sdhc_ice>;
> +
>  			mmc-ddr-1_8v;
>  			mmc-hs200-1_8v;
>  			mmc-hs400-1_8v;
> @@ -1071,6 +1073,13 @@ opp-384000000 {
>  			};
>  		};
>  
> +		sdhc_ice: crypto@7C8000 {

Why this became uppercase?

> +			compatible = "qcom,sc7280-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg = <0x0 0x007C8000 0x0 0x18000>;

And this? there is no uppercase at all, so maybye you copied it from
downstream, but that's not right approach - do not use downstream code.

Best regards,
Krzysztof

