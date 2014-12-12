From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Sat, 13 Dec 2014 00:13:46 +0900
Message-ID: <548B062A.8070608@samsung.com>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
 <1417780783-12939-4-git-send-email-ulf.hansson@linaro.org>
 <CAGOxZ525JR9vTuKAZJJjDF6iq3R2-DuEcJFEOT9KkEMZGimUFw@mail.gmail.com>
 <CAPDyKFpOvs_ML+1edoTzeTPctiMV0B8EeD8aE8daGwjeG7gwMQ@mail.gmail.com>
 <CAGOxZ52RKUdrSegUZs31E19mJr3kaLbyoEStDWD1=bD5vHNLeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41220 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933263AbaLLPNt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Dec 2014 10:13:49 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGH00E2J6AYVJ70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 13 Dec 2014 00:13:47 +0900 (KST)
In-reply-to: <CAGOxZ52RKUdrSegUZs31E19mJr3kaLbyoEStDWD1=bD5vHNLeg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi.

On 12/10/2014 06:30 AM, Alim Akhtar wrote:
> Hi Ulf
> 
> On Mon, Dec 8, 2014 at 3:40 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 6 December 2014 at 13:43, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>> Hi Ulf,
>>>
>>> On Fri, Dec 5, 2014 at 5:29 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> Instead of having a local hack taking care of sending the tuning
>>>> command and as well to verify the response pattern, let's convert to
>>>> the common mmc_send_tuning() API.
>>>>
>>>> This change affects the Exynos variant, since it's the only one which
>>>> support the dw_mmc's ->execute_tuning() callback.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>
>>
>> Alim, thanks for helping out testing!
>>
> Sorry for the delay but currently I don't have access to my work station.
> And thanks for quick suggested patch, I will test this as soon asI go
> back to my work.
> 
> Hi Jaehoon, can you test this and the original patch for hs200 on
> exynos? Just to confirm my board is not the special one.
> Thanks.

Does it need to send "stop command" at exynos5800?
Well, most SoC doesn't need to send stop command, also exynos.
But i will check other exynos boards..then i will share result.

Best Regards,
Jaehoon Chung

> 
>>> With this change HS200 mode does not work on exynos5800 peach-pi board.
>>> I got below error while testing this series:
>>>
>>> mmc0: tuning execution failed
>>> mmc0: error -5 whilst initialising MMC card
>>>
>>> Though, your's next branch with commit _a1d06b4_ works fine in HS200 mode.
>>
>> I was looking into the details of what change my patchset introduces
>> for dw_mmc-exynos. Apparently, dw_mmc-exynos was using the
>> MMC_STOP_TRANSMISSION to end the tuning reqeust (CMD21/19). The new
>> mmc_send_tuning() API doesn't, which also conforms to what the eMMC/SD
>> specifications states.
>>
>> Do you have any idea of why dw_mmc-exynos was using
>> MMC_STOP_TRANSMISSION for CMD19/21?
>>
>> To see if my theory is correct, could you try out the following patch
>> on top of $subject patch?
>> BTW, I have queued patch 1 and 2, from this patchset available on my
>> next branch.
>>
>>
>> From e1ac35bb0e90254275ec7088f41e6e2d59e48367 Mon Sep 17 00:00:00 2001
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Date: Mon, 8 Dec 2014 10:58:48 +0100
>> Subject: [PATCH] mmc: core: End tuning request with stop command
>>
>> Not to be merged!
>>
>> This patch adds the MMC_STOP_TRANSMISSION command to end a tuning
>> request. For some reason dw_mmc seems to need this to complete the
>> tuning request without errors.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/mmc_ops.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 3b044c5..aa79e0c 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -551,6 +551,7 @@ int mmc_send_tuning(struct mmc_host *host)
>>  {
>>         struct mmc_request mrq = {NULL};
>>         struct mmc_command cmd = {0};
>> +       struct mmc_command stop = {0};
>>         struct mmc_data data = {0};
>>         struct scatterlist sg;
>>         struct mmc_ios *ios = &host->ios;
>> @@ -576,10 +577,14 @@ int mmc_send_tuning(struct mmc_host *host)
>>
>>         mrq.cmd = &cmd;
>>         mrq.data = &data;
>> +       mrq.stop = &stop;
>>
>>         cmd.opcode = opcode;
>>         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>>
>> +       stop.opcode = MMC_STOP_TRANSMISSION;
>> +       stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +
>>         data.blksz = size;
>>         data.blocks = 1;
>>         data.flags = MMC_DATA_READ;
>> --
>> 1.9.1
>>
>> Kind regards
>> Uffe
> 
> 
> 

