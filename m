Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C653E22;
	Fri, 23 Aug 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391912; cv=none; b=PQYaNQQyIyN/yTJPub8wNLX+jOpBII4fSLNGXgzGvRQSISCr5l1AJn9B0uDhz+xSui7sQT0K+/NJZofpA/fGrv1Jk+h5cn4Uc/G/E8EBoLAJ4TSCAoKmUO+EFCVuT1NvgO2x2YhttsMdkKyK+fHLJ3Vxa5vJJLiJ82/w7FdAYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391912; c=relaxed/simple;
	bh=BV0kpuGN/cRjmSy21+EeAfWWxCJM1PG8dWGztrew96I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iPhDijfip5aL12YqG73Jmy7SuYFxzX+T9Nxx4JXpXDXmknOFOHL7gKbDYsb9Q5N/vpRSTnMbJi3YSz0L5NRAucS0zjadMI8DUIaJwdhw5mQ6juT7D8yWdmfIk+Ajf6exiJmTJjiwGAYU9KFbG+fa3j6ikBsbfRdqetIIeP1aMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uYz9Sx82; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uYz9Sx82"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724391908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GwKuNVlfgC5W+9zlKT/gn1CtvwJSC/hAS1+oQKVxL0=;
	b=uYz9Sx82KEjltSgj9k7p7gTmj84l82XVbz/+FrOV2fchA3LAlio2d1irfHFJS/SwyyQlN+
	N/0zOPE0OAxzPvygvTWDdFI2IovwVFUuhxvN/bB7aPvs2EUTUZXpwpllTvfFB8mSEg1Pkw
	naIZYOiLI+cQ343I3ol0sODHlpVO/5kbiMUwfB08wkz/R52G8Ex9ps0myU63vbz4KMGsIy
	kQsD2+oACdrNxF1wsY9igmgWoPqFkKNL+E9SBFmfPQ5qrfeIy5YKMpNqTQY8xHBtRCe31R
	WnLGyHemK7YtRV53my1aupiRFMpfQYePBuUyDsEiqwJZKksjLz1iN8kyQza1hg==
Date: Fri, 23 Aug 2024 07:45:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com, Shawn Lin
 <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 3/4] mmc: dw_mmc-rockchip: Skip all phases bigger than
 270 degrees
In-Reply-To: <20240822212418.982927-4-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-4-detlev.casanova@collabora.com>
Message-ID: <711f2561ac3d84bcd5bbe26723869b47@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

On 2024-08-22 23:15, Detlev Casanova wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Per design recommendation, it'd better not try to use any phase
> which is bigger than 270. Let's officially follow this.

Would it be possible to provide a reference to the actual design
specification?  This change affects all users of the dw_mmc-rockchip
driver, so in case any regressions are found later, having as much
detail as possible can only be beneficial.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> (cherry picked from commit 2a53aab5cfa43065b2e979959d727332a8a03c03)
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> b/drivers/mmc/host/dw_mmc-rockchip.c
> index 2748f9bf2691..1458cb5fd5c7 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -310,6 +310,9 @@ static int dw_mci_rk3288_execute_tuning(struct
> dw_mci_slot *slot, u32 opcode)
> 
>  	/* Try each phase and extract good ranges */
>  	for (i = 0; i < priv->num_phases; ) {
> +		/* Cannot guarantee any phases larger than 270 would work well */
> +		if (TUNING_ITERATION_TO_PHASE(i, priv->num_phases) > 270)
> +			break;
>  		rockchip_mmc_set_phase(host, true,
>  				       TUNING_ITERATION_TO_PHASE(
>  						i,
