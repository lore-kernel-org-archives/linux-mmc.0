Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com [101.71.155.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D72E7F27;
	Sat, 20 Dec 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766209282; cv=none; b=fapdwIzB06t6nt53oSnIegM+IqIAX1YOWFKN0Pbv3soUKUUHZmlG76iP6Kdd8ezlsn0joadrRWXKTAX5kHlKtNa3qe25EWi35n9db9hYl1uyTv4lMNHLYD/zGZIix5WI0aQy7vtaQGE/fqTdWjHe0UAwnXuPcFUXiRO8c9hndf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766209282; c=relaxed/simple;
	bh=CSZMIKdNKpJx7QhONJLdsYbKl4leLT99pSR/IH8/lFk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nP9GX1borM9WeIsCpJ7u39hHVxsaeQh4nULjII+WOT/JRYJxjwcLB2CeQvb0OP+WmRONVqMzh9m27T5MNbxvOllCYGiuZPeCP2I+9CQ5wxY/ouzfSRFzrhwRb8xSPdIjBrir5KHNQc6wYcOOWb8ow0eeKoMHkgA2ZyfFTaHh970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DX0Jp296; arc=none smtp.client-ip=101.71.155.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DX0Jp296"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2df48b62d;
	Sat, 20 Dec 2025 13:41:06 +0800 (GMT+08:00)
Message-ID: <f7dde976-6377-4abd-a42b-61209228cda3@rock-chips.com>
Date: Sat, 20 Dec 2025 13:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>,
 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Marek Szyprowski <m.szyprowski@samsung.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
 <1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
 <CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>
 <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
 <dbee3e27-d158-43d3-88ca-a9f3a3264af7@rock-chips.com>
 <9af391bb-b607-481e-9d12-35b892469a06@samsung.com>
 <85c3ab2e-e948-440f-847a-74b006b1a0b2@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <85c3ab2e-e948-440f-847a-74b006b1a0b2@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b3a46a47a09cckunmd3cd05c811583a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQksZSlZKHR5KQx0eQ09MSkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DX0Jp296y3HzpVq1uBEZhmJJE6W/vV+Fp3j9O+1CpzQHvmmbAupeOP0cF/zi0SSxixRGpBW8D24vyHqnAHcG8vS2wCCNug771hcuyRQhHoh21Q2UNar4XOuuSx5JX2Skvi796gDAh0SqOy5+waGodD8D1WTJAvTqI2bpkrffzzQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=x+2yG2/aRYOlG9/xDN/JquR8moFGd8cpbqGvp046SN0=;
	h=date:mime-version:subject:message-id:from;

Hi Marek

在 2025/12/19 星期五 20:25, Shawn Lin 写道:
> 
> 在 2025/12/19 星期五 19:59, Marek Szyprowski 写道:
>> On 19.12.2025 02:47, Shawn Lin wrote:
>>> 在 2025/12/19 星期五 2:23, Marek Szyprowski 写道:
>>>> On 16.12.2025 12:50, Shawn Lin wrote:
>>>>> This patch sets struct dw_mci as mmc_host's private data by
>>>>> copying struct dw_mci passing to dw_mci_probe() in order to
>>>>> achieve with mminimal changes. Then we remove slot everywhere.
>>>>>
>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
>>>> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
>>>> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
>>>> strange, as it works fine on other, similar, Exynos5422 based Odroid
>>>> boards. On Odroid-HC1 no MMC card is detected at all after this 
>>>> patch. I
>>>
>>> Sorry for breaking Odroid-HC1 board. Indeed, it's strange other
>>> Exynos5422-based bards work fine, as this patch wasn't supposed to be
>>> board depend, even SoC depend. Looking closely again, still have no
>>> idea what is happening on Odroid-HC1. I have no Odroid-HC1 board to
>>> debug, could you kindly help applied the attached debug patch and
>>> share the log?  Thanks.
>>
>> I've played a bit with that code and the $subject patch breaks
>> propagating -EPROBE_DEFER from mmc_regulator_get_supply(). This fixes
>> the problem:
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 8a0362257a2c..6be95a440ee9 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3428,6 +3428,7 @@ int dw_mci_probe(struct dw_mci *host)
>>           local_host = dw_mci_init_host(host);
>>           if (IS_ERR(local_host)) {
>>                   dev_dbg(host->dev, "host init failed\n");
>> +               ret = PTR_ERR(local_host);
>>                   goto err_dmaunmap;
>>           }
>>
>> BTW, the $subject patch also lacks fixing drvdata in dw_mmc-pci.c.
>>
>> I think it would make a bit sense to simply pass dev, pdata, regs, irq
>> and flags as parameters to dw_mci_probe() instead of the second copy of
>> the dw_mci structure. Or alternatively move these to the additional
>> structure and pass a pointer to it.
>>
> 
> Thanks for debugging, really appreciate!
> I am going to rework it according to your and Ulf's suggestion.

I just sent out a simpler version(you was CCed) which introuces
dw_mci_alloc_host() to help get rid of dw_mci_slot. Much appreciate it
if you could help test/review it on your boards. :)

> 
>> Best regards
> 
> 

