Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C82C4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EA020717
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 09:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIYJDF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:03:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:46349 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbgIYJDF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Sep 2020 05:03:05 -0400
IronPort-SDR: xKH1SJMtEssAGfWPe1tbjXdO+XdZItYxcz4Mucd0pAg+qWV6ZE5zpS2y4YeCo8gytcA1TyY12s
 4yzzRvjkgFlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158827905"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="158827905"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 02:03:05 -0700
IronPort-SDR: n41CJjIRD3xQYZiPWc8XiZFmQm7Zs/hQW3FWh1MQC5nPjTKpjzEhzRdF9d/j6aaIfpOQrTz7le
 DKCWnmEvImZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="310745537"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2020 02:03:01 -0700
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
 <20200924093538.GA35720@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <14c80da3-5ef5-fba3-8b98-3c50f6241475@intel.com>
Date:   Fri, 25 Sep 2020 12:02:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924093538.GA35720@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/20 12:35 pm, AKASHI Takahiro wrote:
> Adrian,
> 
> This is, hopefully, my last reply to your comments on this patch#12.
> 
> Regarding _request() and _send_command() (and more),
> 
> On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
>> On 10/07/20 2:10 pm, Ben Chuang wrote:
>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>
>>> In this commit, UHS-II related operations will be called via a function
>>> pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
>>> a kernel module.
>>> This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
>>> and when the UHS-II module is loaded. Otherwise, all the functions
>>> stay void.
>>>
>   (snip)
> 
>> Again, this is what I want to avoid.  I would like to have 3 kinds of functions:
>> 	- SD mode only
>> 	- UHS-II only
>> 	- SD functions with no UHS-II code, that can also be used by UHS-II
>> i.e. I don't want to mix UHS-II code and SD mode code in the same function.
>>
>> I think sdhci-uhs2.c should provide a request function and a send_command function.
>> I would start by removing everything you may not need, and then see if you have any problems.
>> e.g.
>>
>> void uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> {
>> 	struct sdhci_host *host = mmc_priv(mmc);
>> 	struct mmc_command *cmd;
>> 	unsigned long flags;
>>
>> 	if (!host->uhs2_mode) {
>> 		sdhci_request(mmc, mrq);
>> 		return;
>> 	}
>>
>> 	spin_lock_irqsave(&host->lock, flags);
>> 	uhs2_send_command(host, cmd);
>> 	spin_unlock_irqrestore(&host->lock, flags);
>> }
>> EXPORT_SYMBOL_GPL(uhs2_request);
>>
>> For sdhci_prepare_data(), I would factor out the dma part, so
>>
>> static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>> {
>> 	struct mmc_data *data = cmd->data;
>>
>> 	sdhci_initialize_data(host, data);
>>
>> 	sdhci_prepare_dma(host, data);
>>
>> 	sdhci_set_block_info(host, data);
>> }
>>
>> The you could export sdhci_initialize_data() and sdhci_prepare_dma() for uhs2.
>>
>>>  }
>>>  
>>>  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>>> @@ -1439,6 +1463,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>  	u16 mode = 0;
>>>  	struct mmc_data *data = cmd->data;
>>>  
>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
>>> +	    host->mmc->flags & MMC_UHS2_SUPPORT) {
>>> +		if (sdhci_uhs2_ops.set_transfer_mode)
>>> +			sdhci_uhs2_ops.set_transfer_mode(host, cmd);
>>> +		return;
>>> +	}
>>> +
>>
>> Once you provide uhs2_request() and uhs2_send_command(), the transfer mode setting can be done in sdhci-uhs2.c
> 
> If I try to make changes as you suggested above, a lot of other uhs2-flavored
> functions will also be created due to calling dependency/sequences
> and for "completeness" compared to uhs counterparts.
> They probably include
>     sdhci_uhs2_prepare_data()
>     sdhci_uhs2_external_dma_prepare_data()
>     sdhci_uhs2_send_command()
>     sdhci_uhs2_send_command_try()
>     sdhci_uhs2_send_tuning()
>     sdhci_uhs2_request()
>     sdhci_uhs2_request_atomic()
>     sdhci_uhs2_thread_irq()
>     sdhci_uhs2_irq()
>     sdhci_uhs2_cmd_irq()
>     sdhci_uhs2_finish_command()
>     sdhci_uhs2_resume_host()
>     __sdhci_uhs2_add_host()
>     sdhci_uhs2_add_host()
> (Some may not be used under the current drivers.)
> 
> In addition, a bunch of functions in sdhci.c will also have to be exported
> to uhs2 as "global" functions instead of "static."
> 
> Is this all that you expect to see?

Yes.  Add what you need.
