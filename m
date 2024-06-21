Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555315A863;
	Fri, 21 Jun 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952263; cv=none; b=C5cy+OV85uLvNHACosVHMwAUGS/Ndje/5ZBRtomW8p52aX/5Fvqv/5hrm7tC9NyCIKxrwS/vFdSUDbOxDoj0PWnv24eJUcNHdehiEDe5j19BoVhvWSb+3Hib7ayzTj72hfD2vO4kvbP+Gt7cQ2FMEME+RHT6s0W7BYLNPhB7HCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952263; c=relaxed/simple;
	bh=e8vsqUTPR8hmmzvnBxNMNmNl9t0csZwAExFhrGl8H6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLbH6tbBEx8GG7j6ebZM5dfq6s7daOXBZ8bRsFVUjG+6aQM+KPMsowxrJMuNhq+72IkevIYVOqkIe6+Kye5t/Tdm8n1KlKjA39qPH/vceB8t3ycYJpg4GDlr5intx09A+Li71gfp4lfHpvdbVqTqpXIDRRBf0s5n+Eaybj6xyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhsBvx0v; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhsBvx0v"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25980546baeso828719fac.2;
        Thu, 20 Jun 2024 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718952261; x=1719557061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w24n82/vIpX8B4Z/eMTSwnntz2rc9ZV12ox6TxguyJY=;
        b=mhsBvx0vl1lD/8SRgHpBrvba4MFjqrXakeFB702z5lDk4lTtnf+qR/H9uEqlWeSucx
         RPuhv8d5smrH+hy/8vKbnztds6G1Cuhw8+gUKsXM+iMPrekPJLvMImnqLRdtS4Vt+YJ1
         XD1MV8Ov/kH6+AcA/bk3fVPbu2LTkiwFJHnKsxvZfjnE/1Ur0c559h+IaF/9QV6iy8+i
         F+seGueXoZ5Ncd8YBvk6u34DzMZFNzs3a4AQDSgeD+36Fc/PPIGO54DAf6JVnXjLuIYC
         ye0APx4mgiiOUirKy+pFNjHMqDkUyY0YpBAYNiop4B6bR0L67plceBnEQbcSv8032tfn
         qEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952261; x=1719557061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w24n82/vIpX8B4Z/eMTSwnntz2rc9ZV12ox6TxguyJY=;
        b=eN4zFh3aPso3Yy1cyOURrhYojhxFBTE/vV6K/On5Txq8Cx6kuQ6Bs/NW/vgVw7tH3s
         ZTwcL0NqwFKIvmXUh7WMK7qEGUBsgAh8E70lflimndqA6YZXEa9l0xCBam7c9zeWbWer
         VzgxUpQIssCUNlV1kfK6C84DDCb0CDeYA6j8bulAZkJkitJVBfJBkM4d1teYpoun/vSH
         vGhsIV1UGKA5zUBdr2+vnUkKb4Rv9I5z2unNCfZFiYSoa9i9f29LPR2uAFwXqDLsD9NE
         pBP0tyH+mqRtbb/R3k0iBGFVIZf5A17HT6E/Jv+uooyv6ylIxOAaoQlkpZJtMwqSHcXz
         BlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrcBuZpghhofnXxyW5l/1FJBtNyCom7tjxuy5VPkmkaXNvYtLebsxv/ydDs3aVPFywxApub4byfEuEaigVwRy6+NvB1L41bNxFXgg7ytIRmQmGm7mhrDU+ZwE0pH9oceqKrQq+LWoIbUIAzll9wvRmFDuWvHp5hlCf2NpEhsDQzQoSBQ==
X-Gm-Message-State: AOJu0Yw5AMoMlILcqpblEfkSfi33xtQ4cXM6rmR+qkXXGT6fP8qjD82y
	tROwE/oo+MSBno7sQztwyCq7rF5e+9O4pybN0okMbZz2/jJZlgRg
X-Google-Smtp-Source: AGHT+IEANZZHgCyKdIftWd3cOp2dSGvWG7foIJAXLX+nyVQbywXPbr3RDWjgbnU4m/tFyceWACZ1kg==
X-Received: by 2002:a05:6870:b50d:b0:254:9501:db80 with SMTP id 586e51a60fabf-25c949a6b97mr8705807fac.14.1718952261214;
        Thu, 20 Jun 2024 23:44:21 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm515928a12.62.2024.06.20.23.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:44:20 -0700 (PDT)
Message-ID: <b6bda253-3fdf-41c5-934a-66b79c991582@gmail.com>
Date: Fri, 21 Jun 2024 14:44:15 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
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
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-2-shanchun1218@gmail.com>
 <3d193f01-2c8b-4d6c-8139-11f2d9a34d2d@kernel.org>
 <42ec842e-84c0-40fd-b6fc-e59d25ede89f@gmail.com>
 <f315c1cd-1f78-46e0-a86b-5240a869bb31@kernel.org>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <f315c1cd-1f78-46e0-a86b-5240a869bb31@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thanks for your review.

On 2024/6/21 下午 02:04, Krzysztof Kozlowski wrote:
> On 21/06/2024 01:53, Shan-Chun Hung wrote:
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  pinctrl-names:
>>>> +    description:
>>>> +      Should at least contain default and state_uhs.
>>> ? Contradicts constraints.
>> I will modify the description to "Should at least contain default.
>> state_uhs is mandatory in this scenario."
> Then just drop it. Don't repeat constraints in free form text.
>
>
> Best regards,
> Krzysztof
OK , I will drop the description.

Best Regards,

Shan-Chun

