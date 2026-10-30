Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371972;
	b=SsWZkBpZznBqnUaMZzhrR2UKBS8qOvI1FnvTR5IBCLBqM0yDM7cfUBpEu9F8qNFOGhmK
	 teIrr2BVKnuIfquBrigIolpdUyh1OnV4CBhx9tVhOEhvEuAKU/z1K0Zf8DkTEcTd6qBb3
	 ZfWQ5jNMLhN/yZGVV1NC6c7SK4lGc1QSNCS7rEUy9npza2X8EiT2RrE8NHhvinhcv5ePg
	 IlIt4knWIBbNpqiTssQBJ8kHO7GieMpLICmhlhcaZL0bR4Czu/gEycrgltff8UdjJeqEA
	 hRyjZGjSkhS+CMATm4Ro4vRaYJ7qtM9O/m3GuZQu0RLNl1nKp6+Ryb33arqwzV5kAMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371972;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=qZeieN35Gda+EsKUmxOq58I80c7GZm75MQvA0bgG1Tg=;
	b=S7/WahGMcaHe+TK+e909hj2l5bqyW09cIVoAU80Iay0DIY4i4oI8E3W21ZBUGZw5i3tv
	 81j54Yst+bclPtpAAI0X3lWybny5zjqh9XxxyQqGMQX3beSqhpUlnmBx/r+1h2To7rfP7
	 HbMU7jC9CBl2wQMCVf56QBfmBoYfsmxt+zcRly/Fr0yPrGRFZxKKfwedGqF7f8uGxG30M
	 k1R9jv6S6P+f5sE0UNLAUPwQ1Gv9m0mpceYv3EA+8g9SJuFW9H2W/dfdfh1GrTrXNml0B
	 lnCP08COWgQk9gVm8VGeoZ4IHL1jBUis/wpIK9S03xN/JOlTd2bcz/JjXHdjp4p5yDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=YAsnzhxM;
	arc=none smtp.remote-ip=103.209.128.57
