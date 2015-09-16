From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: Re: [PATCH 2/3] mmc: sd: Allow calling sd mode switch with retries
Date: Wed, 16 Sep 2015 11:09:30 +0800
Message-ID: <CAECwjAh3gmjUsLqRP-8W-Y=JC9gD+2VmecNV=2wdCF+9cw=c=w@mail.gmail.com>
References: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
 <1441816398-4330-2-git-send-email-yszhou4tech@gmail.com> <55F0CFEB.8030806@rock-chips.com>
 <CAECwjAjQWj_NdTy=_1weq3AciCJ6eoC5-+Xwy3PnhqO+QfH4=Q@mail.gmail.com> <55F8D5C8.4000105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34837 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbIPDJu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 23:09:50 -0400
Received: by oiww128 with SMTP id w128so109320592oiw.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 20:09:50 -0700 (PDT)
In-Reply-To: <55F8D5C8.4000105@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, CPGS <cpgs@samsung.com>

Hi,

On 16 September 2015 at 10:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> On 09/10/2015 12:02 PM, Yousong Zhou wrote:
>> On 10 September 2015 at 08:33, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> On 2015/9/10 0:33, Yousong Zhou wrote:
>>>>
>>>> This will allow retrying access mode switch to High-Speed in the
>>>> following commit.
>
> Well, it's not solution. (It's my preference.)
> Did you consider the card removable case?
>
> Could you share which vendor's card needs to retry?
>

It's a SD card labeled as "pqi" made in Korea.  The issue was found on
sunxi-mmc controller where it reported response crc error when trying
to switch the card into highspeed mode.

The idea about retrying the access mode switch was from U-Boot code of
Allwinner (vendor of sunxi SoCs).  The code comments there said this
issue can happen with eMMC cards from Toshiba [1].

The above info was also said in a previous discussion [1].  A
sunxi-mmc specific change as suggested by Hans de Geode should
definitely be a safer move.  But that requires more fundamental
framework code change I guess.

[1] https://github.com/allwinner-zh/bootloader/blob/master/u-boot-2011.09/drivers/mmc/mmc.c#L2220
[2] http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/18442/focus=18480

Regards,

                yousong

> Best Regards,
> Jaehoon Chung
>
>>>>
>>>> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
>>>> ---
>>>>   drivers/mmc/core/core.c   |    4 ++++
>>>>   drivers/mmc/core/sd_ops.c |    5 +++--
>>>>   drivers/mmc/core/sd_ops.h |   10 ++++++++--
>>>>   3 files changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>
>>> I test this patchset with my already-working sd cards, seems ok.
>>> Actually I don't have a card to test like yours that need retry switch HS,
>>> but from the changes itself, it's harmless to other cards.
>>
>> Thanks for the testing.
>>
>> Those cards normally won't burn out after MMC_CMD_RETRIES access mode switch
>> failures, right?
>>
>>>
>>> so,
>>>
>>> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> BTW, I can't find the cover letter? And another should be clarified, plz see
>>> comment blow
>>>
>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 9ad73f3..e726bb1 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -468,11 +468,13 @@ static void mmc_wait_for_req_done(struct mmc_host
>>>> *host,
>>>>                                   struct mmc_request *mrq)
>>>>   {
>>>>         struct mmc_command *cmd;
>>>> +       struct mmc_data *data;
>>>>
>>>>         while (1) {
>>>>                 wait_for_completion(&mrq->completion);
>>>>
>>>>                 cmd = mrq->cmd;
>>>> +               data = mrq->data;
>>>>
>>>>                 /*
>>>>                  * If host has timed out waiting for the sanitize
>>>> @@ -501,6 +503,8 @@ static void mmc_wait_for_req_done(struct mmc_host
>>>> *host,
>>>>                          mmc_hostname(host), cmd->opcode, cmd->error);
>>>>                 cmd->retries--;
>>>>                 cmd->error = 0;
>>>> +               if (data)
>>>> +                       data->error = 0;
>>>
>>>
>>> What's this change for?
>>
>> sunxi-mmc will set both cmd->error and data->error to -ETIMEDOUT in case of any
>> interrupt error bit was set (related code within `sunxi_finalize_request()').
>>
>> `__mmc_sd_switch()' thought it was a error case if data->error != 0.
>>
>> So the data->error bit needs to be cleared before next retry.
>>
>> Regards,
>>
>>                 yousnog
>>
>>>
>>>
>>>>                 __mmc_start_request(host, mrq);
>>>>         }
>>>>
>>>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>>>> index 48d0c93..22bef3c 100644
>>>> --- a/drivers/mmc/core/sd_ops.c
>>>> +++ b/drivers/mmc/core/sd_ops.c
>>>> @@ -304,8 +304,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
>>>>         return 0;
>>>>   }
>>>>
>>>> -int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>>>> -       u8 value, u8 *resp)
>>>> +int __mmc_sd_switch(struct mmc_card *card, int mode, int group,
>>>> +       u8 value, u8 *resp, int retries)
>>>>   {
>>>>         struct mmc_request mrq = {NULL};
>>>>         struct mmc_command cmd = {0};
>>>> @@ -328,6 +328,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int
>>>> group,
>>>>         cmd.arg &= ~(0xF << (group * 4));
>>>>         cmd.arg |= value << (group * 4);
>>>>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>>>> +       cmd.retries = retries;
>>>>
>>>>         data.blksz = 64;
>>>>         data.blocks = 1;
>>>> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
>>>> index ffc2305..a53c51e 100644
>>>> --- a/drivers/mmc/core/sd_ops.h
>>>> +++ b/drivers/mmc/core/sd_ops.h
>>>> @@ -17,9 +17,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32
>>>> ocr, u32 *rocr);
>>>>   int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
>>>>   int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>>>>   int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
>>>> -int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>>>> -       u8 value, u8 *resp);
>>>>   int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>>>>
>>>> +int __mmc_sd_switch(struct mmc_card *card, int mode, int group,
>>>> +       u8 value, u8 *resp, int retries);
>>>> +static inline int mmc_sd_switch(struct mmc_card *card, int mode, int
>>>> group,
>>>> +       u8 value, u8 *resp)
>>>> +{
>>>> +       return __mmc_sd_switch(card, mode, group, value, resp, 0);
>>>> +}
>>>> +
>>>>   #endif
>>>>
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Shawn Lin
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
