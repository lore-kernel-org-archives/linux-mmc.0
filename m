Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A4329380
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370684; cv=none; b=oitK5j2ekwS9NoiUKrRpm6AOFShinLc3z886sAYkSVb0SC3YOjsf+ICCSBQrea1zFezr7c8WxsKyKdWlPzHqKMt9LCe9tHpfC91iajAcvHrdYHwo0P6fUd/gml4lusEFYFy5+eQCW9qvQBnuijhjgIx+V8l4uVepOv0p0CA+rIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370684; c=relaxed/simple;
	bh=VGf0gQGbe4k9BzXdlQ3d4Pr44VFe2m06NDs5bjCUtHo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OYhZfbb6iWQMrtf9D5AYpodEWq7ZUjapcqeouLUdPMIfodI7I+HPPO8zDtKvQmOrGq1YJ3rvs8mblUcNerf/S6iCyK8O3OguRRsBYVrRgLB41D3wSKf5PL4E6fTbDSkKhjsu1nMwyoNDGPV4NUbpa9DZviDM0V1h7lwKPYPJzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nntWGV7G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nntWGV7G"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so43114105e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763370680; x=1763975480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJvTLRnRDoEqGBIlnWGGjXDEKSpyeQX8qHCstc1K250=;
        b=nntWGV7GUTQkn7kaJVisxMDrcwj8DcYg0qGVu6SZ5iS1x9uR8nPwFlGqGXI/Vlrk+V
         SVyLgcbJ6z5ahx4DVLb1PRKfBL7XZ3Qxoinsheg+hQRqgYL8GKwpS13we/o7IXh693Ew
         mqdSHA6fmIAHNSSyvkg+/KbcNmvWfb2IK921YRw5p2lOhOrOwIy8fpvdVqZOhLbh82x+
         sVCVujkFYl5kXgDxJ7oxcqPWhAm4YejNrxe3XAwOv0VYYCwmxE5kOE34ExrgjptSUvXJ
         DPWtQoeHFH7XYRuvf/wpAZ5slh0KTMq5afcF1Rn855ovTsdDDQDaX84/BY9EP9aD9amy
         IJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370680; x=1763975480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJvTLRnRDoEqGBIlnWGGjXDEKSpyeQX8qHCstc1K250=;
        b=heB3V1w3QPyuGVt6ZXB7ZPk8WeuAj0uXjuN5+xBBsOqyTRCwccVJ4CzrY44CmCd7qk
         o5Y5DpaKJ2yo8yW6+OpV9hIH4EZlObZ4OzKwYko9zsdrCwsrIJlpe6etM4ZlT8RkE679
         TMLHWe1R8cmAyfG792clRMbfjaJowsmjtgFDkoeYGWfQ94y0WvefAXP6hZVxwxs5TH3H
         CKTxqQcIYhRsN+E0l4Pavdu0Wr9df7n3Jv+KCc1EW2Gp5VV7f56uYeUIVGI1J/19R7SH
         KYB0xIGGB0/uSL4EQkVegXKNjbIrifY/FzD2cCUys6tmy7+Io+4R6J2Oq4cnZNfz+YQ6
         Nvcw==
X-Forwarded-Encrypted: i=1; AJvYcCVxeYHdtgCNir87UXnkXs1im5Qs3ttse6AiOP3sXmEQ650JdR4fwkQszUf3vjPMFZNAOgsafM2dr0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29jAwWb2fB4/8FgbhhskPcerm78QvNH/ksOayQ69rXFDiUns9
	x9X6YFlFOeVlayyFAnvxrNaMTy1laHksRwNtCdArDSf6C+5avqUKHepAzhi+ZH74VmY1Oz2JFUa
	2ZvL2
X-Gm-Gg: ASbGncuEffF+IWmOkjxrW1nx1qjT3CzSt3WQTVStOmuvX983ShgPn2nSlKtpdDQrBkx
	V0yAsTI5OMNUEOxJwsfZa8DasLrjJ39srgNtW4mOjKBbRQd19lg+1WTBODgdzqsUJE3nLqAJXQz
	f+HvzAYOJMqpf3hV4cH3vif3jtCyf/HA6JIlWtODK9PIz+SjFsl0HnOx90TLHTPxa4eS0DRN5zH
	5Bs04iidB3sfgKNleXSheob18Jn4x6PMXxZJw9VBKZaJG1dByvSBm7bfZd1Pmd7FujsZFGMK67d
	wAXijQPEJhGvsDXUm6mjPaKK3V1piXKhhrylkfTDcr+y1h++ZcEtXPioZwIUEJdijGd4B1mzJbt
	90DXrJ18LKF5i5GWI7amgSUti/f9R6yjZrWT8vh43dmk4j2Nd/GoI5JbxEfPi2IWdGUj/bE2mYL
	/mlYbNIliJrGu9BfqoF/RN3KqAahZNZYREgGqmZh+PT79DAGkIecbu
X-Google-Smtp-Source: AGHT+IFc3Tyo5Ai1EPE18jNuD1mi3IzLZtTNX0BmhIv38Tygj+IiqVox+H1udGbQDhtv8YRZXbtA7Q==
X-Received: by 2002:a05:6000:2a0a:b0:42c:a449:d6ab with SMTP id ffacd0b85a97d-42ca449d9b4mr993180f8f.30.1763370679961;
        Mon, 17 Nov 2025 01:11:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d631:aa74:9313:e9f3? ([2a01:e0a:3d9:2080:d631:aa74:9313:e9f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm25374870f8f.40.2025.11.17.01.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:11:19 -0800 (PST)
Message-ID: <614d29e5-b662-43fb-98c0-e3dd0efbe25b@linaro.org>
Date: Mon, 17 Nov 2025 10:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 6/7] mmc: meson-mx-sdio: Fix indentation in
 meson_mx_mmc_irq_thread()
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
 <20251108231253.1641927-7-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20251108231253.1641927-7-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 00:12, Martin Blumenstingl wrote:
> Keep the second line with arguments for dma_unmap_sg() aligned.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mmc/host/meson-mx-sdio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 052bcf8f32df..e8b63dc45dd8 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -436,8 +436,7 @@ static irqreturn_t meson_mx_mmc_irq_thread(int irq, void *irq_data)
>   
>   	if (cmd->data) {
>   		dma_unmap_sg(mmc_dev(host->mmc), cmd->data->sg,
> -				cmd->data->sg_len,
> -				mmc_get_dma_dir(cmd->data));
> +			     cmd->data->sg_len, mmc_get_dma_dir(cmd->data));
>   
>   		cmd->data->bytes_xfered = cmd->data->blksz * cmd->data->blocks;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
