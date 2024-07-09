Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569738DF2;
	Tue,  9 Jul 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491045; cv=none; b=ZoOowlUd+qnwzNiLzUeLa3EK6X/9Cm3kg7Fvz0BnbjECuuOHrGHR0mm+t3XQlu1dLThYJQrkp81/1k2H4B8g2ZSW2zxLJkkaWBh//ZoHKfQ6mAJAxIWyA9c+yITed+kOzlMYOKpM6fDh7pUJlIpyCIEIMkQkdoz1jVGmLWJM6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491045; c=relaxed/simple;
	bh=hOVZibqrFcfdl+i0HpDeBdhCF+yLKx8BFsrHlp13YmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri9MT1E77EM9ilDtnzjcxVDawjlN5ojjDJuXK/FcuH+CNDiaYdPgiZS8MfRrvEKv/jSZl4yesXmhaa9PIxduidSg6OnFccv3h9OE1o0qdzrmrYInAWaqcQjHwzoVShW0KDVFdTmKh3YpC7JSegPQEZXQmzMGRCSc1unccdmnJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzX1LsO1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzX1LsO1"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9318a005eso723140b6e.1;
        Mon, 08 Jul 2024 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720491043; x=1721095843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtH7OPMrirvI7ENGdelUQ1QKZy+EaAME7OT8wpfozBA=;
        b=TzX1LsO1973epEKAeeNjO0lZSA5OiLWTl315QuUgd0IwIFgTrRp75p3p92kF2cTP31
         7wZBEw/nenEnHryqnxT0GrqhzOSWSaoaij5cIgeLq0W2h3+F1Sgn0V8KmL2Xa9RKaF1t
         nnQ4PVuUuz0S1aBv1aFNDxv/S1rzwMMjk8Ae3828pRn3lYVOIu3qpzYUoEXBnv4FlDpm
         24Klqsdmf0HUQpLKf/yrtuxb53YCS8ceWzeDzM3DPZEvW3cO06OKKJxObwJOQKmpnVN0
         0rFmHm5VhZaD0S5sMDJFPCJ2DXc+dbrvaYiKAkRjePORIBSWnjbn1+OMsGENQVxHsZg/
         oo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720491043; x=1721095843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtH7OPMrirvI7ENGdelUQ1QKZy+EaAME7OT8wpfozBA=;
        b=Rlz7KQc3ivGEYBzmdOOfwZ5+2hJgxnE1JnESV+vqDFYsx7g+3RDDUitYh17UWeNaKc
         h+zdZE3F71cDdYaE6/T3fipL1eMJrXyTG1tgI5PppMSEhg21m16QbH2LraXLIuIGo3on
         cw6XW18nrgykEkSs8ZMrqfFTVTnzXpHZZI9Aw7eAZmPUIyrvU6c7+MvZAqpBIDC4wRy+
         6NnNBKOKr8VhHH+7SLgiLB4Urr6yuUUKEBrnwhad7FL/RObevsKWd9nZQ4G2lFA7hUKD
         X/4/i7B4jTT6j5IRHx2OoaxMsCbQeS5We99bPSLkJOgsZu5fQVXzEHqUMow94Yy7X7aQ
         R8zA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4Mt7SKXvORa1caUFzkZlP3aHRrPuPZ9P0WKobqIW93GaTNQbcu4jAjpVE3qc/dGLjQJi9GaDzpA6t4T/3e9ltwnfhTM60k6WQsJnrLUlItfRxHLQSk5Mn5ZF1NE4HxHJLAaeNCRxlzuSVaOQddbWszDmr01mvZRg5UwkQy0bnHRxgQ==
X-Gm-Message-State: AOJu0Yx1h1lBBIlvJsVybLZE5RuDIvS+nxqGuyt2qa1+udjIfsjF2Di2
	lUheHONcEmb+ckPpI2P5cCiIvC1zMZz/nPH5eaDfFzLYLOiNw66U
X-Google-Smtp-Source: AGHT+IFge5Or486qU3fsqK7rfLez5SQ73WcKfauMIlXxu9FtbdydQ4vUXacBQgadwkO4rfqutytpBQ==
X-Received: by 2002:a05:6808:2126:b0:3d9:33c1:29cd with SMTP id 5614622812f47-3d93c07b12emr1018035b6e.45.1720491043284;
        Mon, 08 Jul 2024 19:10:43 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d61df022esm497370a12.48.2024.07.08.19.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 19:10:42 -0700 (PDT)
Message-ID: <f1053686-1eaf-4a84-af57-4d25dc5896f2@gmail.com>
Date: Tue, 9 Jul 2024 10:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
 MA35D1 SDHCI controller
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240704062623.1480062-1-shanchun1218@gmail.com>
 <20240704062623.1480062-2-shanchun1218@gmail.com>
 <d1422b93-b111-41f6-8537-a837a48e5743@kernel.org>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <d1422b93-b111-41f6-8537-a837a48e5743@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your review.

I will make sure to keep the same order as in the list of properties.

I'm sorry if I missed your comments before.

I will do my best to address them in the future.

Thanks for your understanding.


Best Regards

Shan-Chun


On 2024/7/8 下午 10:19, Krzysztof Kozlowski wrote:
> On 04/07/2024 08:26, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 SDHCI controller.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
>
>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to access GCR (Global Control Register) registers.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - pinctrl-names
>> +  - pinctrl-0
>> +  - resets
>> +  - nuvoton,sys
> Keep the same order as in list of properties.
>
> Normally I would give conditional review tag, but not that case because
> in the past you kept ignoring review comments.
>
> Best regards,
> Krzysztof
>
