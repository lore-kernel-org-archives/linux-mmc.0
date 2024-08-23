Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747110953;
	Fri, 23 Aug 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396462; cv=none; b=Fld3gaqIk+JdKQE++MBuyJX31mKzJUXEqEGyqZShtzKpxd+FBgN9xBHXl2gzs5BDKbI4TckJx0gT+mjMrKeFMNuC6QwWFgPo6WijRETLJ/PI8hz8+oVexjgXyGInY0wKlj3940mteaO8r3cMIiefQcra92dTArZ5BgpyH15hz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396462; c=relaxed/simple;
	bh=jGshhhvgJvPItJvLyz9xeVPpG2akmVY+mzhE2S2mbXI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HM0BzLgD8PsnDi7IyzUQDTnqNdZC5PQSEQI6282YA8SXME8AxM0kZ5dmVd0twz1Kqc/7QR2P1jJd3hnZNPmYTG/3QjQ6zN1Y4FAZBP4xpS9ODRg5pYGovwm98nUrV9qcXKO9HCAPYy4biKMf3PihxGppUsRyR+wlXSI60CfhtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NDs+9ZSx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NDs+9ZSx"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724396457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPZmmM60tSAujVzmtKbajvXbMMgpiHTPo/2dvKyDtNI=;
	b=NDs+9ZSxY/ek6dPLsXqeuOJwsBeoXV7+MBLiCrJILOstP+qpC9oJCnYApU8E9VQTBKQTiA
	SzzLCqknuhMjQaZOfkGQ7OymI3u66L7WTuHgNAKkBtGF+6DOujeCaz/il9mGWaVfxFs7rd
	4+mKHEVDbJeWypUJeELQzBCMCLgB5a9OZ77fBuVt9A+5smmmVU0+qDKMe2ABjTFasXzpEN
	oYUBKaEn2f49AYOvIVXEYRU64f6GeFPpE09zT/vsfq0SYbiv/xgb4maPHljXE+f32M6HBI
	4xJQo+08F2rxCgrrVe71jq8S9XMc4AHxKFaRKQ6GyN0BODyvntXF9iFChi42FA==
Date: Fri, 23 Aug 2024 09:00:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 4/4] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
In-Reply-To: <20240822212418.982927-5-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-5-detlev.casanova@collabora.com>
Message-ID: <26fe259f390a8015c3f08c6dc027711c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

Please see a comment below.

On 2024-08-22 23:15, Detlev Casanova wrote:
> On rk3576 the tunable clocks are inside the controller itself, removing
> the need for the "ciu-drive" and "ciu-sample" clocks.
> 
> That makes it a new type of controller that has its own dt_parse 
> function.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> b/drivers/mmc/host/dw_mmc-rockchip.c
> index 1458cb5fd5c7..7c8ccf5e71bc 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -410,7 +410,7 @@ static int dw_mci_rk3288_execute_tuning(struct
> dw_mci_slot *slot, u32 opcode)
>  	return ret;
>  }
> 
> -static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> +static int dw_mci_common_parse_dt(struct dw_mci *host)
>  {
>  	struct device_node *np = host->dev->of_node;
>  	struct dw_mci_rockchip_priv_data *priv;
> @@ -420,13 +420,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci 
> *host)
>  		return -ENOMEM;
> 
>  	if (of_property_read_u32(np, "rockchip,desired-num-phases",
> -					&priv->num_phases))
> +				 &priv->num_phases))
>  		priv->num_phases = 360;
> 
>  	if (of_property_read_u32(np, "rockchip,default-sample-phase",
> -					&priv->default_sample_phase))
> +				 &priv->default_sample_phase))
>  		priv->default_sample_phase = 0;
> 
> +	host->priv = priv;
> +
> +	return 0;
> +}
> +
> +static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_rockchip_priv_data *priv;
> +	int err;
> +
> +	err = dw_mci_common_parse_dt(host);
> +	if (err)
> +		return err;
> +
> +	priv = host->priv;
> +
>  	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
>  	if (IS_ERR(priv->drv_clk))
>  		dev_dbg(host->dev, "ciu-drive not available\n");
> @@ -435,13 +451,25 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci 
> *host)
>  	if (IS_ERR(priv->sample_clk))
>  		dev_dbg(host->dev, "ciu-sample not available\n");
> 
> -	host->priv = priv;
> -
>  	priv->internal_phase = false;
> 
>  	return 0;
>  }
> 
> +static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_rockchip_priv_data *priv;
> +	int err = dw_mci_common_parse_dt(host);
> +	if (err)
> +		return err;
> +
> +	priv = host->priv;
> +
> +	priv->internal_phase = true;

Defining priv, assigning it and using it seems rather redundant,
when all that's needed is simple "host->priv->internal_phase = true"
assignment instead.

> +
> +	return 0;
> +}
> +
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
>  	int ret, i;
> @@ -483,11 +511,21 @@ static const struct dw_mci_drv_data 
> rk3288_drv_data = {
>  	.init			= dw_mci_rockchip_init,
>  };
> 
> +static const struct dw_mci_drv_data rk3576_drv_data = {
> +	.common_caps		= MMC_CAP_CMD23,
> +	.set_ios		= dw_mci_rk3288_set_ios,
> +	.execute_tuning		= dw_mci_rk3288_execute_tuning,
> +	.parse_dt		= dw_mci_rk3576_parse_dt,
> +	.init			= dw_mci_rockchip_init,
> +};
> +
>  static const struct of_device_id dw_mci_rockchip_match[] = {
>  	{ .compatible = "rockchip,rk2928-dw-mshc",
>  		.data = &rk2928_drv_data },
>  	{ .compatible = "rockchip,rk3288-dw-mshc",
>  		.data = &rk3288_drv_data },
> +	{ .compatible = "rockchip,rk3576-dw-mshc",
> +		.data = &rk3576_drv_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_rockchip_match);
