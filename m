Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15640C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 06:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D1261059
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFHHAs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:00:48 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:54136 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhFHHAr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 03:00:47 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 7F53A1BC0
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 14:58:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31903T140446927529728S1623135531951303_;
        Tue, 08 Jun 2021 14:58:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f17887725d97f246d2119a868a2c2a02>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: cloehle@hyperstone.com
X-RCPT-COUNT: 4
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <73d27461-ba9f-1a90-0401-4ce0cf59ac30@rock-chips.com>
Date:   Tue, 8 Jun 2021 14:58:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1623057495-63363-1-git-send-email-shawn.lin@rock-chips.com>
 <CWXP265MB2680A140D951939931D1729BC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CWXP265MB2680A140D951939931D1729BC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Christian

On 2021/6/8 14:28, Christian Löhle wrote:
> Hey Shawn,
> You're assuming a card not signalling busy indicates TRAN state, and set the state manually,
> but a card might not be pulling DAT lines in PROG state.

Refer to JESD84-B51 for emmc spec, section 6.5.13 clearly says that. And
SD spec V4 also has a similar statement in section 4.3.4.

So I guess if that was the case you point out, most of all operations in
mmc_ops.c would suffer from this.


> I will send a patch later that reworks card_busy_detect, as there are some issues
> with some command sequences in practice. I'd ask to wait with the patch until then.
> 
> Regards,
> Christian
> 
> 
> From: Shawn Lin <shawn.lin@rock-chips.com>
> Sent: Monday, June 7, 2021 11:18 AM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; Shawn Lin <shawn.lin@rock-chips.com>
> Subject: [PATCH] mmc: block: Use .card_busy() to detect busy state in card_busy_detect
>   
> No need to send CMD13 if host driver supports .card_busy().
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/mmc/core/block.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 88f4c215..23623a9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -417,10 +417,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>           unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>           int err = 0;
>           u32 status;
> +       bool busy;
>   
>           do {
>                   bool done = time_after(jiffies, timeout);
>   
> +               if (card->host->ops->card_busy) {
> +                       busy = card->host->ops->card_busy(card->host);
> +                       status = busy ? 0 : R1_READY_FOR_DATA | R1_STATE_TRAN << 9;
> +                       goto cb;
> +               }
> +
>                   err = __mmc_send_status(card, &status, 5);
>                   if (err) {
>                           dev_err(mmc_dev(card->host),
> @@ -442,6 +449,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>                                    __func__, status);
>                           return -ETIMEDOUT;
>                   }
> +cb:
>           } while (!mmc_ready_for_data(status));
>   
>           return err;
> 


