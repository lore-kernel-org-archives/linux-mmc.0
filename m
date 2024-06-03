Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371488565F;
	Mon,  3 Jun 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415383; cv=none; b=fJ2vABIdcnfRW8nELg+57MA/FLJ6HmvmXrOp9PmaNRBTMhiM3dUFdBDA4hJPu+j5Y/ywtkE1EUzeVU2DptFtiw8gZpwuPPJgUY1q371tVYKzvUsmRzOgRawAI43o0bRjE9hZMfNRmB1ZPL4OutV/VjNWTGcHsqKnC94fSbWXz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415383; c=relaxed/simple;
	bh=EYwlkyIkShgRTxFO9sxXDpPvu7+p5hzz2VBjFZI9M7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofaacxukcE68obMcdr1YcQM1HP9h6klSKZsjIsnx4DruD2C47sKF1ivuF/pZKVuoIi8sbZsn+ran5/HuOdw4YVcz7owbsUS5W3s4EkfWGW8t/Sr9tfhuxBUjzNuH/VVjhepXdGvMoll+GkhP8pn90RMAryDyAhwH5d9x421Bll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT5zsNLL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT5zsNLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717415381; x=1748951381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EYwlkyIkShgRTxFO9sxXDpPvu7+p5hzz2VBjFZI9M7s=;
  b=QT5zsNLLM+9r7L76dGG6YtC9jvuOFR2AVfUBT0/SOCNDKclTzz4s/eIT
   xJFkEaVA5mRRYqqeLROe946ONgTZA5Jwijg3eiatVJIwC8VhVcCR/kVGo
   MS9KVLH7n3G7iHEkipF4T0O2ceqVv8Vt6zcI88YwzSyJdUq5R8ZjD8rMP
   HqHTctDzvSYGCsY613qB8YvLScxUi3WaP9YGIobCSsECjYp2R1erdfuPb
   Tcq1O+ZjtcFdCy0MNrxdizMdAdP2J6L1Vw+KQFosOMxBiJJiotqf7yyfo
   pH0KmY2fRdoXqwOwHbQ/cJwZiDh1czoXgsEsIrQMBWQ7QZfLPG95expY9
   g==;
X-CSE-ConnectionGUID: vzEjJwLjQkudpjFfmK0Y4w==
X-CSE-MsgGUID: 2TiDjhLjQ9CoekJpeZ7MfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13743066"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13743066"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 04:49:41 -0700
X-CSE-ConnectionGUID: ObewvQ1gTniBWdHXyC/+sg==
X-CSE-MsgGUID: TcIgYmVDRKCp5TxZIgeJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37474772"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 04:49:39 -0700
Message-ID: <24c34023-e6c1-471a-ad0e-ee229cba8b3c@intel.com>
Date: Mon, 3 Jun 2024 14:49:34 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a
 suitable irq handler
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, ulf.hansson@linaro.org
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240530215532.2192423-1-heiko@sntech.de>
 <55cea03b-e685-4f7b-a93b-cb464417d364@intel.com> <4015176.ZaRXLXkqSa@diego>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4015176.ZaRXLXkqSa@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/06/24 14:26, Heiko Stübner wrote:
> Am Montag, 3. Juni 2024, 10:01:23 CEST schrieb Adrian Hunter:
>> On 31/05/24 00:55, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>
>>> supports-cqe is an established dt property so can appear in devicetrees
>>> at any time. CQE support in the sdhci-of-dwcmshc driver does require a
>>> special irq handler in the platform-specific ops, to handle the CQE
>>> interrupt.
>>>
>>> Without this special handler we end up with a spew of unhandled interrupt
>>> messages on devices with supports-cqe property but without irq handler:
>>>
>>> [   11.624143] mmc0: Unexpected interrupt 0x00004000.
>>> [   11.629504] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000005
>>> [   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>>> [   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000033
>>> [   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000034
>>> [   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
>>> [   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
>>> [   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004000
>>> [   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>> [   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
>>> [   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000000
>>> [   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>> [   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007cd
>>> [   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
>>> [   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f008
>>> [   11.742600] mmc0: sdhci: ============================================
>>>
>>> So don't enable CQE if a usable interrupt handler is not defined and warn
>>> instead about this fact.
>>>
>>> Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support")
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
>>> ---
>>> My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
>>> supports-cqe in their devicetree, which made me run into this problem
>>> with 6.10-rc1 .
>>>
>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 39edf04fedcf7..4410d4523728d 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>>  
>>>  	/* Setup Command Queue Engine if enabled */
>>>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>>> -		priv->vendor_specific_area2 =
>>> -			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>>> +		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {
>>
>> ->irq() could be used for other things, so checking it for CQE
>> support is not appropriate.
> 
> though here we are in the very limited scope of only the dwcmshc sdhci
> controller.

I am afraid that does not justify it.  It can still create
problems in the future if that very limited scope changes
i.e. someone wants to use the ->irq() callback in
sdhci-of-dwcmshc.c for something else.

> 
> And at this point, any controller using the generic sdhci_dwcmshc_ops
> will always get the CQE irq handler, while _all other_ controllers
> will need to define one to handle the CQE irqs.
> 
> So any variant trying to enable CQE needs to define an irq handler, hence
> the check simply was meant to not allow CQE enablement without any irq
> handler, because that will always cause those unhandled irq issues.
> 
>> If necessary, it would be better to flag which variants support
>> CQE in their platform data.
> 
> I guess we can assume that all of the dwcmshc IP variants support
> CQE, it's just that the implementation is slightly strange in that
> a DT can enable CQE support and this will cause the driver to enable the
> CQE interrupt, even if nothing is there to handle it.

Isn't the problem that the IP may support CQE but the driver does
not for the given variant, but switches it on anyway.

> 
> 
> For my own case I can also just live with the Rockchip irq handler
> patch going in (ideally as a fix) and I just wanted to try to fix this
> will definitly fail if irq-handler not present case.
> 
> 
> Heiko
> 
> 
>> However that would probably mean introducing something
>> like struct dwcmshc_pltfm_data as described here:
>>
>> https://lore.kernel.org/linux-mmc/ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com/
>>
>>
>>> +			priv->vendor_specific_area2 =
>>> +				sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>>>  
>>> -		dwcmshc_cqhci_init(host, pdev);
>>> +			dwcmshc_cqhci_init(host, pdev);
>>> +		} else {
>>> +			dev_warn(&pdev->dev, "can't enable cqe support without irq handler\n");
>>> +		}
>>>  	}
>>>  
>>>  	if (rk_priv)
>>
>>
> 
> 
> 
> 

