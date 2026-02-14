Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38622A4E1;
	Sat, 14 Feb 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771059926; cv=none; b=te0U0FYIBjp16k/SEgBo8qwBTD2nISUQL9tKMiGhLjQG4JKrZtrvZf9RZJOqJuTHvv2NQZYt0nahgzzf1zfRvyugjtefuXwqZ169RypkgLHl6oR8B0WxMbDrpguTWDVwEhcPd8pcEHYvMnW0Ht8Ds+lVBMj6RFY+cHxIbP3JTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771059926; c=relaxed/simple;
	bh=RmINCXF40mAWpNVb2Pl2QrDpNQH9FA4/a1yqxcn3TkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxmMQTaOoVBf6h6fplvp27GaJMLUmHxZOufZETg5LnR+zjF10k6z/NjD3v5ylUPxhKey9iLnr6iSdx08jLaYVIJIZ/lpjK0mLTYkIQGXyYtKTHnAi9qFv70N+8HUWMoyN69Jyw4SieW0OTaRPx0FSow6Udyg9CnkUl6PhwvfgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/F8OB2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/F8OB2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60267C16AAE;
	Sat, 14 Feb 2026 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771059925;
	bh=RmINCXF40mAWpNVb2Pl2QrDpNQH9FA4/a1yqxcn3TkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/F8OB2dHZE67Jztb3m2RnnO5ZluOq7MV8CO1DEmt9G4YpcRGk8gGnyXnJNut0iVG
	 TOGuyHQovV0ti/j6uxfwPEvLGaqxMWHhFpuoCpDpla18DSWwJxlFqd03PYnSk5IaZx
	 X2GElbNM410Q1fIpylMGZLwRge1GaXMzWBOKYWvCeZpOqWuw5tAk9pSrEdHC32OYqr
	 OcEb7RLN8UbAqTqJQk+rHFVkiTP8QG+W41KozkMjbzNmzwP60ij4qgFZiPdPzMzOr+
	 VfGXR/9K1GWOqYcrQdDkngN7vSFqVG8Bbfe4eHDyJJxVHknm9HakHhiieZXN9rY7oB
	 y/5iYVR+JnELw==
Date: Sat, 14 Feb 2026 10:05:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jszhang@kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com, 
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array
 validation
Message-ID: <20260214-heretic-bonobo-of-peace-e5ae15@quoll>
References: <20260214063450.198-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260214063450.198-1-hehuan1@eswincomputing.com>

On Sat, Feb 14, 2026 at 02:34:50PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> The binding defines tuple-style reset-names items for some
> compatibles, which implicitly enforces a fixed array length
> via JSON Schema.
> 
> Defining global maxItems for resets and reset-names causes these
> constraints to be intersected via allOf, resulting in an effective
> minItems equal to the global maxItems. This leads to dtbs_check
> failures reporting reset arrays as too short, even when the DTS
> provides the correct number of entries.
> 
> Fixes: 30009a21f257 ("dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700")
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> 
> ---
> Changes in v2:
>   - Keep the global maxItems constraints and add minItems: 4 for both
>     resets and reset-names properties
>   - Update commit message
> 
> - Link to v1: https://lore.kernel.org/all/20260211094736.88-1-hehuan1@eswincomputing.com/
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 7e7c55dc2440..f268f3b6f153 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -50,9 +50,11 @@ properties:
>      maxItems: 1
>  
>    resets:
> +    minItems: 4
>      maxItems: 5
>  
>    reset-names:
> +    minItems: 4
>      maxItems: 5

You miss to update now minItems: 5 in one of the "if:" cases. Otherwise
please explain why that device(s) should have now 4 or 5 resets.

Best regards,
Krzysztof

