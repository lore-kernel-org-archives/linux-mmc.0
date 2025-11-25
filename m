Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2DCA4E;
	Tue, 25 Nov 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065058; cv=none; b=W5G5XtzSvTxIiguOcyiFGuIwRNlMzbR/ByC4F0tvAWb89mXKqT7KigV9Ha8H7NTBmHZhL0phyFN1481qmnb5bkYkOpnRAG4aGK+iAXe3HtkmOvAQ8XePYQBuwUBnCjq0/igRFVsdKLVHEt8ItzHfsCiGLnewFl0u5gNUUOKHJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065058; c=relaxed/simple;
	bh=3qy+5crLLUIiORvNYhngUSKHHCyDyBki5fe36SXyqxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGic3/uK8K3um6x3bqQAgwiwFcDWnQL+SXVTL57pWwVHI++/GHnca7ecQlqAQXep5KiQBRilIlEd1Sn52rQfUdcMvmGl6z6dTCKwzZhQyybski/iefNQVKbe16iHvTD/Dc/LIjDobBqE77SmvJDcS6AybVisyBPi0ZFADunoJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ7vJMs6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ7vJMs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D495C116D0;
	Tue, 25 Nov 2025 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065058;
	bh=3qy+5crLLUIiORvNYhngUSKHHCyDyBki5fe36SXyqxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQ7vJMs60BFvo8WY6CAoAaJ2+29z0Eu7boqpLvbwPA3icBGJQvvjlasQ8YV0T5UvV
	 dPppIU8HKwloxpjlQd7toCgUCM6sixLlmmyAeU0hGlub/Am/P0qpPmFVr6iXiEFrhg
	 zKvbzMuGkaJSNRqsqU+4o61v00C9cTl3nl744vhnJii93pq0Dw0OZWG4FQtHLkvW1l
	 fscI9dmXBFuv8uuP5CmBibAhMqcdF6z3jEbpRxDVXphRefdqMxEfSwtHZjrNdRaKPp
	 0UWuvNfxSV4GxbDWTynvPL4EMdxLOzsNyemDrXQF0ZEiLmBm5D1srFj53MOCP/e2N6
	 rvRLtfSRHoU9A==
Date: Tue, 25 Nov 2025 11:04:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org, 
	krzk+dt@kernel.org, konradybcio@kernel.org, linux-mmc@vger.kernel.org, 
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] Enable Inline crypto engine for kodiak
Message-ID: <20251125-inquisitive-sincere-mustang-adfcde@kuoka>
References: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
 <176399402112.138918.10418108466178515664.robh@kernel.org>
 <a9f3f5b5-a3cf-ae24-9cd3-b3cd4c5c34c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f3f5b5-a3cf-ae24-9cd3-b3cd4c5c34c6@oss.qualcomm.com>

On Tue, Nov 25, 2025 at 10:28:16AM +0530, Neeraj Soni wrote:
> Hi,
> 
> On 11/24/2025 7:58 PM, Rob Herring wrote:
> > 
> > On Mon, 24 Nov 2025 16:49:12 +0530, Neeraj Soni wrote:
> >> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
> >> node to enable it for kodiak.
> >>
> >> Neeraj Soni (2):
> >>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
> >>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
> >>
> >>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 38 +++++++++++++++++++
> >>  arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 +++++
> >>  2 files changed, 47 insertions(+)
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >>
> > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >   pip3 install dtschema --upgrade
> yes i had tested this patch by running these:
> pip install dtschema
> make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
> make dtbs_check
> but did not see the below errors. I will upgrade and re-run the commands to check these. 

You did not do basic DTS testing, because your code have obvious DTC
errors. The error is even printed here by Rob's bot, but the point is
that you had to do testing of your DTS and it did not happen.

Best regards,
Krzysztof

