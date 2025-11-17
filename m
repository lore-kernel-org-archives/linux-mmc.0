Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288C326D51
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370640; cv=none; b=lynhXart93rP9bs+Z9H7EhQ7IHb6sl91p5OpSwiu6v0z1xD2jtVK6oIbaO/FI00F8Up+3441AjzKnv8W9xPzwsSG2yyfRvwS3fw1HuUACKwBDfv/qAKPhRBRPGnr/gLchEmn7Rqr69DvyAr1G4bAb4IP2N6eypzE9cdK/L7yg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370640; c=relaxed/simple;
	bh=1/azYDKJxaxG26nuJdj4YWbnFkUxnDmREplw9fdjxC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r6ClHB8+Me6UyOvL26Gfnn3Uyb2rWi/TARqNj9nj01SSZ7/goV/vjUUZw/Go27Pfiv3NOQuOEBiPdVm3mbxHMcKt7tWj3Ntrh/e2D5oA5r+cGuxZEN6TkYFhSh51dnB9podRFh8cPdr+2f2Mvt8/SNHX1E0HNNFvu51v/D70V80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/93f+Bb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/93f+Bb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c48e05aeso2385252f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763370637; x=1763975437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5xS83R6jTExGfiXtHMfiumDDrM0n3+eJ9443zfQkUA=;
        b=k/93f+BbSaDCFLp7Yg8fB0YpSP0UtYKK36emEfDKUqNCfsFMFEUCdisBYjowFFGYuB
         Jy8onF4ASBbPGJEA1TrHM2DLhiXTkI7ITjDXd9odTeC/CN0sPKqC3f1dCprHslG/bA9N
         9/BNux6S80XM05tE2YIW9fjxrxTWYWf4r6Mphwpi5sAtLVVD7MejCCzrzExFDbzQBzML
         uYaItahWhgS4dBTZJOzva2CwpBPO58f4u3KT9puBeLr+nOfQej+xFWB9R/wIlmtmuxWD
         fMyNsaOkXY4TDV3G2G8exv2B7K2lGZ+F7+McyQFEUtPjeBpgwIXZBXsmyAW7f1jNgd88
         zt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370637; x=1763975437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5xS83R6jTExGfiXtHMfiumDDrM0n3+eJ9443zfQkUA=;
        b=rWYJmu8Fd9iETEZie2vT6te1Zh4FfLIzDvWZEJmp6kfzLN25drTtbKtWZgtTgwO4Sk
         SZ0iE+4bPkPRL0peBwCjnviBs/B2ZKvXz7OShYF5o1Ingkmt/JJ6tsrBXk0ZpsfxKn6u
         gok/ZsBppehciPVuVfDyTEzjM5u42S4Hq1HocLAsD6DKs6q7iyTjrS/Wu6c8HobrjYjT
         lPyNUTdsTMEAW72lFj+MoIrAhCHZ6ERk3d/IKXTu/rBT/h7Fj79VNwDjiaKSwsh72OI1
         sPjdVzu6kFccINsWLU5flnxbl8roaDkr3R7ldOde7dmKMISretU/XGVB4lja5WcPLQ7+
         MKOg==
X-Forwarded-Encrypted: i=1; AJvYcCUSn4wt5mBWKW1ehmB9H0OwUuvIW5K0zVOSreoQfaLZt9GY1YmlDG/Cmg1EbsUso+aczFGV6Mm3tkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6A0fpde2Ocjk8c+sbgdOzh1Uk8uuT26tdq/Iv5E0u26je5ym
	ieM5HABiUQA/iYHimtEmUFxG9iCbyMQPQqMe0927EcO8hVHr636Ft1JBUq/Ko97lT2A=
