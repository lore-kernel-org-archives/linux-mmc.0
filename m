Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD71C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF13613D8
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 12:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhGAMlj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:41:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbhGAMlj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 08:41:39 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161CWjSG021859;
        Thu, 1 Jul 2021 14:38:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=I92tEKdjU2/3eUXBZEGBNAcz/stz6aDX9ZsKTMc90nI=;
 b=bKqXB86krQLpoi43tcoPljU7mB77Vxwo33kZTF2NyEw3Yj9fiedLbCNNTZju8KXGHWSm
 Ttr1PL3DiyBFCwq8Dr5DZZk6iEeXwSbuZs4w+IQh9xc+/0GGqkTv97DRsOLWWCkPFlP1
 6TAow97Bm5mlbuHRJLoBj9WxnEeanJUM99uxDERDGgiWZ9Vh8P3rWAvgpPPisomaa20G
 fCHpXNQbgXyJBex23Ia9/t8WHG3UDffnba7E2EZyzwx5cNsozVhGLAFH4bPV+L19yB1h
 HtVU7LVnhvBAgRF6CKyvuIG+geQvHrh8Bszw9X8SJCWu1wRWXpLhXftJBtx+F3G+SQe5 nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39h1xqc649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 14:38:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 362DD10002A;
        Thu,  1 Jul 2021 14:38:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C5D5222CA7;
        Thu,  1 Jul 2021 14:38:53 +0200 (CEST)
Received: from lmecxl0504.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Jul
 2021 14:38:52 +0200
Subject: Re: [PATCH v2] mmc: mmci: De-assert reset on probe
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>, "Ulf Hansson" <ulf.hansson@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>
References: <20210630102408.3543024-1-linus.walleij@linaro.org>
From:   Yann Gautier <yann.gautier@foss.st.com>
Message-ID: <4b20c870-ee41-6455-bc28-07f89591c3f9@foss.st.com>
Date:   Thu, 1 Jul 2021 14:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630102408.3543024-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_07:2021-07-01,2021-07-01 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/30/21 12:24 PM, Linus Walleij wrote:
> If we find a reset handle when probing the MMCI block,
> make sure the reset is de-asserted. It could happen that
> a hardware has reset asserted at boot. >
Hi Linus,

I was wondering on which HW you saw this issue?
But I've seen this kind of thing is also done in some other drivers, so 
maybe it is just an alignment?

Anyway I tested it on STM32MP157C-EV1 board, so feel free to add my:
Tested-by: Yann Gautier <yann.gautier@foss.st.com>

Regards,
Yann

> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Drop the else {} clause: reset_control_deassert() handles
>    NULL just fine.
> ---
>   drivers/mmc/host/mmci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 984d35055156..3765e2f4ad98 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2126,6 +2126,9 @@ static int mmci_probe(struct amba_device *dev,
>   		ret = PTR_ERR(host->rst);
>   		goto clk_disable;
>   	}
> +	ret = reset_control_deassert(host->rst);
> +	if (ret)
> +		dev_err(mmc_dev(mmc), "failed to de-assert reset\n");
>   
>   	/* Get regulators and the supported OCR mask */
>   	ret = mmc_regulator_get_supply(mmc);
> 

