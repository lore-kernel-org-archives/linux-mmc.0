From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sat, 5 Sep 2015 16:58:05 +0200
Message-ID: <55EB02FD.5040403@redhat.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbbIEO6H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Sep 2015 10:58:07 -0400
In-Reply-To: <55EAF712.8090203@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.lin@rock-chips.com, Yousong Zhou <yszhou4tech@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, dev@linux-sunxi.org

Hi Shawn Lin,

On 05-09-15 16:07, Shawn Lin wrote:
> On 2015/9/5 18:19, Yousong Zhou wrote:
>> A SD card with sunxi-mmc can fail with the following error message (RCD for
>> response CRC error) when trying to switch to highspeed mode.  Setting the bus
>> clock before the access mode switch fixed it.
>
> No, that's wrong!
>
> Before this card is switched to highspeed, it works under identification mode(From spec: bus clock <= 400KHz). How could you
> raise bus clock to higher clk rate which I _guess_ is 52MHz before you notify sd cards to run into highspeed mode?
>
> Althought it works for this card, this patch will not please the other cards that they might not reply CMDs any longer including the following CMD6.

Thanks for the feedback, this is exactly why I asked Yousong Zhou to take this
to the mmc list.

So if this is not the proper fix for the problem that Yousong Zhou is seeing, then
what might be the proper fix ?

Could it be that the sunxi-mmc is doing some things in the wrong order when
changing the clock, or is this all under control of the mmc core ?

Regards,

Hans


>
>
>>
>>      [    1.112060] mmc0: host does not support reading read-only switch, assuming write-enable
>>      [    1.120203] ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
>>      [    1.126527] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 6, RD RCE !!
>>      [    1.132388] sunxi-mmc 1c0f000.mmc: data error, sending stop command
>>      [    1.139451] sunxi-mmc 1c0f000.mmc: send stop command failed
>>      [    1.145056] mmc0: error -110 whilst initialising SD card
>>      [    1.150424] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
>>      [    1.156533] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 1, RTO !!
>>
>> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
>> ---
>>   drivers/mmc/core/sd.c |   10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 4e7366a..402a8db 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -366,6 +366,11 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>>           return -ENOMEM;
>>       }
>>
>> +    /*
>> +     * Set bus frequency to match highspeed mode.
>> +     */
>> +    mmc_set_clock(card->host, mmc_sd_get_max_clock(card));
>> +
>>       err = mmc_sd_switch(card, 1, 0, 1, status);
>>       if (err)
>>           goto out;
>> @@ -969,11 +974,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>>               goto free_card;
>>
>>           /*
>> -         * Set bus speed.
>> -         */
>> -        mmc_set_clock(host, mmc_sd_get_max_clock(card));
>> -
>> -        /*
>>            * Switch to wider bus (if supported).
>>            */
>>           if ((host->caps & MMC_CAP_4_BIT_DATA) &&
>>
>
>
