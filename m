Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD6C2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 08:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60AE21655
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 08:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="J4rMPyEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDWIMW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:12:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37406 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgDWIMV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Apr 2020 04:12:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N88G59031061;
        Thu, 23 Apr 2020 10:12:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=lnLyhFkF5Kttua+5xE5VipgRM0EklZuvKl52ZMG1pu0=;
 b=J4rMPyEuKrGJ9UDO/aFTHrgID1JgAT0AfVKMA8mllKBEI3ApI300UxBfR85D/Bjvpxmn
 W979/bMwTyZmE4aVbVLQusLaH8uA9ZXzvqVwkl44zOKlsE4OepzRc7AWnFD6Qbl94eFa
 ohbS/QwmYpHBGlu1oVidkKc82Iq2ajY+fgOykq18kSTc7j/HK3mLL0NFqZ0nRbe2sWM2
 AyVgMSqUGARYgHDjyIVxGkHLFkeVsBecKqnmDcCbsXNSrmjBpsNpFsBWSCzJkW9V+bk/
 Aa9Q+cZTAaBxSU+DlKtvAUQ0FceNtz2btH6gn7pZmaeCMDB1fL5hSgTMZJOG23s/jckk aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11ud7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 10:12:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EDDC100038;
        Thu, 23 Apr 2020 10:12:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C9672AD2B8;
        Thu, 23 Apr 2020 10:12:05 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr
 2020 10:12:04 +0200
Subject: Re: [PATCH] mmc: mmci_sdmmc: fix power on issue due to pwr_reg
 initialization
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
References: <20200420161831.5043-1-ludovic.barre@st.com>
 <CAPDyKFqC3fdnQ9CMYhS-=5MiCET=r5Az2S5oFoA2v1gdDeGO3w@mail.gmail.com>
 <CAPDyKFrHcoVd=GKPB70gOFE8STOnTJrJbcZzE_DEgFWh1Vhszg@mail.gmail.com>
 <1d9cefd1-aaed-1eb5-92f2-b1f45b4da2ac@st.com>
 <CAPDyKFpri4VBnH9nbqUa4L=3o_h+fSZ052v7AG_9MhJX2gKgCQ@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <96725b28-fa19-54f0-7ba7-2043098a24a5@st.com>
Date:   Thu, 23 Apr 2020 10:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpri4VBnH9nbqUa4L=3o_h+fSZ052v7AG_9MhJX2gKgCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_06:2020-04-22,2020-04-23 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Le 4/22/20 à 6:03 PM, Ulf Hansson a écrit :
> On Wed, 22 Apr 2020 at 15:40, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> hi Ulf
>>
>> Le 4/21/20 à 11:38 AM, Ulf Hansson a écrit :
>>> On Tue, 21 Apr 2020 at 11:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>
>>>> On Mon, 20 Apr 2020 at 18:18, Ludovic Barre <ludovic.barre@st.com> wrote:
>>>>>
>>>>> This patch fix a power-on issue, and avoid to retry the power sequence.
>>>>>
>>>>> In power off sequence: sdmmc must set pwr_reg in "power-cycle" state
>>>>> (value 0x2), to prevent the card from being supplied through the signal
>>>>> lines (all the lines are driven low).
>>>>>
>>>>> In power on sequence: when the power is stable, sdmmc must set pwr_reg
>>>>> in "power-off" state (value 0x0) to drive all signal to high before to
>>>>> set "power-on".
>>>>
>>>> Just a question to gain further understanding.
>>>>
>>>> Let's assume that the controller is a power-on state, because it's
>>>> been initialized by the boot loader. When the mmc core then starts the
>>>> power-on sequence (not doing a power-off first), would $subject patch
>>>> then cause the
>>>> MMCIPOWER to remain as is, or is it going to be overwritten?
>>
>> On sdmmc controller, the PWRCTRL[1:0] field of MMCIPOWER register allow
>> to manage sd lines and has a specific bahavior.
>>
>> PWRCTRL value:
>>    - 0x0: After reset, Reset: the SDMMC is disabled and the clock to the
>>           Card is stopped, SDMMC_D[7:0], and SDMMC_CMD are HiZ and
>>           SDMMC_CK is driven low.
>>           When written 00, power-off: the SDMMC is disabled and the clock
>>           to the card is stopped, SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK
>>           are driven high.
>>
>>    - 0x2: Power-cycle, the SDMMC is disabled and the clock to the card is
>>           stopped, SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are driven low.
>>
>>    - 0x3: Power-on: the card is clocked, The first 74 SDMMC_CK cycles the
>>           SDMMC is still disabled. After the 74 cycles the SDMMC is
>>           enabled and the SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are
>>           controlled according the SDMMC operation.
>>           **Any further write will be ignored, PWRCTRL value
>>           will keep 0x3**. when the SDMMC is ON (0x3) only a reset could
>>           change pwrctrl value and the state of sdmmc lines.
>>
>> So if the lines are already "ON", the power-on sequence (decribed in
>> commit message) not overwrite the pwctrl field and not disturb the sdmmc
>> lines.
> 
> Thanks for the detailed information, much appreciated!
> 
>>
>>>>
>>>> I am a little worried that we may start to rely on boot loader
>>>> conditions, which isn't really what we want either...
>>>>
>>
>> We not depend of boot loader conditions.
>>
>> This patch simply allows to drive high the sd lines before to set
>> "power-on" value (no effect if already power ON).
> 
> Yep, thanks!
> 
>>
>>>>>
>>>>> To avoid writing the same value to the power register several times, this
>>>>> register is cached by the pwr_reg variable. At probe pwr_reg is initialized
>>>>> to 0 by kzalloc of mmc_alloc_host.
>>>>>
>>>>> Like pwr_reg value is 0 at probing, the power on sequence fail because
>>>>> the "power-off" state is not writes (value 0x0) and the lines
>>>>> remain drive to low.
>>>>>
>>>>> This patch initializes "pwr_reg" variable with power register value.
>>>>> This it done in sdmmc variant init to not disturb default mmci behavior.
>>>>>
>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> Besides the comment, the code and the approach seems reasonable to me.
>>>
>>> Another related question. I just realized why you probably haven't set
>>> .pwrreg_nopower for the variant_stm32_sdmmc and variant_stm32_sdmmcv2.
>>>
>>> I guess it's because you need a slightly different way to restore the
>>> context of MMCIPOWER register at ->runtime_resume(), rather than just
>>> re-writing it with the saved register values. Is this something that
>>> you are looking into as well?
>>
>> Yes exactly, the sequence is slightly different. I can't write 0 on
>> mmci_runtime_suspend, and can't just re-writing the saved register.
> 
> So, it seems like you need to use the ->set_ios() callback, to
> re-configure the controller correctly.
> 
> Just tell if you need more help to make that work, otherwise I am here
> to review your patches.
> 
> In regards to $subject patch, I have applied it for next, thanks!

Thanks for your review.
Have a nice day.

> 
> Kind regards
> Uffe
> 