X-Gm-Gg: ASbGncs5dqoLP+JnrXTKtsJGfug3lzmpMOaWlPZZvyx00ldvHZz7w1Vc9R6v6AdxH9a
	V5jlwQjBfOQoyVfgCpTcyVZ7QQb4YDubRkEueV2peA3cD2BdOUH1H3r2q5m+4moJy1iOGGCC9T3
	5v3LiXJhcOQf8XqbZTm/w27L4uNQAPc9fVn74Bj6WR2bV2M4+DFrqgInzCOkH89adJOozKewvn7
	Vi3JFw8KhDw63yHUKBGaJX0otDDU0TTOYF1/LCnmMZZIAuC/9F/vGfIDZ+am3tXB42uRN5BgSzG
	scXMGklEid5vRXtc1n24CkQWli45uAZT1zJBWtElxoPFEugv868cLZyHl8XLnsZgYZGW1rgpxwK
	3LBWngs5khQNRf0wYCAsvBv2bpSO0bwTnVfLXYDg59Gl1wjpuEYNpP0Yur9WvfOMQ90Ck5ajQdK
	izPk+HwYgUUeycFYbaNmca8FTlTjPv/5gCXI/QFans1K9TNPekH7BKTJECa2+NDVw=
X-Google-Smtp-Source: AGHT+IFInPvL/+hlf6EvBiL3GuycrSuUEXiGcy+maGHmWCjrynz9VPYDH7y5YTt48xKHIlg1cCH8VA==
X-Received: by 2002:adf:b601:0:b0:42c:a420:e755 with SMTP id ffacd0b85a97d-42ca420e9eamr1015380f8f.23.1763370637172;
        Mon, 17 Nov 2025 01:10:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d631:aa74:9313:e9f3? ([2a01:e0a:3d9:2080:d631:aa74:9313:e9f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm25146237f8f.37.2025.11.17.01.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:10:36 -0800 (PST)
Message-ID: <3243f07f-da15-4819-837d-4de081d336ac@linaro.org>
Date: Mon, 17 Nov 2025 10:10:35 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 4/7] mmc: meson-mx-sdio: Use devm_mmc_alloc_host()
 helper
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, Binbin Zhou <zhoubinbin@loongson.cn>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
 <20251108231253.1641927-5-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20251108231253.1641927-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 00:12, Martin Blumenstingl wrote:
> From: Binbin Zhou <zhoubinbin@loongson.cn>
> 
> Use new function devm_mmc_alloc_host() to simplify the code.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mmc/host/meson-mx-sdio.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index ce1828d915da..214ce84f1ddd 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -648,7 +648,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   	else if (IS_ERR(slot_pdev))
>   		return PTR_ERR(slot_pdev);
>   
> -	mmc = mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
> +	mmc = devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
>   	if (!mmc) {
>   		ret = -ENOMEM;
>   		goto error_unregister_slot_pdev;
> @@ -667,13 +667,13 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   					     &meson_mx_sdio_regmap_config);
>   	if (IS_ERR(host->regmap)) {
>   		ret = PTR_ERR(host->regmap);
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>   		ret = irq;
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   	}
>   
>   	ret = devm_request_threaded_irq(host->controller_dev, irq,
> @@ -681,24 +681,24 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
>   					NULL, host);
>   	if (ret)
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   
>   	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
>   	if (IS_ERR(core_clk)) {
>   		ret = PTR_ERR(core_clk);
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   	}
>   
>   	host->cfg_div_clk = meson_mx_mmc_register_clk(&pdev->dev, base);
>   	if (IS_ERR(host->cfg_div_clk)) {
>   		ret = PTR_ERR(host->cfg_div_clk);
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   	}
>   
>   	ret = clk_prepare_enable(host->cfg_div_clk);
>   	if (ret) {
>   		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
> -		goto error_free_mmc;
> +		goto error_unregister_slot_pdev;
>   	}
>   
>   	conf = 0;
> @@ -718,8 +718,6 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>   
>   error_disable_div_clk:
>   	clk_disable_unprepare(host->cfg_div_clk);
> -error_free_mmc:
> -	mmc_free_host(mmc);
>   error_unregister_slot_pdev:
>   	of_platform_device_destroy(&slot_pdev->dev, NULL);
>   	return ret;
> @@ -737,8 +735,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
>   	of_platform_device_destroy(slot_dev, NULL);
>   
>   	clk_disable_unprepare(host->cfg_div_clk);
> -
> -	mmc_free_host(host->mmc);
>   }
>   
>   static const struct of_device_id meson_mx_mmc_of_match[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
