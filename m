From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Tue, 27 Sep 2016 10:36:15 +0530
Message-ID: <573d8790-df4b-7265-46e0-9e6caead87c9@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
 <2575923.JUIzEdKygq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34701 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750906AbcI0FGY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2016 01:06:24 -0400
In-Reply-To: <2575923.JUIzEdKygq@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org

Hi Arnd,

On 9/12/2016 1:03 PM, Arnd Bergmann wrote:
> On Wednesday, August 24, 2016 3:33:38 PM CEST Ritesh Harjani wrote:
>>  #define CMUX_SHIFT_PHASE_SHIFT 24
>>  #define CMUX_SHIFT_PHASE_MASK  (7 << CMUX_SHIFT_PHASE_SHIFT)
>>
>> +struct sdhci_msm_pltfm_data {
>> +       u32 *clk_table;
>> +       int clk_table_sz;
>> +};
>> +
>>  struct sdhci_msm_host {
>>         struct platform_device *pdev;
>>         void __iomem *core_mem; /* MSM SDCC mapped address */
>> @@ -83,6 +88,7 @@ struct sdhci_msm_host {
>>         struct clk *bus_clk;    /* SDHC bus voter clock */
>>         struct mmc_host *mmc;
>>         bool use_14lpp_dll_reset;
>> +       struct sdhci_msm_pltfm_data *pdata;
>>  };
>>
>>  /* Platform specific tuning */
>>
>
> Just noticed this. Please don't add another structure, just put the
> new members into struct sdhci_msm_host directly.
>
> We only need platform_data structures for drivers that also work
> with old-style board files, which this one doesn't.

Ok, I will move this into sdhci_msm_host directly.


Thanks
Ritesh

>
> 	Arnd
>
