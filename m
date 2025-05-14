Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E22882A8;
	Wed, 14 May 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248271; cv=none; b=UAHkOeORFW3Xqd7ssq9ypcb40INNzob1mdIKM4GThxNUD8j5QxmNN/cXyPxcKEGUXT0pGsz9tI4zB3Y9ZXG8VRBTszUxBG5wl/vyN0sZsji9q/evJBYUz9uwWgogRH0Ct7fPxqQAC57ExK+Slcl8E96JjgSERn8AOntNuvGTwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248271; c=relaxed/simple;
	bh=Cfm72KHPHjpJ3mEVdxevFjdi0RZmu1Tw2rX5MxcaV9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gM32Q8lq//g9BNqgmWNc4AY+Ic7KtGRA1LQHw+zEunxp1sMueucp7hHOBWkA1WU3YBQ6IRwr1GWaahw4MUcILP/Ko+LmFIIrO3vIusj073rXZG5zBFgpXq/hKDWSlXlxf040SsjHi77sczGxNQju9LOP5yKxOfzT+oksHp258L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fiDx2PUw; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fiDx2PUw"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54EIiHq93491750;
	Wed, 14 May 2025 13:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747248258;
	bh=j4huf+pjoLBdGdp5HHE13FYd6EiUoz1nox0QBs0LEos=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fiDx2PUwBd6vkq74f6eTISYXaf9I/kMg9MB5Cc78GmaVQDdh3a007JIjMxTjSM1aA
	 4DVuQWGwCNvL/u3AVHnp3Jcjc9UiYlHh+TX3fPZ8OtVAHqrmHyWooVlp3T0O3zGY3g
	 NggJNXgCXP1BCHflfmkYow1frpFTvDCXwqZZMuoc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54EIiHbI2335529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 14 May 2025 13:44:17 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 May 2025 13:44:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 May 2025 13:44:16 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54EIiHnw049959;
	Wed, 14 May 2025 13:44:17 -0500
Message-ID: <483c7c41-4dd4-4ab8-ab09-bd301de2e540@ti.com>
Date: Wed, 14 May 2025 13:44:17 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
 quirk to am62 compatible
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
References: <20250514002513.1179186-1-jm@ti.com>
 <d3222aeb-4920-41a2-a8d7-2551115ab776@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <d3222aeb-4920-41a2-a8d7-2551115ab776@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Adrian,

On 5/14/25 4:10 AM, Adrian Hunter wrote:
> On 14/05/2025 03:25, Judith Mendez wrote:
>> Add a new struct for platform data for the ti,am62-sdhci compatible to
>> apply additional quirks, namely "SDHCI_QUIRK2_SUPPRESS_V1P8_ENA", to
>> host controllers with am62 compatible.
> 
> Could add:
> 
> Note, the fix was originally introduced by commit 941a7abd4666
> ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch") but was
> found to be applied too broadly and had to be reverted.

Sure I can add for v6

...

>>   
>> +static const struct sdhci_pltfm_data sdhci_am62_4bit_pdata = {
>> +	.ops = &sdhci_j721e_4bit_ops,
>> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>> +};
> 
> sdhci_am62_4bit_pdata is the same as sdhci_j721e_4bit_pdata

oh right sdhci_am62_4bit_pdata can be removed. thanks. will fix for v6

Judith

> 
>> +
>> +static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
>> +	.pdata = &sdhci_am62_4bit_pdata,
>> +	.flags = IOMUX_PRESENT,
>> +	.quirks = SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA,
>> +};
>> +

...

