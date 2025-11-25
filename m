Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903ED2D662F
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061581; cv=none; b=NATWGBm2V1GYlqWrkk9ZXljPU9I3BZcHc+hbXLUIOlIZ80ksIIxQHhyA2gFt5XKKpV9QeeRdc867XT7PjVGPMlMTJdj01L3dEZad6Hn9lDdHxI672zk7X0VM0D3hpYSQTX/BpQTp5FraDMvp/OaJ0rfAhsIYHhUhFMkCBtG/kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061581; c=relaxed/simple;
	bh=7IpNl1hs21fsHgVCZ03U51G89Kgu5rL3fP4qzGziAHI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jaqlmoI5Y2im8cdNyPGcXLey7x2Bvspz0o/y90YtHDvAE+Pn1LEBLwIObxZoMjkURE8i2sRcINkrZH89rJecUyPS0m1P+ub24ROykyREb3bTzsnGH5gxMImxlVtLwwzr4lzHe3mBJOBfDgwvaTo42HN1Gvjlfoh5CUFeWLR12EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gu15nRY3; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gu15nRY3"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ad1b5bac;
	Tue, 25 Nov 2025 17:06:12 +0800 (GMT+08:00)
Message-ID: <7afe0b14-a945-427e-b4d9-b7a16a08f298@rock-chips.com>
Date: Tue, 25 Nov 2025 17:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
To: Avri Altman <Avri.Altman@sandisk.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-3-avri.altman@sandisk.com>
 <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
 <DS1PR16MB6753C1E4EB804DA77041DAADE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
 <fecd4ac6-c872-4ab8-a7b7-c27505ed4639@rock-chips.com>
 <LV8PR16MB6757EB0C84FA163C466426BCE5D1A@LV8PR16MB6757.namprd16.prod.outlook.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <LV8PR16MB6757EB0C84FA163C466426BCE5D1A@LV8PR16MB6757.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aba436ee909cckunm92c2e70e486919
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIdTlYeHxkaTEwdQkNJTRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gu15nRY3El+YelO5qVXYl3IWfru+nKM3qDuKLrsbGJjUZKkxCvgpcoGh8tIZCxtB1lkohcO2xB9NUGVHE8BpZjmF+0RWMsU3EBQHnml92GJOAcW8ybpiWrcb6am9rK9P0IT1ojlppDO2iqondy4tV6ZGHH7aXwhVdMvoRb+rxrQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=v5COXpure2hOrwHuEkwjTrHVvMbj0rmG9d+Y3kOjUFk=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/25 星期二 17:01, Avri Altman 写道:
>>>> Would other vendors need this quirk but with different policy/ adjustment?
>>> What do have in mind?
>>
>> Is it possible to add something like below?
>>
>> MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK, CID_OEMID_ANY,
>> mdt_quirk_sandisk, 0),
>>
>> static inline void __maybe_unused mdt_quirk_sandisk(struct mmc_card *card) { if
>> (card->cid.year >= 2010 && card->cid.year <= 2012)
>>          card->cid.year += 16;
>> }
> I see your point.
> But it will require some further complication: the quirks are applied earlier in mmc_add_card(),
> But the year depends on card->ext_csd.rev which is available only later in mmc_decode_ext_csd().
> Specifically, I think we will need to add a field to mmc_card to cash the mdt flavour, e.g. something like:
> 
> static inline void add_quirk_mmc_mdt(struct mmc_card *card, int data)
>      {
>      	card->quirks |= MMC_QUIRK_BROKEN_MDT;
>      	card->mdt_quirk_type = (enum mmc_mdt_quirk_type)data;
>      }
> 
> I will call it for Sandisk with:
> MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc_mdt,
>                        MMC_MDT_QUIRK_SANDISK_OFFSET_16),
> and other vendors would:
> MMC_FIXUP(<....>, add_quirk_mmc_mdt,
>                        MMC_MDT_QUIRK_TBD_OTHER_VENDOR),
> 
> And then, use it in mmc_decode_ext_csd() to apply whatever logic.
> 
> Is that what you meant?

Yeap, that's probably what I thought it to be.

> I can try it if you think it worth the complication.

TBH, I have no strong opinion on this. The question I raised, is more
like for other eMMC vendor guys if they argue it. Let's see if Ulf has
any insight here.

> 
> Thanks,
> Avri
>>
>>
>>
>>>
>>> Thanks,
>>> Avri
> 

