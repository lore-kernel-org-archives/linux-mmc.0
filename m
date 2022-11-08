Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B04BC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiKHIhr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKHIhq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:37:46 -0500
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 00:37:45 PST
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67A5F89
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:37:45 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id C877020185;
        Tue,  8 Nov 2022 16:28:25 +0800 (CST)
Message-ID: <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
Date:   Tue, 8 Nov 2022 16:28:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
Content-Language: en-GB
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEseVkMZQkhDGB5MTB4dTlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6SSo6Ez0jA0gqEgotDwIy
        Lk8KCx1VSlVKTU1MQ0JNSktNSUNMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlMSkg3Bg++
X-HM-Tid: 0a84565adbc92eb6kusnc877020185
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022/11/8 16:20, Adrian Hunter wrote:
> On 8/11/22 09:25, Jyan Chou [周芷安] wrote:
>> Hello Adrian Hunter,
>>
>> We are now using the upstream code of EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER, but we found that the existing driver cannot support the limitation of Synopsys IP.
>>
>> Synopsys IP has a description on their data book " While using DMA, the host memory data buffer size and start address must not exceed 128 MB".

Synopsys-based SDHCI IP does have a limitation of 128MB boundary. But it
has already been solved by upstream driver.

FYI:

commit b85c997d2cfefe7d1f706b85ae46e35a50e3131c ("mmc: sdhci-of-dwcmshc: 
solve 128MB DMA boundary limitation")





>>
>> I am wondering whether there is a method or patch that can fix this boundary limitation.
>> Thanks.
>> Best Regards,
>> Jyan Chou
> 
> Hello Jyan Chou
> 
> I am not clear on what the exact limitation is.  The driver never uses buffers as big as 128 MB.
> To restrict DMA to low memory addresses a DMA mask can be used.
> 
> But perhaps you mean not to cross a 128 MB boundary?
> 
> Please cc your questions to the linux kernel mmc mailing list: linux-mmc@vger.kernel.org because others
> can answer too.
> 
> Regards
> Adrian
