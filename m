Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A063603D1;
	Fri, 27 Feb 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178682; cv=none; b=dR7p09ll+DzHb+Nfaf171FF2vIQuRjmgKfEKbvS0uVKU8HhwlviviV+66Yk/o4m9L3RceGCd3j36L0iHldXxTO3ZxopNWKFFUzOLEbKowGkBUiPPkvPWFVPyhjZTBRCX1AfUyQVaJXmQ7yUOaVVS4BjapRcvhHdixinkXP7qQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178682; c=relaxed/simple;
	bh=tJmofTMkOvrM4zFy4vr0UFifIFUlNdh/swoFBvNlnVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0ECaoVucnPm4STewYzBfSLfDa/DsJqq1IKUyNx7DpZ6uGpjMI+Wq7DwWXJctDNk/v/Jo7PzFB+GLEVD+XNSMc7teycDL7h2Uga3+2HrB10xC2KBy/IEgTzDuv5nBkLuntWZq+jTuhruJ8XFzuGGrjuG99FU28NzUPjgnxoUI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVKwJHNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVKwJHNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA17C19421;
	Fri, 27 Feb 2026 07:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772178682;
	bh=tJmofTMkOvrM4zFy4vr0UFifIFUlNdh/swoFBvNlnVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVKwJHNyff5BxTtW6zzAvPbvgQmeFEH5HP7JBsZRfgYS4tTQj8Qyrdnq3mEakhj1B
	 688i4eLnTxTpzpmoxXd7AVAPVRchm6UVycmvmkgYqT1GLT+kHIvyeFTOLi5Bj1eSwj
	 VEBzg5/J3jOu6/DdaVObTwamNE8MWO0tqU6vPmQLJSnKI2mvsWn/FR8k0ba4+cT3kp
	 KsVJxmYarBpDs0nmnec4opkx5BheTaKgigeCxZXWHIv4W1h8mqc2WpUBA0xtfyv5uV
	 802DHpFYdT1Sz2zgspk2LAwYAv7f87MYpdbCLoYQZbeyNzz9vIYgJXOyMjrN5osoc/
	 mo606voKpgJZw==
Date: Fri, 27 Feb 2026 08:51:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "ping.gao" <ping.gao@samsung.com>
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, 
	jh80.chung@samsung.com, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: synopsys-dw-mshc: No need to
 enforce setting two clocks
Message-ID: <20260227-lively-vivid-wren-8e8a4d@quoll>
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260226091051.300579-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226091051.300579-1-ping.gao@samsung.com>

On Thu, Feb 26, 2026 at 05:10:51PM +0800, ping.gao wrote:
> The driver `dw_mmc.c` now treats the biu clock as optional, so the
> binding can be relaxed to allow a single clock.
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What is this mess in threading? I see here bunch of 15 emails all mixed
up?

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof

