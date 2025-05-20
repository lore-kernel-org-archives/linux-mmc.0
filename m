Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563737160;
	Tue, 20 May 2025 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717899; cv=none; b=QGfgFAdddDmpiWVG9B3+VNlUsF/YtgDC/3M4lpB9t8x+X63CMeTMbElsb+NIrgh5a5L1vlykqCrmHcas/KwZT4X9sTnIlbbLhC/lHCMQLsX9EMpjG+/Eqt9qlA2xMyGlXJ94q+e+nvnhRdDRCdDLNBFu62/EVzyuK/u2xWmvq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717899; c=relaxed/simple;
	bh=HdEsU/vKDhUc8Tz+yA+qkYHOA5NaaS3F+dEaMd7qq5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHE98vwVOxjeSMa5AtKbdeJgqVKomFj0YyOcgRfOInM+9tEvIVJUw47QR9WaMSeawXdIxkdC5vlezRVIANBgKG/iwLcLHyZUbPfdjljKY2yO4mYHiuIZgSGWNCa9sDf+KuWi1fOLXHIdLP0GFDqAzoj9rHrnQc8OrG9pwfzDmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4CszZvF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4CszZvF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c9907967so2048291b3a.1;
        Mon, 19 May 2025 22:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747717897; x=1748322697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RErO6BFlJ5rM/uW4yaFT4DzP3zQVUN3N08kf90qHkk=;
        b=m4CszZvFU3EOMP6jMtBjrQ8eIeSp2yKf+FoMmA+6gWJAEtB+zIKqNfX/LV+5v9zVMt
         BEqG1XHjiMFoRuaiI+gSUIWW3QahK/tz4wqHZZEuoeNkFtae1E4Ch5dIvtm5pmTh1Yru
         hl1kzLRdIuFy+Rw+YIcQLMkCPe0tc8/vGbHG/rSq6R1R/ordV4BDIRlw85e+Z97L9zqy
         gk6xEDG4aRwqCC+R+Zy5pLmsnd2zO2HV5JKR3Z70E2ToTEJvNIvLcp+idUa4VyNm2Q8Y
         LP/ClP0H1unX+p9ZiYrAEd7ui28ejYruAEIu2/RlEn4nC+uqUfr3HjZc2GASzLpvIVKM
         zayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747717897; x=1748322697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RErO6BFlJ5rM/uW4yaFT4DzP3zQVUN3N08kf90qHkk=;
        b=IaEHh4UYKyBh6sAmmF4PzDrHZfG2D0/LQ/IsqYSi4NreDc5V9t42sKGa8ZmYmsZ7I3
         VnnSK4myxqOQ9lTHBwPiaKz8bYBodqyW9DGFYL8+x17Cnyw6+YgUwDGPMxWQdABZCXrs
         h5UohfNECwHxJcvg01jUorvtklccoeO4G2IZ4naZXBQhEWPy/4w/2l34WAw6zXridAz6
         9zu4/p0f3p2Ry+bhL+v0eqzX/TUwUNITbGm640F2Xw3+XHarsf4UPdt4ggXX3c+u8l/d
         9gs8owmRAegvRP0oib1Di1T2lr307WThjTBiBE3fnZ+wcK3TVJdzLHT00CtE09jFDWlX
         024g==
X-Forwarded-Encrypted: i=1; AJvYcCU+Yzk/6ivD2zkSpaFrzHgE74gwckLcSEABPI9VYt4B+HM1pr3O1V4aJttfOfAcHQM+iV/TH9ec6xNjV4O7@vger.kernel.org, AJvYcCVDoy4UUUZ0iDgIwreXXD7E5IBRd44wBp+7BOMuJ0/Y3hPLyZrKfw3uYfA+gTcUHT6tgIx2OwHMyp45@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vhtrAVLEGQATs/1S16o8UG7z9nKEOTlgAkzG5xvlKltc2Ky+
	j0JiM4ade+QVkNZ3A16ZxXyXtEtZboN8WVHrjnUUsDXxVHAnrr9181G1FquGag==
X-Gm-Gg: ASbGncsR1a+dKUMYGhY5LGKfLYcXVyt5fI4AOxZC4KfKYjpFSK4RGx+gNAKGTilSMwH
	3tv8DUBKPacf+H1cPgGm4CYbSMwUiYjoMhMVFwu3KrSdGgnyEGBW5UCRdkyLW/jn39u53AZ8MZW
	RF3lCY3sa9Vfk7jMEXmL5pQv7dE0UTeNQdHvSLuiteO+Gj/3sPg+OWKTGOuUiRxOCIOrK4Qbbs9
	yrZeUAgC/3k2CpagAixGi18KmCHhaV0c0+goSvilpG9Q24bjroMlSoQr4MCDUCCWoCpAzaiSblW
	PExGL5A2OiqjDS9dG+NK8261LtG9whXuX9qe76mhixSN7Uit2aiUrg2tV8us5IpXFQ2NChQqRg=
	=
X-Google-Smtp-Source: AGHT+IEWTUNR2FRJIka6CyDy9SWDCxKCJ+8wbGCOhL82yEnOfAldWJP5tTVsjxdQFJpZTAt0DI716A==
X-Received: by 2002:a05:6a20:3d83:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-216219c7ff4mr27248129637.34.1747717896780;
        Mon, 19 May 2025 22:11:36 -0700 (PDT)
Received: from [192.168.1.6] ([27.57.94.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf70df5sm7151896a12.28.2025.05.19.22.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 22:11:35 -0700 (PDT)
Message-ID: <97474249-7d4b-4a74-b2c2-13b89db1dc6f@gmail.com>
Date: Tue, 20 May 2025 10:41:31 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
 <6a3a7e99-8d45-4e44-8014-14d182de5dd6@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <6a3a7e99-8d45-4e44-8014-14d182de5dd6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19-05-2025 21:36, Krzysztof Kozlowski wrote:
> On 19/05/2025 15:11, Charan Pedumuru wrote:
>> +
>> +  ti,hwmods:
>> +    maxItems: 1
>> +    items:
>> +      type: string
> 
> That's not really correct. That's just a string, so no items, no
> maxItems and use proper ref, not type string.

Okay, I will define string definition using $ref

 
> 
>> +      pattern: "^msdi[0-9]+$"
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - dmas
>> +  - dma-names
>> +  - ti,hwmods
>> +
> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

