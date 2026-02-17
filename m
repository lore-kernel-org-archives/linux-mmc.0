Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662051339B1;
	Tue, 17 Feb 2026 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359404; cv=none; b=BG4vOlLXV6+KeiYTT6vzyACnAXRYcd7VpY5WVXrN5ZvQ/qilM03Vc035TRAYENhVzLXbNw42VUXHqnUECBZ5hH4Iig8u6Xd4QavNf91e64a7M/zETPaNgVNsb8dO3Wo8WjT+yLNLLCs5QUWd5tbtQj1T0AOF1n0+m/aT2GdbFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359404; c=relaxed/simple;
	bh=k72CnIyG3U/2d7xBlHzW7BOSD9hu587CCzmetLgqILM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei5hbgZUOEB9f+yy1rLUtm/YeBBGCgOk7AQS0nKLPVSpvN/BOB47UsgrR08hoEUqa+CmZ4YNBTdIt/PcTgOuq90DOAq2cUiSHjWrroAlkyQgGy50uJR65+gr/LVymzZUauj+HGhM/TmVqa/OqQFqvA6hUgP/jLtBx/aTysrBLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAKM5OuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAKM5OuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FBC4CEF7;
	Tue, 17 Feb 2026 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771359404;
	bh=k72CnIyG3U/2d7xBlHzW7BOSD9hu587CCzmetLgqILM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAKM5OuA4LjGL1bUeFY4+42U1PIJjhn7tFYW0PBWyPBd4g5FFGl133a4dGiIknKcx
	 2PMGTp/yXZC2evyElCorJZhxBgFNI9eTTzGmhO7V1VaHV779GaIVxb2IJbpp6ixLDn
	 SjqIeZQDWZ0lj/wD530sTExOIXNyRbiNiJs/UOOTQ7XSqNilXF+GfFExCRENxHKPgB
	 a6yqnZa4NOdFzHsDIOy8B9emz8HavzgWLJkywpp/sMgmTn75S1qN+c/cjr7HhxYI6R
	 RNq7NJe2eR1LFebUq8mm2NO40+XQoIKPI/9Aj5a0xoGExdGnZOIHWxnKPKpMP4AaRp
	 aDeGIE70f/n3g==
Date: Tue, 17 Feb 2026 21:16:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Message-ID: <20260217-berserk-puma-of-focus-bcbe82@quoll>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
 <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 10:55:24AM +0530, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> To avoid double-modeling, when qcom,ice is present, disallow an embedded ICE

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> register region in the SDHCI node. Older SoCs without ICE remain valid as
> no additional requirement is imposed.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> ---
> 
> Some initial work is done by Abel here:
> https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
> and by Abhinaba here:
> https://lore.kernel.org/all/20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com/
> 
> This patch adds the purpose and usage for phandle in the description and encodes
> it properly in the schema.
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 938be8228d66..9b902e0c8d09 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -140,6 +140,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: platform specific settings for DLL_CONFIG reg.
>  
> +  qcom,ice:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the Inline Crypto Engine (ICE) hardware block for this controller.


Srsly, I asked once and not much improved. What is explicitly written in
coding style which I asked you twice to read?

And how long is this line? Why such trivialities cannot be fixed and I
need to remind this every time?

> +
>    iommus:
>      minItems: 1
>      maxItems: 8
> @@ -223,6 +228,16 @@ allOf:
>              - const: cqhci
>              - const: ice
>  
> +  - if:
> +      required:
> +        - qcom,ice
> +    then:
> +      properties:
> +        reg-names:
> +          not:
> +            contains:
> +              const: ice

And reg is still 4? This is not correct syntax. You need to define
proper and final constraints per each device. I would write example, but
why... more things you could just ignore.

Best regards,
Krzysztof

