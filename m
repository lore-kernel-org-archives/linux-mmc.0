From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 03/13] mmc: mmci: Add Qualcomm Id to amba id table
Date: Fri, 30 May 2014 10:49:27 +0100
Message-ID: <53885427.5090509@linaro.org>
References: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>	<1401284779-16563-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFqf-=WJ7RRpk-n4zc6rm1gEuW42Jc3zzCkWSL6mdYFh1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44429 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803AbaE3Jtc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 05:49:32 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so1689693wgg.21
        for <linux-mmc@vger.kernel.org>; Fri, 30 May 2014 02:49:31 -0700 (PDT)
In-Reply-To: <CAPDyKFqf-=WJ7RRpk-n4zc6rm1gEuW42Jc3zzCkWSL6mdYFh1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>



On 30/05/14 10:39, Ulf Hansson wrote:
> On 28 May 2014 15:46,  <srinivas.kandagatla@linaro.org> wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds a fake Qualcomm ID 0x00051180 to the amba_ids, as Qualcomm
>> SDCC controller is pl180, but amba id registers read 0x0's.
>> The plan is to remove SDCC driver totally and use mmci as the main SD
>> controller driver for Qualcomm SOCs.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>   drivers/mmc/host/mmci.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index a38e714..86f25a9 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -160,6 +160,14 @@ static struct variant_data variant_ux500v2 = {
>>          .pwrreg_nopower         = true,
>>   };
>>
>> +static struct variant_data variant_qcom = {
>> +       .fifosize               = 16 * 4,
>> +       .fifohalfsize           = 8 * 4,
>> +       .clkreg                 = MCI_CLK_ENABLE,
>> +       .datalength_bits        = 24,
>> +       .pwrreg_powerup         = MCI_PWR_UP,
>> +};
>> +
>>   static int mmci_card_busy(struct mmc_host *mmc)
>>   {
>>          struct mmci_host *host = mmc_priv(mmc);
>> @@ -1750,6 +1758,12 @@ static struct amba_id mmci_ids[] = {
>>                  .mask   = 0xf0ffffff,
>>                  .data   = &variant_ux500v2,
>>          },
>> +       /* Qualcomm variants */
>> +       {
>> +               .id     = 0x00051180,
>> +               .mask   = 0x000fffff,
>> +               .data   = &variant_qcom,
>> +       },
>>          { 0, 0 },
>>   };
>
> Shouldn't this patch be moved to very end of this patchset?
>
> If we would apply this patch on it's own - the Qcom variant wouldn't
> work, right?
Yes, I would not work. I will move it to the end of the patchset.

Thanks,
srini
>
> Kind regards
> Ulf Hansson
>
>>
>> --
>> 1.9.1
>>
