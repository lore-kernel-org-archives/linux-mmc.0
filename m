Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B66C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0711664E05
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhBWNmv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:8294 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhBWNmv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Feb 2021 08:42:51 -0500
IronPort-SDR: ZCp3DfbktWity9t49KLtH+mBxxj1HD4LTNWKR7Pr9Ztcbps+hVi3jBOgfobCz2pbw7Nobh4IHQ
 XEzm2CA6jzCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="184918892"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="184918892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 05:42:10 -0800
IronPort-SDR: 1Ym8DMN7f9jJiNnfqYkQ20He7IXTn9aa8b5hv3n0A3B82JkhO8oAVuohOzpvrT0UZK0HP5Ak2j
 H5+Xj0KJk64A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="583210626"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2021 05:42:05 -0800
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in
 __mmc_switch()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Fertser <fercerpav@gmail.com>
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
 <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
 <20210223111926.GC2059@home.paul.comp>
 <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c9adeaa3-8833-fe2b-cea8-50b645db0a9d@intel.com>
Date:   Tue, 23 Feb 2021 15:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/02/21 1:54 pm, Ulf Hansson wrote:
> On Tue, 23 Feb 2021 at 12:19, Paul Fertser <fercerpav@gmail.com> wrote:
>>
>> Hello Adrian,
>>
>> On Tue, Feb 23, 2021 at 01:01:09PM +0200, Adrian Hunter wrote:
>>> On 23/02/21 11:32 am, Paul Fertser wrote:
>>>> Hello Ulf,
>>>>
>>>> On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>> index f5dedb7f9b27..9adf735391fa 100644
>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>>>>>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
>>>>>>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
>>>>>>                 /* Some eMMC set the value too low so set a minimum */
>>>>>> -               if (card->ext_csd.part_time &&
>>>>>> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>>>>>> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>>>>>>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>>>>>>
>>>>>>                 /* Sleep / awake timeout in 100ns units */
>>>>>>
>>>>>> I do not see any more warnings on my system.
>>>>>
>>>>> That looks like the correct fix to the problem. Do you want to send a
>>>>> proper patch that I can pick up or do you prefer if help to do it?
>>>>
>>>> I've sent this as a diff precisely because 1c447116d017 was so
>>>> explicit about special-casing zero ext_csd timeout value, so I thought
>>>> probably Adrian can provide the rationale for that. I'd prefer to wait
>>>> for his feedback before sending a formal patch. Does this make sense?
>>>
>>> Zero means indefinite.  Might be safer to use a higher value than
>>> MMC_MIN_PART_SWITCH_TIME for that case.  The maximum GENERIC_CMD6_TIME is
>>> 2550 ms.
>>
>> Thanks for the clarification! I would guess that most likely than not
>> when whoever defines that value to be zero it means "I do not
>> care/know" rather than "the timeout must be set to more than 2550 ms,
>> too bad 8 bits are not enough to represent that". I'd say setting it
>> to DEFAULT_CMD6_TIMEOUT_MS should be safe enough since it worked
>> before.
> 
> Hmm.
> 
> The DEFAULT_CMD6_TIMEOUT_MS is intended to override the
> ext_csd->generic_cmd6_time, in case it's not defined in the register.
> 
> Perhaps it's reasonable to think that eMMC vendors specify the
> GENERIC_CMD6_TIME, but may skip to specify other timeouts, like the
> PARTITION_SWITCH_TIME. In that case, should we use the specified
> GENERIC_CMD6_TIME, rather than always default to
> DEFAULT_CMD6_TIMEOUT_MS?

Sounds reasonable, but perhaps still enforce a minimum, for some of the same
reasons as commit 1c447116d017 ?
e.g.

	if (!card->ext_csd.part_time)
		card->ext_csd.part_time = card->ext_csd.generic_cmd6_time;
	if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
		card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;



