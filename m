Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58912FF8D
	for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616875; cv=none; b=pyl3vIfD2TnFkBMamDp61xdX+8Hv7rklCSRMkkgod0rtJ7tLo2Gn7MKVFGPrFOvIw8YHQ4Dge1M01VDXpQWYXX10kKQkN+6GT/pLt576ZUIKW0KUg5p94qhxOcDfwNKJUZSfZj82gKZRINYM5YzzMU1zgaRi39SUmyYgwg26DEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616875; c=relaxed/simple;
	bh=ercnD1S5cnxKBrEg6zQSy71HnMExnzpYI/kQumxAdPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAgWdx113LZ2wVL793ner5yKLJH+5ejKm/lAgrg/pKI3cjaf82dbT65NLbQ7AZ377SYdbRYuaQwghjMd7uU8qhs+LOzF0E1BPj6uY9H7B8YePyeQYQFoZmqWgbyXgQr8DCn+YesiY9uTpsJRAyp6vyyhfqretK1H1k7rXHQasmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glqShHko; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glqShHko"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3744392a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616872; x=1709221672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxrLcv3u2YShuTAAoJh89K847e+rW4/UzhIX8cekUD4=;
        b=glqShHkogSGanV+h5iEXQHvdzec7gSSasf2LdhXHDGhVL57tK3kadXFZcx1fT5KLjE
         0GbiGO+gRRuyG6QeeTxQSPcD2de1TT+QTDcU4vluysKBu+uAVJszJp4VLiykFNmYseLj
         bAGyQTB2HIvKOcc9Mhgngk9A/Kt2db8AaxiE6LhHRuMwMlqoUogRssRpemgMqGPLXc+d
         x7w73HaFjdTL03fY0BLHrjLWd4WdyygwgJuPhAEhJYk3Ay05EE5AH1s/AQT+p1kWqkQm
         YONq6Eig4WK9+CgrAM/YDfPz3bibAwMPTsG8aSxA1PTQ/b7m8lGwd9eRikWuAG9yu+mu
         aseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616872; x=1709221672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxrLcv3u2YShuTAAoJh89K847e+rW4/UzhIX8cekUD4=;
        b=FKDaJ7+PcTvAOuJ0Ld6hdg7n/gaBJxbP7Uph3bMPjg+FQHNTc+rMuMF7n/T9Er8GYX
         ITcUx4m04y3s0KSv3MpJz7t6yMNekK2Xj4feyrTKdV6yEHynqhq4v2eTf0RMKRcHeBh4
         nwd8YkmQXL8qyKUC+1x5zhjHRpfIXBWfhpc8q3sQDt8/EnML8P+J6kM1Hh5UQG67g5ZY
         WAmkIleYEUdPOCXDtYjfzZyZqcyLpDX9oH3wY3tGatr5s0EeMokq29UXRWVzmgAVeXP4
         2vyKQ4G4LIajsGe20ApyBGToGMP677ClVZHoc2vEq3cYDR3TBuU2ZGoH53IOVXF9qEPI
         Mj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGMBiOLS+F+Pqfru3zcqcrvOweiiV83fN40glKXeoXmvXB/VEbm+Wl7O+aamSIb99H6vq5Y/aaLh9eT3zVZz3St/QkcVCe6jnS
X-Gm-Message-State: AOJu0YyBm/jF6dwMQcDbxA4Sn747u6HhI+jBMC5pWWgBWqNXZEF6szNr
	JNTLt1/VDr44liQzzHyzlfCEtFo7qlwrQvZyKacE4kCHfI0dsHxv4bVp2Zd92oA=
X-Google-Smtp-Source: AGHT+IHtYWZrrXCsOzphX+C76cATR14INFHQflR+Ad01SX7KZB8GkxIYSgYVacKjpGwEGK2OqDLTAg==
X-Received: by 2002:a05:6402:693:b0:564:56e0:5643 with SMTP id f19-20020a056402069300b0056456e05643mr8233792edy.27.1708616872395;
        Thu, 22 Feb 2024 07:47:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id w16-20020a056402129000b0056470bf320asm4086945edv.43.2024.02.22.07.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:47:51 -0800 (PST)
Message-ID: <d3fa9109-a8c6-4add-8376-bb9fecddc9db@linaro.org>
Date: Thu, 22 Feb 2024 16:47:50 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mmc: fsl-imx-mmc: Document the required
 clocks
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>
References: <20240222143911.979058-1-festevam@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222143911.979058-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 15:39, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The fsl-imx-mmc hardware needs two clocks to operate: ipg and per.
> 
> Document these required clocks.
> 
> This fixes the following schema warning:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

