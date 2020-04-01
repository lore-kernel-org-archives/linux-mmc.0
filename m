Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3770C2D0F3
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5120787
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 14:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EqXV77Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbgDAO5B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:57:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55382 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732749AbgDAO5B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 10:57:01 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031EqsY1011855;
        Wed, 1 Apr 2020 16:56:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=EWMX4dUTXREC+QeK0mkhl2un1ScVfvreF/9iNkJ/5Po=;
 b=EqXV77Ep73eZP2cgb6Lj9cLoPU4qcrBy7L3S7hmXOlTtfCRsZXp+y6peR1F9Kt2uUucl
 rL9Ohb2+xh26Vji44m4fnag+UcTxRGGclg3p67s6rujUDJ2Q2BQYORfVJJIf6+CzmU2a
 de022IfAqZpjYUz4smduOYhweYdzsCP0Cqy96IwA7wvHh+xgxgpZV5IckpQ/gfwVsp4X
 PRygAtG2fEwkEtT8iO1NVg/mor/oLcPde8KpzJ6d09vf9rAKv8MoP6DpSYIzzbIRhXqT
 ynTeu5YKOGaQMZP35x97iOrNjUQqGb7WC3Wg7QvKpyp8zGMGsVvVPdrOS0kjV/1EnbIf rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y5401q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 16:56:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E1CE10002A;
        Wed,  1 Apr 2020 16:56:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C4242B1899;
        Wed,  1 Apr 2020 16:56:44 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 16:56:43 +0200
Subject: Re: [PATCH V2 2/2] mmc: mmci: initialize pwr|clk|datactrl_reg with
 their hardware values
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200325143409.13005-1-ludovic.barre@st.com>
 <20200325143409.13005-3-ludovic.barre@st.com>
 <CAPDyKFpO40Ois8pNwYOeqZrJbV9UeCLok=i8z4GWML+A7TP2-w@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <734ef31d-5104-c7d4-bf14-6bb116484010@st.com>
Date:   Wed, 1 Apr 2020 16:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpO40Ois8pNwYOeqZrJbV9UeCLok=i8z4GWML+A7TP2-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 3/26/20 à 3:27 PM, Ulf Hansson a écrit :
> On Wed, 25 Mar 2020 at 15:34, Ludovic Barre <ludovic.barre@st.com> wrote:
>>
>> In mmci_write_pwr|clk|datactrlreg functions, if the desired value
>> is equal to corresponding variable (pwr_reg|clk_reg|datactrl_reg),
>> the value is not written in the register.
>>
>> At probe pwr|clk|datactrl_reg of mmci_host structure are initialized
>> to 0 (kzalloc of mmc_alloc_host). But they does not necessarily reflect
>> hardware value of these registers, if they are used while boot level.
>> This is problematic, if we want to write 0 in these registers.
> 
> It could be, but I don't see that we ever needs to do that - at least
> not before we have written some other non-zero values to them (through
> the helper functions).
> 

The sdmmc variant is slightly different on pwr_ctrl field
of MMCIPOWER register.

In classic mmci we have 3 or 2 values:
MMCI_PWR_OFF(0x0), MMCI_PWR_UP(0x2)optional, MMCI_PWR_ON(0x3)
-When you switch the external power supply off, the software set
  power-off (0x0).

-When you switch the external power supply on, the software first enters
  the power-up(0x2) phase, and waits until the supply output is stable
  before moving to the power-on (0x3)phase.

On sdmmc we have 3 values:
MMCI_PWR_OFF(0x0), MCI_STM32_PWR_CYC(0x2), MMCI_PWR_ON(0x3)
-When you switch the external power supply off, the software must
  MCI_STM32_PWR_CYC(0x2) => This will make that the SDMMC_D[7:0],
  SDMMC_CMD and SDMMC_CK are driven low, to prevent the card from being
  supplied through the signal lines.

-When you switch the external power supply on, when supply output is
  stable the MMCI_PWR_OFF(0x0) state can be apply (minimum 1ms) => The
  SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are set to drive “1”. After
  MMCI_PWR_ON(0x3) stat could be set.

In fact the last value of power off sequence is different between
classic and sdmmc:
The classic mmci finish the power off sequence by 0x0, But the sdmmc
finish by 0x2, and we must write 0x0 in power on sequence before set
MMCI_PWR_ON.
The 0x0 value is not written due to kzalloc value of pwr_reg
(which not reflect hardware value of pwr register).

>>
>> This patch initializes pwr|clk|datactrl_reg variables with their
>> hardware values while probing.
> 
> Hmm, so in principle this change seems quite okay, but I am hesitant
> to pick it up - unless it really addresses a problem that you have
> observed.
> 
> The reason is, this change may lead to avoiding to re-write the
> register with the same value it got during boot - and who knows what
> is best here.

I understand your hesitation.
If you prefer, I can move the pwr_reg initialisation
in sdmmc_variant_init ?

Regards
Ludo

> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 647567def612..f378ae18d5dc 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -2085,6 +2085,10 @@ static int mmci_probe(struct amba_device *dev,
>>          else if (plat->ocr_mask)
>>                  dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
>>
>> +       host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
>> +       host->clk_reg = readl_relaxed(host->base + MMCICLOCK);
>> +       host->datactrl_reg = readl_relaxed(host->base + MMCIDATACTRL);
>> +
>>          /* We support these capabilities. */
>>          mmc->caps |= MMC_CAP_CMD23;
>>
>> --
>> 2.17.1
>>
