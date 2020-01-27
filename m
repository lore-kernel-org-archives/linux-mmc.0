Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36453C33CB1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EF6214D8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="srl4XyI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0NTO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:19:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1053 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgA0NTO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 08:19:14 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RDHwuC024998;
        Mon, 27 Jan 2020 14:19:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=5qdrnI3NdUz5Awdk75GVDbiFRKKXqvOc7odUVOh4+yY=;
 b=srl4XyI60dB/NBS10I6iEKb2StmvtRfvBUa5lCcEgrTx0JVM43W6olDcWWy3cyfpjTr4
 B2uUsHRONVJTOb2whL0AtqvkzVo3RIRuciH7cY5iagxNmwzZVEAoH9pM/cCuYd25rhON
 2zzasPC5kd6TDr7gpbVy5umdVNvzt4OxC7231HlNep7McHDePjwB3AmX3xikRLjCOygr
 ypjfbp/HI2ZpX1dmfZF0F7Dxa0fcIG91b7GmTWyq4r6kRJZx24tPbk8MViBJJupPb8si
 vrY/8PJcK/LvvF9jB2wyOIcvYbHDkFsM+Nr8NFWJCWg3f5e+BznogHFPEpNB33U2T1Cc DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrc13123c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 14:19:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A54E10002A;
        Mon, 27 Jan 2020 14:19:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0FBEC2B1863;
        Mon, 27 Jan 2020 14:19:03 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 14:19:01 +0100
Subject: Re: [PATCH 6/9] mmc: mmci: sdmmc: add execute tuning with delay block
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
 <20200110134823.14882-7-ludovic.barre@st.com>
 <CAPDyKFq25C6W3df5LRsYAcV71rM0YYx9xd=isURKVkbCiN+fBw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <48b15042-88cc-29d1-63bb-6bfa277980b2@st.com>
