Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D16C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 11:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjFMLnN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLnM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 07:43:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894ABA
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 04:43:11 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DBReds009287;
        Tue, 13 Jun 2023 13:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ITgi4pkDblajKjAIIWZ17h8Io7d3MmLl/BcZpqJkPkg=;
 b=HWssvMINJxfDXXX3UQutCWaAvAprSjY3OA3kxdBp3WUZt1XC8Y5cP6UoWXdc0gDd2gr/
 TlYnPKKSA87NoKGbvWSHWjaMf1sQ4zMPPessBxsXGDc5jSlM0SHMnxtGCM6Z1HT+JsXj
 fAFi2ZPUqfzvjveA+QcJsWcrmfLcPjuD2VaGTB/8kSKjbIKYZsTAq/L5k6rBm8HHlAEZ
 Yksk6LVIpHVmcdOornTcj0CTLPE2E5QQZSbKgnY/rsKDMaawVqfi0qnbIqBjXkJg3X7B
 FNRxeqqpEpfXAajPCwEWpxNt/zAt6SN06Ndp+9/mlxkE2k58tkK/gpIDyJ4OfcMptGWn mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r6mrb9g66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 13:42:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE497100045;
        Tue, 13 Jun 2023 13:42:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC3F9222C93;
        Tue, 13 Jun 2023 13:42:56 +0200 (CEST)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 13 Jun
 2023 13:42:55 +0200
Message-ID: <1b1edc4e-a318-4d55-c99e-eb9a47f9833f@foss.st.com>
Date:   Tue, 13 Jun 2023 13:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>, Dennis Zhou <dennis@kernel.org>
References: <20230612143730.210390-1-ulf.hansson@linaro.org>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20230612143730.210390-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/12/23 16:37, Ulf Hansson wrote:
> All mmc host driver should have enabled the asynchronous probe option, but
> it seems like we missed to set it for mmci, so let's do that now.
> 
> Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/host/mmci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f2b2e8b0574e..97a77eefb11a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2455,6 +2455,7 @@ static struct amba_driver mmci_driver = {
>   	.drv		= {
>   		.name	= DRIVER_NAME,
>   		.pm	= &mmci_dev_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
>   	.probe		= mmci_probe,
>   	.remove		= mmci_remove,

Hi Ulf,

I've tested that on a STM32MP eval board.
It boots OK.

Just a warning for other users of this updated driver: if there are 
several MMC devices on the board, we can no more rely on the order of probe.
For example, this board has an SD-card and an eMMC. Before this patch 
mmc0 was the SD-card, mmc1 the eMMC. Now the order has changed on the 
boot I've tested.
It shouldn't be an issue, as filesystems use UUIDs. Maybe for some tools 
or tests.

Anyway, the patch is OK for me.
You can add my:
Tested-by: Yann Gautier <yann.gautier@foss.st.com>


Best regards,
Yann
