From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Correct response type of stop command for sdcard
Date: Wed, 13 Apr 2016 13:41:02 +0200
Message-ID: <CAPDyKFrE534Nmog9BnPbXpZbu_FKpNXxC5mWyBtwckoNdEPe9Q@mail.gmail.com>
References: <588D8A7789B2934A9950BF189ED6F50A20061122@SHSMSX104.ccr.corp.intel.com>
	<CAPDyKFogQMA-ggtnJBRbempR8zKOc+vydXiyKeq=BhQ1Vrw2xA@mail.gmail.com>
	<588D8A7789B2934A9950BF189ED6F50A200614DE@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38811 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293AbcDMLlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 07:41:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so72442779wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 04:41:03 -0700 (PDT)
In-Reply-To: <588D8A7789B2934A9950BF189ED6F50A200614DE@SHSMSX104.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Yuan, Juntao" <juntao.yuan@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>

On 13 April 2016 at 13:18, Yuan, Juntao <juntao.yuan@intel.com> wrote:
> I tried both R1 and R1b for stop command of SD card.
> I got plenty of warning message 'mmc1: Got data interrupt 0x00000002 even though no data operation was in progress' in console when R1 was being used for stop command.
> It repeated and repeated, endlessly. Did you see this warning before?

Please don't top post!

I haven't seen it. It seems like a problem in the mmc host driver (I
assume it's an SDHCI variant you are using).

Kind regards
Uffe

>
>
> Thanks.
> Juntao.
>
>
> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, April 13, 2016 4:15 PM
> To: Yuan, Juntao <juntao.yuan@intel.com>
> Cc: linux-mmc@vger.kernel.org; Hunter, Adrian <adrian.hunter@intel.com>
> Subject: Re: [PATCH] mmc: block: Correct response type of stop command for sdcard
>
> On 13 April 2016 at 07:59, Yuan, Juntao <juntao.yuan@intel.com> wrote:
>>
>> According to Physical Layer Simplified Specification Version 4.10, SD
>> card needs a R1b response for stop command.
>
> I have looked at this earlier and I don't think R1B is needed.
>
> According to the Command table in the spec, where commands are listed with their corresponding response type, a CMD12 (stop) has an R1B response. As you probably know, the difference between R1 and R1B is the optional busy signalling on DAT0.
>
> Now, if you look into the details about READ and WRITE transfers in the spec, it becomes clear that there's a difference in the response you get from a CMD12. In the READ case there's *no* busy signalling but there is for WRITE. For that reason, using R1 in case of READ seems like the correct thing to do.
>
> I haven't looked at SD 4.10, but according to earlier versions you can find these details in the "Timings" section.
>
> I guess some comment in the code would be valuable as the spec is indeed a bit unclear, let me submit a change for it.
>
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>
>> ---
>>  drivers/mmc/card/block.c |   11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index
>> 3bdbe50..aa8fc98b 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1533,9 +1533,14 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>     if (rq_data_dir(req) == READ) {
>>         brq->cmd.opcode = readcmd;
>>         brq->data.flags = MMC_DATA_READ;
>> -       if (brq->mrq.stop)
>> -           brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> -                   MMC_CMD_AC;
>> +       if (brq->mrq.stop) {
>> +           if (mmc_card_mmc(card))
>> +               brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> +                       MMC_CMD_AC;
>> +           else
>> +               brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
>> +                       MMC_CMD_AC;
>> +       }
>>     } else {
>>         brq->cmd.opcode = writecmd;
>>         brq->data.flags = MMC_DATA_WRITE;
>> --
>> 1.7.9.5
>>
>>
>>
>> Thanks.
>> Juntao.
>>
