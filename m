Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B13290CA;
	Fri, 27 Feb 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178636; cv=none; b=dC6q0XoHchdFLOv5gKEtjnVeth33P1fnjtAdv0psyzS2/NkeAMyOGnYyvxqv+4ZsbkRv091xuVjeSzx3/LjRJ+BUySh540xiUOR4AMTbdF/kp8rECcNDfiCQcJqwAxidYenOJqJ4dSqsUEbYMRUZs1NvBOK3VxoOxxxgnA0wfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178636; c=relaxed/simple;
	bh=AtzJI/kF6wwteQTNN03WbGtDX5pBKSUQTn4wDMFxpjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9whLeoyoc27hBEiw9q0r+QlTEW27NNwilXtNSdOG4r/a/BYGbpoujisNGFPrsFIAnXvG7vsdX2VYAXbY/UEJqMWkN0w8AwAo9nmMAx396p2V4DPCoHBvm5/WpTP4LP1vD7jKQ1tBxZTosRLw4DSpNtil8QOllnTdeuhUfy/9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS4BdkLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS4BdkLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB0C116C6;
	Fri, 27 Feb 2026 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772178635;
	bh=AtzJI/kF6wwteQTNN03WbGtDX5pBKSUQTn4wDMFxpjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VS4BdkLo2DuKU+4F0z+f8IUE+lozC/ko5FRgFT7+u+pM9ZjvIHMcTQeFr5OevKmdG
	 UagmtgJG/uCXd/zxhtHfmRa6rijMt9mwtiLiNuaZsIoXyEq144Pb7MUBkCkAvKBbnC
	 YhIlWpENbwQ/mEhvXDrdR5Cpwah7XXy84DG4RrrBFlO14iWxeKLNZA2Rck7WajBVv5
	 4waPvA/vQxzV4IfTZOYi1roX53XAjVpzv5yQIcttCJf0mbW6dQha0KBap15qq+Pqq7
	 /RyeG0SecTf1alhTbcyDc/aiWIEc1A1WBOQIpUD2hzHUoqYz6sp1cxEOQ0CKvu4WWF
	 OsyGqSVRNtuZA==
Date: Fri, 27 Feb 2026 08:50:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "ping.gao" <ping.gao@samsung.com>
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, 
	jh80.chung@samsung.com, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: synopsys-dw-mshc: No need to
 enforce setting two clocks
Message-ID: <20260227-athletic-marten-of-climate-cff0be@quoll>
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

Not sufficient, bring also arguments in terms of hardware. If the
hardware needs biu, then this is wrong.

Missing blank line.

> Signed-off-by: ping.gao <ping.gao@samsung.com>

Are you sure your name includes "." or you just use login as name?

> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index a6292777e376..7a02fb6f585b 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -24,11 +24,12 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 2
>      description:
>        Handle to "biu" and "ciu" clocks for the
>        bus interface unit clock and the card interface unit clock.
> +      If only one clock is present it must be "ciu" clock.

Drop, don't repeat the schema.

>  
>    clock-names:
>      items:

De-synced with clock-names, so not really tested.

Best regards,
Krzysztof

