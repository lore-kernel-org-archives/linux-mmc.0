Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147832;
	b=5iUtZds3r0rhg/xm3uZhIp3P24RL8EopRFdiIfHl545RGrzRCTV4zPB+qJD5e3Hg8ZU0
	 5Q0nE3j3CEeZU1qbrVBVzZctQJkZERqIC347er59gvTm3vbybmTJMfTqPyCB5xr6ZPsuv
	 QtdD8xjjMY70D2ohOPHYpBDjUVWeHxp2ZuaG1dKDM5CMiAgzkiezoyEynwRFhHXMNvm0C
	 1tCUkJbEocU1Ja5Y54K7R3N6aKlm9HfYGmDg6LBckEbL+qb8YUBU7n2mS9oS6sLb7Ozd+
	 2qecdkooVoPvYR6/kKuYYSlbfISmpZpnZqbma6qMNdjr4uGKrbVx8wsNRPUCIckYBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147832;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8PIwpydXKouR1joEe6jH+BAljrr4d+wB8gTbjsqTGKM=;
	b=gzRnQItQOBtRsWBiLpHTMTe8EbHdT16RvpOxGCsCapyTZCK1Ak1dOCxuhL2x/JrL1oSb
	 qV3aXV5CPr3eMF3wtS46aLGUuaBD4kUMOtRUiccrhdMyugwZTosrwwtrfjUCaZ2yhyHoU
	 DNhRUJPWxSlzrghqGxvda5UbLMcafZsgSuYxLnyG7r3Peq4H7hie6WqwvaYWL74WRg81U
	 2YERUpAsXeLMCnZokeBqDFgCsk5et1xwUHJeb0RsXLxovk/dk/LrzkSVaLDoVAbGoxmvH
	 Iti/7rKXcvoT93tJgJbBiABTBsKmhYES3TJ6gpxIItpt77psRkc3RmENwF6iuy1D2Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PHBcqnbu;
	arc=none smtp.remote-ip=95.215.58.137
Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5F606A31D
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 00:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PHBcqnbu
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g6I0fGip7xLh8Q6oBq2a1cjMBbrnu+NWJFLuMFktGCs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793147829; v=1; x=1793752629;
 b=PHBcqnbu+1NB4z3cOMk1wN9rIqqPlvxlF10Q4PyjdLXZFiZeyI85HNYVP3rZpde0zKBgcRe0
 RPCeQSFyj7xmiXCVLbbG4ZzJ1DM48HyC3BF9CPjAOjeUQOGAyScoed07CGfGEIj8q7A5a2sFWVA
 EZZuxjtC6hMF4jl1lAUE05FA=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 54179253e2ede412;
	Wed, 28 Oct 2026 00:37:08 +0000
X-Mizu-Trace-ID: 54179253e2ede412
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ebe0445-a111-49a5-b9cf-0185d3c3f67b@linux.dev>
Date: Wed, 28 Oct 2026 08:36:56 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com>
 <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
 <CAPx+jO_+P-ksGzbYp9Aky7etMyKtTUvtAZJZJpauw03Y8zP0Lg@mail.gmail.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <CAPx+jO_+P-ksGzbYp9Aky7etMyKtTUvtAZJZJpauw03Y8zP0Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/28 星期三 3:46, Ulf Hansson 写道:
> On Tue, Oct 27, 2026 at 4:02 PM Shawn Lin <shawn.lin@linux.dev> wrote:
>>
>> Hi
>>
>> 在 2026/10/27 星期二 22:40, Ulf Hansson 写道:
>>> From: Kamal Dasu <kamal.dasu@broadcom.com>
>>>
>>> keep-power-in-suspend is currently documented as SDIO-only, but the
>>> requirement it describes -- preserving card power across a
>>> suspend/resume cycle -- applies just as well to any card type. Drop
>>> the SDIO-only restriction so eMMC and SD platforms can use it too.
>>>
>>
>> I don't see how SD could use it from the following patches. Perhaps we
>> should still be more strict here to say SDIO and eMMC only, unless
>> SD part is implemented later.
> 
> I didn't have the bandwidth to implement this for SD at this very
> moment, but the idea is to add it for SD too.
> 

SDIO devices have a clear wake-on-host requirement, so keeping power on
is reasonable. eMMC and SD are passively accessed devices, making this a
pseudo-requirement under system freeze conditions until Broadcom chips
changed the situation for eMMC.

However, for the SD part, I doubt such a need exists. It would require
dedicated ROM code support, and unlike eMMC, SD is not used as primary
storage. Worse still, unlike eMMC and SDIO devices which are soldered
down, vendors typically have an AVL to certify board-mounted components,
while SD cards can be freely swapped. The compatibility of off-the-shelf
SD cards is relatively poor, so I question whether there is a real-world
scenario for SD cards here. If there is no such scenario, this is dead
code.

> That said, I was also thinking that maybe it would make sense to add a
> sysfs node to allow the behavior to be controlled by userspace.
> Thoughts?
> 

Sure, regarding the sysfs node you mentioned, we already have
mmc_caps2_set() exposed to userspace, and we can add
MMC_CAP2_RESET_AT_RESUME support there

>>
>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---
>>>    .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> index 8b9b3b036129..2fc8e06d5ec9 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> @@ -301,7 +301,7 @@ properties:
>>>      keep-power-in-suspend:
>>>        $ref: /schemas/types.yaml#/definitions/flag
>>>        description:
>>> -      SDIO only. Preserves card power during a suspend/resume cycle.
>>> +      Preserves card power during a suspend/resume cycle.
>>>
>>>      wakeup-source:
>>>        $ref: /schemas/types.yaml#/definitions/flag
>>
> 
> Kind regards
> Uffe

