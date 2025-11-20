Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E071335BAA
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643133; cv=none; b=AMCVUq/BPXbuULvo51Ns2LA7N4PcUR5WKy+4jJ2Yr+ACDCQYAcenbVJLzgXJ5bexW1QAQ3i4MQ/Vt3u9UHIQ3Zfh0pjsam5WlttcXMqZIVj1ganbTrzORSWIPkb1p8eE3I7bRFT+N4Yd2P0RY318dQ3RqsiE7FDjWpIqlmfP+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643133; c=relaxed/simple;
	bh=dErLscMg+v/v1lj+GYlIsZmMeFAzfxic17LgOTsJsgc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=io0EbsMqGatCBYue2WBH+HB9nVjocIyufIQDgzkLMWE8jaYQld/3p8HUH43GiGBDoRCeqyznVraAM3hIqNxeIbyHJHgIegw5xF6SlJ3XOLHl+/Dqhn614mE4WJ9yfq4NjF1DnqGPEUvh9U+5aoHaADCawCeQpqS2l9Q4y35u4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SBhQietU; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SBhQietU"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4ca136f;
	Thu, 20 Nov 2025 20:51:56 +0800 (GMT+08:00)
Message-ID: <dedc2dec-59f0-4656-b8d7-73d3e6a7c13e@rock-chips.com>
Date: Thu, 20 Nov 2025 20:51:55 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/13] dw_mmc cleanup
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqHM8VvpTVT-iAbPUvo2Q2EHhyZD2xpgWYTt-4oXrucUQ@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFqHM8VvpTVT-iAbPUvo2Q2EHhyZD2xpgWYTt-4oXrucUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa1524c5b09cckunmd3c5708c183a1f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx4ZH1ZPS0lOQ0xOGU0eS09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SBhQietUCieocswfH2r0vMjrDewciPBM7A8Ef12Q5y7qZn/SudjmEiqzIfxsZxDqzfeJ99gWL+5Tv3oMubbwsrODOKSREl/QvWCL5HNqk4+zdBzUvNAr1jfjOnSmn8EafROQfVHOZJX/diz9b1mxF36eUcufwg1/2lFZ/AuVf3A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=op+gMwCkleXRJoAz/s8HVvB9i4vG+LEN7C/cDFMSl/s=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 19:10, Ulf Hansson 写道:
> On Thu, 20 Nov 2025 at 11:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Ulf & Jaehoon
>>
>> As you can see, dw_mmc is likely one of the most complex and difficult-to-read
>> host driver at present. It maintains various states and bottom-half scheduling,
>> containing a significant amount of redundant code—including a multi-slot mechanism
>> that has been unsupported for over a decade.
>>
>> Jaehoon attempted to remove cur_slot more than ten years ago, but the driver still
>> retains the slot structure and the associated queue mechanism designed to support
>> multiple slots. This has made the already complex code even harder to read and maintain.
>>
>> The first four patches aim to eliminate some of the redundant code, while the remaining
>> patches are intended to ultimately remove the dw_mci_slot variable. To facilitate review
>> and minimize the risk of regression, each patch is designed to accomplish a single,
>> clear objective.
>>
>> This series have been tested on the RK3588S EVB1 platform.
> 
> Thanks for working on this! I had something similar on my todo list
> for dw_mmc for years, but never reached to actually work on it.
> Anyway, I will review the code shortly.

Thanks for helping review it. I found patch 8，12 and 13 need to be 
improved a bit after another round of self-reviewing, but they are
trival formatting issues. Will update onced get reviewed.

> 
> That said, would it be possible for you to step in and help Jaehoon
> with the maintenance going forward?
> 

As I do have other follow-up patches to improve this driver, it would be
good for me to keep an eye on changes of dw_mmc. So yes, I am OK
to step in and help review dw_mmc patches.


> Kind regards
> Uffe
> 
>>
>>
>>
>> Shawn Lin (13):
>>    mmc: dw_mmc: Remove unused struct dma_pdata
>>    mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
>>    mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci
>>    mmc: dw_mmc: Remove unused header files and keep alphabetical order
>>    mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
>>      dw_mci
>>    mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
>>    mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
>>    mmc: dw_mmc: Remove id from dw_mci_slot
>>    mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
>>    mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct
>>      dw_mci
>>    mmc: dw_mmc: Remove mrq from struct dw_mci_slot
>>    mmc: dw_mmc: Remove queue from dw_mci
>>    mmc: dw_mmc: Remove struct dw_mci_slot
>>
>>   drivers/mmc/host/dw_mmc-exynos.c      |   9 +-
>>   drivers/mmc/host/dw_mmc-hi3798cv200.c |   6 +-
>>   drivers/mmc/host/dw_mmc-hi3798mv200.c |  17 +-
>>   drivers/mmc/host/dw_mmc-k3.c          |  21 +-
>>   drivers/mmc/host/dw_mmc-pltfm.c       |   2 +-
>>   drivers/mmc/host/dw_mmc-rockchip.c    |   9 +-
>>   drivers/mmc/host/dw_mmc-starfive.c    |   5 +-
>>   drivers/mmc/host/dw_mmc.c             | 606 ++++++++++++++--------------------
>>   drivers/mmc/host/dw_mmc.h             |  83 ++---
>>   9 files changed, 297 insertions(+), 461 deletions(-)
>>
>> --
>> 2.7.4
>>
> 

