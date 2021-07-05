Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F5CC07E95
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 00:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE2611AD
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 00:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGEAsV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Jul 2021 20:48:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:44924 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGEAsU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Jul 2021 20:48:20 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 708BCFACD7
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jul 2021 08:45:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12341T139824038135552S1625445938503354_;
        Mon, 05 Jul 2021 08:45:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c2e69bcdf5161228ff0bdd1ad01c1673>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 3
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <4d5b1836-e0f2-3a83-78f9-1a62d92d3873@rock-chips.com>
Date:   Mon, 5 Jul 2021 08:45:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1623134576-212150-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFru-h=ypz2WN1Qoz0_XEa6ym6HD0OhEm6nx64C_Chef2Q@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFru-h=ypz2WN1Qoz0_XEa6ym6HD0OhEm6nx64C_Chef2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/7/2 23:00, Ulf Hansson wrote:
> On Tue, 8 Jun 2021 at 08:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> No need to send CMD13 if host driver supports .card_busy().
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Shawn, I just sent a small series that moves the mmc block layer into
> using the common mmc_poll_for_busy() code. I think $subject patch is
> better to be discussed as an improvement on top in that series.
> 
> I already have some thoughts about it, but I will be awaiting to
> provide you with some comment around it, until there is a new version
> from you.

Sure, I will take a close look at your patch-set.

Thanks.

> 
> Kind regards
> Uffe
> 
>>
>> ---
>>
>> Changes in v2:
>> - fix build issue
>>
>>   drivers/mmc/core/block.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 88f4c215..379614a9 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -417,10 +417,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>>          unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>>          int err = 0;
>>          u32 status;
>> +       bool busy;
>>
>>          do {
>>                  bool done = time_after(jiffies, timeout);
>>
>> +               if (card->host->ops->card_busy) {
>> +                       busy = card->host->ops->card_busy(card->host);
>> +                       status = busy ? 0 : R1_READY_FOR_DATA | R1_STATE_TRAN << 9;
>> +                       goto cb;
>> +               }
>> +
>>                  err = __mmc_send_status(card, &status, 5);
>>                  if (err) {
>>                          dev_err(mmc_dev(card->host),
>> @@ -431,7 +438,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>>                  /* Accumulate any response error bits seen */
>>                  if (resp_errs)
>>                          *resp_errs |= status;
>> -
>> +cb:
>>                  /*
>>                   * Timeout if the device never becomes ready for data and never
>>                   * leaves the program state.
>> --
>> 2.7.4
>>
>>
>>
> 
> 
> 


