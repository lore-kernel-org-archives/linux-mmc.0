Return-Path: <SRS0=UCfg=4M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C97C11D30
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Feb 2020 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA6321927
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Feb 2020 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IkyaGR4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBXQUn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:20:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgBXQUn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2020 11:20:43 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OGCfam007873;
        Mon, 24 Feb 2020 17:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=WOrB9zjTn0T7PtrYAJ4aCW7Dq+zTAEPFOtROr7XMOzo=;
 b=IkyaGR4EFtaiGt7dPLgTYVNiT5WVp0abgnGKHqvs5vb7jFPFo9CCfx7MR6GyWcYI94Pp
 vDjJlFTZxwfD7MgR7i+gIVXHFor29lRKAnyWX72QDjXyARdthSLlyUVR7OhnZdcm96nU
 gTLUdZkFVPS5qIqh+Kj+IHMY/TYLweul/f3DeoUbZbvsSXdVHpxWJe+L39GKH8vDCd5E
 jedIymmRP6bmhuo8z2+i2nkgF/8fGKuf3BH/8v2ZEcTYD0xQr72wxqPTBx6HiIdZArCU
 J864vOCt2r1/Ct0L3qydZ6kIHJVk9s2gQc3505UGe7Onar2sg6qbeYX9cf1t0eD9ltPv Lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yatn5ts7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 17:20:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D7BD410002A;
        Mon, 24 Feb 2020 17:20:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C73DE2A7B2C;
        Mon, 24 Feb 2020 17:20:23 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 17:20:23 +0100
Subject: Re: [PATCH V2 0/9] mmc: mmci: sdmmc: add sdr104 support
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
References: <20200128090636.13689-1-ludovic.barre@st.com>
 <CAPDyKFr+7SvRasPPjFDA2kwG0ERS-Qp3FGbVbRGLrscz5N=L2g@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <86464a0a-d830-465e-b35b-8dd2e766db70@st.com>
Date:   Mon, 24 Feb 2020 17:20:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr+7SvRasPPjFDA2kwG0ERS-Qp3FGbVbRGLrscz5N=L2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_04:2020-02-21,2020-02-24 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 2/19/20 à 11:28 AM, Ulf Hansson a écrit :
> On Tue, 28 Jan 2020 at 10:06, Ludovic Barre <ludovic.barre@st.com> wrote:
>>
>> To support the sdr104 mode, sdmmc variant needs:
>> -Hardware delay block support for sdmmc variant
>>   with tuning procedure
>> -Voltage switch callbacks
>> -sdmmc revision 2.0
>>
>> V2:
>> -regroup host->mmc_ops & mmc->ops assignment
>> -add timeout define
>> -rename prep_volt_switch to pre_sig_volt_switch
>> -rename volt_switch to post_sig_volt_switch
>> -add 'why' comment for "mmc: mmci: add volt_switch callbacks"
>>
>> Ludovic Barre (9):
>>    mmc: mmci: sdmmc: replace sg_dma_xxx macros
>>    mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
>>    mmc: mmci: add a reference at mmc_host_ops in mmci struct
>>    mmc: mmci: add private pointer for variant
>>    dt-bindings: mmc: mmci: add delay block base register for sdmmc
>>    mmc: mmci: sdmmc: add execute tuning with delay block
>>    mmc: mmci: add volt_switch callbacks
>>    mmc: mmci: sdmmc: add voltage switch functions
>>    mmc: mmci: add sdmmc variant revision 2.0
>>
>>   .../devicetree/bindings/mmc/mmci.txt          |   2 +
>>   drivers/mmc/host/mmci.c                       |  42 +++-
>>   drivers/mmc/host/mmci.h                       |   8 +
>>   drivers/mmc/host/mmci_stm32_sdmmc.c           | 204 +++++++++++++++++-
>>   4 files changed, 248 insertions(+), 8 deletions(-)
>>
>> --
>> 2.17.1
>>
> 
> Applied for next, thanks!

thanks Ulf.

> 
> I took the liberty to do minor amendments to some of the changelogs,
> but in particular I have change some of prefixes for the commit
> message headers into "mmc: mmci_sdmmc:".

Ok, I use this prefixe for next commit.

> 
> Please tell, if there is anything that you want me to update.

I tested your next branch, and it's ok for me.
sdmmc upstream is almost finished, I just some recent fixes to send.

> 
> Kind regards
> Uffe
> 
