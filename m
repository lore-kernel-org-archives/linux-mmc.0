Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFC212B0A;
	Wed, 11 Mar 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209763; cv=none; b=hDTWHIIl1TSPQsLdov6T2SZLcndWvA1+wQAKT+ewx9Qstby8Zea8FTLQs8X3NuarWm+JuUADUWjCW7ypGbyxFiDaYJoA27fpwpMzeFsV5xVqLS0194jFmRFVTNo6QYOZngbhYQcT4dZp8t91ElQAAAMPcysiPd95nVjYAR4Qop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209763; c=relaxed/simple;
	bh=Xij4l883w8RhKaON3kZ7ergyTw9qVDIhU25duNhfeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+uVolKtTZvlG079X3XOzfL67NrX+/74WEStfimK2pFxW5iBkVKDN/bRCTsP0L1cT4+blpBEsSPc81LM+xzfMpjOnBpAmT+LM4vhC6Kk/RkvmKLW3VJtkGXHS1Z3sJNIRK7F/9JEszL9LvS9/st7DE/Y5Us79OIY4/6H0li0Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX0al50k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX0al50k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A491DC4CEF7;
	Wed, 11 Mar 2026 06:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773209763;
	bh=Xij4l883w8RhKaON3kZ7ergyTw9qVDIhU25duNhfeQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lX0al50kPQjh7bwxxJUpxhsw8N83WjNgBNo1xJ82jBLclUeSimPeADcJjnR+zk18G
	 v6ERyHk+7ZLkhOAuhC5sKqwqyf8WIo5SKr7TcgJIkQDzRnMkCuvVvm4KprxDRPMVSs
	 ZNeYMu3Vt4BJ4aSDB9XcWy/u90IVccxGlP770377OVP0kV6em3Jzw+OG1R3DDW6VcQ
	 Ihedbrje3eXBwlZD4o5eeKHc2hVUqT+XLrfJDzamCVyI+XJyIKMx7+bSzAMgAxAPIX
	 51B2hGYjxmSj5dav+iJ2Qxt1/dxJXX6lXa6JGMYbZIFW0oHwf9iyPEJmBUAgkWKhmo
	 dW92QvUsbX8bA==
Date: Wed, 11 Mar 2026 07:16:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Message-ID: <20260311-fascinating-qualified-whippet-d6d450@quoll>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310113557.348502-2-neeraj.soni@oss.qualcomm.com>

On Tue, Mar 10, 2026 at 05:05:55PM +0530, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded
> ICE register region in the SDHCI node. Older SoCs without ICE remain
> valid as no additional requirement is imposed.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 

Can you please finally start using b4? Except errors in your process I
don't see links to previous discussions either.

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof

