Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D672628
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064257; cv=none; b=CRLuaXg18231LY6RC6ZZcEZRQfIwgWIm1fHbvpi7yd4k7KwK+cIgEoHzycJErThtlNj+vqpUQL15yK8ovgz43fkBQkrr6KsVM2nMGgXIiWi0rTyK4Pc9544j1xwC35YlOYjMaDOfu5fFy/AvIrtLOH3+aIYZgtTVa6Rslfri9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064257; c=relaxed/simple;
	bh=SVNlz68IIT8b9yVQw+xofp80WWKKo5MkKmms7Dm2ptk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVFNPOJplTkS48sAEXMeuxf0IXSzRAjQltb8EktV8gdPAEs4EcqL25QURquMRkR7Xeui/SQ6UBoe4683XNKAoIufd7IlS1ahKrjAQ4r3Y3l40A2PmYER34S9GvkE/19fPBXIh2vDdNCeLswnf62YCFr2ySajGxZYexkMndHMfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il/ciA+O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il/ciA+O"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eec33b737so87267825ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761064255; x=1761669055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRzcTIyAA7EaA4ukA0+FnZHqzvKfstN5UrKhh4GSmJw=;
        b=Il/ciA+OBTkfdgQbCWgKDDpQF7jYH4XHbEaRhtaIpuPtn9USg+JaRK17kB0vBTFacR
         keb0A0nYw2zKppXKDNonPAFa4cvJP+vBpeYf18R6VkGq5j5QOpIEGSQpCeocCZmho2Vt
         zVrTuURN4KOmRmwNXbqPZLtLHwnNqS/q+W+PNpubPUqSbXJ9AZcZwVFw3OM86EGZe0dK
         xncq3HHqNISPWHkZl3aVHsp3KPEGnSMCqeA+vbUX+/1eUD3wlqHAZvRsvkJExTotsOXE
         0oxuwxZvPRRFJVidAKsbVUkOHpXOLxnYZBYle+B0U+3+zw3yUsHV+BYRIhXFd19YIom2
         LSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064255; x=1761669055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRzcTIyAA7EaA4ukA0+FnZHqzvKfstN5UrKhh4GSmJw=;
        b=sd3LvEb6PfHT+JiKU3I9aKkHEz7mpQRY4EI+JWw7a6GZBo3C+4Y7L0PGirs37l796O
         ym9cEW2jJBMNUCL8hD6ujUo80Wt+GNzJ1sHXhZ1CxXq8eHD4It1/VI4aJ7bpY6zDAZ5L
         0qgLHsOIh1fO1sFAUBL6+kGX6vEyhegTAWBtR9lPVEow2c50/KtRHqPyce96ckVrP7AN
         x37YsILInB8M9Bxi9Z6LeY4AL66aT+omrBCERTTibGUoJYe8LS18J7Mk/2frPRnSfW7S
         0/+sSvUVkNvpHdleDr0Zqy2juRiufRo/labL7OE2c4tr5ZON9qtrGFzACe7Kcp6VAtdl
         hpLg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPZCeMuKYtcKOnmpxsAv9QRkbR+WWhTgXV0fy098rz7wRCF4Fka/eisR83//DO8YtGxQVrUrh4eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgaqQNDA0oppoCq5A7j3VTdMe3xi+jSYqBCe0m8omLhHTmFSM
	3JZKE2wj3AxKaSS28Xab/xyOdhFMwZ1MCdDX950G3n2ZJ01MUZU2U4qjQTG6VA==
