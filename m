Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB4C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F02761184
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 07:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIHmu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:42:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35608 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhDIHmu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2021 03:42:50 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1397fcsY013416;
        Fri, 9 Apr 2021 09:42:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=lBIuI0IPIG0tqQ2R1deHRETQaTs9jGsCKm26UPFx2S8=;
 b=QPeB6UYsSP0FyvDqQhnUBlDgwVqFsuU6/njkpkzG5xj0Vh1vvCDevZlo6E4KP23a1mwi
 E9SCxgm2W/O6/7cUSzgnQPjbBwvAlJi6DhztA2fwLlS0hfl1xXncHCxkGfThckanzJl2
 RQxZzWxVupUiEast9xkq9x7rP2ZwWSgwQvndJSg5vq7qn9yGvDubLMyX2iAzozRHM/Ni
 XajOjOu5WZ6CSZu++m82/zu53CkGIBu4N7M9HC7DZVjI1/gSGMIVFLNCIaJ/1Yxg6QJF
 e4DPa5m5h8zXYE4BLmQPcYwjH7ErOOX3nPjb8bKnRdyGkxbRriuy5F8iDm5BeJU7+Efe qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37sw5yxw6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 09:42:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55AB9100038;
        Fri,  9 Apr 2021 09:42:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42FC521CA9E;
        Fri,  9 Apr 2021 09:42:04 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 09:42:03 +0200
Subject: Re: [PATCH -next] mmc: sdhci-st: Remove unnecessary error log
To:     Laibin Qiu <qiulaibin@huawei.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <yuehaibing@huawei.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210409023801.3326572-1-qiulaibin@huawei.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <39dd50a7-6e85-49e4-8072-e88fcc471714@foss.st.com>
Date:   Fri, 9 Apr 2021 09:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409023801.3326572-1-qiulaibin@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_04:2021-04-08,2021-04-09 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Laibin

On 4/9/21 4:38 AM, Laibin Qiu wrote:
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  drivers/mmc/host/sdhci-st.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 78941ac3a1d6..d41582c21aa3 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -400,10 +400,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					   "top-mmc-delay");
>  	pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pdata->top_ioaddr)) {
> -		dev_warn(&pdev->dev, "FlashSS Top Dly registers not available");
> +	if (IS_ERR(pdata->top_ioaddr))
>  		pdata->top_ioaddr = NULL;
> -	}
>  
>  	pltfm_host->clk = clk;
>  	pdata->icnclk = icnclk;
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
