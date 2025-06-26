Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43091FFC41;
	Thu, 26 Jun 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947639; cv=none; b=dW4urIVcmzXwhEoQ8NowZEO1gxdSu1M5lloGp9zUaFzPV9QxOn7XMDvS2KkfeO8L1E/REgzHPgSykUGsLhS18WVZAAGYi8ZwTO6PCs+R+yxsKPGO7ejGD5Pc2JYg4tiEIDBbYkHOZ4gWHtBMP5qQEdP90qL0OUr/n7JOeHd8L7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947639; c=relaxed/simple;
	bh=yxN2RrdCi+oF75J4+SNsoBdRHTZ0fryD0gPR4jugiYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=REvL08YDYgmxTt42aJ+g4/eVd98NcbFCHbkvPD1aLlxb7lYErqWlIuS/o6r0t1LKuWTy4r1uwpilasijoJ+I42/X+m2fIITyFQRT3P3S4WkPeL+wDK4etEfd++gGPqE6aLzcz1/v3Ausk3pTqJJlc5fKOgCDT6jp+Vj1D5VAMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Um9jdZEC; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Um9jdZEC"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QEILMu2480443;
	Thu, 26 Jun 2025 09:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750947501;
	bh=wFsFiLH1AC8uaOEAXzwfhn+J6kmqxAKDCggsNNyWAkM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Um9jdZECWIV0e9EakqymbBQVn/y22bAgmlwIMh7BrwDp1eSY+Jw0Spcn38rvaRLgK
	 e6pzZhrYMic51XSVuJrW1UJddRUkZmyKs2egFV+STbr+Uuh1h04GhqWKfgKLm/YDC5
	 L9g0TCz9PAFbcJo6i3tjyRPFmt8JQae2OytW9GOs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QEILfC2053280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 09:18:21 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 09:18:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 09:18:20 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QEIKGq1132823;
	Thu, 26 Jun 2025 09:18:20 -0500
Message-ID: <44649612-ea42-43af-b07a-f2f504a199fa@ti.com>
Date: Thu, 26 Jun 2025 09:18:20 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed
 DDR support
To: Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20250624221230.1952291-1-jm@ti.com>
 <20250624221230.1952291-3-jm@ti.com>
 <5428ecbd-8154-43b1-a77c-9eda550c47e7@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5428ecbd-8154-43b1-a77c-9eda550c47e7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh,

On 6/25/25 10:58 PM, Vignesh Raghavendra wrote:
> 
> 
> On 25/06/25 03:42, Judith Mendez wrote:
>> For eMMC, High Speed DDR mode is not supported [0], so remove
>> mmc-ddr-1_8v flag which adds the capability.
>>
> 
> Needs a Fixes tag.

Ok, will add fixes tag and send in a separate series.

> 
>> [0] https://www.ti.com/lit/gpn/am625
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index 9e0b6eee9ac7..120ba8f9dd0e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -553,7 +553,6 @@ sdhci0: mmc@fa10000 {
>>   		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>>   		clock-names = "clk_ahb", "clk_xin";
>>   		bus-width = <8>;
>> -		mmc-ddr-1_8v;
>>   		mmc-hs200-1_8v;
>>   		ti,clkbuf-sel = <0x7>;
>>   		ti,otap-del-sel-legacy = <0x0>;
> 

