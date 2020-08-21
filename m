Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32893C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5722078B
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHUO2r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:28:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:40735 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgHUO2r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:28:47 -0400
IronPort-SDR: 0g8xVY0iyrKT/0P9YuHYec8jsh8qSyafrdHYoXY4xMFn+yDI0Ovi5uYaBkAtNmrGyLp2Ood07j
 hxseELYwybfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="156595407"
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="156595407"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:28:46 -0700
IronPort-SDR: AJrAyZoWR5sT0vUxtRkAvJQnYwpeH8jNo6DiUn+ppEZBZqMrOJj5NQoFeLEklyk8ykP9G3Y2or
 OT56dLCFGRfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="497995621"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2020 07:28:41 -0700
Subject: Re: [RFC PATCH V3 04/21] mmc: core: UHS-II support, try to select
 UHS-II interface
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
References: <20200710110848.29114-1-benchuanggli@gmail.com>
 <CAPDyKFoGQFxdNVA+A76NitGP=yZvE2z90fewAo21Q8U+bgPbBQ@mail.gmail.com>
 <CACT4zj_iO58CPk_PTfNCot+c2Z1_vcWeVUwH2nPgN-jx43eN2g@mail.gmail.com>
 <CAPDyKFoL8Yh_SJSw56kQsFBRE64oRGTnyzgvOm__-1f+Cvxpzw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a5ee1d39-01c7-acb4-fe84-64a416ced9de@intel.com>
Date:   Fri, 21 Aug 2020 17:28:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoL8Yh_SJSw56kQsFBRE64oRGTnyzgvOm__-1f+Cvxpzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/08/20 3:25 pm, Ulf Hansson wrote:
> [...]
> 
>>>> @@ -2300,6 +2304,33 @@ void mmc_rescan(struct work_struct *work)
>>>>                 goto out;
>>>>         }
>>>>
>>>> +       if (host->caps & MMC_CAP_UHS2) {
>>>> +               /*
>>>> +                * Start to try UHS-II initialization from 52MHz to 26MHz
>>>> +                * (RCLK range) per spec.
>>>> +                */
>>>> +               for (i = 0; i < ARRAY_SIZE(uhs2_freqs); i++) {
>>>> +                       unsigned int freq = uhs2_freqs[i];
>>>> +                       int err;
>>>> +
>>>> +                       err = mmc_uhs2_rescan_try_freq(host,
>>>> +                                                      max(freq, host->f_min));
>>>> +                       if (!err) {
>>>> +                               mmc_release_host(host);
>>>> +                               goto out;
>>>> +                       }
>>>> +
>>>> +                       if (err == UHS2_PHY_INIT_ERR)
>>>> +                               /* UHS2 IF detect or Lane Sync error.
>>>> +                                * Try legacy interface.
>>>> +                                */
>>>> +                               break;
>>>> +
>>>> +                       if (freq <= host->f_min)
>>>> +                               break;
>>>> +               }
>>>
>>> Assuming we change the initialization order, trying to initialize the
>>> legacy SD interface first to figure out if UHS-II is supported, then I
>>> think we should be able to move the entire code above into a the
>>> UHS-II specific code/path.
>>
>> If the host tries to use the SD interface first,
>> some failure status needs to be considered.
>>
>> For example, first run in SD mode, try UHS-II interface failure,
>>  and then return to SD flow again.
>> I don't know a good way to go back to SD flow again.
> 
> Right, a re-try path for the legacy SD interface is a very good idea!
> However, I don't think the initial support for UHS-II needs to cover
> it. Instead we can add that on top, don't you think?
> 
> As a matter of fact, we could even use something like that for
> different legacy SD speed modes. For example, if UHS-I SDR104 fails we
> could try with UHS-I SDR25.
> 
>>
>>>
>>>> +       }
>>>> +
>>>>         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>>>>                 unsigned int freq = freqs[i];
>>>>                 if (freq > host->f_max) {
>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>> index 5a2210c25aa7..c5b071bd98b3 100644
>>>> --- a/drivers/mmc/core/sd.c
>>>> +++ b/drivers/mmc/core/sd.c
>>>> @@ -901,6 +901,20 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>>>>                 err = mmc_read_switch(card);
>>>>                 if (err)
>>>>                         return err;
>>>> +               if (host->flags & MMC_UHS2_INITIALIZED) {
>>>
>>> Rather than using host->flags, to tweak the behavior of
>>> mmc_sd_setup_card() to support UHS-II, I would prefer to give
>>> mmc_sd_setup_card() a new in-parameter that it can look at instead.
>>
>> Do you mean that adding a new in-parameter to mmc_sd_setup_card() likes this
>> mmc_sd_setup_card(struct mmc_host *, struct mmc_card *, boot reinit,
>> boot uhsii); ?
> 
> Correct.
> 
> [...]
> 
> Looks like we have covered most of the review for the mmc core
> changes. But please tell me, if there is anything else you want me to
> look at - at any time. Otherwise I am deferring to wait for a new
> version of the series.
> 
> If I get some time, I may start to help with hacking some code.
> Perhaps I can do some preparations, so it makes it easier for you to
> add the UHS-II specific code. If so, I will let you know about it, of
> course.
> 
> When it comes to the changes to SDHCI, I am relying on Adrian to give
> his opinions.

I have made some comments.  The thrust of which is:
- get all the UHS-II code into sdhci-uhs2 (not sdhci.c)
- make the driver (i.e sdhci-pci-gli) set existing mmc host ops callbacks
and sdhci host ops callbacks as much as possible to provide UHS-II
functionality i.e. avoid adding new hooks if possible
- refactoring and exporting functions from sdhci.c where that can be done
logically, but otherwise writing separate code for UHS-II
