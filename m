Received: from mail-m82132.xmail.ntesmail.com (mail-m82132.xmail.ntesmail.com [156.224.82.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B013FEE
	for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766284098; cv=none; b=kLAE3xjzP8n5fTxtw7kSf2vf5CltAiL3JwPzBapOzMlZWOpxxu8DWmmG1f7+L6OymwoX9N4LuBNgv8f12YrFhc8CuCherBBoSqEhCdrqk423LXqoUAxVUnpSaCna/s2XlPm/jsbVkZwuYf4yb4gkIU8xfN7IGKFUeRz3iFez9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766284098; c=relaxed/simple;
	bh=iXMRKxt/TrZaE50987yJoipq29Nlq6ouJp4NDH0O6iQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fmg5f3Pmh1j6JFM+kuBVRIcR00NL2BbbHvEYSc8YB6x/zqkueCcHvMHfDqyyAAAjjaMBjHAmzSobc4UaD6daXgum6EQL3JxZ61SeO5Bi9gixYVtXfB6VFv05TIH5jibWxdE+bO5ozb/WJxEckU554xqZa15dZFqafwaATn41tPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gJ5ao+44; arc=none smtp.client-ip=156.224.82.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gJ5ao+44"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dfe0b2d0;
	Sun, 21 Dec 2025 08:05:37 +0800 (GMT+08:00)
Message-ID: <84c0ae6a-5e1d-4bc0-bb00-81a92bf1aa34@rock-chips.com>
Date: Sun, 21 Dec 2025 08:05:34 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Remove struct dw_mci_slot
To: Marek Szyprowski <m.szyprowski@samsung.com>
References: <1766208126-42506-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20251220052224eucas1p18941ee450d7e8a0d0834f3f1d4f7bdf9@eucas1p1.samsung.com>
 <1766208126-42506-2-git-send-email-shawn.lin@rock-chips.com>
 <4707cf10-19e2-4253-8cc0-019eb0b83c95@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <4707cf10-19e2-4253-8cc0-019eb0b83c95@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b3e39da1909cckunm7ec08597167e96
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhMT1ZDGU5CQ0NOH01JHkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gJ5ao+44f99y7OQu0xESA470zILU3w24RI0zdR9bKgSQoZb6Avix8x1DPzgVfdePACXhtQuI0xjSoBOOHojr5TahSGoi0n1EUnQxDItDFUt2XwHDIvnKOTs/MtHmAkhVxdq2n4otim6UQn4/iKjCGPBEXMW/CKJm20LRW7szfEA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VHDjS1ik++lOghcW4+X1+kwuueBrV2mqZGv5C5dMfWY=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/21 星期日 6:44, Marek Szyprowski 写道:
> On 20.12.2025 06:22, Shawn Lin wrote:
>> Use dw_mci_alloc_host() helper to allocate struct dw_mci for dw_mmc-pci.c
>> and dw_mmc-pltfm.c. With that, we could get rid of struct dw_mci_slot and
>> remove it everywhere.
>>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Works fine on my Exynos based tests boards.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Thanks, Marek.

>> ---
>>
>>    drivers/mmc/host/dw_mmc-pci.c   |   7 +-
>>    drivers/mmc/host/dw_mmc-pltfm.c |   7 +-
>>    drivers/mmc/host/dw_mmc.c       | 227 +++++++++++++++++-----------------------
>>    drivers/mmc/host/dw_mmc.h       |  19 +---
>>    4 files changed, 103 insertions(+), 157 deletions(-)
>>
>> ...
> 
> Best regards

