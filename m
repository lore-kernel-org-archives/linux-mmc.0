Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C45C32771
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE3214AF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rpRfr6Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgA0K57 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:57:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46276 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727326AbgA0K57 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 05:57:59 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAqVVc027061;
        Mon, 27 Jan 2020 11:57:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=q3IUqnq8uZOdoSYHGb0y6kLnvH+Tx0j/V7+lgKc4Nzo=;
 b=rpRfr6Dn/ZCXCve9TZDosVDdDszaMeVTTOoOJYbAPp/PZv4DEMWyjyNU9gDF+6fmIL9z
 mAxF7enBIwaeI2O8kbzEpnebCqQ32gFUXMIBrDre5X7ALOTnD7UB3TJQmAtAxt/RkuCk
 kzUCqVthoVzIjkPbRsw8t7LrRZ6Nicr2+iwtX/lm++8cB/KNL86BbGQrykT3LZNIAGeo
 AcohO9zoPTJ+GTIJfvHZeT/ZfwFptKWjp5EzPqka9nPlUJPxfvoj2vI+VLCkW2nd6jvO
 HG5j2MKCEwClLfKew0nb0D3g9iWTz8LX1osKBlil9o/3BgodOMmMi48x/IWvuEQ0vpHu Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdek8c0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 11:57:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5903B10002A;
        Mon, 27 Jan 2020 11:57:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4846B2A5B8E;
        Mon, 27 Jan 2020 11:57:40 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 11:57:39 +0100
Subject: Re: [PATCH 3/9] mmc: mmci: add a reference at mmc_host_ops in mmci
 struct
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
 <20200110134823.14882-4-ludovic.barre@st.com>
 <CAPDyKFpBgRGbRjOKHygknUMvGt9AKke+svoSG+So4B7hdZ8AMw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <075935e7-6c26-9baa-72a5-8dbdecef1e8e@st.com>
Date:   Mon, 27 Jan 2020 11:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpBgRGbRjOKHygknUMvGt9AKke+svoSG+So4B7hdZ8AMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Le 1/24/20 à 2:09 PM, Ulf Hansson a écrit :
> On Fri, 10 Jan 2020 at 14:49, Ludovic Barre <ludovic.barre@st.com> wrote:
>>
>> This patch adds mmc_host_ops pointer in mmci struct.
>> The variant init function may need to add a mmc_host_ops,
>> for example to add the execute_tuning support if this feature
>> is available.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 1 +
>>   drivers/mmc/host/mmci.h | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 7b13d66cbb21..00b473f57047 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1923,6 +1923,7 @@ static int mmci_probe(struct amba_device *dev,
>>
>>          host = mmc_priv(mmc);
>>          host->mmc = mmc;
>> +       host->mmc_ops = &mmci_ops;
> 
> Nitpick:
> 
> Can you please also move the assignment "mmc->ops = &mmci_ops;" to
> this place as well, as I think these belongs together.

OK

> 
>>
>>          /*
>>           * Some variant (STM32) doesn't have opendrain bit, nevertheless
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index ea6a0b5779d4..55acc0971a44 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -407,6 +407,7 @@ struct mmci_host {
>>          u32                     mask1_reg;
>>          u8                      vqmmc_enabled:1;
>>          struct mmci_platform_data *plat;
>> +       struct mmc_host_ops     *mmc_ops;
>>          struct mmci_host_ops    *ops;
>>          struct variant_data     *variant;
>>          struct pinctrl          *pinctrl;
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 
