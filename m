Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A63BC2D0CD
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B3021582
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nT0CjEqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLRPUI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:20:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3856 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfLRPUH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 10:20:07 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIFISIS017156;
        Wed, 18 Dec 2019 16:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=WneSex7HLvk1knfWmC+iWo4b9iXA1aE+DZZb+Ph0YE0=;
 b=nT0CjEqdbNCGAEn8ad4RksgAUyfA4q5u1qVfyaiaiXV9YAkDPApm47cmN8PUcWYpBm1q
 BWx03o7gK2FmI3+EChRlvi70Ru79DJ0pC4LcIsPRC+mLP1qFHl7DamP0vYxAJPZGmlxh
 M7y8vhoZ2QYT04uUbKyO0OMoasjPP6CdO5f/ESlebwgjAszJNvHFhIm/lANHzilnj83W
 R93vTVwKKxBeflkxarvyBuwcQe3KP5gD9g8x0RD2wdV6/bZhODqMaYh3onmq6M1/HgC0
 5IvTstSQBVlMWFuilPsYv/xfW3m1+w8Gs1mVUlxliu6azrck1/SbHzpNEZ0fdvGjzOQo Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1n0dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 16:19:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22D8C100038;
        Wed, 18 Dec 2019 16:19:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E9792B220D;
        Wed, 18 Dec 2019 16:19:44 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 16:19:42 +0100
Subject: Re: [PATCH V2] mmc: mmci: add threaded irq to abort DPSM of
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
References: <20191211133934.16932-1-ludovic.Barre@st.com>
 <CAPDyKFpoqEXO1JvjF=0hX97PiwP=2c1eWORsacb8QvZM=1Tvjw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <7019a4b8-e7a4-0e3a-4c42-0d46c80e5126@st.com>
Date:   Wed, 18 Dec 2019 16:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpoqEXO1JvjF=0hX97PiwP=2c1eWORsacb8QvZM=1Tvjw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi ulf

Le 12/18/19 à 3:01 PM, Ulf Hansson a écrit :
> On Wed, 11 Dec 2019 at 14:40, Ludovic Barre <ludovic.Barre@st.com> wrote:
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
> 
> Applied for next, thanks!
> 
> I took the liberty of doing some minor updates (changelog/comment),
> please have a look and let me know if there is something you want me
> to change.
> 

I read the modifications (changelog and comment function),
and it's ok for me.

thanks
Ludo

> And again, apologize for the delays!
> 
> Kind regards
> Uffe
> 
> 
>> ---
>> change V2:
>>   -check IRQ_WAKE_THREAD only in mmci_cmd_irq error part,
>>    to avoid this test in mmci_request_end.
>>
>> ---
>>   drivers/mmc/host/mmci.c | 46 +++++++++++++++++++++++++++++++++++------
>>   drivers/mmc/host/mmci.h |  1 +
>>   2 files changed, 41 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 40e72c30ea84..2b91757e3e84 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1321,6 +1321,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          } else if (host->variant->busy_timeout && busy_resp &&
>>                     status & MCI_DATATIMEOUT) {
>>                  cmd->error = -ETIMEDOUT;
>> +               host->irq_action = IRQ_WAKE_THREAD;
>>          } else {
>>                  cmd->resp[0] = readl(base + MMCIRESPONSE0);
>>                  cmd->resp[1] = readl(base + MMCIRESPONSE1);
>> @@ -1339,7 +1340,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>                                  return;
>>                          }
>>                  }
>> -               mmci_request_end(host, host->mrq);
>> +
>> +               if (host->irq_action != IRQ_WAKE_THREAD)
>> +                       mmci_request_end(host, host->mrq);
>> +
>>          } else if (sbc) {
>>                  mmci_start_command(host, host->mrq->cmd, 0);
>>          } else if (!host->variant->datactrl_first &&
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
