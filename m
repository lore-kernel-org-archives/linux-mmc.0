Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com [220.197.32.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CE1CEAA3
	for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438085; cv=none; b=hB1uamxpLhjAQflnJ2JleHKkFPFCOB/1Hw6c0bbiAlReL7E2lmAA8LsnYeHHC2j/tk6d1zWTqsimL3tlspwhEw/CxkGnAwCUOj/QGkKSiPhRAZKeOj8VXvabRBEpFJq+VXeqziEkQMNmZU7nUrL4NQYrja8qMRzji244YbD45iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438085; c=relaxed/simple;
	bh=8RM/toVLki4f3+EJRfwMjLDQu4cjunm944fWzHp8nRE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GKi2l8DaUNE82IuA47XRgb7GonWfKstDrk6yYhgaTEkBiHhI3s4atlURgYZgnkTHke88QL6jBLUticYNYzrHcA6TEBlldi3i+nkAfu30MlcvAxBV13EGWDN12e5C7s6mGi+qhutpcKexgNEclt9XwbU0C9/dWfzMQEX6RfwobiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HO8z+Upk; arc=none smtp.client-ip=220.197.32.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HO8z+Upk"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 320303b62;
	Mon, 26 Jan 2026 22:34:33 +0800 (GMT+08:00)
Message-ID: <9bed7572-d4f2-4d48-af14-61aecdc1b1f0@rock-chips.com>
Date: Mon, 26 Jan 2026 22:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 15/18] mmc: dw_mmc: Remove check before calling
 mmc_regulator_set_vqmmc()
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
 <1767665829-183001-16-git-send-email-shawn.lin@rock-chips.com>
 <CGME20260126132209eucas1p17cd332f56bbe6aa2f168d50b44626ebe@eucas1p1.samsung.com>
 <55a29373-fe1f-4628-9e0e-e1ade3a64edd@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <55a29373-fe1f-4628-9e0e-e1ade3a64edd@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bfaba511c09cckunm9103272f15aaa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgeH1YZHkseGB1LTElPHUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HO8z+UpkRl4zUDAjN2FZq3IHfVensdkqPBAjait1oo3l2LS9wMztJ/D7QBH7XaKGkvwDuvZyfBSWkUl4wrlAZdpX5BOHunafizdvnQX2ZoBS0xiPK/43MQPDqWwayZU+U70vW4N5qk30yjBn7yF6SEYTJB/OUQypIPt6IJ5qaz0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PASLXqfk/0Ws0/An6rtWWMj7lHVlcRsYgqXDZ1L2nKw=;
	h=date:mime-version:subject:message-id:from;

Hi Marek,

在 2026/01/26 星期一 21:22, Marek Szyprowski 写道:
> On 06.01.2026 03:17, Shawn Lin wrote:
>> The vqmmc regulator is acquired as optional via devm_regulator_get_optional().
>> The helper function mmc_regulator_set_vqmmc() currently returns -EINVAL when
>> vqmmc is not present. This patch justifies why this error code is acceptable
>> within the dwc driver's usage context.
>>
>> The function is invoked in two scenarios:
>> 1. In mmc_set_initial_signal_voltage(): The return value is ignored, so
>>      returning -EINVAL is harmless.
>> 2. In mmc_host_set_uhs_voltage(): This higher-level UHS voltage setting
>>      procedure should not be attempted if the vqmmc regulator is not available
>>      in the first place. Thus, signaling an error is the correct behavior.
>>
>> In both call paths, returning -EINVAL for a missing optional regulator
>> does not introduce regressions.
>>
>> So this patch removes the check and still returns error to the core, instead
>> of zero, if vqmmc isn't present.
> 
> Unfortunately this change, merged recently to linux-next as commit
> 9157b7f91ed6 ("mmc: dw_mmc: Remove check before calling
> mmc_regulator_set_vqmmc()"), introduces a regression: it breaks probing
> of the built-in eMMC storage device on Samsung Exynos3250 based Rinato
> board (arch/arm/boot/dts/samsung/exynos3250-rinato.dts). In the kernel
> log there are only a few lines about EINVAL error:
> 

I overlooked the case where vqmmc is optional with HS. Thanks for
reporting it. Before we drop the check, I think more things should be
done to improve mmc_regulator_get_supply() to distinguish -ENODEV with
other errors.Given it's nearly merge window, let's consider to drop
patch 15 and  patch 18(which you reported boot unstable) and rework
after then in the next cycle.

Thanks.

> dwmmc_exynos 12510000.mmc: IDMAC supports 32-bit address mode.
> dwmmc_exynos 12510000.mmc: Using internal DMA controller.
> dwmmc_exynos 12510000.mmc: Version ID is 260a
> dwmmc_exynos 12510000.mmc: DW MMC controller at irq 65,64 bit host data
> width,128 deep fifo
> mmc_host mmc0: card is non-removable.
> mmc0: error -22 whilst initialising MMC card
> mmc_host mmc0: Bus speed = 50000000Hz (req 100000Hz, actual 100000HZ div
> = 250)
> mmc0: error -22 whilst initialising MMC card
> mmc0: Failed to initialize a non-removable card
> 
> It looks that the vqmmc regulator is optional and eMMC chip can switch
> to HS without changing the (optional) regulator voltage. Without this
> patch the mmc0 is probed properly on this board:
> 
> mmc_host mmc0: card is non-removable.
> mmc_host mmc0: Bus speed = 50000000Hz (req 400000Hz, actual 396825HZ div
> = 63)
> mmc_host mmc0: Bus speed = 50000000Hz (req 52000000Hz, actual 50000000HZ
> div = 0)
> mmc_host mmc0: Bus speed = 100000000Hz (req 100000000Hz, actual
> 100000000HZ div = 0)
> mmc0: new HS200 MMC card at address 0001
> mmcblk0: mmc0:0001 F5X5MA 3.64 GiB
> mmcblk0boot0: mmc0:0001 F5X5MA 4.00 MiB
> mmcblk0boot1: mmc0:0001 F5X5MA 4.00 MiB
> mmcblk0rpmb: mmc0:0001 F5X5MA 512 KiB, chardev (244:0)
> 
> Best regards

