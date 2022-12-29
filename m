Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32735C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiL2Mws (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiL2MwA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 07:52:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262213FA6
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672318319; x=1703854319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qBNFHqfAWw0K0+6DvKFPNfJYBI1TpwZB8pN1Mm7JZoQ=;
  b=FnqnvKVm0h4t9HpnIrqaqkom46lRpVCvnzW54uqMBo6GxUDe8wnFDCGs
   XDXuZO8FWa/hXeT4uSybDf9RXW6raXRtY6Qlsc+XnA4TDnhDo+p9PjFvb
   oqu0bspJCl9sI2bUfgt7JivxSWE6RjfrwLyPDfrPhMFIKiNkuR1OYjXCG
   Txf1OSfmSgT58IWy+hzbdRHiTED1IP1meEq3BfxTgmXPsWOfqR/Lswuqe
   Vn2y7XlXszwRUuupPHvRy5NewUAEmcB/c6vdsixZSKDPFgEi1ZLXHIMXF
   WFeK8o0wqBt7h3JGCd5Pc0Tneh/1czxBT56G/Y+Vavhx87CDzsT73nWOj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="407300559"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="407300559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:51:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="827679114"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="827679114"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:51:57 -0800
Message-ID: <ebf570a1-3d2f-85d7-3a29-540caf9f576d@intel.com>
Date:   Thu, 29 Dec 2022 14:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/10/22 12:20, Marek Vasut wrote:
> On 10/26/22 08:07, Adrian Hunter wrote:
>> On 25/10/22 22:15, Marek Vasut wrote:
>>> On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>
>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>> Absolute Address  0x00FF160040 (SD0)
>>> Reset Value       0x280737EC6481
>>>
>>> really reads 0x200737EC6481 . The interesting part is the
>>> top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>> missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>> makes the SDHCI core disable retuning timer.
>>>
>>> Fix this up here by explicitly setting tuning_count to 8
>>> as it should be, otherwise an eMMC might fail in various
>>> thermal conditions
>>>
>>> Note that the diff is best shown with -w option, this makes it
>>> visible what happened with !sdhci_arasan->has_cqe conditional,
>>> which is placed between sdhci_setup_host() and __sdhci_add_host()
>>> calls. Since sdhci_add_host() is also a sequence of these two
>>> calls and host->tuning_count must be overriden before calling
>>
>> overriden -> overridden
> 
> Fixed
> 
>>> __sdhci_add_host(), call the two calls separately and do all
>>> the adjustments between them in either case.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> To: linux-mmc@vger.kernel.org
>>> ---
>>>   drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
>>>   1 file changed, 38 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 3997cad1f793d..465498f2a7c0f 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>>>       return 0;
>>>   }
>>>   -static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
>>> +                 struct device *dev)
>>>   {
>>>       struct sdhci_host *host = sdhci_arasan->host;
>>>       struct cqhci_host *cq_host;
>>>       bool dma64;
>>>       int ret;
>>>   -    if (!sdhci_arasan->has_cqe)
>>> -        return sdhci_add_host(host);
>>> -
>>>       ret = sdhci_setup_host(host);
>>>       if (ret)
>>>           return ret;
>>>   -    cq_host = devm_kzalloc(host->mmc->parent,
>>> -                   sizeof(*cq_host), GFP_KERNEL);
>>> -    if (!cq_host) {
>>> -        ret = -ENOMEM;
>>> -        goto cleanup;
>>> -    }
>>> +    /*
>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>> +     *
>>> +     * https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
>>> +     * Absolute Address  0x00FF160040 (SD0)
>>> +     * Reset Value         0x280737EC6481
>>> +     *
>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>> +     * makes the SDHCI core disable retuning timer.
>>
>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>> "sdhci-caps-mask" ?
> 
> No, I wasn't aware of those.
> 
> Is that the preferred approach to this fix, over handling it in the driver ?

I guess ideally.  Mainline does not really need the driver
fix because it seems it can be done by DT.  Older kernels
are a separate issue really.

> 
> I think the driver-side fix would be preferable, because it also fixes systems which use legacy DTs without the sdhci-caps properties, which would be all ZynqMP systems thus far.

You could backport support of the properties "sdhci-caps"
and "sdhci-caps-mask".

> 
> (and I would also still prefer to get feedback from Xilinx on why does the value specified in UG1087 not match what is read out of the hardware)
> 
> [...]

