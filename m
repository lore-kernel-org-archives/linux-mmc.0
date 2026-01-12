Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com [220.197.32.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7D30BF79;
	Mon, 12 Jan 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206588; cv=none; b=N1lO+m7Z0mVzIZ/l6NtEeKLB725uJhMUyyylE7m4C+hjYIE9gnc86AbBHsv9tOV/hzbzpfldGU1gJ+tZ97h0FANTJhS67I/GsYNu70SZPZ760BdGub1K9DlbmmnNX7cH1QnlyigZiQkVKfE1oi+QlOz9701um/68lGbGDZwMSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206588; c=relaxed/simple;
	bh=sAWFENjPaUEYDRo7G7AuH3ugxbKc/Ba0RGACmmnomnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mauNLglVDprnAh0yzcP4MkQiBdQqyvLm4dI+BwA1P6x+LoLQlUZrzJkJvMnQFC2tMQeS1EVs+NPZdKP94UW324TXtmCqxrsref0F+XCTE8nYEdcdbFhfGe309QJ6C9s4jDDaiP39wuwhthZQYEs/+GHFr++7M29tcdGIL5LzyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Mz2WHVuM; arc=none smtp.client-ip=220.197.32.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mz2WHVuM"
Received: from [127.0.0.1] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 304edcf3d;
	Mon, 12 Jan 2026 16:29:41 +0800 (GMT+08:00)
Message-ID: <c3ee063c-ca11-44e4-9e7d-3861a82db3ea@rock-chips.com>
Date: Mon, 12 Jan 2026 16:29:37 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Shawn Lin <shawn.lin@rock-chips.com>,
 Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 heiko@sntech.de, ulf.hansson@linaro.org
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
 <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bb1533d8c03abkunm92c5f95a596e3e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9CSlYZGUgaQk5KTB0aSRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Mz2WHVuMW+7iMT6s/m6RA4cKPpvNWA5eAospboY6hfG3NKiR+1QnkgYooBlte1KHY4+ns2qePp1sfMRrsXRkGYSZK4i1/SBs1r9qhIDriuE7JDiTXQTo6Gs2mdlI7fMz/iKkcbaxz3vG9M0CFLUa/mIqZtuybHllIkLPUm9gVSI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3yzVRdrNoDKkroUAcz9fdq8LyCXDhJQxmbfKFPZcDZY=;
	h=date:mime-version:subject:message-id:from;

Hi Shawn,

On 1/12/2026 11:56 AM, Shawn Lin wrote:
> 在 2026/01/12 星期一 9:32, Shawn Lin 写道:
>> 在 2026/01/10 星期六 9:07, Marco Schirrmeister 写道:
>>> This series addresses a microSD stability issue on the FriendlyElec
>>> NanoPi R76S (RK3576). The board currently suffers from a 400kHz
>>> retuning loop when the controller attempts to enter runtime-suspend
>>> during idle periods.
>>>
>>> Evidence of the failure in dmesg:
>>> [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>> [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
>>> [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully tuned phase to 233
>>> [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>>
>>
>> Does this problem happen with all microSDs or just *a* microSD per
>> your description?
>> Have you ever tried to disable SDR104 support?
>>
> 
> A quick update.
> 
> I found several problems on RK3576 for supporting sd cards. I wondered
> how all upstream RK3576 boards claiming SD support work? Anyway, I sent
> a series to the list[1], not sure if it fixes the problem you faced, but
> these should be the right patches you should have a try.
> 
> 
> [1]https://lore.kernel.org/linux-rockchip/1768189768-96333-1-git-send-email-shawn.lin@rock-chips.com/T/#t
> 

I encountered a similar issue on the RK3576 EVB2. 

It seems that the cd-gpios feature are broken, so SD card events
cannot be detected. However, if the SD card is inserted before Linux
boots, it can at least start up. I suspect that other boards may behave
the same way :)

-- 
Best, 
Chaoyi
