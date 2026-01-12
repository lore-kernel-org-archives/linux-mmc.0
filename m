Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AC346787;
	Mon, 12 Jan 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208298; cv=none; b=FGChlb7jQUKQ3pHWDSkl4ujRM2EudxE3/TDzi8yt87aAsljbIul/zwPTTbqCjYCLfZ9HPOA7KmoXlR+dSpqhKlQTl38ehbt8oL6W1/FRvXcw+EmLMbzrPcNtCwtRSHMQRAqumLb9s/5y+JPhiAyMF0cHyobf44A53jINbSRHnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208298; c=relaxed/simple;
	bh=mhRV4RszuvlNMkXJhHZmrq7OlzdMGpEjotoCimX5KaU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V2ulHX69r5sOaP5z4RGOIBpvifqTdcqi/ocyig+BAkdLMAxEPdF5+PnLSUmVvAAkpT+ySxkcoWe6SumlMBNFrrdwLNBYa5J47gBERhSZViMJ7TG8VaPbmbKxjn8I0z+Nz6P6tpob64n3jDGAuwZeTfBtL6sBDhJ0YyhjuOPRmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UhWoW7kY; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UhWoW7kY"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30503549a;
	Mon, 12 Jan 2026 16:58:05 +0800 (GMT+08:00)
Message-ID: <a346ba30-43f1-4579-91e7-f10d2ccff039@rock-chips.com>
Date: Mon, 12 Jan 2026 16:58:03 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
 ulf.hansson@linaro.org, Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
 <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
 <c3ee063c-ca11-44e4-9e7d-3861a82db3ea@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <c3ee063c-ca11-44e4-9e7d-3861a82db3ea@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bb16d3dad09cckunmbb41a1112d58c1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhodQlZPH0tDTRofTkJJSE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UhWoW7kYX66ut3wPXEqeaqrStdUT65OVLJVljFYrFzAtKSuAfDr5Nj5Jx+o9RG2o5GOl4ti7GN4rUCtv9n8sZNMrC6iuDoI1DHO1KJu0zH8PGgYwSODdl6HJjYMT8/xg3nI7FLlQCIaCKzIp69lC+lThQLXLDukwOmOG1kfdABM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=n0N5cpDzl2Io3llDYSRDqgK0DrphJVLWFS2vQbYLFZc=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/12 星期一 16:29, Chaoyi Chen 写道:
> Hi Shawn,
> 
> On 1/12/2026 11:56 AM, Shawn Lin wrote:
>> 在 2026/01/12 星期一 9:32, Shawn Lin 写道:
>>> 在 2026/01/10 星期六 9:07, Marco Schirrmeister 写道:
>>>> This series addresses a microSD stability issue on the FriendlyElec
>>>> NanoPi R76S (RK3576). The board currently suffers from a 400kHz
>>>> retuning loop when the controller attempts to enter runtime-suspend
>>>> during idle periods.
>>>>
>>>> Evidence of the failure in dmesg:
>>>> [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>>> [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
>>>> [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully tuned phase to 233
>>>> [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>>>
>>>
>>> Does this problem happen with all microSDs or just *a* microSD per
>>> your description?
>>> Have you ever tried to disable SDR104 support?
>>>
>>
>> A quick update.
>>
>> I found several problems on RK3576 for supporting sd cards. I wondered
>> how all upstream RK3576 boards claiming SD support work? Anyway, I sent
>> a series to the list[1], not sure if it fixes the problem you faced, but
>> these should be the right patches you should have a try.
>>
>>
>> [1]https://lore.kernel.org/linux-rockchip/1768189768-96333-1-git-send-email-shawn.lin@rock-chips.com/T/#t
>>
> 
> I encountered a similar issue on the RK3576 EVB2.
> 
> It seems that the cd-gpios feature are broken, so SD card events


Yes, cd-gpios method for RK3576 is broken now, so you need to apply
my first 2 fix patches.

> cannot be detected. However, if the SD card is inserted before Linux
> boots, it can at least start up. I suspect that other boards may behave
> the same way :)

This is true, because .get_cd() returns card present when booting for
the first time, you the only way for upstream RK3576 boards to use sd 
cards is to insert the card before booting. But then hot-plug case will
not able to work.

> 

