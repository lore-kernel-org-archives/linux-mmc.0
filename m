Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E8C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 14:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiJZOjY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiJZOjX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 10:39:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7DB7F7F
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 07:39:22 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QCV3gc020233;
        Wed, 26 Oct 2022 16:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xjV4zaXSi3O2VhDk3xNQfFNuMKu+DRubg1cXcw/xIvQ=;
 b=EQSuFaLL1fY2xZZpfJOXPJgYY6Jsc742iWtF04sa719V0CJpHJHqCORXf7U8QJ8Sw52q
 gQdpgI4hd7fXdRWesKotMuevGlC/u+/8tuQFhTkjTOMwAXOhtDMXKVv2J/yXPf0skcQs
 uY+LpYPm9mGfGymbyRGFXZox+6uFQFU//3JQTv4je/E5Oefln2MBKFSin3PMA4QWScDS
 SPiM0B7U8Lfy8YtmjGwvY5Syahkud4CkqSDrOrAFpue0nYusKl3LFVSk6pD0ounjnBC9
 YNSNONvJ+PqeveJgMyQ753ehQhEEr8OrbnILJ4hX87kby5/Pv3zsimMSi7Haf9NMVY4m gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kebqttvg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 16:39:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F79010002A;
        Wed, 26 Oct 2022 16:39:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3AA2F22F7AE;
        Wed, 26 Oct 2022 16:39:17 +0200 (CEST)
Received: from [10.201.20.201] (10.201.20.201) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 16:39:14 +0200
Message-ID: <db0d75a2-83d9-d752-47b7-8452b9ec945d@foss.st.com>
Date:   Wed, 26 Oct 2022 16:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Issue with an SD-card switching to high speed
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <972a1ea1-7431-21fe-c8af-027c4271f6a2@foss.st.com>
 <CAPDyKFqaJea9MA9KwkkuQt7YcUj5LCw46yeTKyomx1bCRnUzoA@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFqaJea9MA9KwkkuQt7YcUj5LCw46yeTKyomx1bCRnUzoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.201]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/26/22 16:16, Ulf Hansson wrote:
> On Wed, 19 Oct 2022 at 17:50, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> Hi Ulf (and mailing-list),
>>
>> I've an SD-card on a STM32MP157F-DK2 board that cannot switch to
>> high-speed mode:
>> "mmc0: Problem switching card into high-speed mode!"
>>
>> On this board, it is not possible to switch to UHS modes.
>> And there is no power cycle done in kernel.
>>
>> When checking the differences when I add full-pwr-cycle in DT, I see
>> that the OCR we ask the card is different:
>> 0x300000 (MMC_VDD_32_33 | MMC_VDD_33_34) vs 0x200000 (MMC_VDD_33_34).
>>
>> If I add this missing MMC_VDD_32_33 voltage range (without power cycle),
>> then the card can switch to high-speed.
>>
>> Checking where this is done in the framework, I've seen something that
>> could correct my issue in mmc_select_voltage():
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 368f10405e13..bcd8fa81f78b 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1132,7 +1132,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>>                   mmc_power_cycle(host, ocr);
>>           } else {
>>                   bit = fls(ocr) - 1;
>> -               ocr &= 3 << bit;
>> +               ocr &= 3 << (bit - 1);
> 
> To me, this looks like you may be fixing a very old bug. Unless I am
> wrong, it seems like the current code might as well have been:
> 
> ocr &= 1 << bit;
> 
> The upper bit that the '3' is trying to allow to be set, can in fact
> never be set, because we have already done "ocr &= host->ocr_avail" a
> few lines above.
> 
> 
>>                   if (bit != host->ios.vdd)
>>                           dev_warn(mmc_dev(host), "exceeding card's
>> volts\n");
>>           }
>>
>> The ocr given to mmc_select_voltage() is 0x300000.
>> fls(ocr) = 22, bit = 21, 3 << bit = 0x600000.
>> With the &= operator, we then have only 0x200000 and have removed
>> MMC_VDD_32_33 mode.
>> The architecture is an Armv7, I hope that the fls() has the same
>> behavior on other architectures.
>>
>> But as this function is also used for eMMC and SDIO, this could have
>> impacts I've not seen.
>>
>>
>> Maybe the issue is just with this SD-card, that doesn't properly handle
>> the range MMC_VDD_33_34 alone, and it could be out of spec.
>>
>> I then have 3 possibilities:
>> - stop using this type of card if it is out-of-specs
>> - add full-pwr-cycle in this board's DT, but I'll have issues with other
>> boards that really cannot do power cycle
>> - push the proposed patch in mmc_select_voltage()
> 
> Yes, please - so we can discuss it better.
> 
> Also, please try to add a relevant comment in the code too, so it
> becomes a bit more obvious of what goes on.
> 
> Kind regards
> Uffe

Thanks Ulf,

I'll send the patch in the coming days, with the required comments.

Best regards,
Yann
