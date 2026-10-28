Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189357;
	b=aWPPQMZoc8zkn2z5/ftZz9D3rYkqHi0G6r6HcVMU19lSU4yY79GIx6YF2bIEWu9tFPxK
	 QxznK0Hg46Xo3slch3phyxRc49e5AP1na/lJMtNg1MJA8IV+SKxK8cQZiUTAp8cyrplbu
	 BKiudUbk34DFcLnUMZ5hqMF3fFMdgXx6IEM6lrmTppy501RvD6ZvkA2e1FuTTuIV3Ex4S
	 Ll49J+9zdVwTNG0Fj7dbEv9vQAejeVy6cPCnbNFOiRGTrR5+G1Jao7KATYEYABUj4k/Bh
	 VbSUnTzpf6gmFHuHvcWjhTVUChzPre2j8raXhWqRDqutwLlnHnUupyZQhnjekngdyQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189357;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4hubiP6UNKJsfIYjDwqYKPtFGEwf9AKbEUyOZBEjNMA=;
	b=iiKVz4lXaoK79t7h2t3/Xo3F2w6SMvuppMJ5LXOTxPeEF+hf4R0lkMzhX/QhFmI1g7ck
	 Vtvax5IGBjVIwwiST8HfL6eL8jfFbCuvGBuCKPyd/ZBnUcPL/uLAzvkUQKiYEt79q9z6+
	 /bEF5XMIqajvTWqsienhaCHlRQIFLJCisyj6FJBMGoLift9LwJCpb7ii7JE076Csp3wp1
	 YBqd0EdxyXBNzj3ox2ohzxLmZHyG+2ks3PfPoFUto01zogjAQPyJ138Hni7jYFCLNwJfc
	 osmlSKyfdbIOhHS4eXDQ4NNk6ZJKOR8psQSOKKhD9bkvT1f63sxT3BQunvMG5DKKl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gBCbtE6C;
	arc=none smtp.remote-ip=95.215.58.184
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96B606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A96B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gBCbtE6C
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zzD/H3Q9pIRPfiCVs5ygv2SY/cTJiKPRPiAl8d46ES0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793189353; v=1; x=1793794153;
 b=gBCbtE6C2Fa2WtHNHUkJNyZ0gTF8ERSSf3ABvV++lZ1FGMtiFC5DoZaWdA8Nh6ORoIQy3hut
 P33twPIm51AC2J4Hh6iYWpPuKfOfgdOQtI+zDBUt1ZZqF8Cu1s5faYPWuCGqVQ77+20yhWAwpat
 n1SYgo/1bj+vfIgttyTeereE=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b67904be421a6b3;
	Wed, 28 Oct 2026 12:09:12 +0000
X-Mizu-Trace-ID: 0b67904be421a6b3
X-Migadu-Flow: FLOW_OUT
Message-ID: <4b19d1b8-e799-40fd-9ee5-ca85aa3952c2@linux.dev>
Date: Wed, 28 Oct 2026 20:08:59 +0800
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
Cc: shawn.lin@linux.dev, Kamal Dasu <kamal.dasu@broadcom.com>,
 linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com>
 <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
 <CAPx+jO_+P-ksGzbYp9Aky7etMyKtTUvtAZJZJpauw03Y8zP0Lg@mail.gmail.com>
 <5ebe0445-a111-49a5-b9cf-0185d3c3f67b@linux.dev>
 <CAPx+jO98iHx=VRwyWgg+aQmduquLVZe9Q8FNNK4VwkizXB2A9A@mail.gmail.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <CAPx+jO98iHx=VRwyWgg+aQmduquLVZe9Q8FNNK4VwkizXB2A9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/28 星期三 18:43, Ulf Hansson 写道:
> On Wed, Oct 28, 2026 at 1:37 AM Shawn Lin <shawn.lin@linux.dev> wrote:
>>
>> 在 2026/10/28 星期三 3:46, Ulf Hansson 写道:
>>> On Tue, Oct 27, 2026 at 4:02 PM Shawn Lin <shawn.lin@linux.dev> wrote:
>>>>
>>>> Hi
>>>>
>>>> 在 2026/10/27 星期二 22:40, Ulf Hansson 写道:
>>>>> From: Kamal Dasu <kamal.dasu@broadcom.com>
>>>>>
>>>>> keep-power-in-suspend is currently documented as SDIO-only, but the
>>>>> requirement it describes -- preserving card power across a
>>>>> suspend/resume cycle -- applies just as well to any card type. Drop
>>>>> the SDIO-only restriction so eMMC and SD platforms can use it too.
>>>>>
>>>>
>>>> I don't see how SD could use it from the following patches. Perhaps we
>>>> should still be more strict here to say SDIO and eMMC only, unless
>>>> SD part is implemented later.
>>>
>>> I didn't have the bandwidth to implement this for SD at this very
>>> moment, but the idea is to add it for SD too.
>>>
>>
>> SDIO devices have a clear wake-on-host requirement, so keeping power on
>> is reasonable. eMMC and SD are passively accessed devices, making this a
>> pseudo-requirement under system freeze conditions until Broadcom chips
>> changed the situation for eMMC.
>>
>> However, for the SD part, I doubt such a need exists. It would require
>> dedicated ROM code support, and unlike eMMC, SD is not used as primary
>> storage. Worse still, unlike eMMC and SDIO devices which are soldered
>> down, vendors typically have an AVL to certify board-mounted components,
>> while SD cards can be freely swapped. The compatibility of off-the-shelf
>> SD cards is relatively poor, so I question whether there is a real-world
>> scenario for SD cards here. If there is no such scenario, this is dead
>> code.
>>
>>> That said, I was also thinking that maybe it would make sense to add a
>>> sysfs node to allow the behavior to be controlled by userspace.
>>> Thoughts?
>>>
>>
>> Sure, regarding the sysfs node you mentioned, we already have
>> mmc_caps2_set() exposed to userspace, and we can add
>> MMC_CAP2_RESET_AT_RESUME support there
> 
> The reason for the proposed user space node is not to control
> MMC_CAP2_RESET_AT_RESUME. That is a different story, specific to
> Broadcom platforms at this point.
> 
> Instead it was solely about allowing user space to keep the eMMC and
> SD card powered on during system suspend. Which may be useful for
> other reasons. Like, internal garbage collect and suspend/resume
> latency.
> 

I got your point now, it sounds reasonable.

> [...]
> 
> Kind regards
> Uffe

