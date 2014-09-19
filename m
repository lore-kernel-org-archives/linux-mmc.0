From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: tmio: enable odd number size access
Date: Fri, 19 Sep 2014 20:47:09 +0200
Message-ID: <CAPDyKFqtQQenMPnrzfu0j+JUjTzPmzcPOW4hT2b_Mw7y4+YRYQ@mail.gmail.com>
References: <8761gwz2jb.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdW_xLeP6gxdqs9vx6HnwDUQe_DV31j5Pqd6vZ387+ychw@mail.gmail.com>
	<87sik0x7kn.wl%kuninori.morimoto.gx@gmail.com>
	<87tx44jjvf.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:58059 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbaISSrJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Sep 2014 14:47:09 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so58970qaq.22
        for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2014 11:47:09 -0700 (PDT)
In-Reply-To: <87tx44jjvf.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 September 2014 06:48, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulf
>
> ping ?
>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Current tmio is using sd_ctrl_read16/write16_rep()
>> for data transfer.
>> It works if transfer size was even number,
>> but, last 1 byte will be ignored if
>> transfer size was odd number.
>> This patch adds new tmio_mmc_transfer_data()
>> and solve this issue.
>>
>> Tested-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks! Applied for next.

Kind regards
Uffe

>> ---
>> v2 -> v3
>>
>>  - remove cast
>>  - remove extra variable
>>
>>  drivers/mmc/host/tmio_mmc_pio.c |   39 +++++++++++++++++++++++++++++++++++----
>>  1 file changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index ff5ff0f..692e578 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -376,6 +376,40 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
>>       return 0;
>>  }
>>
>> +static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
>> +                                unsigned short *buf,
>> +                                unsigned int count)
>> +{
>> +     int is_read = host->data->flags & MMC_DATA_READ;
>> +     u8  *buf8;
>> +
>> +     /*
>> +      * Transfer the data
>> +      */
>> +     if (is_read)
>> +             sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
>> +     else
>> +             sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
>> +
>> +     /* if count was even number */
>> +     if (!(count & 0x1))
>> +             return;
>> +
>> +     /* if count was odd number */
>> +     buf8 = (u8 *)(buf + (count >> 1));
>> +
>> +     /*
>> +      * FIXME
>> +      *
>> +      * driver and this function are assuming that
>> +      * it is used as little endian
>> +      */
>> +     if (is_read)
>> +             *buf8 = sd_ctrl_read16(host, CTL_SD_DATA_PORT) & 0xff;
>> +     else
>> +             sd_ctrl_write16(host, CTL_SD_DATA_PORT, *buf8);
>> +}
>> +
>>  /*
>>   * This chip always returns (at least?) as much data as you ask for.
>>   * I'm unsure what happens if you ask for less than a block. This should be
>> @@ -408,10 +442,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
>>                count, host->sg_off, data->flags);
>>
>>       /* Transfer the data */
>> -     if (data->flags & MMC_DATA_READ)
>> -             sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
>> -     else
>> -             sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
>> +     tmio_mmc_transfer_data(host, buf, count);
>>
>>       host->sg_off += count;
>>
>> --
>> 1.7.9.5
>>
