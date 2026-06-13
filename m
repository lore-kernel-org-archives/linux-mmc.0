Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2D374739
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334577; cv=none; b=IoqSSwRiTaFmOCZzI0x0xFDSfYlQVnlhXPeTk7MM6I1+W9qlCFBUAF2X3losQr2mJ05aaqkZNXv/3NB03WG6GaDAVJ1dfjTvD4YBdnK2s+LkeJqohHOP4aNf+xqyfraZui1CiC41QOiAKmaKphLY77Wt5MoF6YOw3mJZnKdglLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334577; c=relaxed/simple;
	bh=0VWkmQdyK+ohkbIi8obIRcQ1CwP55X4i56+QKTQOCq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXgHf9zKwwNV/1RI8GSzADlnpJZ8jvhvTbW9qPCRkLmZsnOlC8bK7UW63D3YYjuaMGgVf43POiG019oZo8GaYjvMPLDacRsvXMDwPe6Bm9md7verZ4/bPkv+jriU4djHIuzuD3l0m1zkSWzv40PkeSkseNbxNVB//xWS0NadhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klzilNZk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klzilNZk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso1098259a91.0
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781334573; x=1781939373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqSQR9XwXClJ1dx3NWVea2VA61Fsyqn6eOD6/POM3iY=;
        b=klzilNZkRCFWkPmqVz30PTaZLtUjaXlaKNrdEiGPEJDTgfEbROSudIX4Kn9mQyNlxG
         cRCtM5LeBxYiMj6pqVx+BOxu1KFeE7a8XTimtfut+VxJ+zV8TnF5eVG8frMohJjQ3X+z
         jNT5fVgAoW4d7Fw2kPQWRXd9XiQyikQcHRqtVCAwZV9QztPrqwmR202D9lYwb9b9iFFe
         SE+2+hGI+ce/043Sgyy9K6Ffly2RkDUuBP8/B2Kl5eqqTleQTe2tB3VKL6gmmdkVjqtU
         BJL9C1gU43ePZ4ytcD+aDl68rqC3oWRFt5aEpUbMBmzu7+zvcEpJmtOq1PhN1YUUlXO8
         hXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334573; x=1781939373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqSQR9XwXClJ1dx3NWVea2VA61Fsyqn6eOD6/POM3iY=;
        b=U4kn1+xwdXQ2iX3PCqmWqyII2guR8M+Qj6dFANevNWhHj73ayJ9FkXC2sPKpnIHgg8
         V5nlBWqlv3obO895HLmu1dV//KO/KvpoGx2Vgh5Q+fFP1D3RTQbJRa76vobg8TgtmHHI
         8V3s2CZtRrmkVRe8VkK9sOHEysDf309KpjegJnpVo0bEdIG5URlv0UNY4beW/hgNzt8p
         ZZEsP+l8FPO11xMIu7JjY16KAWqF0BQqWAinaG0VQM3KdrtbNqSDHwAWbjmBm8ojLGyZ
         12fAXHYW5kwjsEOOqa7Sz4gqfEjP3UoucU8xOAB91t62CxXP3VaVEebmuYPR4gQZnAVX
         vb5Q==
X-Forwarded-Encrypted: i=1; AFNElJ99GenA0ERw2t5wlKQNOFo7Qm3IWrQtdFJ4BvT1VsVNsnLIxd6voOkJgCv2r4A7J3RzCFPsf6hMvN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDbs1JVenqFExEZUEJzAkOwEa4l1sq/+9Tg/9CJDiQgkYYaIn
	wFnbmhwfYuszFgw2ndfVCqolEg05qYvLy8Y/t4V+SnlH+WT4JGOuX9Ea
