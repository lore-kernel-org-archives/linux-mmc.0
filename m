From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Wed, 24 Dec 2014 10:43:25 +0900
Message-ID: <549A1A3D.5060702@samsung.com>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
 <1417780783-12939-4-git-send-email-ulf.hansson@linaro.org>
 <CAGOxZ525JR9vTuKAZJJjDF6iq3R2-DuEcJFEOT9KkEMZGimUFw@mail.gmail.com>
 <CAPDyKFpOvs_ML+1edoTzeTPctiMV0B8EeD8aE8daGwjeG7gwMQ@mail.gmail.com>
 <CAGOxZ51O9_8YDU30st6uha6PkVhk0GJC6hdjgVu+Gi0XPiaz-A@mail.gmail.com>
 <CAPDyKFr56_8chuuva0dgA5uD3z-366R4wVoy9uvoim1CFiiRwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36622 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaLXBn1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Dec 2014 20:43:27 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NH200KK1CSD2970@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 24 Dec 2014 10:43:26 +0900 (KST)
In-reply-to: <CAPDyKFr56_8chuuva0dgA5uD3z-366R4wVoy9uvoim1CFiiRwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi, Ulf.

On 12/22/2014 11:41 PM, Ulf Hansson wrote:
> On 20 December 2014 at 14:18, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>> Hi Ulf,
>>
>> On Mon, Dec 8, 2014 at 3:40 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 6 December 2014 at 13:43, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>>> Hi Ulf,
>>>>
>>>> On Fri, Dec 5, 2014 at 5:29 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>> Instead of having a local hack taking care of sending the tuning
>>>>> command and as well to verify the response pattern, let's convert to
>>>>> the common mmc_send_tuning() API.
>>>>>
>>>>> This change affects the Exynos variant, since it's the only one which
>>>>> support the dw_mmc's ->execute_tuning() callback.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>
>>>
>>> Alim, thanks for helping out testing!
>>>
>>>> With this change HS200 mode does not work on exynos5800 peach-pi board.
>>>> I got below error while testing this series:
>>>>
>>>> mmc0: tuning execution failed
>>>> mmc0: error -5 whilst initialising MMC card
>>>>
>>>> Though, your's next branch with commit _a1d06b4_ works fine in HS200 mode.
>>>
>>> I was looking into the details of what change my patchset introduces
>>> for dw_mmc-exynos. Apparently, dw_mmc-exynos was using the
>>> MMC_STOP_TRANSMISSION to end the tuning reqeust (CMD21/19). The new
>>> mmc_send_tuning() API doesn't, which also conforms to what the eMMC/SD
>>> specifications states.
>>>
>>> Do you have any idea of why dw_mmc-exynos was using
>>> MMC_STOP_TRANSMISSION for CMD19/21?
>>>
>>> To see if my theory is correct, could you try out the following patch
>>> on top of $subject patch?
>>> BTW, I have queued patch 1 and 2, from this patchset available on my
>>> next branch.
>>>
>>>
>>> From e1ac35bb0e90254275ec7088f41e6e2d59e48367 Mon Sep 17 00:00:00 2001
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>> Date: Mon, 8 Dec 2014 10:58:48 +0100
>>> Subject: [PATCH] mmc: core: End tuning request with stop command
>>>
>>> Not to be merged!
>>>
>>> This patch adds the MMC_STOP_TRANSMISSION command to end a tuning
>>> request. For some reason dw_mmc seems to need this to complete the
>>> tuning request without errors.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/mmc/core/mmc_ops.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index 3b044c5..aa79e0c 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -551,6 +551,7 @@ int mmc_send_tuning(struct mmc_host *host)
>>>  {
>>>         struct mmc_request mrq = {NULL};
>>>         struct mmc_command cmd = {0};
>>> +       struct mmc_command stop = {0};
>>>         struct mmc_data data = {0};
>>>         struct scatterlist sg;
>>>         struct mmc_ios *ios = &host->ios;
>>> @@ -576,10 +577,14 @@ int mmc_send_tuning(struct mmc_host *host)
>>>
>>>         mrq.cmd = &cmd;
>>>         mrq.data = &data;
>>> +       mrq.stop = &stop;
>>>
>>>         cmd.opcode = opcode;
>>>         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>>>
>>> +       stop.opcode = MMC_STOP_TRANSMISSION;
>>> +       stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>> +
>>>         data.blksz = size;
>>>         data.blocks = 1;
>>>         data.flags = MMC_DATA_READ;
>>> --
>>> 1.9.1
>>>
>> Sorry for delay in testing this suggested patch, I would say this
>> certainly helps, but still I need to change sample phase to make it
>> work with generic tuning function.
>> So with your's adding STOP_TRANSMISSION command and below change,
>> HS200 works well on exynos5800
>>
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index e8fdda8..e0f0337 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -555,7 +555,7 @@
>>         card-detect-delay = <200>;
>>         clock-frequency = <400000000>;
>>         samsung,dw-mshc-ciu-div = <3>;
>> -       samsung,dw-mshc-sdr-timing = <0 4>;
>> +       samsung,dw-mshc-sdr-timing = <2 4>;
>>
>> This basically change the clock-sample phase with which the tuning
>> process starts.
>>
>> I didn't find anything is exynos documentations which suggest
>> STOP_TRANSMISSION is needed, may be Seungwon might be know as he wrote
>> this.
>>
>> Are you ok to add STOP_TRANSMISSION in generic tuning code (probably
>> with a quirk, so that other hosts are still happy)?
> 
> No, I don't want that.
> 
> If special treatment are needed for dw_mmc to handle a tuning request,
> dw_mmc should be able to take care by itself. How about below patch,
> do you think that could work?

According to my analysis, s/w logic of dwmmc controller needs to add the below your patch.
If cmd->error is occurred, dw-mmc controller needs to send stop command.
I will rework for this..But now this patch is good solution for tuning sequence.

Best Regards,
Jaehoon Chung
> 
>>From c2e5783beaa322178f2336b4bff4bdf13da76f56 Mon Sep 17 00:00:00 2001
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Mon, 22 Dec 2014 15:24:14 +0100
> Subject: [PATCH] mmc: dw_mmc: Generate stop commands for failed tuning
>  requests
> 
> It's seems like dw_mmc internal logic expects failed data transfers to
> be ended using a stop command. Let the tuning requests also fall into
> this category, since there are data transfer involved.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a1b80e5..976382db 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -314,7 +314,9 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci
> *host, struct mmc_command *cmd)
>         if (cmdr == MMC_READ_SINGLE_BLOCK ||
>             cmdr == MMC_READ_MULTIPLE_BLOCK ||
>             cmdr == MMC_WRITE_BLOCK ||
> -           cmdr == MMC_WRITE_MULTIPLE_BLOCK) {
> +           cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
> +           cmdr == MMC_SEND_TUNING_BLOCK ||
> +           cmdr == MMC_SEND_TUNING_BLOCK_HS200) {
>                 stop->opcode = MMC_STOP_TRANSMISSION;
>                 stop->arg = 0;
>                 stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> 

