Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40680C433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B8E64FC7
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 09:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBEJJa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:09:30 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46409 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhBEJGZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2021 04:06:25 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1159222J010299;
        Fri, 5 Feb 2021 10:05:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=j0g3MEuv+YFAEugJs8NOIBW0mTSV3dOSXdpJKKD5GY8=;
 b=kH2VenhB+dEQpaWqkHi30IdNh4eIZP32ZjOPXQ7nUuaFlw4/EHPB/EwJrGIHxMOdKVNE
 QyRsr4skH8GpI3sBdjuAW0BCDxfK8cmOjbgVmDyd+tjQgSUjQ8oUuK2Yk5vNa+3Ek4hw
 dJNoHx4/+6Gmk6blzPPhsMGvnhMf1YuZ4ZQEo/qbr0PJWpWtfg9q9IKstMNrb7K4Yxk/
 4thO7CmPugSWp7td+JH1EzrR14BO9T7owC+yDmVbvGQOFiPPtp3mlruMep8lN+2Wq1li
 2Rmj/RL5PxR7IGCfXEKsc+J061C74EhqQ6h7q/zjGcn1M8dLqVd7yonWe1c2RZ81+mKx VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fsderx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 10:05:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2F631001EB;
        Fri,  5 Feb 2021 10:05:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6C7E221F7A;
        Fri,  5 Feb 2021 10:05:22 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 10:05:21 +0100
Subject: Re: [PATCH 2/2] mmc: mmc_test: use erase_arg for mmc_erase command
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>, <per.forlin@linaro.org>,
        <huyue2@yulong.com>, <wsa+renesas@sang-engineering.com>,
        <vbadigan@codeaurora.org>, <p.zabel@pengutronix.de>,
        <marex@denx.de>, <swboyd@chromium.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-3-yann.gautier@foss.st.com>
 <c1531549-29da-25dc-cada-f61edbc5f2fd@intel.com>
From:   Yann GAUTIER <yann.gautier@foss.st.com>
Message-ID: <b527e4ac-a5c7-c684-7a55-0c5510948805@foss.st.com>
Date:   Fri, 5 Feb 2021 10:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c1531549-29da-25dc-cada-f61edbc5f2fd@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/5/21 7:33 AM, Adrian Hunter wrote:
> On 4/02/21 2:05 pm, yann.gautier@foss.st.com wrote:
>> From: Yann Gautier <yann.gautier@foss.st.com>
>>
>> Since [1], the erase argument for mmc_erase() function is saved in
>> erase_arg field of card structure. It is preferable to use it instead of
>> hard-coded MMC_SECURE_ERASE_ARG, which from eMMC 4.51 spec is not
>> recommended:
>> "6.6.16 Secure Erase
>> NOTE Secure Erase is included for backwards compatibility. New system
>> level implementations (based on v4.51 devices and beyond) should use
>> Erase combined with Sanitize instead of secure erase."
>>
>>   [1] commit 01904ff77676 ("mmc: core: Calculate the discard arg only once")
>>
> 
> Did you experience an issue because of this?  You could add that to the
> commit message.

Hi Adrian,

Thanks for the review!
Yes, I've seen an issue on STM32MP157C-EV1 board.
After a write test (e.g. test 36), the tests 37 or 38, using mmc_erase 
fail. With the erase argument used by default in the framework 
(MMC_DISCARD_ARG), I can no more see this.

I can send a new version of the series with comment update here, and a 
fixup on the first patch.


Regards,
Yann

> 
> There does not seem to be a need for secure erase, so:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>>   drivers/mmc/core/mmc_test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
>> index 39a478874ca3..63524551a13a 100644
>> --- a/drivers/mmc/core/mmc_test.c
>> +++ b/drivers/mmc/core/mmc_test.c
>> @@ -2110,7 +2110,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
>>   	if (mmc_can_erase(test->card) &&
>>   	    tdata->prepare & MMC_TEST_PREP_ERASE) {
>>   		ret = mmc_erase(test->card, dev_addr,
>> -				size / 512, MMC_SECURE_ERASE_ARG);
>> +				size / 512, test->card->erase_arg);
>>   		if (ret)
>>   			ret = mmc_erase(test->card, dev_addr,
>>   					size / 512, MMC_ERASE_ARG);
>>
> 

