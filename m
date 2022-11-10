Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938F5C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 08:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKJIMD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Nov 2022 03:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiKJIMA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2022 03:12:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08018B26
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2022 00:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668067920; x=1699603920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=riGxzLx5wnc3Qa8+ajquEkzeTCy562XY1YDeH97Nc9E=;
  b=FhQw2iHmi7W13YK3px5SIz/eR+596T35Zp4DeIHkDugpgobtUuy7BF4+
   hPNNu7br2XmyU2Q2u+fojuRgimIhSCHGezSa9VPMbjNKFJqs888+NFTH8
   YIG2ME+CJoi7RoaWdU82JSq9M6kSR7qsz4YofVF2ctqFXAiwRvFZe05HQ
   4NXtu6LyFrJsbojNr2kXRofWvFpLCZAamvcLoOMJwlVzD1JA130zyv8qh
   mphF8C8dt3HnSX1eEQ4eYx93I5GwinzFPgbl/OtLQ08aagm0p3Qh5hsBD
   iajayMhjD3zlN54697gbCaX2nd2J9FEJoqUZsnPf+Xlt6omypl2xICB5N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290967861"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="290967861"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 00:12:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="742761556"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="742761556"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 00:11:58 -0800
Message-ID: <4849ce3d-d656-2a71-426d-b567667016a3@intel.com>
Date:   Thu, 10 Nov 2022 10:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
 <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
 <dcac1f10-98a7-b831-005c-542b8a0d4337@rock-chips.com>
 <20fda8f718384317a8393baefc553d1b@realtek.com>
 <82cfb880-4283-047b-c476-c23d06706b06@rock-chips.com>
 <c387c95ea0e9457e822e7ebf3aa98951@realtek.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c387c95ea0e9457e822e7ebf3aa98951@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/11/22 04:11, Jyan Chou [周芷安] wrote:
>> CQHCI has its own DMA descriptors, so maybe a similar change is needed for CQHCI?
>> So you do need a similar change for CQHCI
> 
>>> According to these comments, it is acceptable for us to update a patch to solve the limitation of 128MB boundary ?
> 	We have a patch and it works well on cmdq case.
> 	Thanks. 

If you have a patch, you can of course submit it.

> 
> -----Original Message-----
> From: Shawn Lin <shawn.lin@rock-chips.com> 
> Sent: Wednesday, November 9, 2022 11:46 AM
> To: Jyan Chou [周芷安] <jyanchou@realtek.com>
> Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>; Jisheng.Zhang@synaptics.com; Adrian Hunter <adrian.hunter@intel.com>
> Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
> 
> 
> On 2022/11/8 17:19, Jyan Chou [周芷安] wrote:
>>> CQHCI has its own DMA descriptors, so maybe a similar change is needed for CQHCI?
>>
>> I didn't find this limitation in synopsys DW IP databook.
>>>> I found it on page 84
> 
> I see, but it wasn't clear to me if this description on P84 is for CQ engine part as well.  But seems yes after checking with the IP vendor.
> So you do need a similar change for CQHCI in cqhci_host_alloc_tdl.
> 
>>
>> -----Original Message-----
>> From: Shawn Lin <shawn.lin@rock-chips.com>
>> Sent: Tuesday, November 8, 2022 5:15 PM
>> To: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>; 
>> Jyan Chou [周芷安] <jyanchou@realtek.com>; Jisheng.Zhang@synaptics.com
>> Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE 
>> (CQHCI) DRIVER
>>
>> + Jisheng Zhang
>>
>> On 2022/11/8 16:34, Adrian Hunter wrote:
>>> On 8/11/22 10:28, Shawn Lin wrote:
>>>> On 2022/11/8 16:20, Adrian Hunter wrote:
>>>>> On 8/11/22 09:25, Jyan Chou [周芷安] wrote:
>>>>>> Hello Adrian Hunter,
>>>>>>
>>>>>> We are now using the upstream code of EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER, but we found that the existing driver cannot support the limitation of Synopsys IP.
>>>>>>
>>>>>> Synopsys IP has a description on their data book " While using DMA, the host memory data buffer size and start address must not exceed 128 MB".
>>>>
>>>> Synopsys-based SDHCI IP does have a limitation of 128MB boundary. 
>>>> But it has already been solved by upstream driver.
>>>>
>>>> FYI:
>>>>
>>>> commit b85c997d2cfefe7d1f706b85ae46e35a50e3131c ("mmc:
>>>> sdhci-of-dwcmshc: solve 128MB DMA boundary limitation")
>>>
>>> CQHCI has its own DMA descriptors, so maybe a similar change is needed for CQHCI?
>>
>> I didn't find this limitation in synopsys DW IP databook.
>>
>>>
>>>>
>>>>>>
>>>>>> I am wondering whether there is a method or patch that can fix this boundary limitation.
>>>>>> Thanks.
>>>>>> Best Regards,
>>>>>> Jyan Chou
>>>>>
>>>>> Hello Jyan Chou
>>>>>
>>>>> I am not clear on what the exact limitation is.  The driver never uses buffers as big as 128 MB.
>>>>> To restrict DMA to low memory addresses a DMA mask can be used.
>>>>>
>>>>> But perhaps you mean not to cross a 128 MB boundary?
>>>>>
>>>>> Please cc your questions to the linux kernel mmc mailing list:
>>>>> linux-mmc@vger.kernel.org because others can answer too.
>>>>>
>>>>> Regards
>>>>> Adrian
>>>
>>
>> ------Please consider the environment before printing this e-mail.