X-Gm-Gg: ASbGncvNcX+yB5mL2qfngJ6I3MxcratV7EQpWgEtzc9Ku6HjanPJvtU+oPZfi+b3ui9
	JArXzh1Y9MXucxT2ECCkAtG269SYAZv92xs8lOAzHVbEAs3bBefjq8wKgZw1vBulr7xJc0qekRb
	qLIv7VpX5fceF5u35DJyZhbnFUwSxo5n0kowP/tty/MvFHnIrpVX/HfaAdhgn4QCij9QfEMDQNt
	FSOltFzfMUpDX+6sAFj5r8ZUXPG5BEg+DXREe0ZvKRGYU4An+DMR8wDXRfDB+kurOp71jnuN0An
	38mJJ3zyHcSa6dGc4UhqmAAo9Q4QVosP9r4efqNBqWQIf7gGxOVPLWICGseqfnrm9znycDnYOgP
	oRP9BFFlnEaAcmkqvNq4rQAJ4RxgU/JDWhyda7xG1hva6Jgb4omd3gDwLB0n3A16NVDhLpBPIRH
	ILBZ5J76fnNDcc9U0OXx0AV12k4wRhyRhmBNOf
X-Google-Smtp-Source: AGHT+IE/VQ5Q/ofHnJ/j4KGul/sNoONvhN8n2T0Y/oKQlZXIOL9+d55LsvXpf3gZePHh+6OlOX6FiQ==
X-Received: by 2002:a17:902:d4c4:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290ca121e99mr250476425ad.36.1761064254788;
        Tue, 21 Oct 2025 09:30:54 -0700 (PDT)
Received: from [192.168.1.4] ([223.181.116.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebce3asm113645985ad.17.2025.10.21.09.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:30:54 -0700 (PDT)
Message-ID: <df11a312-0e1a-44b4-9781-54cbc8396da8@gmail.com>
Date: Tue, 21 Oct 2025 22:00:48 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
 <20251020142710.GA576827-robh@kernel.org>
 <46aa84cd-63cc-4263-9061-021fa3205b87@gmail.com>
 <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20-10-2025 21:28, Rob Herring wrote:
> On Mon, Oct 20, 2025 at 10:44 AM Charan Pedumuru
> <charan.pedumuru@gmail.com> wrote:
>>
>>
>>
>> On 20-10-2025 19:57, Rob Herring wrote:
>>> On Sun, Oct 19, 2025 at 01:04:36PM +0000, Charan Pedumuru wrote:
>>>> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
>>>> property typo for a DTS file.
>>>>
>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>> ---
>>>> Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
>>>>       disrupt the compilation for other compatibles as the node &mmc is used for all
>>>>       compatibles for some DTS files.
>>>
>>> I don't understand. AFIACT, "ti,needs-special-reset" is only used for
>>> the hsmmc driver/binding. But this series for for the sdhci
>>> driver/binding. So shouldn't the property be removed from sdhci nodes
>>> (and the binding), but kept for hsmmc nodes?
>>
>>
>> Yes we can remove that property from sdhci , but &mmc node in DTS is common for all mmc drivers and this "ti,needs-special-reset" property is defined there for one board, so even when I remove it from DTSI for sdhci nodes, the DTS file still contains this property in &mmc node which is also common for other mmc drivers, so even if we remove that property for sdhci node, we still need to define it in YAML to resolve dtb_check. The issue here is not removing the property from sdhci node in DTSI file, but to remove it from &mmc node from a DTS file which is common to all mmc drivers.
>>
>> Here is the DTS node (ti/omap/am5729-beagleboneai.dts) which contain that property and is common for all mmc drivers.
>> &mmc2 {
>>         status = "okay";
>>         vmmc-supply = <&vdd_1v8>;
>>         vqmmc-supply = <&vdd_1v8>;
>>         bus-width = <8>;
>>         ti,non-removable;
>>         non-removable;
>>         mmc-pwrseq = <&emmc_pwrseq>;
>>
>>         ti,needs-special-reset;
>>         dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
>>         dma-names = "tx", "rx";
>>
>> };
> 
> I'm pretty sure that's not how &mmc2 works and you are confused. I
> would suggest you do a dtb->dts pass and compare the results.

Okay, then I will remove ti,needs-special-reset property for sdhci node, above mentioned DTS and from YAML too.

> 
> Rob

-- 
Best Regards,
Charan.

