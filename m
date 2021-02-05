Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89EAC433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 12:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6109D64FDD
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 12:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBEMWa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 07:22:30 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54607 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231934AbhBEMUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2021 07:20:30 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115CCNU0017758;
        Fri, 5 Feb 2021 13:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TgkwKl2BECy0Q+4thRnTns/kLvVDeFiR+zC2ZUA0n98=;
 b=ZaGbZ3WnKyL+34zPpozlCxSsS1fDB+i8+Jne3JsCO7zziBNZjFyM8lUk9Lsu/WWFKuyt
 4uBOmwiOufLR+SuB2/GAJJPgb6tF5hEHQNLdp2X0fg4s3L40YJnAC7DNmRUf4Ro/bBdK
 BRtHkH0h4yhVzqHtt/w0M3MGTqUdkraDptCN/Sn0ubB/BFBr56gykoa1xarY2yzef7cj
 yQS5+Acm8l2hifU7r2hjsdSCsxmf5WU2/y6+L6A435wMcesa93KPa2ePYQ4vZw+pbCOa
 SPNMRfqeTSLq3sQxkIKFZImibAilqCV+U1Uhdc80q2mkG6Z4KKjizNcccxTKIHq4k9ZR Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fsen70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 13:19:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8A7B10002A;
        Fri,  5 Feb 2021 13:19:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF04122FF07;
        Fri,  5 Feb 2021 13:19:33 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 13:19:33 +0100
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com>
 <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
From:   Yann GAUTIER <yann.gautier@foss.st.com>
Message-ID: <e31df871-ae1a-7c80-d741-0813f90532c7@foss.st.com>
Date:   Fri, 5 Feb 2021 13:19:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_07:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/5/21 10:53 AM, Ulf Hansson wrote:
> - trimmed cc-list
> 
> On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
>>
>> From: Yann Gautier <yann.gautier@foss.st.com>
>>
>> To properly manage commands awaiting R1B responses, the capability
>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
>> manage busy detection.
>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
> 
> Would it be possible for you to share a little bit more about the
> problem? Like under what circumstances does things screw up?
> 
> Is the issue only occurring when the cmd->busy_timeout becomes larger
> than host->max_busy_timeout. Or even in other cases?
> 
>>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 1bc674577ff9..bf6971fdd1a6 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
>>                  if (variant->busy_dpsm_flag)
>>                          mmci_write_datactrlreg(host,
>>                                                 host->variant->busy_dpsm_flag);
>> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
> 
> This isn't correct as the ux500 (and likely also other legacy
> variants) don't need this. I have tried it in the past and it works
> fine for ux500 without MMC_CAP_NEED_RSP_BUSY.
> 
> The difference is rather that the busy detection for stm32 variants
> needs a corresponding HW busy timeout to be set (its
> variant->busy_timeout flag is set). Perhaps we can use that
> information instead?
> 
> Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
> not be set by the core for erase commands, CMD5 and CMD6.
> 
> By looking at the code in mmci_start_command(), it looks like we will
> default to a timeout of 10s, when cmd->busy_timeout isn't set. At
> least for some erase requests, that won't be sufficient. Would it be
> possible to disable the HW busy timeout in some way - and maybe use a
> software timeout instead? Maybe I already asked Ludovic about this?
> :-)
> 
> BTW, did you check that the MMCIDATATIMER does get the correct value
> set for the timer in mmci_start_command() and if
> host->max_busy_timeout gets correctly set in
> mmci_set_max_busy_timeout()?
> 
> [...]
> 
> Kind regards
> Uffe
> 

Hi Ulf,

Thanks for the hints.
I'll check all of that and get back with updated patches.

As I tried to explain in the cover letter and in reply to Adrian, I saw
a freeze (BUSYD0) in test 37 during MMC_ERASE command  with 
SECURE_ERASE_ARG, when running this test just after test 36 (or any 
other write test). But maybe, as you said that's mostly a incorrect 
timeout issue.

Regards,
Yann
