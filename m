Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com [101.71.155.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB91264627
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853673; cv=none; b=kBpdCyksesEFWwAQLjxSPGMRsfsTSk9odhY22TdHJJfFalkkedlRxgzSch5KjyU0zVtRBw6Ynp9XC8sXBb1R5Pq3wkE/AMq4Op9LcyR2Sak1M8fP1zO/8gY/pSndOavQQUIFGEr2ANSO2V7k4EVtSHK8LxIWSwPCoRP8fRw8llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853673; c=relaxed/simple;
	bh=k6puD8twACJkT1allEHzRbdRg7JXFZBVm6zVSIVY/Fw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ehDnJrQ/ztR2mJU2w2HCGx8oqQJd0HaPG7e/D8wYdCQeXsLCjS7UmyFzgRwCQfYXzC+CLpJ57XAI7pX82ldDPbxLce4GVMtZaBdAwuOws+/QWPXK2PgS8cnbg9wTIGbBwBjZgIouKSVXvx/Tj4Vh48qyAUjgbbnzx6qTrJkzIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cEAodIy1; arc=none smtp.client-ip=101.71.155.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cEAodIy1"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 292e615d9;
	Tue, 11 Nov 2025 17:34:20 +0800 (GMT+08:00)
Message-ID: <85adb746-4ad8-425d-bea0-0e43f3158986@rock-chips.com>
Date: Tue, 11 Nov 2025 17:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC
 in HS400 for Rockchip
To: Anand Moon <linux.amoon@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
References: <20251111072158.6686-1-linux.amoon@gmail.com>
 <b749faf3-b197-4b78-a918-501a639a8f4d@rock-chips.com>
 <CANAwSgTs1dqyF8UfizOP-8Yt4kxeRD+7ebZGkXuVbMe5HqT-XQ@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CANAwSgTs1dqyF8UfizOP-8Yt4kxeRD+7ebZGkXuVbMe5HqT-XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7244260f09cckunmd312f0c314f26cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1ISlZPQ0JLSEMYQkkfHUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cEAodIy1Pxi34xwhTNwM8JwAOcJ5UY7W92FykKYWI2pATHMS8qUqQNvow1J5pC1bq2hfk9CeUlcIHy/GD2ZogcO156qVsfn12xJiKgPV84Mpwdmuo8C5p8TNXgEtHS7dcarWLxBytA8UEdjnVnoj8kTwAvxVnt37m7FbySGptyo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=huwCfXN1YvJd6gyUsGxIsd4QnIMBfT4d8w3vxg5y/Jc=;
	h=date:mime-version:subject:message-id:from;

+ Fukaumi-sang

在 2025/11/11 星期二 17:11, Anand Moon 写道:
> Hi Shawn,
> 
> Thanks for your review comments.
> On Tue, 11 Nov 2025 at 13:09, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2025/11/11 星期二 15:21, Anand Moon 写道:
>>> As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
>>> enhanced strobe mode, set the card type to eMMC in HS400 during clock
>>> configuration. This bit instructs Host to sample the CMD line using data
>>> strobe for HS400 mode.
>>>
>>
>> Did you really test the latest kernel?
> Yes, with the fio command, testing before and after this patch on a
> Radxa Rock 5b eMMC.


The commit msg says RK3588, but it already supported enhanced strobe...

Quote a boot log from V6.18-rc5 of a RK3588 board without any patch:

[    0.544447] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    0.545540] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
[    0.548983]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8
[    0.550874] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB
[    0.552682] mmcblk0boot1: mmc0:0001 BJTD4R 4.00 MiB
[    0.554334] mmcblk0rpmb: mmc0:0001 BJTD4R 4.00 MiB, chardev (509:0)

So the whole patch makes no sense.

> 
> $ dmesg | grep mmc
> [   16.321495] [     T60] mmc0: SDHCI controller on fe2e0000.mmc
> [fe2e0000.mmc] using ADMA
> [   16.425317] [     T72] mmc0: new HS400 Enhanced strobe MMC card at
> address 0001
> [   16.449670] [     T72] mmcblk0: mmc0:0001 SLD64G 57.6 GiB
> [   16.550133] [     T72]  mmcblk0: p1 p2
> [   16.577289] [     T72] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> [   16.641182] [     T72] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
> [   16.699865] [     T72] mmcblk0rpmb: mmc0:0001 SLD64G 4.00 MiB,
> chardev (234:0)
> 
>> HS400ES for Rockchip platform has been supported for 3 years..
>>
> The only modification made was to enable the strobe bit in the eMMC control.

sdhci_dwcmshc_rk35xx_ops->dwcmshc_set_uhs_signaling（） set it... please
check the code.

>> please see commit c6f361cba51c536e7a6af31973c6a4e5d7e4e2e4
>>
> Based on my analysis and the RK3568 TRM, neither the RK3566 nor the
> RK2568 supports
> HS200 or HS400 modes.

There is no a chip called RK2568, so I assume you meant RK3568?
RK3566/RK3568 support HS200, but not HS400（HS400ES also）, so we didn't
add properties in the DT. This is not because of the code, but the
chip design reason.


> 
> Thanks
> -Anand
> 

