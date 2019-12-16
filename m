Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C239C43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4A8206A5
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfLPNqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:46:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:60796 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfLPNqe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Dec 2019 08:46:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 05:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="389461898"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.169]) ([10.237.72.169])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2019 05:46:30 -0800
Subject: Re: [PATCH v3 2/7] mmc: sdhci: add support for using external DMA
 devices
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, zhang.chunyan@linaro.org, tony@atomide.com
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-3-faiz_abbas@ti.com>
 <92fd22bf-3024-928d-ebf5-e7382988a36b@intel.com>
 <fdf1334a-39bc-9247-9934-df6e1562f4b8@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ebfceaa6-a8a9-1df2-4c31-263f097b68bd@intel.com>
Date:   Mon, 16 Dec 2019 15:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fdf1334a-39bc-9247-9934-df6e1562f4b8@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/12/19 10:27 am, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 12/12/19 6:25 pm, Adrian Hunter wrote:
>> On 10/12/19 11:51 am, Faiz Abbas wrote:
>>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>
>>> Some standard SD host controllers can support both external dma
>>> controllers as well as ADMA/SDMA in which the SD host controller
>>> acts as DMA master. TI's omap controller is the case as an example.
>>>
>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>> the host controller but does not have any support for external DMA
>>> controllers implemented using dmaengine, meaning that custom code is
>>> needed for any systems that use an external DMA controller with SDHCI.
>>>
>>> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
>>> 1. Map scatterlists before dmaengine_prep_slave_sg()
>>> 2. Use dma_async() functions inside of the send_command() path and call
>>> terminate_sync() in non-atomic context in case of an error.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
> ...
>>>  {
>>> @@ -1379,12 +1562,19 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>  	}
>>>  
>>>  	host->cmd = cmd;
>>> +	host->data_timeout = 0;
>>>  	if (sdhci_data_line_cmd(cmd)) {
>>>  		WARN_ON(host->data_cmd);
>>>  		host->data_cmd = cmd;
>>> +		sdhci_set_timeout(host, cmd);
>>>  	}
>>>  
>>> -	sdhci_prepare_data(host, cmd);
>>> +	if (cmd->data) {
>>> +		if (host->use_external_dma)
>>> +			sdhci_external_dma_prepare_data(host, cmd);
>>> +		else
>>> +			sdhci_prepare_data(host, cmd);
>>> +	}
>>
>> Please make the 3 changes above and the corresponding changes
>> sdhci_prepare_data into a separate patch i.e.
> 
> Ok. And I agree with all your style change requests above this. Will fix
> in v4.
> 
>>> @@ -2652,6 +2845,18 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>  	if (host->flags & SDHCI_REQ_USE_DMA) {
>>>  		struct mmc_data *data = mrq->data;
>>>  
>>> +		spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +		/* Terminate and synchronize dma in case of an error */
>>> +		if (data && (mrq->cmd->error || data->error) &&
>>> +		    host->use_external_dma) {
>>> +			struct dma_chan *chan = sdhci_external_dma_channel(host,
>>> +									  data);
>>> +			dmaengine_terminate_sync(chan);
>>> +		}
>>> +
>>> +		spin_lock_irqsave(&host->lock, flags);
>>> +
>>
>> Need to take the mrq out of mrqs_done[] to ensure it is not processed again,
>> and put it back again to be consistent with the remaining code. Also put
>> host->use_external_dma as the first condition i.e.
>>
>> 		if (host->use_external_dma && data &&
>> 		    (mrq->cmd->error || data->error)) {
>> 			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
>>
>> 			host->mrqs_done[i] = NULL;
>> 			spin_unlock_irqrestore(&host->lock, flags);
>> 			dmaengine_terminate_sync(chan);
>> 			spin_lock_irqsave(&host->lock, flags);
>> 			sdhci_set_mrq_done(host, mrq);
>> 		}
>>
>> where sdhci_set_mrq_done() is factored out from __sdhci_finish_mrq() i.e.
>>
>> static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>> {
>> 	int i;
>>
>> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
>> 		if (host->mrqs_done[i] == mrq) {
>> 			WARN_ON(1);
>> 			return;
>> 		}
>> 	}
>>
>> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
>> 		if (!host->mrqs_done[i]) {
>> 			host->mrqs_done[i] = mrq;
>> 			break;
>> 		}
>> 	}
>>
>> 	WARN_ON(i >= SDHCI_MAX_MRQS);
>> }
>>
>> sdhci_set_mrq_done() can be made in the refactoring patch.
> Haven't we already done the sdhci_set_mrq_done() part in
> __sdhci_finish_mrq()?
> 
> We are picking up an already "done" mrq, looking at whether it had any
> error and then sychronizing with external dma. Or at least that is my
> understanding.

sdhci supports having 2 requests (1 data, 1 cmd) at a time, so there is an
error case where 1 request will wait for the 2nd request before doing a
reset.  That logic is further down in sdhci_request_done() so you have to
put the mrq back into host->mrqs_done[] to make it work.

> 
>>
>>>  		if (data && data->host_cookie == COOKIE_MAPPED) {
>>>  			if (host->bounce_buffer) {
>>>  				/*
>>> @@ -3758,12 +3963,28 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>  		       mmc_hostname(mmc), host->version);
>>>  	}
>>>  
>>> -	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>> +	if (host->use_external_dma) {
>>> +		ret = sdhci_external_dma_init(host);
>>> +		if (ret == -EPROBE_DEFER)
>>> +			goto unreg;
>>> +
>>> +		/*
>>> +		 * Fall back to use the DMA/PIO integrated in standard SDHCI
>>> +		 * instead of external DMA devices.
>>> +		 */
>>> +		if (ret)
>>> +			sdhci_switch_external_dma(host, false);
>>> +	}
>>> +
>>> +	if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
>>>  		host->flags |= SDHCI_USE_SDMA;
>>> -	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
>>> +	} else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
>>>  		DBG("Controller doesn't have SDMA capability\n");
>>> -	else
>>> +	} else if (host->use_external_dma) {
>>> +		/* Using dma-names to detect external dma capability */
>>
>> What is this change for?  Do you expect for SDHCI_USE_SDMA and
>> SDHCI_USE_ADMA flags to be clear?
> 
> Yes. Today the code enables SDMA by default (in the else part below
> this). I want it to not enable SDMA in the external dma case.

What about moving the "if (host->use_external_dma) {" clause and explicitly
clearing SDHCI_USE_SDMA and SDHCI_USE_ADMA?
