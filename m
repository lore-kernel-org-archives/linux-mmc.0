Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20B17BB6;
	Sat,  1 Mar 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740826431; cv=none; b=Dyr+rbReBTnT6/V792Pp3mVacCB1gDIWbRHJDWLgzW3CKHFzTPBz2meuSGh2C3sI8usI9mGgksXgB4kkyApeMiIJDtBoZznqKvzpLhZ/vrG3uQYgElP4U4dX8WmLo1nDCJvnfWEHLyGQ4vtSMUwngxqUoqIb8WnSQHPZZcXsoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740826431; c=relaxed/simple;
	bh=CJzhoN8ea/k1Fetjo1S8JrpXLfZw8rrH+qRLx50b1Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+QMGv2VLlBwL4ZjFi1s1d+iER9OnrLy1oPEkVZfz57yGVdkTOQs45tgZTlebjvt8Xm/8WVD6LGdkNwwT6a0X/2vDMAjCC4+vYCdzvcnczbQZ5Uw/vhsDZKyLjDR2n22mkJ7+034og0hxgAgERnppkwioIFJuDuacuRYr+skKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=L90RqOFE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="L90RqOFE"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 09C4825C6C;
	Sat,  1 Mar 2025 11:53:48 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eePE81pfhHnS; Sat,  1 Mar 2025 11:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740826427; bh=CJzhoN8ea/k1Fetjo1S8JrpXLfZw8rrH+qRLx50b1Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L90RqOFErJ0UJUHz22ZdufLaHFD3mG8PeoJycaWRLI3UH1L7EL5t5CqMz4MhubUNl
	 h1q35UqDQVizPDdg5sc28yeaOCPc8N68dIsreZhmCmixO/RZoJYoqpmBe5TeLtOp2f
	 gfUAc3XdJ6lGELMiVkGi9iWtqRRGLRtQd+DDhFXDozVP8IK/OxkLTmmVP56llu0GeI
	 BKYmPjlVgViP1lhHP07anCPRj4P55HDdZbD6SeVuswGO5y1y2CXPCIxMdJpdLjvhI8
	 OQOYFmko3tkqZyT4urFDRVvAwW/OtxarrKRAdggb/KdBFTJXxdmxKgHc1FZkTnWrFm
	 1TPzwVCVkWYEA==
Date: Sat, 1 Mar 2025 10:53:21 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: clock: Add GRF clock definition for
 RK3528
Message-ID: <Z8LnIfDWZtuwoUrk@pie.lan>
References: <20250301104413.36335-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301104413.36335-1-ziyao@disroot.org>

On Sat, Mar 01, 2025 at 10:44:13AM +0000, Yao Zi wrote:
> These clocks are for SD/SDIO tuning purpose and come with registers
> in GRF syscon.

Please ignore this e-mail and refer to the series[1] instead, I missed
--in-reply-to when sending. Sorry for the noise.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/20250301104250.36295-1-ziyao@disroot.org/

> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/dt-bindings/clock/rockchip,rk3528-cru.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/rockchip,rk3528-cru.h b/include/dt-bindings/clock/rockchip,rk3528-cru.h
> index 55a448f5ed6d..0245a53fc334 100644
> --- a/include/dt-bindings/clock/rockchip,rk3528-cru.h
> +++ b/include/dt-bindings/clock/rockchip,rk3528-cru.h
> @@ -414,6 +414,12 @@
>  #define MCLK_I2S2_2CH_SAI_SRC_PRE	402
>  #define MCLK_I2S3_8CH_SAI_SRC_PRE	403
>  #define MCLK_SDPDIF_SRC_PRE		404
> +#define SCLK_SDMMC_DRV			405
> +#define SCLK_SDMMC_SAMPLE		406
> +#define SCLK_SDIO0_DRV			407
> +#define SCLK_SDIO0_SAMPLE		408
> +#define SCLK_SDIO1_DRV			409
> +#define SCLK_SDIO1_SAMPLE		410
>  
>  /* scmi-clocks indices */
>  #define SCMI_PCLK_KEYREADER		0
> -- 
> 2.48.1
> 
