Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28517083D
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909819; cv=none; b=es/eqeHgI18wX5Y4gIKIJ5mCV5vWxzYIF8tlnVQ3RZlqQ9KXHQE3jkP6XeuxJ1V41hU8U34A4q6rc8rphavqVLdg1TAw6pbc7sAMRrvkpOXxmjEIGcbrNr/8AJ5W2gMM0piOMVhbqTSijPPecqiOQsPxhSlmwnrOrO+thyjFwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909819; c=relaxed/simple;
	bh=+oY2i3ORszQzqTqLfKsLXN4yVq1csMECzrBqBC5Sd/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TxR/8owpgXLL6UHmY3l+CD/twBsfk5U8TywJ6Yl48gMl7T/0duJnfLqRJ7kcaQbmpu3PGtignVsoYbMVxnNYv0m1uGnCaq92P5gZ4Qxe5l3P+4EQIStPrHncIeWOeRgczMjJ+ZSKA7B9yhFHmpOo/yPxI7Ku4+18b/1AiP4ndUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFVhFRuv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFVhFRuv"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so19106851fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716909816; x=1717514616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsbJtYVErR8r/q4B3UZZI5IbYruF+B+qko3pEEYjirw=;
        b=pFVhFRuvC5nPe8sIW4K9nmZp1VXiTJcA2aAVQV07tnqarmbj/9cfBjBmbvQe4l/B+5
         MSxL3QCsKVJWs5ipePGgKK73/1PwjcIuywR00bX5LxP/+7/51gEfazp3UzxMWDbK4tM5
         o12abG+nnWHDCWKfc9mKUyJ7JlMFf6cYGBj9cSWPEDgs8p20CBncsEqQT64YO7N63OA6
         toJZB8RGhR26M5E23trPAiwXo4PS8nkAEqEjqDby3mCaJDhgYFRvV/EepnZL9isG5rnQ
         ng+16MJPRFxs2DqiSoPcF1wWCthZD52o1ShYDFC8ELKk97sHHcWRFAJVZNYOwf/rfDix
         ltNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909816; x=1717514616;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsbJtYVErR8r/q4B3UZZI5IbYruF+B+qko3pEEYjirw=;
        b=AqCHYgRAnBXHCe53J39BC2yViTtJm6vZyrfRSZpJQGPFW7NmvL0pqD754kBpsY6XqL
         7QHKGvOdN0hHIUz/pGD5f8PwdRnafTSdfe3md/Yvfl+o8OLcZiMIQzSZ+XOuoZMs/BEx
         735X7797hcSjdIAeTTop1DbFcj5A2bo7UAyTrLZMXBR1BVMJ2SLCsTovZMFUI8IQNaQ8
         O/IfuGvZHFqv/ZNFVq+Y745cMYXoqhgMsDFBiSrXO4DcGuShCwQftJDUhDWgYam16kp0
         zmSuVFRztHMSdMuis5r7qAd7IT9IpDEZ9oSMGPfoSj+v7gQ+dO/sog0ntuSNCDfpYEaL
         btcA==
X-Forwarded-Encrypted: i=1; AJvYcCWb+0vX0GGSJuZXhsIrT0eBezALYYBW4hSC+u6Ohyo4r23DnEyIe3pdxsKd5LBoIj7KfAcop5P0oDPcc91S/054ySap/y/P0yHa
X-Gm-Message-State: AOJu0YzLMzJTinFdA31p+BxCPem3RW8GDxYRud08qanuxE3TQ8CWeKCg
	IuxIfTMXI2M3/1+BA2Ne5HlSH/1scwUWeIyLBkFlvHd7Bs55ZqSCu1nrDX5Slzs=
X-Google-Smtp-Source: AGHT+IHv+UOhINHAZ7Fq5UJg/jDZV5knNHIr4lPjm300UHSoRr04rGCzGorgsgzk+pXAc6lRduafPA==
X-Received: by 2002:a19:ad07:0:b0:524:3ce:d4ca with SMTP id 2adb3069b0e04-52966005aadmr9643491e87.37.1716909815989;
        Tue, 28 May 2024 08:23:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817e60sm623136066b.21.2024.05.28.08.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:23:35 -0700 (PDT)
Message-ID: <799dca35-b5b7-4bf1-9cdc-25f9fc7c7ba8@linaro.org>
Date: Tue, 28 May 2024 17:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: Add support for BCM2712 SD host
 controller
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <0f263886c0622f43d3a2f4cccaebae0c39ba1bc5.1716899600.git.andrea.porta@suse.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0f263886c0622f43d3a2f4cccaebae0c39ba1bc5.1716899600.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2024 15:32, Andrea della Porta wrote:
> The BCM2712 has an SDHCI capable host interface similar to the one found
> in other STB chipsets. Add the relevant compatible string.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

