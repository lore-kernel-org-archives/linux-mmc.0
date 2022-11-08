Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E548C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKHIfR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKHIfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:35:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2A1145B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667896510; x=1699432510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKJrzjG+bRmj1VC2Tjh8tPVeg76t7p98tJy0l6m3AG8=;
  b=Wfrx8dFhsnEzNBCJR8LxRSB5cEtwB2PZkJfRWODKmYfri6cXV7V8N2QY
   KpxvWuc2i+06H1PJybhUa4TtNhJfgNRGpaEe6yi4ePd+qjjd8VwwmBUS2
   P3ydViYbQ7PZYhsTvshMYICzATWtBXPPsQF2KhsRX3FHHo6HsN9NEw2/O
   5WXOqzpjE5b7ESwUCmqyMYHoXWyHswdL47JnR/yJNCPYGgU/nAVh8fo7G
   JsT0JTP/ErDyi7MC+O9qItup6yRuKhkduV1i+wBg1WMBRvpc+tM59mKRF
   dYIPLsfXKZsxZFXwYSoqGHUzjcGV1A4GhmaPIcgaDs4bNPpXL0wOyd63I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="294010783"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="294010783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:35:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587295788"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="587295788"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.164])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:35:04 -0800
Message-ID: <38161cf2-4e6e-dbb3-4743-a21657b92451@intel.com>
Date:   Tue, 8 Nov 2022 10:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Content-Language: en-US
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
 <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
 <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <0f8f0d91-9e1f-c71e-86a6-25a6bdb4f6b1@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/11/22 10:28, Shawn Lin wrote:
> On 2022/11/8 16:20, Adrian Hunter wrote:
>> On 8/11/22 09:25, Jyan Chou [周芷安] wrote:
>>> Hello Adrian Hunter,
>>>
>>> We are now using the upstream code of EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER, but we found that the existing driver cannot support the limitation of Synopsys IP.
>>>
>>> Synopsys IP has a description on their data book " While using DMA, the host memory data buffer size and start address must not exceed 128 MB".
> 
> Synopsys-based SDHCI IP does have a limitation of 128MB boundary. But it
> has already been solved by upstream driver.
> 
> FYI:
> 
> commit b85c997d2cfefe7d1f706b85ae46e35a50e3131c ("mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation")

CQHCI has its own DMA descriptors, so maybe a similar change is needed for CQHCI?

> 
>>>
>>> I am wondering whether there is a method or patch that can fix this boundary limitation.
>>> Thanks.
>>> Best Regards,
>>> Jyan Chou
>>
>> Hello Jyan Chou
>>
>> I am not clear on what the exact limitation is.  The driver never uses buffers as big as 128 MB.
>> To restrict DMA to low memory addresses a DMA mask can be used.
>>
>> But perhaps you mean not to cross a 128 MB boundary?
>>
>> Please cc your questions to the linux kernel mmc mailing list: linux-mmc@vger.kernel.org because others
>> can answer too.
>>
>> Regards
>> Adrian

