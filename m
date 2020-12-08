Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EEC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75C023A7D
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 08:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgLHIti (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:49:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:18181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgLHIti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Dec 2020 03:49:38 -0500
IronPort-SDR: llUxlM0XzVXBBN1SffG6Z6aC+VRx4ZM3kYwRc8kUP1IZPxk8G+RZebdvTX+ZVd8DwkfFkOkiwt
 mereTPu+h73Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="174002494"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="174002494"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 00:48:51 -0800
IronPort-SDR: pMczkkcSRYKv/O4u8W5KLpKfRiGFd5mjH1wslwYA8X5ddg7EHrvtiH8YMX2mtQ5UH5SdUgMe/r
 x4y2bWuiNdPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="347815745"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2020 00:48:49 -0800
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <c8f7e9ad-3e8d-01cc-edeb-5be364bfcc36@intel.com>
 <20201201030937.GE43403@laputa>
 <523f9ed9-318e-7121-d58d-c3843d9b9b7c@intel.com>
 <20201208075815.GC31973@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5eef5f29-624e-6413-dd9a-eacebf75fbc0@intel.com>
Date:   Tue, 8 Dec 2020 10:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208075815.GC31973@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/12/20 9:58 am, AKASHI Takahiro wrote:
> Adrian,
> 
> On Thu, Dec 03, 2020 at 11:55:23AM +0200, Adrian Hunter wrote:
>> On 1/12/20 5:09 am, AKASHI Takahiro wrote:
>>> Adrian,
>>>
>>> Thank you for your review comments.
>>>
>>> On Thu, Nov 26, 2020 at 10:18:55AM +0200, Adrian Hunter wrote:
>>>> On 25/11/20 9:41 am, AKASHI Takahiro wrote:
>>>>> Gentle ping;
>>>>>
>>>>> On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
>>>>>> This is an interim snapshot of our next version, v4, for enabling
>>>>>> UHS-II on MMC/SD.
>>>>>>
>>>>>> It is focused on 'sdhci' side to address Adrian's comments regarding
>>>>>> "modularising" sdhci-uhs2.c.
>>>>>> The whole aim of this version is to get early feedback from Adrian (and
>>>>>> others) on this issue. Without any consensus about the code structure,
>>>>>
>>>>> Any comments so far?
>>>>>
>>>>
>>>> Overall, I like this approach of separating UHS2 from legacy sdhci as much
>>>> as possible.  The only major change, is to drop support for legacy quirks
>>>> and features that you do not need.  The reason for that, is that there may
>>>> be few drivers that end up with UHS-II support (opting instead for SD
>>>> Express), so there is no point going to a lot of trouble to support things
>>>> that never get used.
>>>>
>>>> From what I have seen that looks like it includes:
>>>> 	- any quirks
>>>
>>> GLI driver (gl9755) needs
>>>   * SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>>>   * SDHCI_QUIRK2_BROKEN_DDR50
>>> but they are managed in sdhci code.
>>>
>>>> 	- SDHCI LED support
>>>> 	- external DMA support
>>>
>>> Should we add 'depends on !SDHCI_UHS2' to MMC_SDHCI_EXTERNAL_DMA?
>>>
>>>> In this regard, the important thing is to have a comment somewhere that
>>>> lists what is not supported.
>>>>
>>>> I have only looked at SDHCI patches so far, and only up to about patch 20,
>>>> but maybe that gives you enough to go on for a while.
>>>
>>> Well, I have almost done.
>>> Can I expect your comments on the patches #21-#27 as well soon?
>>
>> I have made some more comments and that is all for now, except for anything
>> more you wish to discuss.
> 
> Thank you.
> I assume that you don't have any objection against adding extra hooks
> to sdhci_ops in patch#23 and #25, do you?

No objections at the moment.

> 
> If so, since we don't have any critical issues to discuss,
> I hope that my changes will be contained in the new version
> where a major rework will be done on the core side by Ben.

Ok
