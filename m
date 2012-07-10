From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v8 1/2] mmc: add packed command feature of eMMC4.5
Date: Tue, 10 Jul 2012 11:54:22 +0530
Message-ID: <CANfBPZ-xHGH4o+m+Ffe1NwtEpePCU6rJ9pREtQbc1S3ZZ+u=-g@mail.gmail.com>
References: <006801cd55b0$314960f0$93dc22d0$%jun@samsung.com> <87y5msqhxy.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41573 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794Ab2GJGYp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 02:24:45 -0400
Received: by bkcji2 with SMTP id ji2so6358058bkc.8
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 23:24:43 -0700 (PDT)
In-Reply-To: <87y5msqhxy.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Saugata Das <saugata.das@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>

On Tue, Jul 10, 2012 at 11:24 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Jun 29 2012, Seungwon Jeon wrote:
>> This patch adds packed command feature of eMMC4.5.
>> The maximum number for packing read(or write) is offered
>> and exception event relevant to packed command which is
>> used for error handling is enabled. If host wants to use
>> this feature, MMC_CAP2_PACKED_CMD should be set.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Reviewed-by: Maya Erez <merez@codeaurora.org>
>> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>> ---
>>  drivers/mmc/core/mmc.c   |   25 +++++++++++++++++++++++++
>>  include/linux/mmc/card.h |    3 +++
>>  include/linux/mmc/host.h |    4 ++++
>>  include/linux/mmc/mmc.h  |   15 +++++++++++++++
>>  4 files changed, 47 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 258b203..bfb271f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -516,6 +516,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>               } else {
>>                       card->ext_csd.data_tag_unit_size = 0;
>>               }
>> +
>> +             card->ext_csd.max_packed_writes =
>> +                     ext_csd[EXT_CSD_MAX_PACKED_WRITES];
>> +             card->ext_csd.max_packed_reads =
>> +                     ext_csd[EXT_CSD_MAX_PACKED_READS];
>>       } else {
>>               card->ext_csd.data_sector_size = 512;
>>       }
>> @@ -1246,6 +1251,26 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>               }
>>       }
>>
>> +     if ((host->caps2 & MMC_CAP2_PACKED_WR &&
>> +                     card->ext_csd.max_packed_writes > 0) ||
>> +         (host->caps2 & MMC_CAP2_PACKED_RD &&
>> +                     card->ext_csd.max_packed_reads > 0)) {
>> +             err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                             EXT_CSD_EXP_EVENTS_CTRL,
>> +                             EXT_CSD_PACKED_EVENT_EN,
>> +                             card->ext_csd.generic_cmd6_time);
>
> Sorry, I don't have a copy of the eMMC 4.5 spec -- is PACKED_EVENT_EN
> a one-time programmable fuse on the eMMC, like BKOPS_ENABLE was?
>
It's not. PACKED_EVENT_EN is a bit set into EXCEPTION_EVENTS_CTRL
register, which is reset duing a power cycle
