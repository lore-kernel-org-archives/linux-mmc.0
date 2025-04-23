Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0119DF4A;
	Wed, 23 Apr 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447293; cv=none; b=T47KkKPHxk9EJn3uFzBiJbh/e7GQNESBitdM+odFzISDfPIKLjPzEP8BhK8hmOD8nbaGINKTRRlAP3SAk/EzrO/ToSPREBqcntBiTxwOse2Pr0ZBdBxxeZ7mSVJr0r6UiHuMvPhDQPlJfa8o61utZyksD6doxu8nyookrweO2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447293; c=relaxed/simple;
	bh=cz6xCYWcS4PqGHXcBFShpbdeWty6WjNd4cN2aPrJmJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LEIOgCuKEI1JPN0Ig2U5keKwOyZHN13HBp962VtDpWj3p97s5LprET1f4v3WostsTyapW6YjTeGD3zrbML9cja7ZPlt9kLXOp9Vkc+JQN/OdHJ68JA67iOTrgdkMrlzbj99vcXdH0c5cZSduHfZZQwH5PV9+PNzBME9pwJP2LSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uZNf5ndM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uZNf5ndM"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53NMRlwx2305813
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 17:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745447267;
	bh=Sci9yMspbMD4lKOR2y75ZVpSS5ydsma73LWBeFpHdb8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uZNf5ndMmPB6FHx10Yr/xKpXy5Poef6u/GByG4vBxSwGt2Af1C3bjIepfPlx2nJQx
	 RXj9k7BiOchp7/tqS6Fg2X3NnZLWNBKkBgWHzyyEaEirP1biFi+iES5AS4NEy8UIX/
	 2AlKBg33cFw/DST9m+VUBqeBFnTjp9zUmNnERaIk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53NMRlHh011323
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Apr 2025 17:27:47 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 17:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 17:27:47 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53NMRlFx013207;
	Wed, 23 Apr 2025 17:27:47 -0500
Message-ID: <8678d284-db12-451a-b789-2b75f9932f9f@ti.com>
Date: Wed, 23 Apr 2025 17:27:47 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/3] Add ti,suppress-v1p8-ena
To: Nishanth Menon <nm@ti.com>, Josua Mayer <josua@solid-run.com>,
        "Sverdlin,
 Alexander" <alexander.sverdlin@siemens.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hiagofranco@gmail.com>, Moteen Shah <m-shah@ti.com>,
        <stable@vger.kernel.org>
References: <20250422220512.297396-1-jm@ti.com>
 <20250423180809.l3l6sfbwquaaazar@shrank>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250423180809.l3l6sfbwquaaazar@shrank>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth,

On 4/23/25 1:08 PM, Nishanth Menon wrote:
> On 17:05-20250422, Judith Mendez wrote:
>> Resend patch series to fix cc list
>>
>> There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC
>> and Microcenter/Patriot SD cards on Sitara K3 boards due to the HS200
>> initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
>> is optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
>> For SD cards we shall parse DT for ti,suppress-v1p8-ena property to
>> determine whether to suppress V1P8_SIGNAL_ENA. Add new ti,suppress-v1p8-ena
>> to am62x, am62ax, and am62px SoC dtsi files since there is no internal LDO
>> tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.
>>
>> This fix was previously merged in the kernel, but was reverted due
>> to the "heuristics for enabling the quirk"[0]. This issue is adressed
>> in this patch series by adding optional ti,suppress-v1p8-ena DT property
>> which determines whether to apply the quirk for SD.
> [...]
>>
>> [0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/
> 
> Why cant we use compatible to enable the quirk instead of blindly
> enabling for all IPs including ones that have onchip LDOs? That was the
> reason it failed in the first place for am64x.

We made an assumption that did not work out.

> 
> This is very much like a quirk that seems to go hand-in-hand with the
> compatible for am62-sdhci ?
> 
> Is it worth exploring that option in the driver thread? from where I
> stand, this sounds very much like an issue that AM62x IP has, and should
> be handled by the driver instead of punting to dts to select where to
> use and not to use the quirk.
> 

Sure, I can test this out and respin the series. It does seem like a
more clean solution, thanks for reviewing.

~ Judith

