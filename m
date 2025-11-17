Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5B31A07B
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370668; cv=none; b=je1dSAZoPv/jSeJv24yGuxVO+6oF1NtKgMXdAGvuvuh0+yKc+blHmi4xXN8SscxiwxqcYo+MO/tl7sgq0febKeROpTKmnXz8YdVagFYxId7aGkh2wIF/XlCPR3SzXusU8JiivlyTU2sW8CgJ+liDd3qQ64FZ8kLS8nVQizgr6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370668; c=relaxed/simple;
	bh=d5rt0Bj1r9kKBoHcDV3AnxDc6WmjFwrujktBfs5pJVQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jk+nB53mABH5yzR6Dft6wYCPIUKZkGFVAzkrcjdLA9xis+dM/t5xXw/fxq5DAUBoMPt29dR7AOlOWMeb3NwETEyN6aBNsG5bNLc60fLLcKx4jIYZk1dCrw6AaG3+/HHKFnuLb6s2De3NlNi3bVRKLNhtJwRbbFsNWINvw7e+6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IP83CR2E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP83CR2E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso2613089f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763370664; x=1763975464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWXKv6dzpM2CS8QuqpR6KyDTLS4NLIuX56g7jGiE3Rc=;
        b=IP83CR2EEapcc6HDnoTlnHrdlRuv4ph9pzWcigIGH2923Bm9qoVUspTmvRtTuaxKPm
         tgWd/NrNOSBwHXNPlGvAXWECGPttsY5COJzC9HQg3so8KVlLq9EVUHxxOZ1ikOotfO55
         X3py90li5kLLHWG6s39BksaCCrCQouAsPsSVmeKzqPyin7M81x3y84HdOa1ZBdoc9kQ0
         RUs4F3TRrzJvq20YcoZfZisSGPgU2bh91saet9ln76I29YNIDwCQMNnLGxXlXCmtDIa/
         uRDJxGv2htbRrmKpL6LDgzGcfqsXKdftYRKC7IjTaNhCQYCXscZ/DhdmdMXlcKgEKTla
         d/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370664; x=1763975464;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWXKv6dzpM2CS8QuqpR6KyDTLS4NLIuX56g7jGiE3Rc=;
        b=i3FdSoIz4e5RE4slqQC5PhXWGF/Ok7iXLVQKy5c74JAtytuiDCwcKz6vUvmn3nozGt
         dPQfmeY4xLkHUqXEoukfmpTgaSoAr+pVBD+6ocb1YZyfvX9KwaX5brCBu3Xiw3g2NI9c
         mv4PF+2DGavzSCu8eEFl05Fkx+uG4sIKB6561AaWx8UA4V4DW7dgfdov0eKAA6Vlq9E+
         i1Lngr/FueztoWb2hp9Jtp/Y3TUnplovQT5GDb92H4BikFl3XRsPPzWp9k+SVxQ6NV52
         j8dFwgtTiZu9WRZcaCZL9NImj18hVKTCIDWD2fD0VHWNbXqpLyKnBbm/AQ6mH+fe34v6
         iuRg==
X-Forwarded-Encrypted: i=1; AJvYcCWktFHyxWzNTrGAmeFt6RzTNv//rtiZXcCEL7diQ7u5kekwSbHmP2g5GkfpB2ww2OCAJ2OiAnbIyCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJotmjWX5ryzCmFob4t6yHVrEBZBoYnUTzOkahhbdYsLGIH7AA
	l/TL640vWkgCywjTTtApUHInWFxInHV0OyU7QMTEhzVSMOhA3kn/tDuzLLqZ3huS00k=
