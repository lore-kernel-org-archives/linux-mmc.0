Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D3C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJSPy2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiJSPx5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 11:53:57 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A619609E
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 08:51:30 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JB56qd002837;
        Wed, 19 Oct 2022 17:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : content-type :
 content-transfer-encoding; s=selector1;
 bh=hcsgfZruIUMtPb87GdqNr9FruKdkFdUJU5pKd1jKqQA=;
 b=ei+ageqL8Ep8Z71mQwIXqLBCXnT1wmboKpGhUApUcfpim3yGNjZn7XoWgA8RkYef8Jpm
 grMVZPj4uJAkju3d6bOkbQ6o4mLs9gIaeEsW5nByaVQhchk5gXyWoyMNLpKAzYE4LeVG
 W3THLJvcuf1OY76F1mTg0SoVPZfODyoPzJ629Rx5iFdu/6p7B8Y0v1ZojvhbHcI/0Ntr
 4nL47Lhb9IbxcAJqqAjeN8YPloyLoWIgnBY56rTfsSOeG/+L7FtgMcaqAuuoSdG1X2vH
 ZxLRCMn5BOxQHn5mwr/DuWe4PheXodhDCKLbd4yqFHFkCDZCM5hh66g9QHXV19Za7UC+ dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k94sdhd8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 17:50:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 696B210002A;
        Wed, 19 Oct 2022 17:50:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 088CC233001;
        Wed, 19 Oct 2022 17:50:27 +0200 (CEST)
Received: from [10.201.20.201] (10.201.20.201) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 17:50:26 +0200
Message-ID: <972a1ea1-7431-21fe-c8af-027c4271f6a2@foss.st.com>
Date:   Wed, 19 Oct 2022 17:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
Subject: Issue with an SD-card switching to high speed
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.201]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf (and mailing-list),

I've an SD-card on a STM32MP157F-DK2 board that cannot switch to 
high-speed mode:
"mmc0: Problem switching card into high-speed mode!"

On this board, it is not possible to switch to UHS modes.
And there is no power cycle done in kernel.

When checking the differences when I add full-pwr-cycle in DT, I see 
that the OCR we ask the card is different:
0x300000 (MMC_VDD_32_33 | MMC_VDD_33_34) vs 0x200000 (MMC_VDD_33_34).

If I add this missing MMC_VDD_32_33 voltage range (without power cycle), 
then the card can switch to high-speed.

Checking where this is done in the framework, I've seen something that 
could correct my issue in mmc_select_voltage():

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..bcd8fa81f78b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1132,7 +1132,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
                 mmc_power_cycle(host, ocr);
         } else {
                 bit = fls(ocr) - 1;
-               ocr &= 3 << bit;
+               ocr &= 3 << (bit - 1);
                 if (bit != host->ios.vdd)
                         dev_warn(mmc_dev(host), "exceeding card's 
volts\n");
         }

The ocr given to mmc_select_voltage() is 0x300000.
fls(ocr) = 22, bit = 21, 3 << bit = 0x600000.
With the &= operator, we then have only 0x200000 and have removed 
MMC_VDD_32_33 mode.
The architecture is an Armv7, I hope that the fls() has the same 
behavior on other architectures.

But as this function is also used for eMMC and SDIO, this could have 
impacts I've not seen.


Maybe the issue is just with this SD-card, that doesn't properly handle 
the range MMC_VDD_33_34 alone, and it could be out of spec.

I then have 3 possibilities:
- stop using this type of card if it is out-of-specs
- add full-pwr-cycle in this board's DT, but I'll have issues with other 
boards that really cannot do power cycle
- push the proposed patch in mmc_select_voltage()


What's your opinion?



Best regards,
Yann
