Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4428FABC;
	Wed,  6 Aug 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493879; cv=none; b=a4j05PnMVYVtwRRg3hXn/Zk9B/C0tKufkoXfSZdK+NXd+89LixdjWHk5ZlKsz+8x7asNXcV/Yv4Z2KxhfuYCwDByVsQSYIt6XJ0H349Ir840latyPlv2vzcrBeuasGel0NRr2QJRXPmyYBqayLd8OYaycWMt43KN7rhKi7+GD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493879; c=relaxed/simple;
	bh=IPrjJM0iNDTDA9YSrop9GNcDQsARPADzizUa+drioNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rWcNmB9he6exm8Mfyt3TudOzixQ00FM+1C57vhWK670NKfwRrQDZLCtWeW/IDuvVGAfa2PTe6/nGpZmWpsMxxsFkt6uLBlT6L0CjRVmWsldRICUeafEuqDgQIlquPQyH6l9awXxbuVinGK1zU0h3N/A8X55QU/jzDHti7Mhkgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hzsO1BXe; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzsO1BXe"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576FORiO603713;
	Wed, 6 Aug 2025 10:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754493867;
	bh=7RsgK39bZGGSX6h47xkhxWwFZ1ITqr8yrpYQjfJ5U7g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hzsO1BXe0Wzvoo9dSBV6u7zuoy/ZcmqIENibhejADzSxWaFki3CNbIurssoKE8dD4
	 Ia5BMXZdr87A0hKdGXlE82F8wmtPzv+nShj5MkTPS76O2m22G0hikaTcLgN1w82z81
	 YLuGVEo/iKGes8G1thXOAJTRimOpXrbKPf+J7cI0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576FOQe7122291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 10:24:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 10:24:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 10:24:26 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576FOQI53740880;
	Wed, 6 Aug 2025 10:24:26 -0500
Message-ID: <e9394117-996c-4134-b9f2-50accf633601@ti.com>
Date: Wed, 6 Aug 2025 10:24:26 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: hwinfo: Add second register range for
 GP_SW
To: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20250805234950.3781367-1-jm@ti.com>
 <20250805234950.3781367-2-jm@ti.com>
 <0f1cbec6-6032-48f6-8887-e526484c0d20@kernel.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <0f1cbec6-6032-48f6-8887-e526484c0d20@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krystoff,

On 8/6/25 1:40 AM, Krzysztof Kozlowski wrote:
> On 06/08/2025 01:49, Judith Mendez wrote:
>> This adds a second register range in ti,k3-socinfo. This register
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

I can reword this.

> 
> 
>> range can also be used to detect silicon revisions.
>>
>> AM62px SR1.0, SR1.1, and SR1.2 can only be distinguished with GP_SW
>> registers, so increase maximum items to 2 for reg property and update
>> the example.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   .../devicetree/bindings/hwinfo/ti,k3-socinfo.yaml        | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>> index dada28b47ea0..3b656fc0cb5a 100644
>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>> @@ -24,7 +24,8 @@ properties:
>>         - const: ti,am654-chipid
>>   
>>     reg:
>> -    maxItems: 1
>> +    maxItems: 2
>> +    minItems: 1
> 
> They always come with reversed order... but anyway, you instead must
> list the items with minItems.
> 
> another problem is that this is not supposed to be per register. I
> already complained more than once about some of TI bindings: stop
> creating device nodes or address spaces per register.
> 
> That's one address space.

That does not really make sense. Registers jtag vs gp_sw have a
different back-end, one from silicon and another from efuse. Not even
sure if the memory map will always be the same across processors.

> 
>>   
>>   required:
>>     - compatible
>> @@ -34,7 +35,9 @@ additionalProperties: false
>>   
>>   examples:
>>     - |
>> -    chipid@43000014 {
>> +    chipid@14 {
> 
> And this was never even checked :/ You have clear warnings here.

I will double check this.


~ Judith

