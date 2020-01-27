Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DBC33CB1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035E624673
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Oa8/ux9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0NV3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:21:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32028 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgA0NV3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 08:21:29 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RDHIgu030114;
        Mon, 27 Jan 2020 14:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Ynyg3l3bCZvEHYJP9ooaKE6qoJny3AOLT9lZG+35P+Y=;
 b=Oa8/ux9a8wVQREI/DQEGek7/L3+KZ11oy/8M8Wqb4ntcZzz9NkaGBk5eii18tdyUP/2l
 o48/s6ku5LYMkcHRk6Lgt0qo3vx5GKdMVv6/T6QRdFjo5anu80ZlWhDz655ISyMDzeFz
 0LYci8ICQasSli1cJBR6qOx4SNXgOR5WZHkb+EbpYTDPSchmJszbbgMoowblruWO5uih
 UQdNCd7/Ejq20XtRXAJaWWNILoj9IV65o3cnL+SAx29HZi+2dYVwaO3aeaOF9KKgDKUQ
 P7S41DkRid9Omm/WBjysgy/UEsDxuDAjBMKVCJ34qprTLZ9utI6nffWfUnBNQZtWU88Y +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpas72t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 14:21:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DA4D10002A;
        Mon, 27 Jan 2020 14:21:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECEE62B1871;
        Mon, 27 Jan 2020 14:21:19 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 14:21:18 +0100
Subject: Re: [PATCH 7/9] mmc: mmci: add volt_switch callbacks
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
 <20200110134823.14882-8-ludovic.barre@st.com>
 <CAPDyKFqt6SuQh8V1_2-2HzBixR2HTKM+1FKgYuNA1zytc22W7g@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <1b8e1428-c1b6-86e4-8d21-4257bcc16a90@st.com>
Date:   Mon, 27 Jan 2020 14:21:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqt6SuQh8V1_2-2HzBixR2HTKM+1FKgYuNA1zytc22W7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 1/24/20 à 2:12 PM, Ulf Hansson a écrit :
> On Fri, 10 Jan 2020 at 14:49, Ludovic Barre <ludovic.barre@st.com> wrote:
>>
>> This patch adds 2 voltage switch callbacks in mmci_host_ops:
>> -prep_volt_switch allows to prepare voltage switch before to
>>   sent the SD_SWITCH_VOLTAGE command (cmd11).
>> -volt_switch callback allows to define specific action after
>>   regulator set voltage.
> 
> I am fine with adding these callbacks, however I strongly suggest to
> have a reference to "signal voltage" in the name of the callbacks. As
> to avoid confusion for what there are used for.
> 
> Perhaps ->post_sig_volt_switch() and ->pre_sig_volt_switch() can work?
> 

sure, I change to post_sig_volt_switch and pre_sig_volt_switch.

>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 8 ++++++++
>>   drivers/mmc/host/mmci.h | 2 ++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 00b473f57047..d76a59c06cb0 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/mmc/pm.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/card.h>
>> +#include <linux/mmc/sd.h>
>>   #include <linux/mmc/slot-gpio.h>
>>   #include <linux/amba/bus.h>
>>   #include <linux/clk.h>
>> @@ -1207,6 +1208,9 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>                  writel_relaxed(clks, host->base + MMCIDATATIMER);
>>          }
>>
>> +       if (host->ops->prep_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)
>> +               host->ops->prep_volt_switch(host);
>> +
>>          if (/*interrupt*/0)
>>                  c |= MCI_CPSM_INTERRUPT;
>>
>> @@ -1820,6 +1824,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
>>
>>   static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>   {
>> +       struct mmci_host *host = mmc_priv(mmc);
>>          int ret = 0;
>>
>>          if (!IS_ERR(mmc->supply.vqmmc)) {
>> @@ -1839,6 +1844,9 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>                          break;
>>                  }
>>
>> +               if (!ret && host->ops && host->ops->volt_switch)
>> +                       ret = host->ops->volt_switch(host, ios);
>> +
>>                  if (ret)
>>                          dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
>>          }
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index ddcdfb827996..c04a144259a2 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -377,6 +377,8 @@ struct mmci_host_ops {
>>          void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
>>          void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
>>          bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
>> +       void (*prep_volt_switch)(struct mmci_host *host);
>> +       int (*volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
>>   };
>>
>>   struct mmci_host {
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 
