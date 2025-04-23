Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E61A2380
	for <linux-mmc@vger.kernel.org>; Wed, 23 Apr 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415796; cv=none; b=go2awdyrGyjsGJbTRLtfSEgOPULMd+XQzNa2wUBIEA3VxytA2AsrBNUaouflq5yrhMlqk7uv8n4AmQYWkXm5VieOVvRpLBIONFG8EcAU3gEUAW2uQe6yxU4CV3YCmlc/Ajj8qpKctQAsXpvfu4zxV76LVV2H69ImTRUbTwgKQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415796; c=relaxed/simple;
	bh=2oNxgFh7wQy3eSTXUuVVZ5YrZWKlKCIvbcZjJzlgFfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b2zWwGpaRNq9kZx3TPCw4yxMW6Nsp8RhmWiaRbQdpVG2A2e5fqlbfR+JnRlU/yV2Xmx2DD96VyJgmkOc+YeWR+vKEDiDGmbVuitnfiHGemTp/RKI1M2E8LsM/zJ1ih+tbhvyq/99x1KKyaHpwdsUfS1mC5k9G8xaWca14KzZUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i45NS8VH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i45NS8VH"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so64701555e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 23 Apr 2025 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745415792; x=1746020592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfrnhMcNKf5rCGWHGoNIZp7mNgbnWoHESdB7RpEhfqo=;
        b=i45NS8VH9j1Oz0y0h9MAM2BESfQeaGh+Dh+a6FJhpDkpc/b5nSBZi6eUChnC3FtqOB
         h9RYFH9VVn2NY3O6feDekcZTqtzU81CFECv4chNYTcRWpXluuaXpyhvsUJrIwD3lvj0i
         g541zgQKukKKx5+D2EpbjzeO6J/1nFSeAOSvvyYJxVgmqlHzBUegXZf2/O1wUR5QnTKL
         etVuKR5KPf5z13JejwrvSqbRsCW4zFAUwncAbqrA9TIS7dVdUaGFDyNAeWQ/6swPf5U3
         0bD/tIlq0iMfTnvTVLaD15P8xHbFsCCKpyh6UgibOswlmcmWqOM6njeJJ+ECcYGXv+aY
         XnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415792; x=1746020592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfrnhMcNKf5rCGWHGoNIZp7mNgbnWoHESdB7RpEhfqo=;
        b=AmoxxbcTO/iEc+DBQDnMCnRzugG+tfBTEUOy+bqdV035QTgTPyKXGm6sKa9VPQz5e1
         sF13Kf5jyAbEEHWJyvR2hccszNuhNyOHu06V+KuI6xlK4zihI8ZWSKuuKnTCHkKPpYq6
         A4fUcwfOgiNQar8nmiyHyC6I8vYYjzoZIDyNLAtqRmILrJnPJBf4MmzxiwIieDZvgR/u
         z25Zkh4OusrhU4h3nzcrJkpi58zDt5HmcJVO88BVm8xsyCAXUwUEbdqTayXhN2hsKejr
         wwCIfdAKP2etK2J4GX7Emcnr7AFYWXMXvDtTaEpkmbSGI8V14h98Yz29CCiNBLYjF+7I
         9Pzw==
X-Forwarded-Encrypted: i=1; AJvYcCWTDH9eI80TNOfNb8SsQzRFSxZOt45POFP2+2+DGYGseLFM+1Q3YDJ7Fu5g3/+G/WYSiiQ+e9L5CSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHc54+5z6h4sL+zQYUV5EPM/4S7wwdfFjOeaiqCeGKYK7OvdK
	qMWJPjbGpJhfGcRFQuri72WhFLpuy255btWvCqnaR0vkBJ1McnrtVbYQhvEe48Q=
X-Gm-Gg: ASbGncuD+s3prB8WKJmEsE00agXkZiVJG1KNPBg6tCNI3KEaSWREuGJUkhkoBwNQEh+
	ok2W0m7FvIc5qJb3qH4L6wkMoCMLqGOtxmQ7EP5MdfpDDKiM0SCRzmHNg4pQXarY4O0MNl06kuU
	Ej1iFfQTXt6QjwsRKXtM+yl8U+a6/wXzgkbWWL2svRQdsgLds6siiTxT2SBCaU1Q/7Qrpvg6o7U
	6L40tWBC2LQv+5+IMqGnFFwcCNV6nNUzqnyEJM/OTEiWJHNcAeUiCHVzCfCW5U+yFn6U+X6kY1c
	ZsN+4SfjIjPoswU5g1B2WAs8Age/r+65cIe5reD16bbdxitfVTEZmkVk4XtqtZhpRthjEejkNX5
	58q+Jxkq2d9sRqIzhGg==
X-Google-Smtp-Source: AGHT+IHnS/+w8vgB7Qer4VFmmeqW2fg9vqIPQjMtQu2PKuXwZePY3kDPFYEnC2G7XWePQ888jen21Q==
X-Received: by 2002:a05:600c:5027:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4406abfa6bcmr157183955e9.20.1745415792377;
        Wed, 23 Apr 2025 06:43:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd? ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092db2ba6sm26108245e9.31.2025.04.23.06.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:43:11 -0700 (PDT)
Message-ID: <1acbe9dc-02ca-4233-a79a-901e714f5c9c@linaro.org>
Date: Wed, 23 Apr 2025 15:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 32/33] dt-bindings: display: panel: samsung,ams581vf01:
 Add google,sunfish
To: Danila Tikhonov <danila@jiaxyga.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, linux@mainlining.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250422213137.80366-1-danila@jiaxyga.com>
 <20250422213137.80366-16-danila@jiaxyga.com>
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
In-Reply-To: <20250422213137.80366-16-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2025 23:31, Danila Tikhonov wrote:
> This panel is used in Google Pixel 4a (google,sunfish). Document the
> corresponding string.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   .../bindings/display/panel/samsung,ams581vf01.yaml        | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> index 70dff9c0ef2b..a3a1de32d8be 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
> @@ -17,7 +17,13 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: samsung,ams581vf01
> +    oneOf:
> +      - enum:
> +          - samsung,ams581vf01
> +      - items:
> +          - enum:
> +              - google,ams581vf01-sunfish
> +          - const: samsung,ams581vf01


Why do you introduce a new compatible ? using samsung,ams581vf01 is prefectly fine
if it's same panel.

Neil

>   
>     reg:
>       maxItems: 1