Received: from mail-m12857.netease.com (mail-m12857.netease.com [103.209.128.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CA606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=YAsnzhxM
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f602461;
	Fri, 30 Oct 2026 22:52:39 +0800 (GMT+08:00)
Message-ID: <d10d58bb-473a-44fd-9fd2-b179400c9316@rock-chips.com>
Date: Fri, 30 Oct 2026 22:52:36 +0800
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
Cc: shawn.lin@rock-chips.com, Avri Altman <Avri.Altman@sandisk.com>,
 Ulf Hansson <ulfh@kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Shawn Lin <shawn.lin@linux.dev>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel
 cdev + mmc-utils)
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
 <BL3PR16MB44734321BBE9FC4EB9EC91C7E5BC2@BL3PR16MB4473.namprd16.prod.outlook.com>
 <0e773d95-eaf4-4408-bd20-42821c38e634@rock-chips.com>
 <CAPx+jO9mbSobH3m9ZAgr4RvDa4n0vrdG8u4cNo4-RYynMx1j1w@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPx+jO9mbSobH3m9ZAgr4RvDa4n0vrdG8u4cNo4-RYynMx1j1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa18d4c6f2903a4kunm99fde55023ab35
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUodVhgdSk4eTR1CSElLGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=YAsnzhxM110Qgm0Wt8IHWqzED+4q55JrihVXoJn8DZui+u5oN6vFAKS2w0vyDBfoCyzFAFNNYTfMbrSsT48cmgozma3Gp+y+CKDd7tjeRWitV175F02vs8e348rxd6KZSd3/aFmJ8yPRPllqKn6uCtd/jUuH62HwsUVaFSR2W+Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qZeieN35Gda+EsKUmxOq58I80c7GZm75MQvA0bgG1Tg=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf,

在 2026/10/30 星期五 22:12, Ulf Hansson 写道:
> On Mon, Sep 14, 2026 at 3:19 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2026/09/13 星期日 15:24, Avri Altman 写道:
>>>> From: Shawn Lin <shawn.lin@linux.dev>
>>>>
>>>> Hi Ulf
>>>>
>>>> This RFC series adds raw userspace access to the SDIO register space, spanning
>>>> two projects and therefore threaded into a single series:
>>>>
>>>>     - Patch 1 (kernel tree): a passthrough character device exposing
>>>>       CMD52/CMD53 to userspace for every SDIO function.
>>>>
>>>>     - Patches 2-4 (mmc-utils tree): SDIO enumeration in 'mmc list'
>>>>       plus 'mmc sdio' commands using the new interface, i.e. the first
>>>>       userspace consumer of the kernel patch.
>>>>
>>>> They are sent together so the kernel UAPI and its user can be reviewed as a
>>>> whole. If you prefer, I am happy to split them into independent threads per
>>>> project.
>>>>
>>>> === Motivation ===
>>>>
>>>> SDIO cards are normally driven by function drivers (brcmfmac, mwifiex,
>>>> rtw88_8723bs, ...), but bring-up, debugging and factory test frequently need
>>>> to poke the SDIO register space directly:
>>>> CCCR/FBR in function 0, or vendor registers before any function driver is
>>>> bound, and some deployments, notably lightweight IoT boards, want to
>>>> handle the SDIO function entirely from userspace.
>>>> Today the only way is to write a tiny kernel driver per device.
>>>>
>>>> eMMC and SD already have userspace tooling in mmc-utils; SDIO is
>>>> conspicuously absent from it.
>>>>
>>>> === Why not lssdio? ===
>>>>
>>>> Standalone SDIO enumeration tooling already exists: the lssdio script of the
>>>> sdioutils project [1], and the sdio.ids database proposed here comes from
>>>> that very project. Still, I would rather grow mmc-utils than use lssdio, for two
>>>> reasons:
>>>>
>>>>     - Userspace tooling of a subsystem is conventionally unified:
>>>>       USB has lsusb, PCI has lspci, and MMC/SD cards are already
>>>>       enumerated by 'mmc' from mmc-utils. SDIO devices live on the
>>>>       same subsystem, so extending 'mmc list' is their natural home:
>>>>       one tool, one consistent output format, one place to maintain.
>>>>
>>>>     - lssdio is a standalone perl script, and SDIO devices are mass
>>>>       deployed in lightweight IoT/embedded systems where a perl
>>>>       runtime costs 10-20MB of storage - a non-starter there. mmc-utils
>>>>       is a tiny C binary already present on most boards shipping eMMC
>>>>       or SD, so SDIO support comes essentially for free, and the
>>>>       sdio.ids database it needs is a few KB.
>>> +Johannes , who might be interested to comment on this as well
>>>
>>> The kernel UAPI may need a small reference/debug client,
>>> but that does not require making mmc-utils the home of SDIO userspace tooling.
>>> The fact that SDIO shares the Linux MMC core and SD physical interface is not sufficient:
>>> mmc-utils is a storage-management utility, not a generic enumerator or control plane for every device function carried over that bus.
>>>
>>> My main concern is the long-term scope boundary.
>>> eMMC is a JEDEC storage specification with a relatively stable, finite management surface,
>>> whereas SD and SDIO are part of the actively evolving SDA specification family and extend beyond storage into device-function domains.
>>>
>>> Once mmc-utils starts carrying SDIO function enumeration and its own sdio.ids database,
>>> it establishes itself as the home for SDA SDIO userspace support.
>>> That is a substantially broader commitment than a small reference client for a kernel UAPI,
>>> and it invites further non-storage functionality as the SDA specifications and SDIO use cases evolve.
>>>
>>
>> Hi Avri,
>>
>> Thanks for the quick review.
>>
>> I agree with the scope concern and am happy to keep sdio support in
>> mmc-utils out of this series, so we could still discuss this later but
>> focusing on the UAPI design itself now. Your suggestion of a small
>> reference/debug client seems the right shape, so I plan to rework the
>> series.
>>
>>
>> Ulf, any objection to tools/sdio/ as the home of the reference client?
> 
> Seems reasonable. Although, I would appreciate it if you or someone
> else could step in and help me to maintain this part. Similarly as
> Avri are helping out with mmc-utils.
> 

Sure, I'm glad to help maintain this part.

>> And I'd appreciate comments on the UAPI design in patch 1 itself.
> 
> Yes, this needs an in-depth review as it becomes ABI. I noticed your
> ping on the new version - my apologies for the delay!
> 
> Unfortunately, I need a couple of more weeks to complete the review


Understood. No hurry, we can refine the design properly in v2. I'll hold 
off until you're ready.

> (entering a busy period with traveling). In the meantime, perhaps
> there is someone that we can include to help moving the review
> forward?

I'm not sure how many other community members are interested in this 
area. Maybe Avri or Adrian would be willing to help in v2?

> 
> Kind regards
> Uffe
> 
> 

