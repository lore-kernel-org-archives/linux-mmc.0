Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241B23D2B4
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370568; cv=none; b=GdMUUuq0RotJsnlv0YF4wxlnmBym+z+7w4QMoKTMuvZrIDcH1zLzoJYyIElf8yat9xynqm/QVbLg3DsYsdCJy3iiSsxXwfMEMumEO9hV61ZKmsyJ3v5VV3rH+ziFotBaYrcLnZfWcLUsZu7T7WeGZHXBRySZxOPH9hgcTXJyvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370568; c=relaxed/simple;
	bh=/rW/lGUEt9cA7z4QojzSNx++UPGBTHJxL12VKoW0jsc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xy2EhZmp5KoE+szC3a4hykprVeJDbH9bpFWiPuSdEZOUx0KPYlx+pO/eLIIwFvBpmY+Ooga3MJFC1a4okSg834bMHJTE4NhdPvilgHCmSYL+cYyeLstEErJH6FqiKHwoDq2UG+Tb0ew0FClEkxLuazJje2hs1gbm3N5Ja5YELP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=colUJ5fj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="colUJ5fj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47789cd2083so27394075e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763370564; x=1763975364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNklcNl/h84G0BAPSH5Ap/sAnFYDzlujPx7lPybvZNg=;
        b=colUJ5fj2welGtqjt+ZWY2D/lGKvbI2PbNRWdE0Npokv/l4WsMdVozQ0PUP5mTW6tu
         +HuS8YkUSP+O7zf4mTzo+ZXqsFQIxQXpxGMiE2nptE0iLg9K3EuwMSKxqDw/T78H2uUD
         DfbrdRalPbJ/rWKYClDyhdTNUqaRWZZHGd15dDmTF4CuXjRTPGErfkgV6HhV4bA1FJjr
         KPFk1j/K5eiKr4DiXGzTI0/O566fEddMUz7ORJWRwQl6NkSXU+vCHqdHouek1InR3ySs
         PLfIVVnK530KEPvWXiXAHPDTWRe25ghATGmdMT9hbUwqae8Q8DAYEipIc7mmUzjl1Zgo
         4hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370564; x=1763975364;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNklcNl/h84G0BAPSH5Ap/sAnFYDzlujPx7lPybvZNg=;
        b=mGkkgVHFsQBsr7PyMcHn/wapwdiic9lGij+F2LzU/fHN1SxY/Xxcd8Mpt//QBE/Wwb
         Z+kNhVxwfA5YQGDYTO5aTeBKQDSX5ma7l068+oEWaCtQz2tPMLfJCZ3nGtij/oGxlaxE
         /cg3gtuAOZ9nMfX1vIWox51bs8xjYqRU8l5AcMjZ73nAzDd19rgBD3UHTS90ue/T0vrY
         61J6lIU/OvgO9aJrQ0KomPy9nd+UPoY2/uyudwwtqYmBPoGdwyGiVzWcz6J0z1IglL93
         +lzg95yz9+VdkLOQ613mZ3HE/vVJ0eqw0JmXrBQvrzhQP1yRat2w4nDLJx9XHPgxoHbH
         LPmw==
X-Forwarded-Encrypted: i=1; AJvYcCXVwLbcb8LhmjZk/pNCac4yZjJuukYlvL6YDAxbL0/Fk9l+WcRNZMUhfN2K3tMEAEnhufz7R4Xk/FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZGFQrl7jgDt81ohj3hMNpy5slvfNmFLX4917YcENjI5vUIff
	Crb3fYvtHIp0Ef2/3fJWRJfsPmpPmKAjHP0JTqMe2jva6+bEufclFE+79IiW51OQmTU=
