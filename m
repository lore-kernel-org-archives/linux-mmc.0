Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1778C90;
	Fri, 14 Jun 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364652; cv=none; b=RCdXfVLLeETOLCTrWABD1fuOUoaSTMiCwZMEwZVmGyuq1FylVDLrChCpbiPZZ44YvcnZzOROApcnJYuwjdaql8hMFgqbA2QaQzV0yriUoczsX1NXBxfzG5FCPbE/eoRrEHVc1ihsZrZVbahOuYRXWv2fojgo/eZGdp7WWd354CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364652; c=relaxed/simple;
	bh=2dW9BLwG6oC3P28VKLtWY4CDOSlhuDxEzcX2A6m2FAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4SDEnqISWO4GT8H0G9HKuijZr+2Ax6FnQ+eVnRidHWEwK5h2CT7Xw3AhB5uLozr1MgGSZksuuvNGYs4h6Wf6e/scMXBzlZeX+1iEaQkPoRxDdyIvwp690PI6o8dhmcAMpIlqkV3Aok9CSWnxQ6bLutCTh4cnorAPJwGbUkCqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUsBVo+G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUsBVo+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718364650; x=1749900650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2dW9BLwG6oC3P28VKLtWY4CDOSlhuDxEzcX2A6m2FAk=;
  b=OUsBVo+GWamXb1L4KVGTZtdgm3Qb8r7jcFyn97gcjag3s4hoPU94Vb8J
   O+cwZyMkkPFr3C3sM6Nguf3i6bce+38oQwlXNvgoBnkIelUs/hLSAWVgV
   /+X0sm/MixnQhKHieGUEKanFRJVj2o+OWWCkYG/mi4QnQTzd2GJHPS/gH
   3mr2Pg0DpFHHMgcdgSx6HS8LMWREy+gpXLpi+1BhLYGsQg3aOEXcTcaR6
   aEPCtH/Q8u+mb3hZziJv5BhSbkuvBTcjDof75lEY49DBaPdr0LUEZYsCI
   haWo4XBkERkmoiwhXQJqPd5yAv9be94UfauZhKvlyl5kihK09crmBFg8W
   g==;
X-CSE-ConnectionGUID: w1lzoj/vTfiFo+mVfHlq1g==
X-CSE-MsgGUID: xesUAuJLRfu1T9xIDF3kDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15080030"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15080030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 04:30:50 -0700
X-CSE-ConnectionGUID: 3Y+9No+pQ2Sg390PXaImbA==
X-CSE-MsgGUID: NjnN7p/QQk6cvkez2JYdng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44845707"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.10])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 04:30:47 -0700
Message-ID: <576c8d7a-f1ce-4909-866d-b7f61d89682d@intel.com>
Date: Fri, 14 Jun 2024 14:30:43 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a
 suitable irq handler
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240530215532.2192423-1-heiko@sntech.de>
 <4015176.ZaRXLXkqSa@diego> <24c34023-e6c1-471a-ad0e-ee229cba8b3c@intel.com>
 <6504160.iIbC2pHGDl@phil>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6504160.iIbC2pHGDl@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/06/24 15:40, Heiko Stuebner wrote:
> Am Montag, 3. Juni 2024, 13:49:34 CEST schrieb Adrian Hunter:
>> On 3/06/24 14:26, Heiko Stübner wrote:
>>> Am Montag, 3. Juni 2024, 10:01:23 CEST schrieb Adrian Hunter:
>>>> On 31/05/24 00:55, Heiko Stuebner wrote:
>>>>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>>>
>>>>> supports-cqe is an established dt property so can appear in devicetrees
>>>>> at any time. CQE support in the sdhci-of-dwcmshc driver does require a
>>>>> special irq handler in the platform-specific ops, to handle the CQE
>>>>> interrupt.
>>>>>
>>>>> Without this special handler we end up with a spew of unhandled interrupt
>>>>> messages on devices with supports-cqe property but without irq handler:
>>>>>
>>>>> [   11.624143] mmc0: Unexpected interrupt 0x00004000.
>>>>> [   11.629504] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>> [   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000005
>>>>> [   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>>>>> [   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000033
>>>>> [   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000034
>>>>> [   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
>>>>> [   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
>>>>> [   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004000
>>>>> [   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>>>> [   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>>>> [   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
>>>>> [   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000000
>>>>> [   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>>>> [   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007cd
>>>>> [   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
>>>>> [   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f008
>>>>> [   11.742600] mmc0: sdhci: ============================================
>>>>>
>>>>> So don't enable CQE if a usable interrupt handler is not defined and warn
>>>>> instead about this fact.
>>>>>
>>>>> Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support")
>>>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>>> ---
>>>>> My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
>>>>> supports-cqe in their devicetree, which made me run into this problem
>>>>> with 6.10-rc1 .
>>>>>
>>>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
>>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> index 39edf04fedcf7..4410d4523728d 100644
>>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> @@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	/* Setup Command Queue Engine if enabled */
>>>>>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>>>>> -		priv->vendor_specific_area2 =
>>>>> -			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>>>>> +		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {
>>>>
>>>> ->irq() could be used for other things, so checking it for CQE
>>>> support is not appropriate.
>>>
>>> though here we are in the very limited scope of only the dwcmshc sdhci
>>> controller.
>>
>> I am afraid that does not justify it.  It can still create
>> problems in the future if that very limited scope changes
>> i.e. someone wants to use the ->irq() callback in
>> sdhci-of-dwcmshc.c for something else.
>>
>>>
>>> And at this point, any controller using the generic sdhci_dwcmshc_ops
>>> will always get the CQE irq handler, while _all other_ controllers
>>> will need to define one to handle the CQE irqs.
>>>
>>> So any variant trying to enable CQE needs to define an irq handler, hence
>>> the check simply was meant to not allow CQE enablement without any irq
>>> handler, because that will always cause those unhandled irq issues.
>>>
>>>> If necessary, it would be better to flag which variants support
>>>> CQE in their platform data.
>>>
>>> I guess we can assume that all of the dwcmshc IP variants support
>>> CQE, it's just that the implementation is slightly strange in that
>>> a DT can enable CQE support and this will cause the driver to enable the
>>> CQE interrupt, even if nothing is there to handle it.
>>
>> Isn't the problem that the IP may support CQE but the driver does
>> not for the given variant, but switches it on anyway.
> 
> exactly ... that is the problem I have with that accidential "supports-cqe"
> in that devicetree.
> 
> 
> The sdhci-of-dwmshc has already some
> 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
> conditionals in its probe function for variant-specific init, so I guess
> we could also just move the CQE init into those?

Those are going away, after which it can just be a driver data flag:

	https://lore.kernel.org/linux-mmc/2182f65bad83e394a7ffb9259b2c1aa130912961.1718241495.git.unicorn_wang@outlook.com/


> 
> bool supports_cqe = false;
> 
> if (pltfm_data == &sdhci_dwcmshc_pdata)
> 	supports_cqe = true;
> 
> if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
> {
> ....
> 	supports_cqe = true;
> }
> 
> Because in the end I would guess once every variant has check it's CQE
> support, we'll have all of them supporting it anyway, so that can
> handling could than get removed again.
> 

