Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962D33C18E;
	Fri, 19 Dec 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144916; cv=none; b=CotUottBvszdZPBjgSmcu7ROTPFPQsue5voCJ7AZuarmDJJy20TpiHFjUh5mYFqVNs6DWzpwJyFI6Udn73jgG9WGV7JgkT9Nr5fSydXDry6cE52O8irDMI51j7PmIcezqzAfogfF5Nl26QzVXm7o26Kjux59SaQr8YJcwmZy6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144916; c=relaxed/simple;
	bh=gpL48Oht5RUJp6VZ0xUKculnaj1Bm4MTyX6Jl2jr164=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B5R4KPqWUUj1Yqe2FwuNWfaNNX5nfaL9KK2gy9eyGlTkelSX+2KKdFJ3H2eXt3+2gt8bxBn4QQVC+Mwx7l5i5as7NXLSRrttwG7tIPwTS0VM71otoUV2ODenW2pS0Dm6HqLsplEXONTJ+CwQi+wG3w8Kb+KMrRieStoIJbi+6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JhhifqZq; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JhhifqZq"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2de56a93a;
	Fri, 19 Dec 2025 19:48:22 +0800 (GMT+08:00)
Message-ID: <ded6ac69-bc6d-46e6-a136-e4a16264d44b@rock-chips.com>
Date: Fri, 19 Dec 2025 19:48:18 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>
 <1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
 <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
 <CAPDyKFpfU5Qxutx9WTz=4H0mbsvfsScWvTDi1KqP1Ab5_iaAjA@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFpfU5Qxutx9WTz=4H0mbsvfsScWvTDi1KqP1Ab5_iaAjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b3670858a09cckunmaab57eb4b4c5a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1CS1YaGBgdHx5IGkNCTkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JhhifqZqypdYalovHZE75rsSanzVUFJZOoiKUBIjuzQnETpei27h8RU2GdygfvFCcyvUUSkPY9/4hgQ0AHiNBQ3hmf3o6jULAF00FPUdIIWPvj3uvYSiMdFF7E45aA4nKShH7rxEu7+3yPFS2EF/6chXyN0lrga4r0yowSqw3oE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=TiMlQDUnbWYNNyOQDJ4k+oQqCKc9j11qp1UBoFiZ14c=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/19 星期五 18:59, Ulf Hansson 写道:
> On Thu, 18 Dec 2025 at 19:23, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> On 16.12.2025 12:50, Shawn Lin wrote:
>>> This patch sets struct dw_mci as mmc_host's private data by
>>> copying struct dw_mci passing to dw_mci_probe() in order to
>>> achieve with mminimal changes. Then we remove slot everywhere.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
>> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
>> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
>> strange, as it works fine on other, similar, Exynos5422 based Odroid
>> boards. On Odroid-HC1 no MMC card is detected at all after this patch. I
>> briefly checked the code and I don't see anything suspicious besides
>> this host vs. local_host structure copying... Reverting $subject patch
>> on top of linux-next fixes this issue.
> 
> Indeed that copying looks suspicious. In principle we end up with two
> different data structures for the struct dw_mci host, as the callers
> of dw_mci_probe() have already allocated one that they may operate
> upon too.
> 
> Instead of doing it like $subject patch implements, the allocation
> should be done only once, upfront by the callers of dw_mci_probe().
> 
> That said, I am dropping the $subject patch for now from my next branch.
> 
> Shawn, please re-work the code according to the above. Even if that
> doesn't fix the problem, it's still the right thing to do.

I must admit that it's not the best way to implement as $subject patch.
Sure, I will rework the code. Sorry for that.

> 
> [...]
> 
> Kind regards
> Uffe
> 
> 

