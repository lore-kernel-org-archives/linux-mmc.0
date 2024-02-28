Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71122065
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109393; cv=none; b=We4+TPdSleSv0kFJ7xF9Jeeb3UDczdxH3fjnimTJ6OJf4+RnV58YqXdAhcNDIlnJUGyzyKuH875RO5N0y6DhWFt5ZJM0DQVPzmZnokwajF3u/Si/aS8i5PrE3YWzasYIbT43cEZ6m0TZUa2CRdMew2URbD8Ts4lAh0GTP6HcebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109393; c=relaxed/simple;
	bh=O3m2CPVXT1UFb7iiGulyeajpF8q5Zkl6K8XtPQwdVoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIXtxhk4xh8RxwryyHMqRnFfy1W2i4D5PBEp0LNPQDZp4iaIbviIqRm8J3SnH8F0/Sj8a7Qq26UR7smoqOdHEryKa5hm80tgi+BBW6BYup6MJOfMEbd/PZ+EPT9ve6BAV7C0MLJMtPDcm1TZo+VjyvsVAQ+tLp1Ro94pRk1codk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHH+/qiR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHH+/qiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709109391; x=1740645391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O3m2CPVXT1UFb7iiGulyeajpF8q5Zkl6K8XtPQwdVoE=;
  b=SHH+/qiR/YSxtEs3wbmSnYJTVuQO8ioDLafGjSFnFNVDPaiSnI4qkYbf
   EMswTunbi0NvJ45kQ1GTpSsIU0Fy6LOcx2wNJ+AQxmTELwbWj8sO5lQfw
   3OrjW1TWStydDAu8CBSMkkz0XjMTwWmdS3ZQrYxKm2KBUfqDofzSrMn5q
   8AY1gELM8wedS4kobBZleQoO8mAo9yqudwlvISNpDtzZ1plvygT9z/EEQ
   wj0+V23HfnwY2UIaD3MKIAIzKDhNKhbzUPQCTdKeN0SRLkKmuE6qDEVoX
   j33lW6NRTgUNEzqSrZIbP6SGV3vLr0WqVxgPFH2/VhMUB/Opx2jVCqnZk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="21045421"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="21045421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 00:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11976101"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 00:36:29 -0800
Message-ID: <ce6709b3-b87a-4823-b4c8-b36f82195191@intel.com>
Date: Wed, 28 Feb 2024 10:36:24 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Angelo Dureghello <angelo.dureghello@timesys.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org
References: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org>
 <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com>
 <CACRpkdaRHz5LE_TpD7xkitX5ohafEvqOACx8PrEUuD-6oz-pUg@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CACRpkdaRHz5LE_TpD7xkitX5ohafEvqOACx8PrEUuD-6oz-pUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/24 10:40, Linus Walleij wrote:
> On Thu, Feb 22, 2024 at 7:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 22/02/24 02:00, Linus Walleij wrote:
>>> The sg_miter used to loop over the returned sglist from a
>>> transfer in the esdhc subdriver for SDHCI needs to know if
>>> it is being used in process or atomic context.
>>>
>>> This creates a problem because we cannot unconditionally
>>> add SG_MITER_ATOMIC to the miter, as that can create
>>> scheduling while atomic dmesg splats.
>>>
>>> Bit the bullet and make the .request_done() callback in
>>> struct sdhci_ops aware of whether it is called from atomic
>>> context or not, and only add the flag when actually called
>>> from atomic context.
>>>
>>> sdhci_request_done() is always called from process context,
>>> either as a work or as part of the threaded interrupt handler,
>>> so this will pass false for is_atomic, and the one case when
>>> we are actually calling .request_done() from an atomic context
>>> is in sdhci_irq().
>>>
>>> Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
>>
>> I notice, in fact, that the driver is already using a bounce
>> buffer always:
>>
>> static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
>> ...
>>         if (!host->bounce_buffer) {
>>                 dev_err(&pdev->dev, "bounce buffer not allocated");
>>                 err = -ENOMEM;
>>                 goto cleanup;
>>         }
>> ...
>>
>> Doesn't that mean the original patch is not needed?
> 
> TBH I just followed the pattern to handle sglists everywhere the same
> way.
> 
> I looked closer at it: on the write path what you say is definately correct:
> we copy the data to the bounce buffer and byte swap it in
> esdhc_mcf_copy_to_bounce_buffer() and that buffer is a GFP_KERNEL
> allocation so it will be in lowmem.
> 
> As we can see in sdhci_pre_dma_transfer() this is however as the name
> suggests only copying *to* the bounce buffer on mem->device transfers
> using DMA, i.e. when writing blocks. (Small writes is where we saw the
> big win with this bounce buffer when we wrote the code.)
> 
> In the case of incoming data, reading blocks, DMA will read data into the
> sglist locations, which are some physical memory. This could very well
> be in highmem, especially for prefetching. Then at the end of a read
> esdhc_mcf_request_done() is called to byteswap incoming data, and
> if that is in highmem we need this sg miter walking code.
> 
> So I think this code is needed, at least theoretically.
> 
> Then whether ColdFire m5441x will use highmem is another
> question. I don't know anything about the ColdFire memory configurations
> so I converted it on a "better safe than sorry"-basis.
> arch/m68k/include/asm/mcf_pgalloc.h makes an effort to avoid putting
> page tables into highmem, and I suppose that is for a reason so this device
> can actually have highmem?

Dunno

But passing around is_atomic seems ugly

And esdhc_mcf_buffer_swap32() doesn't sleep, so there should not
be a problem using kmap_atomic()

As an aside, gotta wonder why there is not:

#define SG_MITER_LOCAL_PAGE    (1 << 3)        /* use kmap_local_page */

