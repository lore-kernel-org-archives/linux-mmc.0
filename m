Return-Path: <SRS0=rnDB=C2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75328C433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 04:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B582078D
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 04:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIQE7n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:59:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:30634 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgIQE7n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Sep 2020 00:59:43 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 00:59:43 EDT
IronPort-SDR: tQH15jtmZyoPgPDKQAMUIPHXioDUVN4opmcjQ7OC5LoHeN5o8ZcyQL2gOp87PdvHRey2uHeKn7
 4TzE1r8eObrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="147376543"
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; 
   d="scan'208";a="147376543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 21:52:33 -0700
IronPort-SDR: EZx53lVLNOJ7+SKCF+PiT3pV8k3iXJY82eiGNxo8putKmObQDEBj2qznk5oJDYZ/nwGc+KPk2v
 F8FAQvsRYRlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; 
   d="scan'208";a="331997095"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2020 21:52:30 -0700
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
 <20200916080558.GA2978867@laputa>
 <6bf86b26-391a-0699-1818-d070357b9ddc@intel.com>
 <20200917023113.GB3071249@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <255e030e-98e3-713a-a8fe-9f4c470c630f@intel.com>
Date:   Thu, 17 Sep 2020 07:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917023113.GB3071249@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/09/20 5:31 am, AKASHI Takahiro wrote:
> Adrian,
> 
> On Wed, Sep 16, 2020 at 01:00:35PM +0300, Adrian Hunter wrote:
>> On 16/09/20 11:05 am, AKASHI Takahiro wrote:
>>> Adrian,
>>>
>>> Your comments are scattered over various functions, and so
>>> I would like to address them in separate replies.
>>>
>>> First, I'd like to discuss sdhci_[add|remove]_host().
>>>
>>> On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
>>>> On 10/07/20 2:10 pm, Ben Chuang wrote:
>>>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>>
>>>>> In this commit, UHS-II related operations will be called via a function
>>>>> pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
>>>>> a kernel module.
>>>>> This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
>>>>> and when the UHS-II module is loaded. Otherwise, all the functions
>>>>> stay void.
>>>>>
>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>> ---
>>>
>>>  (snip)
>>>
>>>>>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
>>>>>  			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>>>>>  				      SDHCI_CARD_PRESENT;
>>>>> @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>>  		/* This may alter mmc->*_blk_* parameters */
>>>>>  		sdhci_allocate_bounce_buffer(host);
>>>>>  
>>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
>>>>> +	    host->version >= SDHCI_SPEC_400 &&
>>>>> +	    sdhci_uhs2_ops.add_host) {
>>>>> +		ret = sdhci_uhs2_ops.add_host(host, host->caps1);
>>>>> +		if (ret)
>>>>> +			goto unreg;
>>>>> +	}
>>>>> +
>>>>
>>>> I think you should look at creating uhs2_add_host() instead
>>>>
>>>>>  	return 0;
>>>>>  
>>>>>  unreg:
>>>>> @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>>>>>  {
>>>>>  	struct mmc_host *mmc = host->mmc;
>>>>>  
>>>>> +	/* FIXME: Do we have to do some cleanup for UHS2 here? */
>>>>> +
>>>>>  	if (!IS_ERR(mmc->supply.vqmmc))
>>>>>  		regulator_disable(mmc->supply.vqmmc);
>>>>>  
>>>>> @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
>>>>>  		mmc->cqe_ops = NULL;
>>>>>  	}
>>>>>  
>>>>> +	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
>>>>> +		/* host doesn't want to enable UHS2 support */
>>>>> +		mmc->caps &= ~MMC_CAP_UHS2;
>>>>> +		mmc->flags &= ~MMC_UHS2_SUPPORT;
>>>>> +
>>>>> +		/* FIXME: Do we have to do some cleanup here? */
>>>>> +	}
>>>>> +
>>>>>  	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
>>>>>  	if (!host->complete_wq)
>>>>>  		return -ENOMEM;
>>>>> @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
>>>>>  unled:
>>>>>  	sdhci_led_unregister(host);
>>>>>  unirq:
>>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
>>>>> +	    sdhci_uhs2_ops.remove_host)
>>>>> +		sdhci_uhs2_ops.remove_host(host, 0);
>>>>>  	sdhci_do_reset(host, SDHCI_RESET_ALL);
>>>>>  	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>>>>>  	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>>>>> @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>>>>  
>>>>>  	sdhci_led_unregister(host);
>>>>>  
>>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
>>>>> +	    sdhci_uhs2_ops.remove_host)
>>>>> +		sdhci_uhs2_ops.remove_host(host, dead);
>>>>> +
>>>>
>>>> I think you should look at creating uhs2_remove_host() instead
>>>
>>> You suggest that we will have separate sdhci_uhs2_[add|remove]_host(),
>>> but I don't think it's always convenient.
>>>
>>> UHS-II capable host will be set to call sdhci_uhs2_add_host() explicitly,
>>> but we can't do that in case of pci and pltfm based drivers as they utilize
>>> common helper functions, sdhci_pci_probe() and sdhci_pltfm_register(),
>>> respectively.
>>
>> sdhci-pci has an add_host op
>>
>> sdhci_pltfm_init can be used instead of sdhci_pltfm_register
>>
>>
>>> Therefore, we inevitably have to call sdhci_uhs2_add_host() there.
>>>
>>> If so, why should we distinguish sdhci_uhs2_add_host from sdhci_uhs_add_host?
>>> I don't see any good reason.
>>> Moreover, as a result, there exists a mixed usage of sdhci_ interfaces
>>> and sdhci_uhs2_ interfaces in sdhci-pci-core.c and sdhci-pltfm.c.
>>>
>>> It sounds odd to me.
>>
>> It is already done that way for cqhci.
> 
> Okay, if it is your policy, I will follow that.
> Then, I'm going to add
> - remove_host field to struct sdhci_pci_fixes
> - a controller specific helper function to each driver (only pci-gli for now)
>   even though it looks quite generic.

If they seem generic then consider naming them
sdhci_pci_uhs2_[add|remove]_host and putting them in sdhci-pci-core.c

> 
>   sdhci_gli_[add|remove]_host(struct sdhci_pci_slot *slot)
>   {
>       return sdhci_uhs2_[add|remove]_host(slot->host);
>   }
> 
> # Or do you want to create a file like sdhci-uhs2-pci.c for those functions?

No

> 
> -Takahiro Akashi
> 
>>>
>>> -Takahiro Akashi
>>>
>>>
>>>>
>>>>>  	if (!dead)
>>>>>  		sdhci_do_reset(host, SDHCI_RESET_ALL);
>>>>>  
>>>>>
>>>>
>>

