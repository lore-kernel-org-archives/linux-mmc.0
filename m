Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028D1A4F21;
	Thu, 17 Apr 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902359; cv=none; b=fBIJpDyXTeSDyTVGZ8+8ZSw0VXj/bBFzydfoz3s6hPyEgFmZsid5D+7BrGT8LI62SBu9iCLmsOqgX60iZWO0Z2L1oO7TCVOB+GGGrpvwG1kQJufbRsy7QdBUZAjDohxdH2sxS5wrNm6W733qJks3ZYe6H+RtYC/1KIvcV9nYHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902359; c=relaxed/simple;
	bh=irOKLa1Sthbz7vCcSRPqRYhkzGrhNXEN+2LtxGs29QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qncAJMEkGrnkKI4fXMgWEUdY0WSamm1DdQPFxzaV7AHxxYFZ1ZHuEkiwziqTYfZ6fTyhPXa3rwSYJy8qoRsIfBT8k//SGwQxfRK3o98AJirnhme2XryRxSFC6iP7KHpZMSPH+Vs403UCVzu190rheMUbuDMasO+f1+1m+C1C4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YpK6ZqUz; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YpK6ZqUz"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HF5k1o732499
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 10:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744902346;
	bh=xJC1a4GzB2Wp5Dc04jAoYGqUfmof66chQq2ZmQVaRJ4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YpK6ZqUzl4UZF1MKSHFW6DSmTZUY0VvClzQO9J5xS008R6CQXtn/FzxU5+FAU7Mwn
	 imTtRwiJgqyMNhQ2bUC4ksXcbx/KYKQnoIaCtdVtOnyXl35WJOiGKSejOc2G+KVbDB
	 uzKSyS4S4UoVooyr77PrStHGqMwudjPxLFo7toBs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HF5k8H066420
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 10:05:46 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 10:05:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 10:05:46 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HF5k3N101248;
	Thu, 17 Apr 2025 10:05:46 -0500
Message-ID: <0c029559-8c73-45ad-bf35-309e9c8a56a5@ti.com>
Date: Thu, 17 Apr 2025 10:05:46 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <3f31eded-4a7b-43f0-819f-a3be48cffc7b@ti.com>
 <da959d37-1513-4679-bb09-d08bdbe00fa8@intel.com>
 <48664ea9-f949-43de-8706-463e78afcb61@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <48664ea9-f949-43de-8706-463e78afcb61@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Adrian,

On 4/17/25 7:03 AM, Adrian Hunter wrote:
> On 16/04/25 22:11, Adrian Hunter wrote:
>> On 16/04/25 19:59, Judith Mendez wrote:
>>> Hello Adrian,
>>>
>>> On 4/7/25 5:27 PM, Judith Mendez wrote:
>>>> For all TI devices, timing was closed For Legacy and HS modes in
>>>> half cycle timing, where data is launched on the negative edge of
>>>> clock and latched on the following positive edge of clock. The
>>>> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
>>>> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
>>>>
>>>> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
>>>> requirements for TI devices so add a .set_hs_ena callback in
>>>> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
>>>>
>>>> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
>>>> specific Kingston eMMC due to the sequencing when enumerating to
>>>> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
>>>> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
>>>> the kernel, but was reverted due to the "heuristics for enabling
>>>> the quirk"[0]. The new implementation applies the quirk based-off of
>>>> bus width, which should not be an issue since there is no internal
>>>> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
>>>> effect timing for MMC0 interface.
>>>
>>>
>>> On this patch series, I am bringing back the fix for V1P8_SIGNAL_ENA,
>>> Ulf requested a change [0] which I am planning to do for v2. But I was
>>> hoping to get your opinion on whether Hiago's suggestion [1] is doable
>>> so I can add that as well to v2. Thanks for your attention.
>>>
>>>
>>> [0] https://lore.kernel.org/linux-mmc/CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com/
>>> [1] https://lore.kernel.org/linux-mmc/20250412132012.xpjywokcpztb4jg4@hiago-nb/
>>>
>>
>> Sorry for the slow reply - been a bit distracted.
>>
>> I'll look at it properly tomorrow, but noticed
>> sdhci_am654_write_b() already is dealing with SDHCI_HOST_CONTROL
>> and SDHCI_CTRL_HISPD.  Can you make use of that instead of
>> a .set_hs_ena callback?
> 
> Patch 1 continues to look unneeded because sdhci_am654_write_b()
> seems to do the same thing.

You are right, I will drop the first patch then.

> 
> WRT patch 2, the suggestion to add a DT property and check the bus
> width seems fine to me.  DT properties can be added to identify
> "broken" hardware that cannot be identified by the compatible
> string.
> 
Cool, will add this functionality to v2, thanks

~ Judith

