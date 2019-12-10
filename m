Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD89C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E836C20836
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MUQzmcaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLJODu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:03:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbfLJODu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 09:03:50 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAE3Wsi012011;
        Tue, 10 Dec 2019 15:03:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=N8+PdFVjbmmTn2I/xjA82hSahC5K+ZEGZOWc06jsdSY=;
 b=MUQzmcaWPIYcSTlCzircMy1rPaaNiXBKIacp8SocnyDqAKPN7Z6dONkspE43CLAWPuxn
 MuhY7GGaTL3JH06njZs7ClppQ5+O8T7WrcrMbdTTQkTs8tNnpbwhYUoqZwH7iX83doNo
 sEZiXhumdCk9xi1hE+P304zPUqOIAVrEGOURZw3y7a6oL6IEGq5vWSuEzvLeEV0xf7rd
 r/ayH/N7mh7TdKlQKS0Tew9NuXH4aIL14zSuX7vO6peXhQll1/WdDlbMK6JfBupHMusY
 +IwBIx4jMvin82oJ4JihyvzDFNMfruaYLHntijqA0T/5j6NfRd82NJqYoYxxSHY2VPzR fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wrbrfcuhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 15:03:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FC4610003A;
        Tue, 10 Dec 2019 15:03:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AD3E2BC7B8;
        Tue, 10 Dec 2019 15:03:16 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 15:03:14 +0100
Subject: Re: [PATCH 1/1] mmc: mmci: add threaded irq to abort DPSM of
 non-functional state
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
References: <20191113172514.19052-1-ludovic.Barre@st.com>
 <CAPDyKFrZxOCkw9U05UZPRSGz2CqmhOq944z8MEVox8Y_UEYC4A@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <2e5639cd-0dea-8cc1-d1aa-721025d66bac@st.com>
Date:   Tue, 10 Dec 2019 15:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrZxOCkw9U05UZPRSGz2CqmhOq944z8MEVox8Y_UEYC4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_03:2019-12-10,2019-12-10 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 12/10/19 à 1:30 PM, Ulf Hansson a écrit :
> On Wed, 13 Nov 2019 at 18:25, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> If datatimeout occurs on R1B request, the Data Path State Machine stays
>> in busy and is non-functional. Only a reset aborts the DPSM.
>>
>> Like a reset must be outside of critical section, this patch adds
>> threaded irq function to release state machine. In this case,
>> the mmc_request_done is called at the end of threaded irq and
>> skipped into irq handler.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
>>   drivers/mmc/host/mmci.h |  1 +
>>   2 files changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 40e72c30ea84..ec6e249c87ca 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
>>   static void
>>   mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>>   {
>> +       if (host->irq_action == IRQ_WAKE_THREAD)
>> +               return;
>> +
> 
> It seems a bit unnecessary to check this every time mmci_request_end()
> is called.
> 
> How about avoiding to call mmci_request_end() for the one specific
> condition instead? See more below.
> 
>>          writel(0, host->base + MMCICOMMAND);
>>
>>          BUG_ON(host->data);
>> @@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          } else if (host->variant->busy_timeout && busy_resp &&
>>                     status & MCI_DATATIMEOUT) {
>>                  cmd->error = -ETIMEDOUT;
>> +               host->irq_action = IRQ_WAKE_THREAD;
> 
> You could check this flag a few lines below and if it's set to
> IRQ_WAKE_THREAD, avoid to call mmci_request_end().

yes, it was my first implementation. after, I wanted to centralize this,
if the irq threaded would be extend.
But you are right, it's not the goal of this commit.

I resend a v2

> 
>>          } else {
>>                  cmd->resp[0] = readl(base + MMCIRESPONSE0);
>>                  cmd->resp[1] = readl(base + MMCIRESPONSE1);
>> @@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>   {
>>          struct mmci_host *host = dev_id;
>>          u32 status;
>> -       int ret = 0;
>>
>>          spin_lock(&host->lock);
>> +       host->irq_action = IRQ_HANDLED;
>>
>>          do {
>>                  status = readl(host->base + MMCISTATUS);
>> @@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>                  if (host->variant->busy_detect_flag)
>>                          status &= ~host->variant->busy_detect_flag;
>>
>> -               ret = 1;
>>          } while (status);
>>
>>          spin_unlock(&host->lock);
>>
>> -       return IRQ_RETVAL(ret);
>> +       return host->irq_action;
>> +}
>> +
>> +/*
>> + * mmci_irq_threaded is call if the mmci host need to release state machines
>> + * before to terminate the request.
>> + * If datatimeout occurs on R1B request, the Data Path State Machine stays
>> + * in busy and is non-functional. Only a reset can to abort the DPSM.
>> + */
>> +static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
>> +{
>> +       struct mmci_host *host = dev_id;
>> +       unsigned long flags;
>> +
>> +       if (host->rst) {
>> +               reset_control_assert(host->rst);
>> +               udelay(2);
>> +               reset_control_deassert(host->rst);
>> +       }
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +       writel(host->clk_reg, host->base + MMCICLOCK);
>> +       writel(host->pwr_reg, host->base + MMCIPOWER);
>> +       writel(MCI_IRQENABLE | host->variant->start_err,
>> +              host->base + MMCIMASK0);
>> +
>> +       host->irq_action = IRQ_HANDLED;
>> +       mmci_request_end(host, host->mrq);
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       return host->irq_action;
>>   }
>>
>>   static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> @@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
>>                          goto clk_disable;
>>          }
>>
>> -       ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
>> -                       DRIVER_NAME " (cmd)", host);
>> +       ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], mmci_irq,
>> +                                       mmci_irq_threaded, IRQF_SHARED,
>> +                                       DRIVER_NAME " (cmd)", host);
>>          if (ret)
>>                  goto clk_disable;
>>
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 158e1231aa23..5e63c0596364 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -412,6 +412,7 @@ struct mmci_host {
>>
>>          struct timer_list       timer;
>>          unsigned int            oldstat;
>> +       u32                     irq_action;
>>
>>          /* pio stuff */
>>          struct sg_mapping_iter  sg_miter;
>> --
>> 2.17.1
>>
> 
> Otherwise this looks good, besides my other earlier comments, of course.
> 
> Kind regards
> Uffe
> 
