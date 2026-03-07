Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57090258CD7;
	Sat,  7 Mar 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879815; cv=none; b=SyZPuJT62kPDB376MJpDbFlzrzupxVnVxoej5YYUn/+G84MFK+KtVlrpCcwx3wXIRc2Sgop5oKYMQ6AN3oji3Zhv8+JimF0ePOWl85afpiX6VlytUvnei5tfYL8Or71QZIGzaXVoLp390IaX2a1fMoD5sFpkmlDxJqhgNUcnITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879815; c=relaxed/simple;
	bh=U8ypS7Lz2A3tC5dEZwAsW+AZ1FoNqxvk8Ah5X7QXGVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAZesJGN8qYp2PAaBXJfvvFJmYaxq2kX4j6Q7NTb+57UdEdExFpqR7Q7ULJO3VJjFPQrgv/TyFisBFPkOW1XjQlntn82m+YusU3tKc3MBU41URdeQ6bcu8WGPlsxk3q9B7uL5mXDdG9FceknG/X+L+tdfK5zx6/uY9XXrlTscwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmbOJfBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmbOJfBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F02C19422;
	Sat,  7 Mar 2026 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772879815;
	bh=U8ypS7Lz2A3tC5dEZwAsW+AZ1FoNqxvk8Ah5X7QXGVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmbOJfBUCPobD89sGRuwbCFuAj69GbfCmEKPRfp5Zn3/YpRF9tc3uQqVhMmOkFvMr
	 QLwvggTACy1acK3NT3DDN/Qodf5BBlKdKncfWOZ8c/9p887t4SodPSRq6j0G6b92rP
	 H5oW5BYGdry4S2XdBiZXu2RIGw8neIY6GQ56B5yTX+VfkzwUTMZgY36uHKVPt57sqc
	 Ava69VALn6JyS+68PAy6tDfKRNfcTyrezvRKCTZgByTJyKsbXC8UfrKEPH5YzNG8jJ
	 lHpNXCT3zS92zxUTmcoDpwBFzVGFNxWEmcn1cJ/vg+B0pJBKoQQzQcSxTEqxRY2PE6
	 dMCzai/0xUKNQ==
Date: Sat, 7 Mar 2026 11:36:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Message-ID: <20260307-llama-of-massive-downpour-2e512a@quoll>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
 <20260306093332.4193993-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306093332.4193993-2-neeraj.soni@oss.qualcomm.com>

On Fri, Mar 06, 2026 at 03:03:30PM +0530, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded ICE

Can you finally fix checkpatch warning? I have impression you ignore
checkpatch in each posting.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> register region in the SDHCI node. Older SoCs without ICE remain valid as
> no additional requirement is imposed.

With this fixed

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

