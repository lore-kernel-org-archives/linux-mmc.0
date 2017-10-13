From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: dw_mmc: busy check incomplete?
Date: Fri, 13 Oct 2017 18:00:29 +0800
Message-ID: <948b84f0-b9b3-696a-4e0d-da8a8e347960@rock-chips.com>
References: <FD897F46D140444CAB8DC80B08F0742B0185ABC5E7@PFDE-MX11.EU.P-F.BIZ>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:55854 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdJMKA3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Oct 2017 06:00:29 -0400
In-Reply-To: <FD897F46D140444CAB8DC80B08F0742B0185ABC5E7@PFDE-MX11.EU.P-F.BIZ>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

+ Ulf

On 2017/10/12 20:27, Goldschmidt Simon wrote:
>> On 2017/9/22 17:40, Shawn Lin wrote:
>> Still think that should be part of mmc core's behaviour. I try to make
>> sure the following ugly patch could work for you? And we could move
>> forward later to see how to do it more gracefully.
> 
> Thanks for your response and sorry my answer comes with three weeks delay.
> Unfortunately, I had other problems with the board in question up to now.
> 
> I can confirm the patch works for me. On the oscilloscope shots, I can clearly
> see that the next request gets delayed when R1b tells the host the "card" is busy.
> 

Thanks for testing.

> How can we move forward to a clean fix here?

I think mmc core haven't considered this case that we issue a R1b
command from usersapce and check the busy(or poll the CMD13 to get it
right). I was thinking of adding some check for that case but I'm aslo
now thinking could we reuse the functions from mmc_ops.c instead of
directly sending this command to the host drivers. That we better reuse
the checking logic of the existing code, for instance, mmc_switch.

Ulf, do you have some comment here?

> 
> Regards,
> Simon
> 
>>
>>
>> @@ -546,6 +546,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
>> *card, struct mmc_blk_data *md,
>>                           return err;
>>           }
>>
>> +       /*
>> +         * Don't try to rely on the host drivers to check the busy status
>> +         * and do it for here. Maybe it's worth more condiction check
>> +         * to see if this cmd use data line or not, as we could still
>> support
>> +         * cmd in flight even the the device is busy, for instance CQE.
>> Andt
>> +         * not sure how much time need to be a proper arbitrary, so bindly
>> +         * resort to MMC_BLK_TIMEOUT_MS. Also not sure if we need to take
>> +         * poll mathod if no card_busy available.
>> +         */
>> +       if (card->host->ops->card_busy) {
>> +               int tries = MMC_BLK_TIMEOUT_MS;
>> +               while (host->ops->card_busy(card->host) && --tries)
>> +                       mmc_delay(1);
>> +
>> +               if (tries == 0)
>> +                       return -ETIMEDOUT;
>> +       }
> 
> 
> 
> 

