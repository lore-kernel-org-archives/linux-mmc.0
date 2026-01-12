Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6152DB7B7;
	Mon, 12 Jan 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190189; cv=none; b=c5xATc2lysDyPcrrqiDLzpyGzBg2Nf5fKcTxUX0Wqj8kC0520iGyB595uwDVE0s/ftn/a3JyRpio5rUhJcHKwHyPr0hHnig9Z8xlHhwlyJXZYbrwTQ4pBC0Z8e82rzfwmTgE2ZDKq+L1FXJ5VpXFU6xqIuUkUPJyX1Isl+yLCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190189; c=relaxed/simple;
	bh=gFLSDks9bFjYP85nhhWRjTT4NaXpUiRY8YzS8AjuOV0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YbuUiIp9KCn2H0QYEKoFruYnC41aDVjApcGD6ieBsoRAzJgNr0eAqse5iGraYhMGRUohmbnXDTHC1aCDag1JK3jjDAnGFl73KQXx8GteJyu9x2EinaHCn6y+QjtLmgC5iUjK/y4X+97/1Mtj0LqRjf2Ig4gGbcji9msa05eoL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gkLq5RkU; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gkLq5RkU"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3044e44ca;
	Mon, 12 Jan 2026 11:56:16 +0800 (GMT+08:00)
Message-ID: <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
Date: Mon, 12 Jan 2026 11:56:15 +0800
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
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de, ulf.hansson@linaro.org
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Marco Schirrmeister <mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bb058ed4309cckunm6534380e27c895
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhITFYaGRhMSB9CTUxKTE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gkLq5RkUHA/jjWV8Rk9VWuM4wzc6Zkhxh4l2+J8YzBQDeo+6LUx5DqvwVrTPt3RE8ZlKH9pOP2BWfyeSzwxRyYdR9RTR1NU1iIzSLk/0WsOZlyk+LQ43RybaNoXpmbjGiBQTewErGr5qmgbjF5TCVcD8xIDtHuhaRWh316d8Ktk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=M5HkEfQNGnj6jOwDHh//dxwlKfw3KT7shLqCV0JgOhc=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/12 星期一 9:32, Shawn Lin 写道:
> 在 2026/01/10 星期六 9:07, Marco Schirrmeister 写道:
>> This series addresses a microSD stability issue on the FriendlyElec
>> NanoPi R76S (RK3576). The board currently suffers from a 400kHz
>> retuning loop when the controller attempts to enter runtime-suspend
>> during idle periods.
>>
>> Evidence of the failure in dmesg:
>> [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>> [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 
>> 198000000Hz
>> [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully 
>> tuned phase to 233
>> [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>
> 
> Does this problem happen with all microSDs or just *a* microSD per
> your description?
> Have you ever tried to disable SDR104 support?
> 

A quick update.

I found several problems on RK3576 for supporting sd cards. I wondered
how all upstream RK3576 boards claiming SD support work? Anyway, I sent
a series to the list[1], not sure if it fixes the problem you faced, but
these should be the right patches you should have a try.


[1]https://lore.kernel.org/linux-rockchip/1768189768-96333-1-git-send-email-shawn.lin@rock-chips.com/T/#t

>> Testing confirmed that the issue can be manually addressed by
>> disabling runtime PM via sysfs:
>> echo on > /sys/devices/platform/soc/2a310000.mmc/power/control
>>
>> I experimented with various changes in the Device Tree, including
>> lowering the bus frequency and attempting to keep the power domains
>> active, but nothing stopped the retuning loop.
>> The issue only went away when I forced the controller to stay active
>> by disabling the runtime power management.
>>
>> This quirk is the only way I have found to keep the SDR104 link from
>> crashing on the NanoPi R76S, I am open to suggestions if there is
>> a better way to handle this in the driver or the DTS.
>>
>> Marco Schirrmeister (3):
>>    dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
>>    mmc: host: dw_mmc-rockchip: add rockchip,disable-runtime-pm quirk
>>    arm64: dts: rockchip: add stability quirk to NanoPi R76S
>>
>>   .../bindings/mmc/rockchip-dw-mshc.yaml        |  8 ++++++
>>   .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  |  1 +
>>   drivers/mmc/host/dw_mmc-rockchip.c            | 25 ++++++++++++++++---
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
> 
> 

