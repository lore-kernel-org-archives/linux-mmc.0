Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02D342526;
	Thu, 15 Jan 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467791; cv=none; b=ea5pVbKyLzdNG41pqS9fnVXfx1B2FdNmnrK4gQX49If5P5KRv5ZXAsolmUcK0HGG4uokBvVzxjcsbGP6yFDdDVQ6P1lJfeCkOMPKIHOW9XpYmqcLval2OeafNDCp3fkgKoDtLU3vuJBBpopTNOiLQhjjM0lfI81tUUq0JzD5IoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467791; c=relaxed/simple;
	bh=jDXGiu6B72c0bWfvPOBddtDJcs4BxcAV67JRcN2b1JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPLgYILMymJdPE8yPW5MdkoruKZYVTJ6CwKeOA1hI0TIlgklt7AIB69VoOIXNgzWq/wXmaU8WhfS7CFHdQbRc2r9ZuUjri6y5nheGnTOTUkPrRhXRuFZgKoDH/r5SbwDLND6apIX7rFkxQvlwqEyshJMCubjqMy3LL6l+D7rkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVGyqg1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVGyqg1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD00C19421;
	Thu, 15 Jan 2026 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768467791;
	bh=jDXGiu6B72c0bWfvPOBddtDJcs4BxcAV67JRcN2b1JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVGyqg1q+X8SORiP16qN4L2kkE8XzZR2MyVbqZS6jm2EBXTPdLXqA6FbJ9MYwla8s
	 ilSMDXVFHcQ6rCaIl2G66FPTA00GXxh9jqhbgxvPzXi7w5CGyWDLSjgm/wuBdl5rGq
	 F/xCTN3Vbj/o8aFfpzfW7B7urzrVgF0hdPU1Ct//BHVkeYSQes6xItqhTqyNbU+bHE
	 O5PmPr3xsDSY7uxCi5PzTGcMCs60qR/vLyayBI+7XJHakrgHTpu0xZMZi37HrZoDeQ
	 EYunDx7fs9MK5Bovn4wqdL04L1j78mS60pKqzbHLrw16XGxR7Bu8RANWhfZjs2k8HX
	 g8dH3STMkHH9A==
Date: Thu, 15 Jan 2026 10:03:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Message-ID: <20260115-intrepid-space-meerkat-d44ec9@quoll>
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <20260114094848.3790487-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114094848.3790487-2-neeraj.soni@oss.qualcomm.com>

On Wed, Jan 14, 2026 at 03:18:47PM +0530, Neeraj Soni wrote:
> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
> So add the qcom,ice property to reference it.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 938be8228d66..8a6a25ceabe1 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -140,6 +140,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: platform specific settings for DLL_CONFIG reg.
>  
> +  qcom,ice:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the Inline Crypto Engine node

Description should also say: for what purpose.

You either have this phandle or ICE address space on sc7280 and newer.
You cannot have both, so your schema should encode it properly.

Otherwise you just sent something which already was on the list and it
even was reviewed:

https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/

You even copied the commit msg but did copy the authorship!

Anyway v3 and v4 were not correct and probably v2 should be used after
adjusting it with my comments.


Best regards,
Krzysztof