Date:   Mon, 27 Jan 2020 14:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq25C6W3df5LRsYAcV71rM0YYx9xd=isURKVkbCiN+fBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 1/24/20 à 2:10 PM, Ulf Hansson a écrit :
> On Fri, 10 Jan 2020 at 14:49, Ludovic Barre <ludovic.barre@st.com> wrote:
>>
>> The hardware delay block is used to align the sampling clock on
>> the data received by SDMMC. It is mandatory for SDMMC to
>> support the SDR104 mode. The delay block is used to generate
>> an output clock which is dephased from the input clock.
>> The phase of the output clock must be programmed by the execute
>> tuning interface.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 147 ++++++++++++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index df08f6662431..10059fa19f4a 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -3,10 +3,13 @@
>>    * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>>    * Author: Ludovic.barre@st.com for STMicroelectronics.
>>    */
>> +#include <linux/bitfield.h>
>>   #include <linux/delay.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/card.h>
>> +#include <linux/of_address.h>
>>   #include <linux/reset.h>
>>   #include <linux/scatterlist.h>
>>   #include "mmci.h"
>> @@ -14,6 +17,20 @@
>>   #define SDMMC_LLI_BUF_LEN      PAGE_SIZE
>>   #define SDMMC_IDMA_BURST       BIT(MMCI_STM32_IDMABNDT_SHIFT)
>>
>> +#define DLYB_CR                        0x0
>> +#define DLYB_CR_DEN            BIT(0)
>> +#define DLYB_CR_SEN            BIT(1)
>> +
>> +#define DLYB_CFGR              0x4
>> +#define DLYB_CFGR_SEL_MASK     GENMASK(3, 0)
>> +#define DLYB_CFGR_UNIT_MASK    GENMASK(14, 8)
>> +#define DLYB_CFGR_LNG_MASK     GENMASK(27, 16)
>> +#define DLYB_CFGR_LNGF         BIT(31)
>> +
>> +#define DLYB_NB_DELAY          11
>> +#define DLYB_CFGR_SEL_MAX      (DLYB_NB_DELAY + 1)
>> +#define DLYB_CFGR_UNIT_MAX     127
> 
> [...]
> 
>> +static int sdmmc_dlyb_lng_tuning(struct mmci_host *host)
>> +{
>> +       struct sdmmc_dlyb *dlyb = host->variant_priv;
>> +       u32 cfgr;
>> +       int i, lng, ret;
>> +
>> +       for (i = 0; i <= DLYB_CFGR_UNIT_MAX; i++) {
>> +               sdmmc_dlyb_set_cfgr(dlyb, i, DLYB_CFGR_SEL_MAX, true);
>> +
>> +               ret = readl_relaxed_poll_timeout(dlyb->base + DLYB_CFGR, cfgr,
>> +                                                (cfgr & DLYB_CFGR_LNGF),
>> +                                                1, 1000);
> 
> I suggest you introduce a define for this timeout, in the top of the file.

OK

> 
>> +               if (ret) {
>> +                       dev_warn(mmc_dev(host->mmc),
>> +                                "delay line cfg timeout unit:%d cfgr:%d\n",
>> +                                i, cfgr);
>> +                       continue;
>> +               }
>> +
>> +               lng = FIELD_GET(DLYB_CFGR_LNG_MASK, cfgr);
>> +               if (lng < BIT(DLYB_NB_DELAY) && lng > 0)
>> +                       break;
>> +       }
>> +
>> +       if (i > DLYB_CFGR_UNIT_MAX)
>> +               return -EINVAL;
>> +
>> +       dlyb->unit = i;
>> +       dlyb->max = __fls(lng);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
>> +{
>> +       struct sdmmc_dlyb *dlyb = host->variant_priv;
>> +       int cur_len = 0, max_len = 0, end_of_len = 0;
>> +       int phase;
>> +
>> +       for (phase = 0; phase <= dlyb->max; phase++) {
>> +               sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
>> +
>> +               if (mmc_send_tuning(host->mmc, opcode, NULL)) {
>> +                       cur_len = 0;
>> +               } else {
>> +                       cur_len++;
>> +                       if (cur_len > max_len) {
>> +                               max_len = cur_len;
>> +                               end_of_len = phase;
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (!max_len) {
>> +               dev_err(mmc_dev(host->mmc), "no tuning point found\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       phase = end_of_len - max_len / 2;
>> +       sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
>> +
>> +       dev_dbg(mmc_dev(host->mmc), "unit:%d max_dly:%d phase:%d\n",
>> +               dlyb->unit, dlyb->max, phase);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +       struct mmci_host *host = mmc_priv(mmc);
>> +       struct sdmmc_dlyb *dlyb = host->variant_priv;
>> +
>> +       if (!dlyb || !dlyb->base)
>> +               return -EINVAL;
>> +
>> +       if (sdmmc_dlyb_lng_tuning(host))
>> +               return -EINVAL;
>> +
>> +       return sdmmc_dlyb_phase_tuning(host, opcode);
> 
> What happens to the tuning registers when the controller device
> becomes runtime suspended? Would it possible that the values gets lost
> and then they need to be restored in runtime resume?

when the device goes to runtime suspend:
-The sdmmc clock is disabled => sdmmc & dlyb registers are not accessible.
-The power domain of this blocks is not off, the register values are not 
lost.

On runtime resume the clock is re-enabled and the registers
are accessible and with right values

Regards
Ludo

> 
>> +}
>> +
>>   static struct mmci_host_ops sdmmc_variant_ops = {
>>          .validate_data = sdmmc_idma_validate_data,
>>          .prep_data = sdmmc_idma_prep_data,
>> @@ -338,5 +469,21 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>>
>>   void sdmmc_variant_init(struct mmci_host *host)
>>   {
>> +       struct device_node *np = host->mmc->parent->of_node;
>> +       void __iomem *base_dlyb;
>> +       struct sdmmc_dlyb *dlyb;
>> +
>>          host->ops = &sdmmc_variant_ops;
>> +
>> +       base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
>> +       if (IS_ERR(base_dlyb))
>> +               return;
>> +
>> +       dlyb = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dlyb), GFP_KERNEL);
>> +       if (!dlyb)
>> +               return;
>> +
>> +       dlyb->base = base_dlyb;
>> +       host->variant_priv = dlyb;
>> +       host->mmc_ops->execute_tuning = sdmmc_execute_tuning;
>>   }
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 
