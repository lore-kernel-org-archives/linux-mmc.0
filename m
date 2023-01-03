Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6FC3DA7D
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Jan 2023 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjACUxh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Jan 2023 15:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjACUxg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2023 15:53:36 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C3C740
        for <linux-mmc@vger.kernel.org>; Tue,  3 Jan 2023 12:53:35 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0248584CBD;
        Tue,  3 Jan 2023 21:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672779213;
        bh=K1dnp6jFdDcVZGPkCX3YiQdFfZNd51omn48BwlGMdzQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mCp+Uwoz/WqLQKVsvNPJeEaRbkZZbryE+VzuD8++ASbyUN3Db3xD1tFvxw49eVh3A
         JdScWc76LSNQeAQWgfUHYkuul2situVdfk/ArwE45GvbD5KmHQKRz01gNQGreFhTZN
         JQ/fJA+0+9Nrzl8z7umbu1F4bg7U4/wbXrtNXhX4DB3jgIpwHXg+AfeAmzpMKKNbeZ
         QEZYZmq763dgmd8rzOxCGE1P/wbavmqy0D0viGoplpHFh2Jai0cBY4Zm6OARiqyhj7
         UaBc7P5ycQ4sshjO36WpFkbEPUVCfr2gxoRzIIu04FKLa7Ohm7XwITn038iJ36URjD
         AFKL1w5jsxjXQ==
Message-ID: <feb69d12-54a7-7e55-1ec3-b94b845339a3@denx.de>
Date:   Tue, 3 Jan 2023 21:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Content-Language: en-US
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Goud, Srinivas" <srinivas.goud@amd.com>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <8b9d6dd1-01fa-5ae1-072e-c5dc7f8b553e@denx.de>
 <BY5PR12MB42584370EDE593D8DBB42CF8DBE89@BY5PR12MB4258.namprd12.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <BY5PR12MB42584370EDE593D8DBB42CF8DBE89@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/22/22 10:20, Potthuri, Sai Krishna wrote:
> Hi Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Wednesday, December 21, 2022 3:10 PM
>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Adrian Hunter
>> <adrian.hunter@intel.com>; linux-mmc@vger.kernel.org
>> Cc: Michal Simek <michal.simek@xilinx.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
>> SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
>>
>> On 12/21/22 06:09, Potthuri, Sai Krishna wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>>>>>
>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabil
>>>>>> it
>>>>>> ies.html#
>>>>>> Absolute Address  0x00FF160040 (SD0)
>>>>>> Reset Value       0x280737EC6481
>>>>>>
>>>>>> really reads 0x200737EC6481 . The interesting part is the top 32
>>>>>> bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The missing 0x800 is
>>>>>> SDHCI_RETUNING_TIMER_COUNT_MASK=0, which makes the SDHCI
>> core
>>>> disable
>>>>>> retuning timer.
>>>>>>
>>>>>> Fix this up here by explicitly setting tuning_count to 8 as it
>>>>>> should be, otherwise an eMMC might fail in various thermal
>>>>>> conditions
>>>>>>
>>>>>> Note that the diff is best shown with -w option, this makes it
>>>>>> visible what happened with !sdhci_arasan->has_cqe conditional,
>>>>>> which is placed between sdhci_setup_host() and __sdhci_add_host()
>> calls.
>>>>>> Since sdhci_add_host() is also a sequence of these two calls and
>>>>>> host->tuning_count must be overriden before calling
>>>>>
>>>>> overriden -> overridden
>>>>
>>>> Fixed
>>>>
>>>>>> __sdhci_add_host(), call the two calls separately and do all the
>>>>>> adjustments between them in either case.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>> ---
>>>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> To: linux-mmc@vger.kernel.org
>>>>>> ---
>>>>>>     drivers/mmc/host/sdhci-of-arasan.c | 57
>>>>>> ++++++++++++++++++++---------
>>>> -
>>>>>>     1 file changed, 38 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> index 3997cad1f793d..465498f2a7c0f 100644
>>>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> @@ -1521,37 +1521,56 @@ static int
>>>>>> sdhci_arasan_register_sdclk(struct
>>>> sdhci_arasan_data *sdhci_arasan,
>>>>>>        return 0;
>>>>>>     }
>>>>>>
>>>>>> -static int sdhci_arasan_add_host(struct sdhci_arasan_data
>>>>>> *sdhci_arasan)
>>>>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data
>>>> *sdhci_arasan,
>>>>>> +                             struct device *dev)
>>>>>>     {
>>>>>>        struct sdhci_host *host = sdhci_arasan->host;
>>>>>>        struct cqhci_host *cq_host;
>>>>>>        bool dma64;
>>>>>>        int ret;
>>>>>>
>>>>>> -    if (!sdhci_arasan->has_cqe)
>>>>>> -            return sdhci_add_host(host);
>>>>>> -
>>>>>>        ret = sdhci_setup_host(host);
>>>>>>        if (ret)
>>>>>>                return ret;
>>>>>>
>>>>>> -    cq_host = devm_kzalloc(host->mmc->parent,
>>>>>> -                           sizeof(*cq_host), GFP_KERNEL);
>>>>>> -    if (!cq_host) {
>>>>>> -            ret = -ENOMEM;
>>>>>> -            goto cleanup;
>>>>>> -    }
>>>>>> +    /*
>>>>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>>>> +     *
>>>>>> +     *
>>>>
>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.
>>>> html#
>>>>>> +     * Absolute Address  0x00FF160040 (SD0)
>>>>>> +     * Reset Value       0x280737EC6481
>>>>>> +     *
>>>>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>>>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0,
>> which
>>>>>> +     * makes the SDHCI core disable retuning timer.
>>>>>
>>>>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>>>>> "sdhci-caps-mask" ?
>>>>
>>>> No, I wasn't aware of those.
>>>>
>>>> Is that the preferred approach to this fix, over handling it in the driver ?
>>>>
>>>> I think the driver-side fix would be preferable, because it also
>>>> fixes systems which use legacy DTs without the sdhci-caps properties,
>>>> which would be all ZynqMP systems thus far.
>>>>
>>>> (and I would also still prefer to get feedback from Xilinx on why
>>>> does the value specified in UG1087 not match what is read out of the
>>>> hardware)
>>> Reset value of the retuning timer count is set to 0x0 via ZynqMP FSBL,
>>> we have an ERRATA for the same.
>>> https://support.xilinx.com/s/article/68550?language=en_US
>>>
>>> Xilinx recommendation is to program the appropriate value in the
>>> retuning timer count field based on the specific requirements via DT
>> property.
>>
>> Why is the retuning timer disabled for HS200 mode ?
> Based on discussions with the Xilinx IP design team, they told retuning is
> not required as Xilinx uses DLL for higher frequency modes.

Does this require the eMMC "DS" line ?

> So, we disabled retuning by default even in Xilinx next generation platforms
> like Versal.
> Even in our internal PVT testing also, without retuning we didn't see any issues.
> 
> Did you face any real issue without this re-tuning? If yes, could you please
> provide some details about the test case.

Yes, on devices with wider temperature range, the eMMC might suffer read 
failures over time.
