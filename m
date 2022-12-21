Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C7C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiLUJjw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 04:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiLUJjv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 04:39:51 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F2A1869D
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 01:39:48 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id ED01685411;
        Wed, 21 Dec 2022 10:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671615586;
        bh=pMrEoDlUNww56eWKjSiP2cpnIvYbKw7buj1wwmueCuY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rTl37jfHbhFKs7WQt///ePqLXBmcLkXcFl3fkWPCM5WX6S38GJJ/m3XnIJL3pS2fR
         JaJ95TLLK1yu9vHbynEY3NcrUF98opE6Uc5q+w+rkSLoKFE6psl8t9reAAIOR/epQ2
         SdHqaQusZ4vIylgko5EQsvTO2Hx1jZtid2v4owh461VYDd1giCPcMwIH+n37yPatGI
         9b0qBjyzyOWJtsLonNJRumEOby2rHIHcFqlVwXOrxpZv/DFQjP0xF6uMWgYduQyR92
         Ni4EX9b5dIqoqAL+3SBKBtkkPNGuDdP54KRrdgpVgAVoqObo2fqTfRg77cyMVXrV2m
         kNOKLeHEgAyUQ==
Message-ID: <8b9d6dd1-01fa-5ae1-072e-c5dc7f8b553e@denx.de>
Date:   Wed, 21 Dec 2022 10:39:44 +0100
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
        <linux-arm-kernel@lists.infradead.org>
References: <20221025191500.149167-1-marex@denx.de>
 <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
 <c3d62448-fd1c-066c-aa53-2df7eae1555d@denx.de>
 <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <BY5PR12MB425809920721B2CBC5A4F517DBEB9@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/21/22 06:09, Potthuri, Sai Krishna wrote:
> Hi Marek,

Hi,

>>>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilit
>>>> ies.html#
>>>> Absolute Address  0x00FF160040 (SD0)
>>>> Reset Value       0x280737EC6481
>>>>
>>>> really reads 0x200737EC6481 . The interesting part is the top 32
>>>> bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The missing 0x800 is
>>>> SDHCI_RETUNING_TIMER_COUNT_MASK=0, which makes the SDHCI core
>> disable
>>>> retuning timer.
>>>>
>>>> Fix this up here by explicitly setting tuning_count to 8 as it should
>>>> be, otherwise an eMMC might fail in various thermal conditions
>>>>
>>>> Note that the diff is best shown with -w option, this makes it
>>>> visible what happened with !sdhci_arasan->has_cqe conditional, which
>>>> is placed between sdhci_setup_host() and __sdhci_add_host() calls.
>>>> Since sdhci_add_host() is also a sequence of these two calls and
>>>> host->tuning_count must be overriden before calling
>>>
>>> overriden -> overridden
>>
>> Fixed
>>
>>>> __sdhci_add_host(), call the two calls separately and do all the
>>>> adjustments between them in either case.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> To: linux-mmc@vger.kernel.org
>>>> ---
>>>>    drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++---------
>> -
>>>>    1 file changed, 38 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>>> index 3997cad1f793d..465498f2a7c0f 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct
>> sdhci_arasan_data *sdhci_arasan,
>>>>       return 0;
>>>>    }
>>>>
>>>> -static int sdhci_arasan_add_host(struct sdhci_arasan_data
>>>> *sdhci_arasan)
>>>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data
>> *sdhci_arasan,
>>>> +                             struct device *dev)
>>>>    {
>>>>       struct sdhci_host *host = sdhci_arasan->host;
>>>>       struct cqhci_host *cq_host;
>>>>       bool dma64;
>>>>       int ret;
>>>>
>>>> -    if (!sdhci_arasan->has_cqe)
>>>> -            return sdhci_add_host(host);
>>>> -
>>>>       ret = sdhci_setup_host(host);
>>>>       if (ret)
>>>>               return ret;
>>>>
>>>> -    cq_host = devm_kzalloc(host->mmc->parent,
>>>> -                           sizeof(*cq_host), GFP_KERNEL);
>>>> -    if (!cq_host) {
>>>> -            ret = -ENOMEM;
>>>> -            goto cleanup;
>>>> -    }
>>>> +    /*
>>>> +     * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
>>>> +     *
>>>> +     *
>> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.
>> html#
>>>> +     * Absolute Address  0x00FF160040 (SD0)
>>>> +     * Reset Value       0x280737EC6481
>>>> +     *
>>>> +     * really reads 0x200737EC6481 . The interesting part is the
>>>> +     * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
>>>> +     * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
>>>> +     * makes the SDHCI core disable retuning timer.
>>>
>>> Are you aware that caps can be changed in DT via "sdhci-caps" and
>>> "sdhci-caps-mask" ?
>>
>> No, I wasn't aware of those.
>>
>> Is that the preferred approach to this fix, over handling it in the driver ?
>>
>> I think the driver-side fix would be preferable, because it also fixes systems
>> which use legacy DTs without the sdhci-caps properties, which would be all
>> ZynqMP systems thus far.
>>
>> (and I would also still prefer to get feedback from Xilinx on why does the
>> value specified in UG1087 not match what is read out of the hardware)
> Reset value of the retuning timer count is set to 0x0 via ZynqMP FSBL, we have
> an ERRATA for the same.
> https://support.xilinx.com/s/article/68550?language=en_US
> 
> Xilinx recommendation is to program the appropriate value in the retuning
> timer count field based on the specific requirements via DT property.

Why is the retuning timer disabled for HS200 mode ?
