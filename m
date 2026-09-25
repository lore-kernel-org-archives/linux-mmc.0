Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C63D6CB4;
	Fri, 25 Sep 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368075; cv=none; b=NuT9VpHgwlNkCYV+pVFlrJwMrte3dWxZGK+rqZd1PbqAmVAGLTuPzBfOsaKw3TuBOOuFWZMWnqLmzmyOS4PFhRH0jDFqf5m9hzD3yxGXQQ/5PW3LK/Mi1IuMj47clgROFVfSWIJoGOYvQAJxs0Vg4uvLPQQVekRE72Cqy0bYs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368075; c=relaxed/simple;
	bh=mY7nsB09y931pprZ/+lN0ketHmOAKHl/pWuUPgNz+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWkf4QJcHFm5N9W/qOwFuJWw7FoKttBRygdvMHn7RKdhLimzn4dP0Ee0U9nwvsbCxFDG37cmgePNHYQBG9aFGyz/psWG1zOYg3PzqTKGFm/XPlkKizfR1p3h+dePS14IvQV16ev0PiVtbUSnZmgBcFGUxHo8wTR6zv+SyLRsOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZik6+/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZik6+/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B21F000FF;
	Fri, 25 Sep 2026 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368074;
	bh=I5RqeR1sxkZyEYFyn07bPDEJbXbIhE5mqXirIcZRBWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZik6+/17U2ygSn7UEgfp5cZIPbUoH9S90bq8wTc/i2Oyqc2hIJVPoJNMiU5BmjJq
	 nlkl2+Kw+6dBdvjoxQlomY953+sq8N9l2TyVm93yxU4DEM+2Ar2klbpLhRorQ5yyIW
	 lhtdkobfgJI2QzeFygV7FuciZZ/+2hhTNoDjYYoiDB+I02biw5UyDVM8YAO/nr/Ifj
	 bGQRpFQA3OD1YyNcWa44YsaryxfgRyabUYnw0BzVUeYI5bON4EU1IYkKtGIMiAr6wf
	 N3CAm9rJyIss4qqnQ//w1QLagAXtXdIR7lfvJ+3jLTgFpNaHHVkqjFQavtudb1xjZ4
	 yJV1JgcBxKJbg==
Date: Fri, 25 Sep 2026 15:27:49 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>, 
	Kernel Team <kernel@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>, Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>, 
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: Shikra SD Card support
Message-ID: <arbZCZduUH78aBnS@zenbook>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>

On Fri, Sep 11, 2026 at 03:09:30PM +0530, Monish Chunara wrote:
> This is v5 of the Shikra SD Card support series.
> 
> This series adds SD card support for the Shikra platform.
> 
> The first patch adds the SDHC2 controller node and the necessary pinctrl
> configurations to the base Shikra SoC dtsi. The second patch enables
> this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> the regulator supplies and the card detection GPIO.
> 
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

I don't understand how you managed to send patch 1 alone and then 2 and
3 in a series...

Please stop doing your own thing and adopt b4!


I'll put these 3 patches in the recyle bin for now, please rebase,
retest and resubmit.

Regards,
Bjorn

> 
> Changes in v5:
> - Rebased on top of latest linux-next
> - Fix interrupts-cells to 4 for sdhc_2 (sashiko-bot)
> - Moved gpio include directive into shikra-evk.dtsi (sashiko-bot)
> - Link to v4: https://lore.kernel.org/all/20260804122054.3462145-1-monish.chunara@oss.qualcomm.com/
> 
> Changes in v4:
> - Rebase on latest code base
> - Collect Reviewed-by tags (Konrad)
> - Drop the dependency link - since all base changes are merged
> - Link to v3: https://lore.kernel.org/all/20260702073354.3641966-1-monish.chunara@oss.qualcomm.com/
> 
> Changes in v3:
> - Padded the address part of the reg property in the sdhc_2 node to
>   8 hex digits with leading zeroes for consistency with other nodes
>   in the file
> - Moved the common sdhc_2 properties to shikra-evk DT file
> - Link to v2: https://lore.kernel.org/all/20260630165700.1886608-1-monish.chunara@oss.qualcomm.com
> 
> Changes in v2:
> - Rectify the alignment for clocks and interconnect properties for SD
>   card
> - Link to v1: https://lore.kernel.org/all/20260604122045.494712-1-monish.chunara@oss.qualcomm.com
> 
> Testing:
> - Validated on Shikra EVK variants.
> 
> Monish Chunara (2):
>   arm64: dts: qcom: Add SD Card support for Shikra SoC
>   arm64: dts: qcom: Enable SD card for Shikra EVK
> 
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  9 ++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  9 ++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 11 +++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  9 ++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 97 +++++++++++++++++++++
>  5 files changed, 135 insertions(+)
> 
> --
> 2.34.1
> 
> --- b4-submit-tracking ---
> {
>   "series": {
>     "revision": 5,
>     "change-id": "20260911-shikra-sd-card-61d428639de0",
>     "prefixes": [],
>     "from-thread": "20260804122054.3462145-1-monish.chunara@oss.qualcomm.com"
>   }
> }
> -- 
> 2.34.1
> 
