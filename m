Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63691C64E8A
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05E5206A5
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgLCJ4f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:56:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:10908 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbgLCJ4f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Dec 2020 04:56:35 -0500
IronPort-SDR: vqRKvvXLtKNNYviSac2PJgY8Hu3x4Kgro55YhZlaq0LH7RCryFUMYI3sGSZbncMdmt64s5Eyjw
 0s9LNYif3LRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173325395"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="173325395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 01:55:54 -0800
IronPort-SDR: k3CkseoiaZiOxxxG9F8faD5BfisaOL3mZXJaw9e8ZF1mvAsz1GtpafTHilUGtlJfGL7x4v2OOP
 B7gZnTJL9fzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="315637688"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2020 01:55:49 -0800
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <c8f7e9ad-3e8d-01cc-edeb-5be364bfcc36@intel.com>
 <20201201030937.GE43403@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <523f9ed9-318e-7121-d58d-c3843d9b9b7c@intel.com>
Date:   Thu, 3 Dec 2020 11:55:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201201030937.GE43403@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/12/20 5:09 am, AKASHI Takahiro wrote:
> Adrian,
> 
> Thank you for your review comments.
> 
> On Thu, Nov 26, 2020 at 10:18:55AM +0200, Adrian Hunter wrote:
>> On 25/11/20 9:41 am, AKASHI Takahiro wrote:
>>> Gentle ping;
>>>
>>> On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
>>>> This is an interim snapshot of our next version, v4, for enabling
>>>> UHS-II on MMC/SD.
>>>>
>>>> It is focused on 'sdhci' side to address Adrian's comments regarding
>>>> "modularising" sdhci-uhs2.c.
>>>> The whole aim of this version is to get early feedback from Adrian (and
>>>> others) on this issue. Without any consensus about the code structure,
>>>
>>> Any comments so far?
>>>
>>
>> Overall, I like this approach of separating UHS2 from legacy sdhci as much
>> as possible.  The only major change, is to drop support for legacy quirks
>> and features that you do not need.  The reason for that, is that there may
>> be few drivers that end up with UHS-II support (opting instead for SD
>> Express), so there is no point going to a lot of trouble to support things
>> that never get used.
>>
>> From what I have seen that looks like it includes:
>> 	- any quirks
> 
> GLI driver (gl9755) needs
>   * SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>   * SDHCI_QUIRK2_BROKEN_DDR50
> but they are managed in sdhci code.
> 
>> 	- SDHCI LED support
>> 	- external DMA support
> 
> Should we add 'depends on !SDHCI_UHS2' to MMC_SDHCI_EXTERNAL_DMA?
> 
>> In this regard, the important thing is to have a comment somewhere that
>> lists what is not supported.
>>
>> I have only looked at SDHCI patches so far, and only up to about patch 20,
>> but maybe that gives you enough to go on for a while.
> 
> Well, I have almost done.
> Can I expect your comments on the patches #21-#27 as well soon?

I have made some more comments and that is all for now, except for anything
more you wish to discuss.

