Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037A22C322;
	Wed, 21 May 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807152; cv=none; b=SPurpHV9KcVFSc4gxgx8sRxR8CoqZY+W0ehAlTKj35+17HidkzcKmQExztVumoCaeoDlWeE9tR0KrVd9Cae7I/9OVOT7FWFaNTRlCnhQGVdTsGHOyDg3oUKO4LNLZoH3dBLQeaDn5VdiosPzkJ/1vdRjMGnoQnueHPdsCPtkmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807152; c=relaxed/simple;
	bh=LVhrHR1tMcLhhW2UavkcaIXMLFZu0WczRHk5PM8pUj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laZAhLkHW0glHOQ5rHJV1SXXSPQMWCYXhA9Hys66ZtG4aHkls2Yzg0vljkOdYURi5O955UtheX7e7t8n1bZGGhVr0WeG062cHaR51btTSOGiaxivQ4N85K8LI6Wam18wRiBwxmuVmKcqIDq8qBDQFzhGMVWfH1gun1Loh/KEjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e10tuhm3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e10tuhm3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231bf5851b7so49623365ad.0;
        Tue, 20 May 2025 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747807151; x=1748411951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SEan474ZhQBei+HXcPzrBD5hupQQ2unpzXgj0fBG4Q=;
        b=e10tuhm3MMu+XWGVYaVjN+TP9UHSCVRJPg65MJWFeXCJcIjYHtO+h2U5eao8mny05o
         6ezziL3IL+seRpG33JOejXWxOb1xP4Mn3ljxMIuZXA3fRIS06NvMUX4oIy+HcOB5CeDe
         ufRaSeI5ChveNUQkwdw4UkWQ7L7wqjMG1Tbg2jdLzYJym2QfhctzPyMzpMfh36Kz+Myf
         8FYrwzaRPlTrp0xe92Gwn7NfmWmT/ifMeUO/NwYAfCLSG7eopJtEAAOPb2Co93sWEtyX
         IEJhfdFDcx+7wCKvu0MRuPggJpQ+e3wk7XgPqBKEEb0G6FiI/ysoWU28QyYbv1svSxT8
         63lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747807151; x=1748411951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SEan474ZhQBei+HXcPzrBD5hupQQ2unpzXgj0fBG4Q=;
        b=lsHihya6SIwsSXhzO3JLMmRJBxyKnHkIAnXdzB5KGCq7Gv1EK9bsFliZ5IEZubsFuF
         X8qgIzf9JIBPnq1iTHxs3/qJuz2NIm0310FQT3JjKuM++ZDmhZE7jk26XlLB2hHxwMRr
         q3vZw94CyviJ6AVDlxkywwS0lZUrQ2RlcitoMkyZOqZbiDXKDaU0CumFWdUzc+7Lb4NR
         LclnNNoKEyrDuqKwxwKlYnOjhg0uSI7qgy/pWEH02mHk1aYf+cO3HDJRayTLSgiAyv27
         ZV5LboknZ8OIovsFo4Hdr2j+48BYg93C0x/JTAiM2T47TCbvNV5PhD9ccxFD6H/tQiMi
         +t0A==
X-Forwarded-Encrypted: i=1; AJvYcCXC1HOPJpkQQjE2cLg58bG0aATEGX7rZlp5TDvNp8qMenkbSQ7HXApTOQbcVemAExvv0JnLQNcoHG5yloy/@vger.kernel.org, AJvYcCXo4UfnlG8ZrQH/4OHnplfeJYJ9pTJyPEp8TIQ0kNknRz+hLB9QfIF1sem8eKzI7jxRf0QEnERL6quv@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxezjMKQbtrNXMNnH0IpwbHiTJRYcSIA2qMzXlHWqky5p4KrF
	4uNb/q9hP6enJzevTi8fziNa0lJj50q8bdpo09cIcrRG/z9Hql0Knw/UogG4eA==
X-Gm-Gg: ASbGncucU44JWOuIhuT50H/XexwfM3g9YnUN7mUx97KZQEBFKIDvA3jZzPt/Wj8GSvM
	w8xLl3Oq/yAewcXZZ/HDIMJ6I3H2dC727tyrmbV773deJ9aVgKSgyrMWvG5C5PH97P1wPgf+rJf
	Zmahitev3quF/DpIGdo5qmUlAMMQ07BaK9/d3MqxEWIUQGjIsTZrc3zk+N8jdaicRFq+lWsiqWH
	cdWHzOCkC43qfbovnADdQpuCHLDlSW7cKQOctiGx3ddvLmeCRiRhFfCc+lP9m4SqxkyvB9S2ZnE
	vRrz4spSNnqz6k0m21XKsfh6O4bTIKVwcLPXru3QC49fnHysIp5gyGqqYmszvB1+O8Ek5SjBL06
	67g==
X-Google-Smtp-Source: AGHT+IG35nUtpeW7NuqC9GunoFabQ0VrXDY+Uf8O8KYSnhJwYUYJ040n6Z3Fc2zkgCvgBJKQouvNCg==
X-Received: by 2002:a17:903:428d:b0:231:e3f9:dd53 with SMTP id d9443c01a7336-231e3f9de00mr223599395ad.53.1747807150541;
        Tue, 20 May 2025 22:59:10 -0700 (PDT)
Received: from [192.168.1.6] ([110.227.160.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed25a9sm86211035ad.223.2025.05.20.22.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 22:59:10 -0700 (PDT)
Message-ID: <ac396bdd-fc7b-4322-9eb0-7c361914c35c@gmail.com>
Date: Wed, 21 May 2025 11:29:05 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: mmc: ti-omap2420-mmc: convert text based
 binding to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250520-ti-omap-v3-1-aa845b301c4c@gmail.com>
 <f0ae042a-7c38-4e9d-9664-157afd861c3c@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <f0ae042a-7c38-4e9d-9664-157afd861c3c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20-05-2025 19:39, Krzysztof Kozlowski wrote:
> On 20/05/2025 15:12, Charan Pedumuru wrote:
>> Convert TI MMC host controller binding to YAML format.
>> Changes during Conversion:
>> - Add new properties 'dma', 'dma-names' under required.
> 
> Why?

Actually, dma and dma-names can be removed from required, so there is no need to add any new properties to required. I will remove them.

> 
>> - Define two separate phandles for 'dmas' in the examples.
>> - Include appropriate header file for interrupts and use
>>   it in the examples.
> 
> Examples are not the binding, so you can drop last two items.
> 
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>> Changes in v3:
> 
> 
> ...
> 
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  ti,hwmods:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      List of hwmod names (ascii strings), that comes from the OMAP
>> +      HW documentation, attached to a device. Must contain at least
>> +      one hwmod.
> 
> Description does not match the property. It is not a list and where the
> hwmod below:


Sure, will change the description.

> 
>> +    pattern: "^msdi[0-9]+$"
> 
> I see msdi - is it something different?
> 
> There was no such description in original binding, so maybe you are
> changing something but anyway it should be correct.

Normally, it should be mmc, but for this particular binding it is msdi or do we need to change it to mmc for ti,hwmods property in dts and redefine the pattern here?

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - dmas
>> +  - dma-names
>> +  - ti,hwmods
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

