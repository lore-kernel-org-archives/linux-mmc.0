From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RFC PATCH 0/4] mmc: core: Provide CMD5 awake and partial_init
 support
Date: Mon, 20 Feb 2017 18:34:25 +0530
Message-ID: <fae03aba-c42f-4d1e-52eb-f8421ce45627@codeaurora.org>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
 <CAPDyKFrytpFeH5MCLO_GOrLE9YPbbVBTbrsROOF3G-iOu5a_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdBTNEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2017 08:04:35 -0500
In-Reply-To: <CAPDyKFrytpFeH5MCLO_GOrLE9YPbbVBTbrsROOF3G-iOu5a_HA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Asutosh Das <asutoshd@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ulf,

On 2/20/2017 5:09 PM, Ulf Hansson wrote:
> On 20 February 2017 at 09:03, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>> As per JEDEC spec - CMD5 can be used to awake from sleep mode for emmc.
>> This patch series provide CMD5(awake) + mmc_partial_init support to resume
>> mmc card device. This is mainly to reduce the resume time.
>
> I assume with "resume time" you don't mean "system PM resume time"?
I meant mmc_runtime_resume time which will be accounted only in MMC card 
run-time resume now.


>
> The current approach we have for MMC is to postpone system PM resume
> of the card until it's actually needed, thus via runtime PM instead.
> Then the time it takes to re-initialize the eMMC don't affect the
> system PM resume time at all.
>
> Therefore I am wondering about how big of a problem this really is. Is
> there a specific use case you are optimizing for?
In general MMC card resume time will be optimized.

>
>>
>> This was tested on db410c (emmc with HS200 mode) and MS8996 (emmc with HS400ES)
>> based internal board. This patch reduced the resume time by ~50% on msm8996
>> and ~11% on db410c.
Sorry, I did not enable MMC_CAP_WAIT_WHILE_BUSY on db410c. That's why we 
see 11% improvement only. After I enabled this cap, I see ~47% 
improvement in mmc_runtime_resume on db410c.


>
> The improved behaviour in percentage is very interesting, but I would
> also like to see real numbers.

<DB410c>
1. ~110ms without the patch on db410c (with MMC_CAP_WAIT_WHILE_BUSY)

2. ~97ms with the patch on db410c (w/o enabling MMC_CAP_WAIT_WHILE_BUSY)

3. ~58ms with the patch (with MMC_CAP_WAIT_WHILE_BUSY capability).= ~47%

<MSM8996>
1. ~142ms without the patch on msm8996 (with MMC_CAP_WAIT_WHILE_BUSY)

2. ~50ms with the patch on msm8996. (with MMC_CAP_WAIT_WHILE_BUSY)= ~60%

>
> Moreover, I would like to know what kind of mechanism the
> corresponding host drivers/controllers are using for card busy
> detection?
These controllers have MMC_CAP_WAIT_WHILE_BUSY capability enabled.

I have tested with below caps.

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 10cdc84..2da9c4e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1283,6 +1283,9 @@ static int sdhci_msm_probe(struct platform_device 
*pdev)
         pm_runtime_use_autosuspend(&pdev->dev);

         host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
+       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+       host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
+       host->mmc->caps2 |= MMC_CAP2_SLEEP_AWAKE;
         ret = sdhci_add_host(host);
         if (ret)
                 goto pm_runtime_disable;


>
>>
>> As of now this patch series provides a caps (MMC_CAP2_SLEEP_AWAKE) to enable this feature.
>> Since there is no dependency on host platform for this, we can enable this feature by
>> default as well. Thoughts?
>
> I will look into the series in more detail, however we must not add a
Sure, please let me know your feedback.

> corresponding DT binding for this as this isn't a HW configuration. I
> guess what you need to know is that VCCQ stays powered on when the
> card is a sleep, else waking up with CMD5 won't work
> (MMC_CAP_FULL_PWR_CYCLE).
Ok.

>
> The current main concern I can think of, is whether the added
> complexity to the wakeup path can be justified for the improved
> behaviour.
This may not be very complex actually.


>
>>
>>
>> Ritesh Harjani (4):
>>   Documentation: mmc: add mmc-sleep-awake
>>   mmc: core: add mmc-sleep-awake caps
>>   mmc: mmc: add support for CMD5 awake
>>   mmc: core: Implement mmc_partial_init during resume
>>
>>  Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
>>  drivers/mmc/core/core.c                       |  13 +++
>>  drivers/mmc/core/core.h                       |   1 +
>>  drivers/mmc/core/host.c                       |   2 +
>>  drivers/mmc/core/mmc.c                        | 160 ++++++++++++++++++++++++--
>>  include/linux/mmc/card.h                      |   3 +
>>  include/linux/mmc/host.h                      |   2 +
>>  7 files changed, 176 insertions(+), 7 deletions(-)
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project.
>>
>
> Kind regards
> Uffe
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
