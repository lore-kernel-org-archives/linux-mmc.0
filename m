Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com [101.71.155.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8BA4A04;
	Thu, 15 Aug 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683382; cv=none; b=IbHVTyFcFjanmKHnQMmxEobi58i3ts0bnMqmBk/Zg1OIltE91L9TKYghsOW2Ype1HDQvDNyjNEMZOXg+FlwQLKB+yaRKAdtNWC7CfaYW2tqxQkQKMZi0wYGErcJWyNB2mDghCF6BwrMe5vRXHb4FGC7fM+75B8QVVBARjEdjlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683382; c=relaxed/simple;
	bh=04OQOPxXE3MXJtfGuILzGqusZ+FX1Cv8QWOlUtDOfeQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jOUVnjd2y8LUbE6X9uc9pGgxQo8RPADXVhziORkZfj3XOEjhZBcheouASoRyMfKqAJXZK/AptGulaMcp7bN71syVrtCl6luaoDastOkFato1Bra5/Jk/mOBO52M0AyX9s46nNNnHKWJwZBkZpPhAieSsfDbs21OnGYq8BL1PVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VsLc+OpT; arc=none smtp.client-ip=101.71.155.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VsLc+OpT"
DKIM-Signature: a=rsa-sha256;
	b=VsLc+OpTy4yiMoQUzJP4gG0dTMLiDIg4arecgkwV4VogdpQXJ8ialiNZBJVsL1fYmXONb+JlunOG78AITFlYdUKKWT0n6b3EFS15djONE6edIM83vb7UY+BsGUmf6YQ813r89SKlD3U7A482Jvh3z8yBzCzb0ZR//9utrNK8l7E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=jibRnnrGx3Q4KOhIBFEiSAKP3XFIdjxz/CsdAGw1aiE=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 60327460171;
	Thu, 15 Aug 2024 08:55:37 +0800 (CST)
Message-ID: <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
Date: Thu, 15 Aug 2024 08:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-3-detlev.casanova@collabora.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20240814223555.3695-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0fH1ZNTk5NGE1MSx0YGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a915388786203aekunm60327460171
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06Dgw*CDI5OUwXLTg2A0wK
	FUkaChFVSlVKTElITUNISEhDQktNVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5PSko3Bg++

Hi Detlev

在 2024/8/15 6:34, Detlev Casanova 写道:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> v2 tuning will inherit pre-stage loader's phase settings for the first
> time, and do re-tune if necessary.
> Re-tune will still try the rough degrees, for instance, 90, 180, 270,
> 360 but continue to do the fine tuning if sample window isn't good
> enough.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 49 ++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index b07190ba4b7ac..367633f4e8892 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -24,6 +24,8 @@ struct dw_mci_rockchip_priv_data {
>   	struct clk		*sample_clk;
>   	int			default_sample_phase;
>   	int			num_phases;
> +	bool			use_v2_tuning;
> +	int			last_degree;
>   };
>   
>   static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> @@ -134,6 +136,42 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   #define TUNING_ITERATION_TO_PHASE(i, num_phases) \
>   		(DIV_ROUND_UP((i) * 360, num_phases))
>   
> +static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
> +{
> +	struct dw_mci *host = slot->host;
> +	struct dw_mci_rockchip_priv_data *priv = host->priv;
> +	struct mmc_host *mmc = slot->mmc;
> +	u32 degrees[4] = {90, 180, 270, 360};
> +	int i;
> +	static bool inherit = true;
> +
> +	if (inherit) {
> +		inherit = false;
> +		i = clk_get_phase(priv->sample_clk) / 90 - 1;
> +		goto done;
> +	}
> +
> +	/* v2 only support 4 degrees in theory */
> +	for (i = 0; i < ARRAY_SIZE(degrees); i++) {
> +		if (degrees[i] == priv->last_degree)
> +			continue;
> +
> +		clk_set_phase(priv->sample_clk, degrees[i]);
> +		if (!mmc_send_tuning(mmc, opcode, NULL))
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(degrees)) {
> +		dev_warn(host->dev, "All phases bad!");
> +		return -EIO;
> +	}
> +
> +done:
> +	dev_info(host->dev, "Successfully tuned phase to %d\n", degrees[i]);
> +	priv->last_degree = degrees[i];
> +	return 0;
> +}
> +
>   static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>   {
>   	struct dw_mci *host = slot->host;
> @@ -157,6 +195,13 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>   		return -EIO;
>   	}
>   
> +	if (priv->use_v2_tuning) {
> +		ret = dw_mci_v2_execute_tuning(slot, opcode);
> +		if (!ret)
> +			return 0;
> +		/* Otherwise we continue using fine tuning */
> +	}
> +
>   	ranges = kmalloc_array(priv->num_phases / 2 + 1,
>   			       sizeof(*ranges), GFP_KERNEL);
>   	if (!ranges)
> @@ -277,6 +322,10 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>   					&priv->default_sample_phase))
>   		priv->default_sample_phase = 0;
>   
> +	priv->use_v2_tuning =
> +		of_device_is_compatible(host->dev->of_node,
> +					"rockchip,rk3576-dw-mshc");
> +

v2 is a kind of software decision instead of hardware dependency.
So in theory, any SoC can claim to use it via DT.

>   	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
>   	if (IS_ERR(priv->drv_clk))
>   		dev_dbg(host->dev, "ciu-drive not available\n");
