From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: add the debug message for SET_BLOCK_COUNT
Date: Wed, 08 Feb 2012 16:40:14 +0900
Message-ID: <4F3226DE.6070208@samsung.com>
References: <4F30B2E6.60406@samsung.com>
 <CAKYAXd-_eA7BKsxWK0Pgz_8r+DeZ+xKdYscHA6qhMO25kVyocQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33612 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab2BHHk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2012 02:40:28 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZ200EGYDAVFBT0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Feb 2012 16:40:25 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZ200LQKDBCXRC0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Feb 2012 16:40:24 +0900 (KST)
In-reply-to: <CAKYAXd-_eA7BKsxWK0Pgz_8r+DeZ+xKdYscHA6qhMO25kVyocQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/07/2012 04:27 PM, Namjae Jeon wrote:

> 2012/2/7 Jaehoon Chung <jh80.chung@samsung.com>:
>> This patch is added just debug message.
>> Almost features need to use the CMD23.
>> But we didn't see the debug message for sbc.
>> If sbc's message can see, should be help for debugging.
>> (We can check whether use the cmd23 or not)
> Hi. Jaehoon.
> how about using CONFIG_MMC_DEBUG around this debug message.

Why using?

> Thanks.
> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/core/core.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 8a19143..6b72eb8 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -188,6 +188,12 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>        struct scatterlist *sg;
>>  #endif
>>
>> +       if (mrq->sbc) {
>> +               pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
>> +                        mmc_hostname(host), mrq->sbc->opcode,
>> +                        mrq->sbc->arg, mrq->sbc->flags);
>> +       }
>> +
>>        pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
>>                 mmc_hostname(host), mrq->cmd->opcode,
>>                 mrq->cmd->arg, mrq->cmd->flags);
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


