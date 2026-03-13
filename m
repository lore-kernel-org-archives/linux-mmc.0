Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932403BB40;
	Fri, 13 Mar 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407953; cv=none; b=uQ/a3IaB3Qm9hw7T1BWNKesw37OTjLYeSSfWlpaeZEIaRKyL36GTwbrZzk1fzzpYf/1qetdfsoyMUITp/OpCcPUPi0d1AxIBFil+vT4M/8MirKdydalZd897lLAiEnEAnWIYt84bSKMmEL93KT+3+jHgm1drFgp/XgqVGPExgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407953; c=relaxed/simple;
	bh=eOxdydwzMCWwKW+m6Pjcr2i9St6pdp+5lfwnBN75Ue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXy0gsO9bdwW/2QX+mgakVUOn+WDTNwBzqfWDXFpEKpAakMLt8f8DB7XnUvL9dIBrZR3wEYNGE1lEB8whW+Ass0JaqXnBJPhKTpdRa+i8tnYQaSPObudO3loHfU+wSrvfaHAkGFKkVC1Epcn0pB7YQahblyTDHi8sjF06MqfMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qidgDliL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qidgDliL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB2CC19421;
	Fri, 13 Mar 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407953;
	bh=eOxdydwzMCWwKW+m6Pjcr2i9St6pdp+5lfwnBN75Ue0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qidgDliLWV56T+pWIRaAYqwiYRmbvN5sjvoHdLrM/q1rbu+3FBqgvZueFtjn86tS8
	 BSzHMQ9WwieAssNxkKIoHMRI0n0lLIwk1M5f1M4WvA7cmEgtLCKizTofKTmJsCzA3n
	 r5/9EAV8ZX1/aoZHPgO3y452D2/vL0N7gdh0h1C8ECPIWU7B0R7CZiHBg5BNVQqU0I
	 886Jbui0v/eCK1Y64UR0Y+X0mx40UagSSWvo2azwcNjdFwkHYuxyLKIivY4PJlsVqL
	 KI2zMfiXvPFU36gQVor2aPc1JRsNQTt7RkVmqS6cyz37SqBARX6mpxqdKu0ZK81MYx
	 0BBJNafgbaZ3g==
Date: Fri, 13 Mar 2026 14:19:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: firmware: qcom,scm: Document ipq5210 SCM
Message-ID: <20260313-glorious-daffy-kangaroo-f6dad6@quoll>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-7-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-7-fe857d68d698@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 03:15:49PM +0530, Kathiravan Thirumoorthy wrote:
> Document the scm compatible for ipq5210 SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

