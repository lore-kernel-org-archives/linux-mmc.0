Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF9BC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiBQUBQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:01:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbiBQUBQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 15:01:16 -0500
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8A12E150
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 12:01:00 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id KmxUnmRTpBzeEKmxUng2RW; Thu, 17 Feb 2022 21:00:59 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 17 Feb 2022 21:00:59 +0100
X-ME-IP: 90.126.236.122
Message-ID: <bcd6688f-6f42-ca8f-ab9c-978eeff4f4e3@wanadoo.fr>
Date:   Thu, 17 Feb 2022 21:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: mtk-sd: use div64_u64() instead of do_div()
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>, Qing Wang <wangqing@vivo.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
 <CAPDyKFqg5N1tCqQ2u2jt5qU0qLuDJRSJRtq_aMVDc7XNDbRvkw@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAPDyKFqg5N1tCqQ2u2jt5qU0qLuDJRSJRtq_aMVDc7XNDbRvkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le 17/02/2022 à 16:39, Ulf Hansson a écrit :
> On Wed, 9 Feb 2022 at 09:39, Qing Wang <wangqing@vivo.com> wrote:
>>
>> From: Wang Qing <wangqing@vivo.com>
>>
>> do_div() does a 64-by-32 division.
>> When the divisor is u64, do_div() truncates it to 32 bits, this means it
>> can test non-zero and be truncated to zero for division.
>>
>> fix do_div.cocci warning:
>> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
> 
> Applied for next, thanks!


This is wrong.

See [1].


Wang Qing, you should really warn all the people you have sent such patches.

CJ

[1]: 
https://lore.kernel.org/linux-kernel/19b96972-cee7-937f-21ce-c78982ed2048@linaro.org/


> 
> Kind regards
> Uffe
> 
> 
>> ---
>>   drivers/mmc/host/mtk-sd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>> index 65037e1..777c9a8
>> --- a/drivers/mmc/host/mtk-sd.c
>> +++ b/drivers/mmc/host/mtk-sd.c
>> @@ -766,7 +766,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
>>                  clk_ns  = 1000000000ULL;
>>                  do_div(clk_ns, mmc->actual_clock);
>>                  timeout = ns + clk_ns - 1;
>> -               do_div(timeout, clk_ns);
>> +               div64_u64(timeout, clk_ns);
>>                  timeout += clks;
>>                  /* in 1048576 sclk cycle unit */
>>                  timeout = DIV_ROUND_UP(timeout, BIT(20));
>> --
>> 2.7.4
>>
> 

