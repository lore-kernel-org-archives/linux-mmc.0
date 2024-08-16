Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65932C1BA
	for <linux-mmc@vger.kernel.org>; Fri, 16 Aug 2024 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772985; cv=none; b=Y4LnnhiJ6TgfFAQn1IgIsqA7SesuzP6Wa+a7WbE8UyOLrar81KPsJHQ0wsaSyIGKTF83V13tICepvzguMeIzSZpYVu6Iy4mVbawLG9aSPijbJJyFo3i0VisOf3/YfKOWTMwJca7WA9giDUR4NfcMHN3g9heZCd+K/spnpLd9c+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772985; c=relaxed/simple;
	bh=5cO82lDlBiGaymw0KG8MQ2jYrv3ioPtFnqnfpyR5/Wo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N6XhTyvttD0CV3dF+S+ij5OqBRA4tq+qAYUkTtx8KFjkTrw19RLR8tE8k2z33FtC6mk25D0L0ImK+FwH30r1HHyBEvTQxR0zELWIm6Vae+Lw9xApvPrlLS9xHLH5f/KgjDEm6cxrMcW2OPUQbCodHky8zXmykyB7DyJ0WJeNfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=i5x3b0ad; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="i5x3b0ad"
DKIM-Signature: a=rsa-sha256;
	b=i5x3b0adi+qvx066i3a4n3jQuaJk/61zGYbYHrCX8ZZdtLQvSA4nlwf3wXyiq4BIaCVilKACDXHbcr/lMvVaf7IRU8GvnjAoW1C4ZvG/mdNkbp2uyqZeKi51frQhdDgQ0Cet2GFr+dAPU2Md0qJxnsi4Q51lq4zELDPdO0t/ww4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=MKH35ylF7JGrMtSvPuROGizQ+XPrHM7tY4mziCtuw+c=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BDB514601C1;
	Fri, 16 Aug 2024 08:34:02 +0800 (CST)
Message-ID: <70a236d5-f58e-4b3e-a0a9-d02d6312811d@rock-chips.com>
Date: Fri, 16 Aug 2024 08:34:02 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ricky WU <ricky_wu@realtek.com>
Subject: Re: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-11-avri.altman@wdc.com>
 <aa4bd0dc-b349-4ef7-83a7-59af67d61cbf@rock-chips.com>
 <DM6PR04MB65751ADBBDD03386CCF2A7F3FC802@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <DM6PR04MB65751ADBBDD03386CCF2A7F3FC802@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5ITVYYQ0pJHUIYQ0pCTBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91589b10c303aekunmbdb514601c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Gjo*PzI3ODoYGUNRMxQP
	MzgwChNVSlVKTElITE1DT09IT0lLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhPQkg3Bg++

Hi Avri,

在 2024/8/15 20:57, Avri Altman 写道:
> Hi,
> Thanks for having a look.
> 
>> Hi Avri,
>>
>> 在 2024/8/14 15:29, Avri Altman 写道:
>>> @@ -948,13 +949,20 @@  static int mmc_sd_num_wr_blocks(struct mmc_card
>> *card, u32 *written_blocks)
>>>        int err;
>>>        u32 result;
>>>        __be32 *blocks;
>>> -
>>> + u8 resp_sz;
>>>        struct mmc_request mrq = {};
>>>        struct mmc_command cmd = {};
>>>        struct mmc_data data = {};
>>> -
>>>        struct scatterlist sg;
>>>
>>> + /*
>>> + * SD cards, specifically high volume cards, expect to be allowed with the
>>> + * full 500msec busy period post write. Otherwise, they may not indicate
>>> + * correctly the number of bytes written.
>>> + */
>>> + if (mmc_card_is_sduc(card->host))
>>> + mmc_delay(500);
>>
>> Could you kindly point me to the right section of SD spec which states
>> this 500ms before ACMD22 ? Is it the write busy time?
> Yes. I encountered it while testing SDUC:
> If there are some phy errors (probably caused because the micro-to-SD adapter I was using),
> The first get-status response contains an error bit, and the recovery flow is entered immediately.
> Thus, violating the min 500msec allotted to the card write.

I see.

> 
>>
>> And as you mentioned high volume cards, I am curious if 1TB sandisk
>> MircoSDXC need 500ms delay as well?
> Theoretically should be applied to all cards.
> But since this code is there since forever, and no issue observed thus far -
> I preferred limiting this to ultra capacity cards only.
> 

So my biggest guess is the cards issue the busy indication after the 
first error block and the host drivers implemented either SW or HW wait
busy mechanism, maybe before ACMD22 is issued, so no issue observed?

> Thanks,
> Avri
> 