X-Gm-Gg: ASbGncvejQdG09LXuAyTPHGwVvbGvVll/DGTNojcS8J/0H9xpp3X0uEfJdOlKayQivN
	KlRsds8oLTE+EQkzxV06lGi6qFRB4nsy688HTimSMPHI0MHzFx2APveVei9XRHmceFUZhG7Kc6G
	ekI8nIGN6khxIM8qcWZiwLyHZxmyiBGeNYiJ5ZEkcTDRuTHslUMFM11k86JpUE4J2mHMQ7x9FK9
	BAWuovLhWNs6yIeJwdOlCOVnEuu9ZRW6BJnfBgRZ75yr9i1ywMC/GTB1BIQnN8S4QZlFr2fc02v
	cy1ep7ksC670D5baYlim3nm/zfE5A7qFSnjkPnUtLAGj2yQ0zzitau97Dp+sMr7kUZo+EZjE0VK
	GwC5SblxyhELlSvC+UN/tf9U49NT8iVZ8BFRsuh9LTN10epglRbYC0hKJRPVxafzXzroxpVkpJP
	Irshr0I3jnI8XMsv/NiIg1tW2jYFw61NWFyFpxMbnohZq7A8enMjCvMrWYbUZrRh0=
X-Google-Smtp-Source: AGHT+IHyuINLK5MdbEyCE84WDmNGgCERjzRvEgCe7ErPY+YmW9fdaWeR1WnnEstHTpOfhgyPahtbCg==
X-Received: by 2002:a05:6000:657:b0:42b:2a09:2e55 with SMTP id ffacd0b85a97d-42b592d106dmr9359114f8f.0.1763370664318;
        Mon, 17 Nov 2025 01:11:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d631:aa74:9313:e9f3? ([2a01:e0a:3d9:2080:d631:aa74:9313:e9f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b622sm24597140f8f.29.2025.11.17.01.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:11:02 -0800 (PST)
Message-ID: <9df2dd4c-9283-4f3c-859e-586e1b397a96@linaro.org>
Date: Mon, 17 Nov 2025 10:11:00 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 5/7] mmc: meson-mx-sdio: Use dev_err_probe() where
 appropriate
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
 <20251108231253.1641927-6-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20251108231253.1641927-6-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 00:12, Martin Blumenstingl wrote:
> This streamlines probe error handling / logging with other drivers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mmc/host/meson-mx-sdio.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 214ce84f1ddd..052bcf8f32df 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -520,16 +520,14 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
>   	struct device *slot_dev = mmc_dev(mmc);
>   	int ret;
>   
> -	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id)) {
> -		dev_err(slot_dev, "missing 'reg' property\n");
> -		return -EINVAL;
> -	}
> +	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id))
> +		return dev_err_probe(slot_dev, -EINVAL,
> +				     "missing 'reg' property\n");
>   
> -	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS) {
> -		dev_err(slot_dev, "invalid 'reg' property value %d\n",
> -			host->slot_id);
> -		return -EINVAL;
> -	}
> +	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS)
> +		return dev_err_probe(slot_dev, -EINVAL,
> +				     "invalid 'reg' property value %d\n",
> +				     host->slot_id);
>   
>   	/* Get regulators and the supported OCR mask */
>   	ret = mmc_regulator_get_supply(mmc);
> @@ -666,7 +664,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>   					     &meson_mx_sdio_regmap_config);
>   	if (IS_ERR(host->regmap)) {
> -		ret = PTR_ERR(host->regmap);
> +		ret = dev_err_probe(host->controller_dev, PTR_ERR(host->regmap),
> +				    "Failed to initialize regmap\n");
>   		goto error_unregister_slot_pdev;
>   	}
>   
> @@ -680,12 +679,16 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   					meson_mx_mmc_irq,
>   					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
>   					NULL, host);
> -	if (ret)
> +	if (ret) {
> +		dev_err_probe(host->controller_dev, ret,
> +			      "Failed to request IRQ\n");
>   		goto error_unregister_slot_pdev;
> +	}
>   
>   	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
>   	if (IS_ERR(core_clk)) {
> -		ret = PTR_ERR(core_clk);
> +		ret = dev_err_probe(host->controller_dev, PTR_ERR(core_clk),
> +				    "Failed to get and enable 'core' clock\n");
>   		goto error_unregister_slot_pdev;
>   	}
>   
> @@ -697,7 +700,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   
>   	ret = clk_prepare_enable(host->cfg_div_clk);
>   	if (ret) {
> -		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
> +		dev_err_probe(host->controller_dev, ret,
> +			      "Failed to enable MMC (cfg div) clock\n");
>   		goto error_unregister_slot_pdev;
>   	}
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
