Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com [45.254.49.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C31E7660
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349079; cv=none; b=DvGssGgiCsJCaenFfd3JzQVez4oEFEUKxyrfMJ0222uMA46A45TFiQOLPa7Ge9vmLaobveawlGTH4AFqDVTXRNjeFDoh6Nj4PTx02KWxsVuxMcXyPmLCTcbVGnk7JI1NWYtkqnIgLFEKWotzVWzUk8SPLkZyM5si0i6/0W6i+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349079; c=relaxed/simple;
	bh=kLXTvgrF5vfec7V7RDM4+/Zwe2tro3WOh0aIKGzw+oo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=einVf7+0jbFVfQHvTAXv1pb7ND3CUMl7vdlqGdWhxroI/jt6nZmtYepMjHbn85JnWno50QWfdhrfcmMPayzNfjB/tYgtKn8BRMZhRsTvQAWa0kZxHSDk1P1rNA6f4gK1mzDD+cQ9+jnQY/KmPVuLdcPqAkDoW+wPGWYdag9A76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BIo8a+i+; arc=none smtp.client-ip=45.254.49.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BIo8a+i+"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d991246a;
	Mon, 14 Sep 2026 09:19:19 +0800 (GMT+08:00)
Message-ID: <0e773d95-eaf4-4408-bd20-42821c38e634@rock-chips.com>
Date: Mon, 14 Sep 2026 09:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Shawn Lin <shawn.lin@linux.dev>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel
 cdev + mmc-utils)
To: Avri Altman <Avri.Altman@sandisk.com>, Ulf Hansson <ulfh@kernel.org>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
 <BL3PR16MB44734321BBE9FC4EB9EC91C7E5BC2@BL3PR16MB4473.namprd16.prod.outlook.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <BL3PR16MB44734321BBE9FC4EB9EC91C7E5BC2@BL3PR16MB4473.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09d7f469203a4kunm618c520676879e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQk9IVklKSRlNQkpDSE4eTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=BIo8a+i+Ckk3bUo7qPnhqbFnKs2EUs5/zOX1ERmZkuzM8tKeApnQmR+0pNKRLKLHMs8QIF58sTKVt+RgVwP1hFh1byqs4GgWZX8ebLoiQ+zeLTF1OI9rKmTsoVDg91OFQOe0WA5xgDtO6h57aC9t5+zsOzCzN8fCWGz/VmMoN9o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=stYqBpmePClCUQcyVfrekvRaLCUFXFZJPdYXnUyUx54=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/13 星期日 15:24, Avri Altman 写道:
>> From: Shawn Lin <shawn.lin@linux.dev>
>>
>> Hi Ulf
>>
>> This RFC series adds raw userspace access to the SDIO register space, spanning
>> two projects and therefore threaded into a single series:
>>
>>    - Patch 1 (kernel tree): a passthrough character device exposing
>>      CMD52/CMD53 to userspace for every SDIO function.
>>
>>    - Patches 2-4 (mmc-utils tree): SDIO enumeration in 'mmc list'
>>      plus 'mmc sdio' commands using the new interface, i.e. the first
>>      userspace consumer of the kernel patch.
>>
>> They are sent together so the kernel UAPI and its user can be reviewed as a
>> whole. If you prefer, I am happy to split them into independent threads per
>> project.
>>
>> === Motivation ===
>>
>> SDIO cards are normally driven by function drivers (brcmfmac, mwifiex,
>> rtw88_8723bs, ...), but bring-up, debugging and factory test frequently need
>> to poke the SDIO register space directly:
>> CCCR/FBR in function 0, or vendor registers before any function driver is
>> bound, and some deployments, notably lightweight IoT boards, want to
>> handle the SDIO function entirely from userspace.
>> Today the only way is to write a tiny kernel driver per device.
>>
>> eMMC and SD already have userspace tooling in mmc-utils; SDIO is
>> conspicuously absent from it.
>>
>> === Why not lssdio? ===
>>
>> Standalone SDIO enumeration tooling already exists: the lssdio script of the
>> sdioutils project [1], and the sdio.ids database proposed here comes from
>> that very project. Still, I would rather grow mmc-utils than use lssdio, for two
>> reasons:
>>
>>    - Userspace tooling of a subsystem is conventionally unified:
>>      USB has lsusb, PCI has lspci, and MMC/SD cards are already
>>      enumerated by 'mmc' from mmc-utils. SDIO devices live on the
>>      same subsystem, so extending 'mmc list' is their natural home:
>>      one tool, one consistent output format, one place to maintain.
>>
>>    - lssdio is a standalone perl script, and SDIO devices are mass
>>      deployed in lightweight IoT/embedded systems where a perl
>>      runtime costs 10-20MB of storage - a non-starter there. mmc-utils
>>      is a tiny C binary already present on most boards shipping eMMC
>>      or SD, so SDIO support comes essentially for free, and the
>>      sdio.ids database it needs is a few KB.
> +Johannes , who might be interested to comment on this as well
> 
> The kernel UAPI may need a small reference/debug client,
> but that does not require making mmc-utils the home of SDIO userspace tooling.
> The fact that SDIO shares the Linux MMC core and SD physical interface is not sufficient:
> mmc-utils is a storage-management utility, not a generic enumerator or control plane for every device function carried over that bus.
> 
> My main concern is the long-term scope boundary.
> eMMC is a JEDEC storage specification with a relatively stable, finite management surface,
> whereas SD and SDIO are part of the actively evolving SDA specification family and extend beyond storage into device-function domains.
> 
> Once mmc-utils starts carrying SDIO function enumeration and its own sdio.ids database,
> it establishes itself as the home for SDA SDIO userspace support.
> That is a substantially broader commitment than a small reference client for a kernel UAPI,
> and it invites further non-storage functionality as the SDA specifications and SDIO use cases evolve.
> 

Hi Avri,

Thanks for the quick review.

I agree with the scope concern and am happy to keep sdio support in 
mmc-utils out of this series, so we could still discuss this later but
focusing on the UAPI design itself now. Your suggestion of a small
reference/debug client seems the right shape, so I plan to rework the
series.


Ulf, any objection to tools/sdio/ as the home of the reference client?
And I'd appreciate comments on the UAPI design in patch 1 itself.


> Thanks,
> Avri
> 

