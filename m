Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0ED3203B0
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370627; cv=none; b=HwOfFwPc+mF5Bn+R8rdGz/L8roDzenUKkE5FKbarWETguSYZANawKC4k3wVRF99gcnsrKd5E+lpHAtJoxgh9Wv9lVbiwNQ/NragWX2/Ns+pHOItdGWPtcjw2n7oE9ULkIPkseyi+X7AvllDygyAOpvyTt2XEZmTpS3QAyq6cCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370627; c=relaxed/simple;
	bh=BRmvDRMSTzEg6ecaIJPhiDfsvhYiZPlOW2AKRurJfUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oijmz7ypCN4obqK1jpq39Jbsv/QrMj/nGV7bCCPj6Wh0rmTtut01ljNvbUA8yDWGqx23nB/j/1zQ1xCOOqJANxqsQJCBSsD53rm9uEva0BT+1HUnrg89FlFuKiYY3V1+JgFkwSNlYjf51JJNQR0/VEsV/z4NXYYhfRMHBWqeDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJP330Zb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJP330Zb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775638d819so22639755e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763370623; x=1763975423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLxVKWIHglxfb8tAgDDKVJo+NTOcB5a0GO0w4pJQiPw=;
        b=aJP330ZbgdcIWQ6JF27cmXGbZNfpre3p3eZwb0FcUlUV0fbC5XsIckQL5PLHVWTpLo
         U/S9rZsEk+BkaMcms3XvhzF3pVYnIeHM1ZQKNPIoeAkjU0HJ3piKbDi7R2FOBRW/6Iug
         7yl+A3UnQjPeF2k4gR7bCTZ/6rarKeYYZNPVuRVN3/Zd9zqaSixnifj2mN81U6+rrfkm
         SMjs8XO9Pp54aiOmF2/CE7MC7wGABXGQQpnN5qMX9P/v4wRAE0XYDyrBvAc5/KWmKjeu
         z51eripazlSF6UdkxEZESTrRVRShoTcGuRfF4Gide9tiJGQczCi1rQ1wVEiTFZCIIuJp
         EBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370623; x=1763975423;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLxVKWIHglxfb8tAgDDKVJo+NTOcB5a0GO0w4pJQiPw=;
        b=AbRsZKCArVLCE7Gaxyr+MGNTztSAVE14E07Atn4+ntxw9CqyRW1LagmSDQQ+x6ZIBn
         P8mJJyn1mxMI9+dzygi1XiZisYGO8ZHj1xG3DoeQ/JFUMKeysEIkzplUoe5ZIMrD+hW9
         M3ZLPP8s65C1XLHFg8FEXlU7nkUQ84GvWj29hRhCHfD61f/vQqhfiQJAa5tub7GOjpsr
         6NzB/95scfjwY27THkWYZvCEb665flGOf+mp+0Mk2qkwc5BORonDslwEHRjaV9AN9uoO
         2cYUlm5Rq2dq2XfEbau1B6gqJAj7Rz5dMhJ7qcG+oaPtB2qFPjG+y5Pdp04x0DGZfrMu
         O5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVaAabe5E6ZXBIMtss6FgEcrrPI73GFQ7DVQ4EWluW8X8Fiey+BBa5vefk9/Xmqt3JYTfhYjrtvVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwNi4KNmTKiS+HRJHfciKgkoNrFJy6moqDld6bg6Uf4M1tYwL
	nBD386iLxdDW3bWKDlviCybG+G6YLXVqcv6vuSmt23Ny5KcfsqebHJ/UJZvhElytXiJped+hGf1
	zxZd+
X-Gm-Gg: ASbGnctYFhnW6sERifxEUBLj+5YxAWGr5RoaSGD9mWREqCuKShn1J9oc49x+Os5b+Or
	sox71Jrrww9CNXoKAQPEC/dn4bELeg1SZrsbg+D94RaBGDAS6oUaMBFwNI9dswODMC7AoX0hM+W
	XKIPl/F3BgnQPKTfSuqJ/QsTynqJmGsJsoiHMnS7S+veaLPchyb7rBrAgki1b0gSEjRyS+ih3/w
	WFYWJxDEc9BaDtxNTNpPk8DetZZvsQ4C+xgL6XX7t3Bjzs4VTXCRY63G6xeA41UBO+4z7WYmPW3
	4yj3IL0kWEm+Th2WIN9rbMf3E8LpbRu2FK4Hw36R9sfo/pjn21g10/l/JvFhSctqB5kykB/f1+E
	wJr2jJq+hFbFgZi+jLALOxaKXydMNqD0j2+zzT/4jnBaQJHTdXM6WheGpC1qXKeZoE8o5jZ4uko
	56xpUjLLYksEdgVN3myh0LxFO/ZWxqZ9RdKWGIyeGsTV762oL9ZJNmhomIb0w+QSU=
