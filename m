Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D081C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiKHJOx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiKHJOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 04:14:48 -0500
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A91F9E9
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 01:14:47 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id E04A920428;
        Tue,  8 Nov 2022 17:14:44 +0800 (CST)
Message-ID: <dcac1f10-98a7-b831-005c-542b8a0d4337@rock-chips.com>
Date:   Tue, 8 Nov 2022 17:14:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
        Jisheng.Zhang@synaptics.com
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Content-Language: en-GB
To:     Adrian Hunter <adrian.hunter@intel.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
 <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkxLVkxJSU5OSENNTklNT1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxA6LDo4IT0YA0giVjMDSDI#
        EU4KCjFVSlVKTU1MQ0JDQ0NOTU5DVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhJQkI3Bg++
X-HM-Tid: 0a84568543bf2eb6kusne04a920428
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Jisheng Zhang

On 2022/11/8 16:34, Adrian Hunter wrote:
> On 8/11/22 10:28, Shawn Lin wrote:
>> On 2022/11/8 16:20, Adrian Hunter wrote:
>>> On 8/11/22 09:25, Jyan Chou [周芷安] wrote:
>>>> Hello Adrian Hunter,
>>>>
>>>> We are now using the upstream code of EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER, but we found that the existing driver cannot support the limitation of Synopsys IP.
>>>>
>>>> Synopsys IP has a description on their data book " While using DMA, the host memory data buffer size and start address must not exceed 128 MB".
>>
>> Synopsys-based SDHCI IP does have a limitation of 128MB boundary. But it
>> has already been solved by upstream driver.
>>
>> FYI:
>>
>> commit b85c997d2cfefe7d1f706b85ae46e35a50e3131c ("mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation")
> 
> CQHCI has its own DMA descriptors, so maybe a similar change is needed for CQHCI?

I didn't find this limitation in synopsys DW IP databook.

> 
>>
>>>>
>>>> I am wondering whether there is a method or patch that can fix this boundary limitation.
>>>> Thanks.
>>>> Best Regards,
>>>> Jyan Chou
>>>
>>> Hello Jyan Chou
>>>
>>> I am not clear on what the exact limitation is.  The driver never uses buffers as big as 128 MB.
>>> To restrict DMA to low memory addresses a DMA mask can be used.
>>>
>>> But perhaps you mean not to cross a 128 MB boundary?
>>>
>>> Please cc your questions to the linux kernel mmc mailing list: linux-mmc@vger.kernel.org because others
>>> can answer too.
>>>
>>> Regards
>>> Adrian
> 
