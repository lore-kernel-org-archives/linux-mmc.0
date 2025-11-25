Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com [220.197.31.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6621C9E1
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079224; cv=none; b=ZzKpIjyvm/s5kSMNW7/rSY82xLl6AMzmliOKQHWTCKYfem/Re64pI74E8Ia+ul1TGzAe9EFMTehI8N0sE5ot7tMjligKi/KW7MNcP1QRsTB7i4X7Ofr+PD7gPvLDk84/GeHDUlu5sMqynKA1ux+tlp7SJCtX903YVwZzpZlfn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079224; c=relaxed/simple;
	bh=vNzFqArEqWsUS5vWEks0XsAmvx3wYQVcvJX8++6wvAg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aLXRsmXpp+vRH7b6SQuzmTnMRBoylkM6uNj8NAI6LN+6Ay/6hvnSmcYXtONCXkOdCxNA7zlBGaWpYieKViQtOOx/GgTgXJQibQymbD24TTc8ZBSOyrc449Vjo5UwESEe7Z3CoqrkkUnifn8cthCguAZRybTF7H4542l+BIyA1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VYLqlwtL; arc=none smtp.client-ip=220.197.31.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VYLqlwtL"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ad997fe5;
	Tue, 25 Nov 2025 22:00:10 +0800 (GMT+08:00)
Message-ID: <c78eab31-d2f4-4d95-bb43-91feda233824@rock-chips.com>
Date: Tue, 25 Nov 2025 22:00:08 +0800
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
 <CAPDyKFp4B-=LDoc8xcLBaE-wX_H3t4BUDd99coyjxQZfbB0+GA@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFp4B-=LDoc8xcLBaE-wX_H3t4BUDd99coyjxQZfbB0+GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9abb508f5809cckunmb38fd0c64ada4f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkYQ1ZJGUhJGUwaS0lOGEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VYLqlwtLNNiPtuopBn9gi81XmTnM55mpOtAO8a0U9rUu71o18xZYEEfB3Pkec/jFJLVjKkiNr1bWkBvndL5wEkk0v/4iQv9NOmRv2/MER2CTN+5fLNADAJOq5yArUBrmJ0o5YcNLZux9Z2wpN6qXpLloSBBSrWaijkaYYE6DnCY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=OewcyCr0tT7m3k8G5MjG4pC3MLaLjYkWdxLQ0yoKx/I=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/25 星期二 20:33, Ulf Hansson 写道:
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
> I have walked through the series and overall this looks good to me,
> besides the comments on patch 3 and the obvious reported build
> problems.

Yes, I have fixed them locally and will look more into your comment on
patch 3.

> 
> Moreover, I would appreciate it if you could work a bit on the commit
> messages. No empty commit messages please - and try to describe a bit
> more on why/what each patch does.

Sure, will do.

> 
> Kind regards
> Uffe
> 

