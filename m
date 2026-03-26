Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022D271A7C
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529719; cv=none; b=uXoS4eGGtPz6f3J72VyFPU96sqw0Vtv07l+tsaof0LJyQVEWdQpl3bLT9oLb0TDRzaeSL7npNuBnr5YavNySKs9/W8RcAJwwRLPQ7auRF/YDpVGDiHB/SzRU9iMitfgazo0YSSKMCgHem9/StrtNKZu1twEFNbEZ3iC2JRvVFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529719; c=relaxed/simple;
	bh=Y0FF9WEp5KmFXbC+L8OjWx066EP02rkF8OEbRbkcYEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RnYAswl3CRUBucUE/7Rr+azt0eGXDxFsLUfep3N24ne3ihGXCGR2PB0TJ16OtbdZxEAEGY9vRnEr0vVUuk+QAae8xYumkwxHqja9qraberZ07hwDbLiMDQeI/fvIL22U1oYT6oHg53wqhmV63iJUnNNKLWCCr6mUY5eV/uvCrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJ8ufbuQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ8ufbuQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso8203845e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774529715; x=1775134515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X67yw9hp70DJW5SbayvQBOmUIp03R92/bYFmSlkehKU=;
        b=KJ8ufbuQUFmOzhQDZvCLZ6XVPxV0h6G5EVwow/IApzRkh/cr0RTs94Nvvn5GWcmRm8
         0kYHkw5xqF3W5fR4MfNdp7XkttG9TpmjSKIS7ccHHwM4+CZD8cFEhsi3jzDp+zMRLHon
         ooUmd85gyEX6sAo2VmMsSPxgkpNPO6x5Jgw496YopxCOoMqaAc35ql8xhhtlSFVtfFuO
         XlTvhuzLydszWUNQG2vNjWiKrjsIp3DGG0fcnbnzC9wP9KYBvvxNchZdmGtN21UnGPKm
         pvC47s7rP1SSXvLU7NofnInnhtY69HsiJfaVHtnlx806r5tkeRPX2gIioZNKSPWjpxwG
         OxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529715; x=1775134515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X67yw9hp70DJW5SbayvQBOmUIp03R92/bYFmSlkehKU=;
        b=FTZcfrl0HqvLxP5WjZ6+8NBTR9hMsWbco5xLyx8S/zZWBCmXowbWWu9NlBGMCrk4Hd
         rWPIzaE+OE0dAtgzBFhim4gpyujMTxZEg1LrXWtbTGsfzmhHbKwJXF8q5YHGtEHI2i0o
         XIpcMnKndqPK6XepvmhH/sXt2a0H4ykJmYLOJOsI3bV0R091ROqXFEx9XjbHn4EvbqGM
         vPJWygU5SUkYIx5db4+NDCmClqaZJaiSCgFv9lR7JHs9Evch/6M3piGtqQSCkDlfqDnz
         uWNGU7QnWtBHoTA44G5MwGqk3p2Nc9wGW2xZ9h2ubSyw6iRVIVqsrAkhXNA/LGQIRJd7
         a5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIU6GJQj2RTdddxCGBl1hXdsTHybtLe3Wpc+1SvtdX/KTXbjBIi3F/DjL/Jeohf85T6TjOhb7P0M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTE1YIObB3Mhv2OPrJEk1UoOr5WQjKBejtj0wvwRWOnvSCyHgj
	lexHRuBnmnbCF6VTrh4hYuT52fGSr27jV51jH3VyhHoVtD07l+0hJM7cKWqinjWTUtU=
X-Gm-Gg: ATEYQzzjxOEaaDrzyxo3hK2OVbTst4Disha7F9fO2pKUFaiERtreR86EGpeLo7UqsDX
	1rHsSZ/ulQcKuvq+H9+lndxg1VWraEK9wTH3gfpfLFim6lziPHWzq+AewR5tb5L8jV4m4Jxj+sf
	W4fZji+JihZNcP8qoTiHYtpZ3FQNvpaWIWwfLNH0aU5w1t4nsO+Ba5fDractRmroPYyTi8DWFLg
	WI0+zkIunWW75jYLe2Az8QoDS7Jgkk0IKVFD7KpvlkjCSkcp6NKzETXtWKBZtPV9+TxVAPmtv00
	QQq/THkOBeMuYaku83zNNU8GTmli6YfbAI2spfsRAWDcU+NlD9G3+86R7PKc+JqbTiBxAHg1z5V
	8b32fi4gfYoBzRvx9ymvrw2Z5tFDGELtelEo7sLaUO3sXwa4eVVrV9YBTAtzJFoFMKtgHZO1aoa
	vzhBo0ffCIDiQFbrDmWY48MNyOd8FzXTPxntUN7aREupoMHwwfJZM3jVDpQ90UaMTYEB2A/w10M
	wiqVEu1pcMzOznsbA==
X-Received: by 2002:a05:600c:1f12:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-48716050758mr107584965e9.25.1774529715255;
        Thu, 26 Mar 2026 05:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487209378e2sm14061155e9.31.2026.03.26.05.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:55:14 -0700 (PDT)
Message-ID: <9bc23f1e-1cf3-43d1-935a-c4738d576c29@linaro.org>
Date: Thu, 26 Mar 2026 13:55:13 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 8/9] dt-bindings: net: wireless: brcm: Add compatible
 for bcm43752
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-8-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-8-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 10:59, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index 3be7576787644..81fd3e37452a6 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -42,6 +42,7 @@ properties:
>                 - brcm,bcm4356-fmac
>                 - brcm,bcm4359-fmac
>                 - brcm,bcm4366-fmac
> +              - brcm,bcm43752-fmac
>                 - cypress,cyw4373-fmac
>                 - cypress,cyw43012-fmac
>                 - infineon,cyw43439-fmac
> 

I'll apply all the other DT patches, please send this one alone with the [PATCH net-next] prefix so it gets picked by the wireless/net people.

Thanks,
Neil