X-Google-Smtp-Source: AGHT+IHzs/FH8zMsIZdeSQnHXZamtDjuZgE7t4GyT8+Rzh1vO8S/OVrjZ8A59XksMNfjALKbiojoHg==
X-Received: by 2002:a05:600c:8b4c:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-4778fe67aeamr107158895e9.10.1763370622473;
        Mon, 17 Nov 2025 01:10:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d631:aa74:9313:e9f3? ([2a01:e0a:3d9:2080:d631:aa74:9313:e9f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd27ad5sm106977585e9.16.2025.11.17.01.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:10:22 -0800 (PST)
Message-ID: <47aadf0e-f59c-47de-8c7c-78571c83017a@linaro.org>
Date: Mon, 17 Nov 2025 10:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 3/7] mmc: meson-mx-sdio: Refactor internal clock
 initialization
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
 <20251108231253.1641927-4-martin.blumenstingl@googlemail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251108231253.1641927-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 00:12, Martin Blumenstingl wrote:
> Use modern common clock framework helpers for simplifying the clock
> controller management:
> - switch to struct clk_hw for internal clocks and only get the
>    "cfg_div_clk" (which has to be managed at runtime) as struct clk
>    using devm_clk_hw_get_clk() which is then the only clock used by
>    struct meson_mx_mmc_host.
> - use CLK_HW_INIT_FW_NAME and CLK_HW_INIT_HW helper macros for simpler
>    init data initialization
> - keep the clock controller memory allocation separate to prevent a
>    potential use-after-free because struct meson_mx_mmc_host_clkc is
>    free'd before controller_dev
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mmc/host/meson-mx-sdio.c | 119 ++++++++++++++++---------------
>   1 file changed, 61 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 1159cc911359..ce1828d915da 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -99,15 +99,15 @@
>   #define MESON_MX_SDIO_RESPONSE_CRC16_BITS			(16 - 1)
>   #define MESON_MX_SDIO_MAX_SLOTS					3
>   
> +struct meson_mx_mmc_host_clkc {
> +	struct clk_divider		cfg_div;
> +	struct clk_fixed_factor		fixed_div2;
> +};
> +
>   struct meson_mx_mmc_host {
>   	struct device			*controller_dev;
>   
> -	struct clk			*parent_clk;
> -	struct clk_divider		cfg_div;
>   	struct clk			*cfg_div_clk;
> -	struct clk_fixed_factor		fixed_factor;
> -	struct clk			*fixed_factor_clk;
> -
>   	struct regmap			*regmap;
>   	int				irq;
>   	spinlock_t			irq_lock;
> @@ -548,8 +548,7 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
>   
>   	/* Get the min and max supported clock rates */
>   	mmc->f_min = clk_round_rate(host->cfg_div_clk, 1);
> -	mmc->f_max = clk_round_rate(host->cfg_div_clk,
> -				    clk_get_rate(host->parent_clk));
> +	mmc->f_max = clk_round_rate(host->cfg_div_clk, ULONG_MAX);
>   
>   	mmc->caps |= MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
>   	mmc->ops = &meson_mx_mmc_ops;
> @@ -565,54 +564,62 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
>   	return 0;
>   }
>   
> -static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host,
> -				      void __iomem *base)
> +static struct clk *meson_mx_mmc_register_clk(struct device *dev,
> +					     void __iomem *base)
>   {
> -	struct clk_init_data init;
> -	const char *clk_div_parent, *clk_fixed_factor_parent;
> -
> -	clk_fixed_factor_parent = __clk_get_name(host->parent_clk);
> -	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
> -				   "%s#fixed_factor",
> -				   dev_name(host->controller_dev));
> -	if (!init.name)
> -		return -ENOMEM;
> +	const char *fixed_div2_name, *cfg_div_name;
> +	struct meson_mx_mmc_host_clkc *host_clkc;
> +	struct clk *clk;
> +	int ret;
>   
> -	init.ops = &clk_fixed_factor_ops;
> -	init.flags = 0;
> -	init.parent_names = &clk_fixed_factor_parent;
> -	init.num_parents = 1;
> -	host->fixed_factor.div = 2;
> -	host->fixed_factor.mult = 1;
> -	host->fixed_factor.hw.init = &init;
> -
> -	host->fixed_factor_clk = devm_clk_register(host->controller_dev,
> -						 &host->fixed_factor.hw);
> -	if (WARN_ON(IS_ERR(host->fixed_factor_clk)))
> -		return PTR_ERR(host->fixed_factor_clk);
> -
> -	clk_div_parent = __clk_get_name(host->fixed_factor_clk);
> -	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
> -				   "%s#div", dev_name(host->controller_dev));
> -	if (!init.name)
> -		return -ENOMEM;
> +	/* use a dedicated memory allocation for the clock controller to
> +	 * prevent use-after-free as meson_mx_mmc_host is free'd before
> +	 * dev (controller dev, not mmc_host->dev) is free'd.
> +	 */
> +	host_clkc = devm_kzalloc(dev, sizeof(*host_clkc), GFP_KERNEL);
> +	if (!host_clkc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fixed_div2_name = devm_kasprintf(dev, GFP_KERNEL, "%s#fixed_div2",
> +					 dev_name(dev));
> +	if (!fixed_div2_name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	host_clkc->fixed_div2.div = 2;
> +	host_clkc->fixed_div2.mult = 1;
> +	host_clkc->fixed_div2.hw.init = CLK_HW_INIT_FW_NAME(fixed_div2_name,
> +							    "clkin",
> +							    &clk_fixed_factor_ops,
> +							    0);
> +	ret = devm_clk_hw_register(dev, &host_clkc->fixed_div2.hw);
> +	if (ret)
> +		return dev_err_ptr_probe(dev, ret,
> +					 "Failed to register %s clock\n",
> +					 fixed_div2_name);
> +
> +	cfg_div_name = devm_kasprintf(dev, GFP_KERNEL, "%s#div", dev_name(dev));
> +	if (!cfg_div_name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	host_clkc->cfg_div.reg = base + MESON_MX_SDIO_CONF;
> +	host_clkc->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
> +	host_clkc->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
> +	host_clkc->cfg_div.hw.init = CLK_HW_INIT_HW(cfg_div_name,
> +						    &host_clkc->fixed_div2.hw,
> +						    &clk_divider_ops,
> +						    CLK_DIVIDER_ALLOW_ZERO);
> +	ret = devm_clk_hw_register(dev, &host_clkc->cfg_div.hw);
> +	if (ret)
> +		return dev_err_ptr_probe(dev, ret,
> +					 "Failed to register %s clock\n",
> +					 cfg_div_name);
>   
> -	init.ops = &clk_divider_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> -	init.parent_names = &clk_div_parent;
> -	init.num_parents = 1;
> -	host->cfg_div.reg = base + MESON_MX_SDIO_CONF;
> -	host->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
> -	host->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
> -	host->cfg_div.hw.init = &init;
> -	host->cfg_div.flags = CLK_DIVIDER_ALLOW_ZERO;
> -
> -	host->cfg_div_clk = devm_clk_register(host->controller_dev,
> -					      &host->cfg_div.hw);
> -	if (WARN_ON(IS_ERR(host->cfg_div_clk)))
> -		return PTR_ERR(host->cfg_div_clk);
> +	clk = devm_clk_hw_get_clk(dev, &host_clkc->cfg_div.hw, "cfg_div_clk");
> +	if (IS_ERR(clk))
> +		return dev_err_ptr_probe(dev, PTR_ERR(clk),
> +					 "Failed to get the cfg_div clock\n");
>   
> -	return 0;
> +	return clk;
>   }
>   
>   static int meson_mx_mmc_probe(struct platform_device *pdev)
> @@ -682,16 +689,12 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   		goto error_free_mmc;
>   	}
>   
> -	host->parent_clk = devm_clk_get(host->controller_dev, "clkin");
> -	if (IS_ERR(host->parent_clk)) {
> -		ret = PTR_ERR(host->parent_clk);
> +	host->cfg_div_clk = meson_mx_mmc_register_clk(&pdev->dev, base);
> +	if (IS_ERR(host->cfg_div_clk)) {
> +		ret = PTR_ERR(host->cfg_div_clk);
>   		goto error_free_mmc;
>   	}
>   
> -	ret = meson_mx_mmc_register_clks(host, base);
> -	if (ret)
> -		goto error_free_mmc;
> -
>   	ret = clk_prepare_enable(host->cfg_div_clk);
>   	if (ret) {
>   		dev_err(host->controller_dev, "Failed to enable MMC clock\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
