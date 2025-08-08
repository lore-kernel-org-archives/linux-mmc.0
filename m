Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37904280037;
	Fri,  8 Aug 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664715; cv=none; b=Zlc/hRntwGMEetLJr37m/9FPc/Yv8tKu1rZbIIL8i0FUqqSPKnIjNVURUiQqXr4STvQQhemtI6vCZ4xtUYvw5EfM9yk6y40uzNxkZXgtFLU0Tog1wLZEXkl2Dw0roX13BCAt/eI4pAQzzTvbd6ivze6Dq4uFGHFk48kmsfoC1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664715; c=relaxed/simple;
	bh=075plO5JMPwnMH6/amdHG5cVw4hU+2wPHbNInNbrlE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EIyL10SkJnVNeOFIdT2U32ttXTnU7Jh+pGkcPMq/SePxlYWmWfU8xgcx4d8a2ewDVC3PRwvDTh2MwTHML7XkyoV0ZJRwBf2lmG4j1I3t9s1yKDKPzRJ8pRA8HxyM2ZT8cOH7pqHNWf0YQ3YI4yWI1pSNvFoWNM9jj1UiGi3J0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W9GqhBc2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W9GqhBc2"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578EpidW617288;
	Fri, 8 Aug 2025 09:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754664704;
	bh=xVBqPanUJUwJ6qp/cR831F5S2Wgr/hexcTikkyTDa6Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=W9GqhBc2p7xHirp7SgaGjlbphnX74Y6BZui1Tc3MMjGutz3Z97JN+6ShhJgTbz3GD
	 ZjLqblS2qaxF48pa34QIlkO3U8Ve85OcihKxHa73M/p8Q8RgGOSbcOrjP6v28EzAkx
	 IoaD77MtkSQnntKrHpDuAh9dCpJJbAxHAU55x5Us=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578EpiPN1699212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 09:51:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 09:51:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 09:51:43 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578Eph0s2902758;
	Fri, 8 Aug 2025 09:51:43 -0500
Message-ID: <4fdd0d2a-dbbc-43bb-9a31-18f5f1da3193@ti.com>
Date: Fri, 8 Aug 2025 09:51:43 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: ti: k3-socinfo: Add support for AM62P
 variants
To: Andrew Davis <afd@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250807225138.1228333-1-jm@ti.com>
 <20250807225138.1228333-2-jm@ti.com>
 <bac04814-ed8a-4dad-b5a3-72d0a2fc5d76@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <bac04814-ed8a-4dad-b5a3-72d0a2fc5d76@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 8/8/25 8:50 AM, Andrew Davis wrote:
> On 8/7/25 5:51 PM, Judith Mendez wrote:
>> This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
>>
>> On AM62P, silicon revision is discovered with GP_SW1 instead of JTAGID
>> register, so read GP_SW1 to determine SoC revision only on AM62P.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/soc/ti/k3-socinfo.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>> index d716be113c84..81d078f15cd2 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -15,6 +15,9 @@
>>   #include <linux/sys_soc.h>
>>   #define CTRLMMR_WKUP_JTAGID_REG        0
>> +#define CTRLMMR_WKUP_GP_SW1_OFFSET        544
>> +#define GP_SW1_MOD_OPR                16
>> +
>>   /*
>>    * Bits:
>>    *  31-28 VARIANT    Device variant
>> @@ -66,6 +69,10 @@ static const char * const j721e_rev_string_map[] = {
>>       "1.0", "1.1", "2.0",
>>   };
>> +static const char * const am62p_gpsw_rev_string_map[] = {
>> +    "1.0", "1.1", "1.2",
>> +};
>> +
>>   static int
>>   k3_chipinfo_partno_to_names(unsigned int partno,
>>                   struct soc_device_attribute *soc_dev_attr)
>> @@ -83,7 +90,7 @@ k3_chipinfo_partno_to_names(unsigned int partno,
>>   static int
>>   k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
>> -              struct soc_device_attribute *soc_dev_attr)
>> +              struct soc_device_attribute *soc_dev_attr, u32 gp_sw1)
>>   {
>>       switch (partno) {
>>       case JTAG_ID_PARTNO_J721E:
>> @@ -92,6 +99,14 @@ k3_chipinfo_variant_to_sr(unsigned int partno, 
>> unsigned int variant,
>>           soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>>                              j721e_rev_string_map[variant]);
>>           break;
>> +    case JTAG_ID_PARTNO_AM62PX:
>> +        /* Always parse AM62P variant from GP_SW1 */
>> +        variant = gp_sw1 % GP_SW1_MOD_OPR;
>> +        if (variant >= ARRAY_SIZE(am62p_gpsw_rev_string_map))
>> +            goto err_unknown_variant;
>> +        soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>> +                           am62p_gpsw_rev_string_map[variant]);
>> +        break;
>>       default:
>>           variant++;
>>           soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0",
>> @@ -121,6 +136,7 @@ static int k3_chipinfo_probe(struct 
>> platform_device *pdev)
>>       struct soc_device *soc_dev;
>>       struct regmap *regmap;
>>       void __iomem *base;
>> +    u32 gp_sw1_val = 0;
>>       u32 partno_id;
>>       u32 variant;
>>       u32 jtag_id;
>> @@ -163,7 +179,14 @@ static int k3_chipinfo_probe(struct 
>> platform_device *pdev)
>>           goto err;
>>       }
>> -    ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
>> +    if (partno_id == JTAG_ID_PARTNO_AM62PX) {
>> +        ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG +
>> +                  CTRLMMR_WKUP_GP_SW1_OFFSET, &gp_sw1_val);
> 
> This is wrong, you cannot read from the register GP_SW1 (offset 544). In DT
> the region is 4 bytes long (reg = <0x14 0x4>;).
> 
> This only worked in your testing because the above ioremap_resource() 
> has to
> map in page sized(4K) chunks and we didn't set max_register in our 
> regmap_config
> so no bounds checking is done. If we fix either of the above then this read
> will stop working.
> 
> So yes you'll have to make DT changes and fight it out with Krzysztof. My
> suggestion is to make a efuse region for the 3 GPSW registers and use a
> phandle from this node to fetch the extra info you need to get revision.


Sure I also believe that is the correct implementation and is actually
the way I approached the issue in v1.

But it seems like Krzysztof will not take that implementation [0]
https://lore.kernel.org/linux-mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org/

so what to do then....

~ Judith



