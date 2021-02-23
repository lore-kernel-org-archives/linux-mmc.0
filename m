Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2533C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D2264E32
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhBWLB4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:01:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:11729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232210AbhBWLBm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Feb 2021 06:01:42 -0500
IronPort-SDR: MSitowZL9qvi80uV2itFuZ0e2UWu0RPTwJfSceNrC3FTXof27zIFhn30smLLSz28LjLpB+MiOR
 t1zWydITHwLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="204191915"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="204191915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 03:01:01 -0800
IronPort-SDR: osNzaSgHHVSLM2SW8uM2xI4MRixVuDtxwWe1Tzsz9hWYlLsZ6XLLtPt0iA7Kn+KGPo7kVOfvyM
 xXXJ7uovf0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="583153284"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2021 03:00:59 -0800
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in
 __mmc_switch()
To:     Paul Fertser <fercerpav@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp>
 <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
Date:   Tue, 23 Feb 2021 13:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223093247.GA2059@home.paul.comp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/02/21 11:32 am, Paul Fertser wrote:
> Hello Ulf,
> 
> On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index f5dedb7f9b27..9adf735391fa 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
>>>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
>>>                 /* Some eMMC set the value too low so set a minimum */
>>> -               if (card->ext_csd.part_time &&
>>> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>>> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>>>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>>>
>>>                 /* Sleep / awake timeout in 100ns units */
>>>
>>> I do not see any more warnings on my system.
>>
>> That looks like the correct fix to the problem. Do you want to send a
>> proper patch that I can pick up or do you prefer if help to do it?
> 
> I've sent this as a diff precisely because 1c447116d017 was so
> explicit about special-casing zero ext_csd timeout value, so I thought
> probably Adrian can provide the rationale for that. I'd prefer to wait
> for his feedback before sending a formal patch. Does this make sense?

Zero means indefinite.  Might be safer to use a higher value than
MMC_MIN_PART_SWITCH_TIME for that case.  The maximum GENERIC_CMD6_TIME is
2550 ms.
