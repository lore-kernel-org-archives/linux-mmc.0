Received: from mail-m1973176.qiye.163.com (mail-m1973176.qiye.163.com [220.197.31.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CE320A14;
	Fri, 19 Dec 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147171; cv=none; b=SOLCDUan2rgB6gx7gmxgJ1dco8wPpCUuP75xnYfkHbXE/ghq8/UPy3Aw7dG7eRkId8Zds1WIhG3hfni5wK8Zb/Lu/A9zDXEtXGdOhfdH7EPQ6tktSGTjq3VkszpADCb1C+rt+D8iNc8uitKj3lvgjw84LhAsqNGlwsBSHuXf8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147171; c=relaxed/simple;
	bh=/5sXIn9JHB4By2fMdwprcYPZ97dwckcX0QlXStYrrSE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2RDu8/4zHkaiiipYK7vklgyy9xN8VeJD4s07NJYkWD7v+s5VWuQU/f6EXHv69z3zYiraJaonB8RHQDf9D4ToQ+e+NgEfOfrG6QKwpvkymkCndRMhcIbwVNqbnOCMEF+cU4MYXzIHVGGzI3xpHlYGXrDb51Umt1i1cL7VM+XWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=E6Sq8rni; arc=none smtp.client-ip=220.197.31.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="E6Sq8rni"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2de61eb17;
	Fri, 19 Dec 2025 20:25:54 +0800 (GMT+08:00)
Message-ID: <85c3ab2e-e948-440f-847a-74b006b1a0b2@rock-chips.com>
Date: Fri, 19 Dec 2025 20:25:53 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <9af391bb-b607-481e-9d12-35b892469a06@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b3692e0bc09cckunm2b41111eb84b7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0weS1YaTBhOTRpLSBgeTB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E6Sq8rniSvznUMtWfJk76RtrpD28TjdxhREJkciQlst291cnk8wqd+l1jAqSBoQE67cL1pDT2xHNBbUbe+66Qo/bKvVWAK9VoZm6Gx1RZDwww8pNZ2GKI2uR5xNkBghpvX8N02GUuH18lTvss0i0IGQWp06Xvo7Du8Bz3UL5Xq4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=amEsueT6NgILjaWM9X/Ne3m6waRdMZuPS/h0LujePsA=;
	h=date:mime-version:subject:message-id:from;


在 2025/12/19 星期五 19:59, Marek Szyprowski 写道:
> On 19.12.2025 02:47, Shawn Lin wrote:
>> 在 2025/12/19 星期五 2:23, Marek Szyprowski 写道:
>>> On 16.12.2025 12:50, Shawn Lin wrote:
>>>> This patch sets struct dw_mci as mmc_host's private data by
>>>> copying struct dw_mci passing to dw_mci_probe() in order to
>>>> achieve with mminimal changes. Then we remove slot everywhere.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
>>> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
>>> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
>>> strange, as it works fine on other, similar, Exynos5422 based Odroid
>>> boards. On Odroid-HC1 no MMC card is detected at all after this patch. I
>>
>> Sorry for breaking Odroid-HC1 board. Indeed, it's strange other
>> Exynos5422-based bards work fine, as this patch wasn't supposed to be
>> board depend, even SoC depend. Looking closely again, still have no
>> idea what is happening on Odroid-HC1. I have no Odroid-HC1 board to
>> debug, could you kindly help applied the attached debug patch and
>> share the log?  Thanks.
> 
> I've played a bit with that code and the $subject patch breaks
> propagating -EPROBE_DEFER from mmc_regulator_get_supply(). This fixes
> the problem:
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8a0362257a2c..6be95a440ee9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3428,6 +3428,7 @@ int dw_mci_probe(struct dw_mci *host)
>           local_host = dw_mci_init_host(host);
>           if (IS_ERR(local_host)) {
>                   dev_dbg(host->dev, "host init failed\n");
> +               ret = PTR_ERR(local_host);
>                   goto err_dmaunmap;
>           }
> 
> BTW, the $subject patch also lacks fixing drvdata in dw_mmc-pci.c.
> 
> I think it would make a bit sense to simply pass dev, pdata, regs, irq
> and flags as parameters to dw_mci_probe() instead of the second copy of
> the dw_mci structure. Or alternatively move these to the additional
> structure and pass a pointer to it.
> 

Thanks for debugging, really appreciate!
I am going to rework it according to your and Ulf's suggestion.

> Best regards