X-Gm-Gg: Acq92OHlo7iI7qwkavw3uE9VCZud8TwZ3bKVDL1gH7pXJvRHfxK1O0QKP1xn9HHhKNc
	AjVfIB/D5hvf/p7xalg0TjpBY1K9U365yOS+XetLsZ5R/XUERXrJjf2pp9z0vnvExWkKDMFskia
	vpt8d4S+O5VHnwQl6wpNC4Yodr5mXI7FZG4+7Z2Nyc0tgtaWmVnkH83sVAGD8TkAQR9sitBZy8R
	LP0qKsGeEfOmOjtWTuQGgh4enDJGVcyy7RXNfvJaIGgy8fYPsEE1bTpwteIrrNGpHe/3QPTFUnK
	16YZKBpjKP6l8VBTIusuWLk02j5PFol6wfFhWkyKhQp5TRCx+LbAl5QTmzBxgbJmEoYhH2oqWWo
	l9cOWhglvNCw0OzfoO3EfrwehOrHhLwcGdrqS0t1vi2j7GK6cdhaCf6O0CVVcUrpNfU3rmmKPdT
	UN1O+yvfmfMlmFu5eW8im1KjHOhtR9c+rEl0S8gG0SY6a7
X-Received: by 2002:a17:90b:2d4b:b0:368:ed26:15b2 with SMTP id 98e67ed59e1d1-37c2bc65207mr2649723a91.8.1781334573307;
        Sat, 13 Jun 2026 00:09:33 -0700 (PDT)
Received: from [192.168.0.8] ([49.207.61.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1f363409sm4369435a91.8.2026.06.13.00.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:09:32 -0700 (PDT)
Message-ID: <f3e1ecce-9917-456d-b02e-a75827d9c867@gmail.com>
Date: Sat, 13 Jun 2026 12:39:27 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] dt-bindings: mmc: st,sdhci: convert
 STMicroelectronics SDHCI-ST MMC/SD Controller controller binding to YAML
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
 <CAPx+jO9woUB9VGUx+ebWD9oOhqCwzXL9=41MEesnWS15Nyr66g@mail.gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <CAPx+jO9woUB9VGUx+ebWD9oOhqCwzXL9=41MEesnWS15Nyr66g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29-05-2026 17:40, Ulf Hansson wrote:
> On Fri, May 8, 2026 at 7:23 PM Charan Pedumuru
> <charan.pedumuru@gmail.com> wrote:
>>
>> This patch series converts the legacy text-based Device Tree binding for
>> STMicroelectronics SDHCI-ST MMC/SD controller to DT schema (YAML) format.
>>
>> Note:
>> The patch "dt-bindings: mmc: st,sdhci: convert to DT schema"
>> depends on the patch "arm: dts: st: align node patterns with established
>> convention". If the DT schema patch is applied before the DTS
>> cleanup patch, `dtbs_check` will fail due to the presence of the removed
>> properties in the existing DTS.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> 
> The series looks good to me, but awaiting and ack from some of the dt
> maintainers before applying.

Yeah, but until now they is no response from anyone.

> 
> As the change in patch2 for arch/arm/boot/dts/st/stih407-family.dtsi
> doesn't seem to cause any conflict from soc maintainer trees point of
> view, I can pick this up too when applying.

Sure.

> 
> Kind regards
> Uffe
> 
> 
>> ---
>> Changes in v3:
>> - st,sdhci: Edit description of reg property. Modify reg-names. Add
>>   "minItems" for clocks and clock-names properties.
>> - Modify the commit message to match with the updated changes.
>> - Link to v2: https://patch.msgid.link/20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com
>>
>> Changes in v2:
>> - Fix node name in DTS for the MMC to match with the estableshed convention.
>> - st,sdhci: drop unnecessary properties, modify "reg", "reg-names" and
>>   "clock-names" properties, include an allOf with $ref to mmc-controller.
>> - Link to v1: https://patch.msgid.link/20260409-st-mmc-v1-1-4c54321c3535@gmail.com
>>
>> ---
>> Charan Pedumuru (2):
>>       arm: dts: st: align node patterns with established convention
>>       dt-bindings: mmc: st,sdhci: convert to DT schema
>>
>>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
>>  .../devicetree/bindings/mmc/st,sdhci.yaml          |  91 +++++++++++++++++
>>  arch/arm/boot/dts/st/stih407-family.dtsi           |   4 +-
>>  3 files changed, 93 insertions(+), 112 deletions(-)
>> ---
>> base-commit: cf2cd8efd046c561191b8541d32a8bfe845bf06b
>> change-id: 20260327-st-mmc-c906ad95ff83
>>
>> Best regards,
>> --
>> Charan Pedumuru <charan.pedumuru@gmail.com>

-- 
Best Regards,
Charan.

