Return-Path: <SRS0=w3lL=2N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC1C2D0C0
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Dec 2019 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CD0206CB
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Dec 2019 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sbcFqhQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWOYL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:24:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45580 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOYK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2019 09:24:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNENxdb127514;
        Mon, 23 Dec 2019 08:23:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577111039;
        bh=+On56O2Tc/wog1z+VbvgCVcTNDNaeeIWmkKlZWUSHDg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sbcFqhQSYaxf42gfHtCuGmYayRIDQ6g9/8AhIfJsVtbo5qIjWGNM4VQbao6iG+Ktb
         dXbzbnN6aPrN/1DiE8p9dh8EE0RKnIVMXxoL4hvwM2CwPpZAqDhnNGPeuFJaiqOQmi
         CIJJB3mIDmbpz2rNiWGKuLV4Z4+kzG30kINHIYSA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNENxQ9056841
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 08:23:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 08:23:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 08:23:59 -0600
Received: from [172.24.190.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNENtNM074112;
        Mon, 23 Dec 2019 08:23:56 -0600
Subject: Re: [PATCH v3 2/7] mmc: sdhci: add support for using external DMA
 devices
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <zhang.chunyan@linaro.org>,
        <tony@atomide.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-3-faiz_abbas@ti.com>
 <92fd22bf-3024-928d-ebf5-e7382988a36b@intel.com>
 <fdf1334a-39bc-9247-9934-df6e1562f4b8@ti.com>
 <ebfceaa6-a8a9-1df2-4c31-263f097b68bd@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <eee34228-117e-02fe-4c77-d6b316a20819@ti.com>
Date:   Mon, 23 Dec 2019 19:55:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <ebfceaa6-a8a9-1df2-4c31-263f097b68bd@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 16/12/19 7:15 pm, Adrian Hunter wrote:
> On 16/12/19 10:27 am, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 12/12/19 6:25 pm, Adrian Hunter wrote:
>>> On 10/12/19 11:51 am, Faiz Abbas wrote:
>>>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>
>>>> Some standard SD host controllers can support both external dma
>>>> controllers as well as ADMA/SDMA in which the SD host controller
>>>> acts as DMA master. TI's omap controller is the case as an example.
>>>>
>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>>> the host controller but does not have any support for external DMA
>>>> controllers implemented using dmaengine, meaning that custom code is
>>>> needed for any systems that use an external DMA controller with SDHCI.
>>>>
>>>> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
>>>> 1. Map scatterlists before dmaengine_prep_slave_sg()
>>>> 2. Use dma_async() functions inside of the send_command() path and call
>>>> terminate_sync() in non-atomic context in case of an error.
>>>>
>>>> @@ -2652,6 +2845,18 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>>  	if (host->flags & SDHCI_REQ_USE_DMA) {
>>>>  		struct mmc_data *data = mrq->data;
>>>>  
>>>> +		spin_unlock_irqrestore(&host->lock, flags);
>>>> +
>>>> +		/* Terminate and synchronize dma in case of an error */
>>>> +		if (data && (mrq->cmd->error || data->error) &&
>>>> +		    host->use_external_dma) {
>>>> +			struct dma_chan *chan = sdhci_external_dma_channel(host,
>>>> +									  data);
>>>> +			dmaengine_terminate_sync(chan);
>>>> +		}
>>>> +
>>>> +		spin_lock_irqsave(&host->lock, flags);
>>>> +
>>>
>>> Need to take the mrq out of mrqs_done[] to ensure it is not processed again,
>>> and put it back again to be consistent with the remaining code. Also put
>>> host->use_external_dma as the first condition i.e.
>>>
>>> 		if (host->use_external_dma && data &&
>>> 		    (mrq->cmd->error || data->error)) {
>>> 			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
>>>
>>> 			host->mrqs_done[i] = NULL;
>>> 			spin_unlock_irqrestore(&host->lock, flags);
>>> 			dmaengine_terminate_sync(chan);
>>> 			spin_lock_irqsave(&host->lock, flags);
>>> 			sdhci_set_mrq_done(host, mrq);
>>> 		}
>>>
>>> where sdhci_set_mrq_done() is factored out from __sdhci_finish_mrq() i.e.
>>>
>>> static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>>> {
>>> 	int i;
>>>
>>> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
>>> 		if (host->mrqs_done[i] == mrq) {
>>> 			WARN_ON(1);
>>> 			return;
>>> 		}
>>> 	}
>>>
>>> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
>>> 		if (!host->mrqs_done[i]) {
>>> 			host->mrqs_done[i] = mrq;
>>> 			break;
>>> 		}
>>> 	}
>>>
>>> 	WARN_ON(i >= SDHCI_MAX_MRQS);
>>> }
>>>
>>> sdhci_set_mrq_done() can be made in the refactoring patch.
>> Haven't we already done the sdhci_set_mrq_done() part in
>> __sdhci_finish_mrq()?
>>
>> We are picking up an already "done" mrq, looking at whether it had any
>> error and then sychronizing with external dma. Or at least that is my
>> understanding.
> 
> sdhci supports having 2 requests (1 data, 1 cmd) at a time, so there is an
> error case where 1 request will wait for the 2nd request before doing a
> reset.  That logic is further down in sdhci_request_done() so you have to
> put the mrq back into host->mrqs_done[] to make it work.

Sorry for the late response. I had to spend some time figuring out how
the mrqs_done handling works. Will add the new function above.

> 
>>
>>>
>>>>  		if (data && data->host_cookie == COOKIE_MAPPED) {
>>>>  			if (host->bounce_buffer) {
>>>>  				/*
>>>> @@ -3758,12 +3963,28 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>  		       mmc_hostname(mmc), host->version);
>>>>  	}
>>>>  
>>>> -	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>> +	if (host->use_external_dma) {
>>>> +		ret = sdhci_external_dma_init(host);
>>>> +		if (ret == -EPROBE_DEFER)
>>>> +			goto unreg;
>>>> +
>>>> +		/*
>>>> +		 * Fall back to use the DMA/PIO integrated in standard SDHCI
>>>> +		 * instead of external DMA devices.
>>>> +		 */
>>>> +		if (ret)
>>>> +			sdhci_switch_external_dma(host, false);
>>>> +	}
>>>> +
>>>> +	if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
>>>>  		host->flags |= SDHCI_USE_SDMA;
>>>> -	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
>>>> +	} else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
>>>>  		DBG("Controller doesn't have SDMA capability\n");
>>>> -	else
>>>> +	} else if (host->use_external_dma) {
>>>> +		/* Using dma-names to detect external dma capability */
>>>
>>> What is this change for?  Do you expect for SDHCI_USE_SDMA and
>>> SDHCI_USE_ADMA flags to be clear?
>>
>> Yes. Today the code enables SDMA by default (in the else part below
>> this). I want it to not enable SDMA in the external dma case.
> 
> What about moving the "if (host->use_external_dma) {" clause and explicitly
> clearing SDHCI_USE_SDMA and SDHCI_USE_ADMA?
> 

I am ok with this as well. Sending a new version.

Thanks,
Faiz


