Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7014D8B9;
	Fri, 23 Aug 2024 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391709; cv=none; b=G8hXt2fmZZgXiuwapHYlbtn/aV3J70mkRUVs/+YuAbw0RRVJbFjFlvkQdVA1vpNBOg2MCTDkzol+tkp2hLNGSfl6c/wQVHdtOEvZJ+pmHuNnsbsQ9ujym6JtUnmJkuFsNWXRlu9vWspbEQNuki/lM3fRfvU+zjMS1ytcwMAYkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391709; c=relaxed/simple;
	bh=zN5K0O0Uogjv01HXcAekDzWVBLfDozzhiagytuaKqmY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EXo9VXZkrGpAg3hF6ShtKofkuVnlTRhNqlm8/cxu6IDnDAWs2q5fA1R3k14CSJlqJiLkZUMD+TPSJHUQwn3HhQCVlfMoRhaDBaZi9FDlIBzLvDvxZnrSRE/If4JHCWoj3m4bgduzxKOqvj+mOGxWD7KTp/riTxhhsXpsFE97qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LRw7Ys8l; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LRw7Ys8l"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724391705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRUQof1fws+WZTJx29gSd/eBycDm7t6bJjqwUp6NViY=;
	b=LRw7Ys8lgOzutA9tpD8TM3mcqM/cHCl/kjJKkrwpn3mGtvTgBmsoqtomdsRW28xZV+jB0o
	Q7WOnRHSIdE2tTbMvE8AxLg8LnBoJ220unGcC1IQWjGus1m9XHp6zIuLmN2PBzu9PELq7K
	Hf12AnExJlDAUGHYvA/kYWwSSjdhUZENypDXs2ebYxpn5/XlKS3DLOBr/OGFst6phiXvLW
	1qPkJuIq8oaFZ+csNVMTNpEH9LHRCmIwleIqZxaYm0Hz8m+XuCqolnmxiCaTlB+777m/6B
	p/d6Zy4GtieDHnE9jQ0i5YC58U2zz6FR6ghZahgWSF7H2F2DPLzmcWmt4axlug==
Date: Fri, 23 Aug 2024 07:41:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com, Shawn Lin
 <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 2/4] mmc: dw_mmc-rockchip: Add internal phase support
In-Reply-To: <20240822212418.982927-3-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-3-detlev.casanova@collabora.com>
Message-ID: <f0f5dec4a5403616fa25c6ed754f6050@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

Please see a comment below.

On 2024-08-22 23:15, Detlev Casanova wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Some Rockchip devices put the phase settings into the dw_mmc 
> controller.
> 
> When the feature is present, the ciu-drive and ciu-sample clocks are
> not used and the phase configuration is done directly through the mmc
> controller.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 171 +++++++++++++++++++++++++++--
>  1 file changed, 160 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> b/drivers/mmc/host/dw_mmc-rockchip.c
> index b07190ba4b7a..2748f9bf2691 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -15,7 +15,17 @@
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> 
> -#define RK3288_CLKGEN_DIV	2
> +#define RK3288_CLKGEN_DIV		2
> +#define SDMMC_TIMING_CON0		0x130
> +#define SDMMC_TIMING_CON1		0x134
> +#define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
> +#define ROCKCHIP_MMC_DEGREE_MASK	0x3
> +#define ROCKCHIP_MMC_DEGREE_OFFSET	1
> +#define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
> +#define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff << 
> ROCKCHIP_MMC_DELAYNUM_OFFSET)
> +#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
> +#define HIWORD_UPDATE(val, mask, shift) \
> +		((val) << (shift) | (mask) << ((shift) + 16))
> 
>  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 
> };
> 
> @@ -24,8 +34,143 @@ struct dw_mci_rockchip_priv_data {
>  	struct clk		*sample_clk;
>  	int			default_sample_phase;
>  	int			num_phases;
> +	int			internal_phase;
>  };

It might be good to declare internal_phase as "unsigned int 
internal_phase:1",
i.e. as a bit field, which isn't going to save some memory in this 
particular
case, but it would show additional attention to detail.