X-Gm-Gg: ASbGncuKz79EANlTFSOySJUI59WKcSnh45LJqgzM9eH0uuiwCyS1Yj4sasCRquGoiLD
	+dcI31oEpcpLZYJPOiMESS8464/Kwxf5Pc5USS58Th7J311AZ5J1CWUUWUF6YAxkSzBJRIVrGm4
	9SspTo0B2engud1HbbKBtWXdwioKrL934EXUV6y2Y/5o17DQheloJlcJrzlw/DUdyQZIXi3d45X
	kzyvcwfthU+nMCQxuLM3YieFEOdbyVgqVTRQkPhopkdYRDLYRaNU0dQDqoHTWNTHBrJAh6z/7pB
	645G/Yj9WLzCdfDSEtIlM4C0Hzmjd88E392kGzYFE3aHMAptlBFTuaWxmTIGzrtrucWpddNhTcd
	U9OuXq/ccSkAm4K1GhjSo9XrrQz7Q3wuEcJHipmZwos+0ML2UNFEc7DU0C23RdqjFrO8OXGcXMH
	pWlUdvm2e6vPupiJ6qClEP6Y+sfkii5Mfc8aaLxXaS6Yku+J4jhJl2vqapA9PUfLc=
X-Google-Smtp-Source: AGHT+IFEqkwxSjllnBhN7jZwXn9JEstugFlfcv/0lGieX2lTDkq55U3llo5HzCc4RWdNNcS783EXgg==
X-Received: by 2002:a05:600c:4712:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4778fe9b36emr102254505e9.24.1763370564404;
        Mon, 17 Nov 2025 01:09:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d631:aa74:9313:e9f3? ([2a01:e0a:3d9:2080:d631:aa74:9313:e9f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm322893365e9.0.2025.11.17.01.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:09:24 -0800 (PST)
Message-ID: <5d6d8e57-a660-4b9e-9fc1-f074551f1d89@linaro.org>
Date: Mon, 17 Nov 2025 10:09:22 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/7] mmc: meson-mx-sdio: Use devm_clk_get_enabled()
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
 <20251108231253.1641927-3-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20251108231253.1641927-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 00:12, Martin Blumenstingl wrote:
> This simplifies the code. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mmc/host/meson-mx-sdio.c | 23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2448f21bd683..1159cc911359 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -103,7 +103,6 @@ struct meson_mx_mmc_host {
>   	struct device			*controller_dev;
>   
>   	struct clk			*parent_clk;
> -	struct clk			*core_clk;
>   	struct clk_divider		cfg_div;
>   	struct clk			*cfg_div_clk;
>   	struct clk_fixed_factor		fixed_factor;
> @@ -627,6 +626,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   	struct platform_device *slot_pdev;
>   	struct mmc_host *mmc;
>   	struct meson_mx_mmc_host *host;
> +	struct clk *core_clk;
>   	void __iomem *base;
>   	int ret, irq;
>   	u32 conf;
> @@ -676,9 +676,9 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto error_free_mmc;
>   
> -	host->core_clk = devm_clk_get(host->controller_dev, "core");
> -	if (IS_ERR(host->core_clk)) {
> -		ret = PTR_ERR(host->core_clk);
> +	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
> +	if (IS_ERR(core_clk)) {
> +		ret = PTR_ERR(core_clk);
>   		goto error_free_mmc;
>   	}
>   
> @@ -692,16 +692,10 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto error_free_mmc;
>   
> -	ret = clk_prepare_enable(host->core_clk);
> -	if (ret) {
> -		dev_err(host->controller_dev, "Failed to enable core clock\n");
> -		goto error_free_mmc;
> -	}
> -
>   	ret = clk_prepare_enable(host->cfg_div_clk);
>   	if (ret) {
>   		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
> -		goto error_disable_core_clk;
> +		goto error_free_mmc;
>   	}
>   
>   	conf = 0;
> @@ -715,14 +709,12 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   
>   	ret = meson_mx_mmc_add_host(host);
>   	if (ret)
> -		goto error_disable_clks;
> +		goto error_disable_div_clk;
>   
>   	return 0;
>   
> -error_disable_clks:
> +error_disable_div_clk:
>   	clk_disable_unprepare(host->cfg_div_clk);
> -error_disable_core_clk:
> -	clk_disable_unprepare(host->core_clk);
>   error_free_mmc:
>   	mmc_free_host(mmc);
>   error_unregister_slot_pdev:
> @@ -742,7 +734,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
>   	of_platform_device_destroy(slot_dev, NULL);
>   
>   	clk_disable_unprepare(host->cfg_div_clk);
> -	clk_disable_unprepare(host->core_clk);
>   
>   	mmc_free_host(host->mmc);
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
