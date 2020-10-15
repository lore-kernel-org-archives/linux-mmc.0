Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADEC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589C122250
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 08:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgJOIuX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Oct 2020 04:50:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:43954 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJOIuX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Oct 2020 04:50:23 -0400
IronPort-SDR: d2PEOhObRl5A2yQySoi9WOdB2nmTPWBtnp9O3854j02NCTbMU+cBh2z1nR4SAOe2U3xWizg78I
 /p4rNO0J2rRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166357244"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="166357244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 01:50:22 -0700
IronPort-SDR: 1efJrh/yFBGraDXBuDtGF9sPXTPMzVYn2qeYieGe5dBl4phrHiS0DsHeK8kjwqZjAPdDMbwyKD
 WT95ksIbjtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="330733197"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2020 01:50:20 -0700
Subject: Re: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is
 true
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20201013190851.715df9ad@xhacker.debian>
 <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
 <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
 <20201014183212.475a789d@xhacker.debian>
 <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
 <20201015101207.3a88004e@xhacker.debian>
 <20201015103840.3935a420@xhacker.debian>
 <f1d6c1cf-b74a-701f-5136-e6be7bd4bfa9@intel.com>
 <20201015142353.4ef890ed@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9d748c0b-9c53-8d29-1472-53266c8eff36@intel.com>
Date:   Thu, 15 Oct 2020 11:50:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015142353.4ef890ed@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/10/20 9:24 am, Jisheng Zhang wrote:
> On Thu, 15 Oct 2020 08:57:05 +0300 Adrian Hunter wrote:
> 
>>
>>
>> On 15/10/20 5:38 am, Jisheng Zhang wrote:
>>> On Thu, 15 Oct 2020 10:12:07 +0800 Jisheng Zhang wrote:
>>>
>>>  
>>>>
>>>> On Wed, 14 Oct 2020 22:44:50 +0300 Adrian Hunter wrote:
>>>>  
>>>>>
>>>>>
>>>>> + Chunyan
>>>>>
>>>>> On 14/10/20 1:32 pm, Jisheng Zhang wrote:  
>>>>>> Auto CMD Auto Select can only be used when v4_mode is enabled.  
>>>>>
>>>>> The SDHCI spec. doesn't seem to say that.  AFAICS it refers only to v4.1 not
>>>>> v4 mode.  
>>>>
>>>> 4.10 defines the "Auto CMD Auto Select" mode, v4 mode bit in SDHCI_HOST_CONTROL2
>>>> selects V3 compatible or V4 compatible mode, I think the v4 here includes
>>>> v4.0, v4.1 and v4.2, so if we want to use the mode we have to ensure v4_mode  
>>>
>>> So if we want to use the "Auto CMD Auto Select" mode, we have to ensure v4 mode
>>> is enabled.  
>>
>> But that is not exactly what the SDHCI spec. says.  It is quite explicit
>> about which registers and bit fields are affected by "Host Version 4 Enable =1".
>>
> 
> Just my humble opinion, this is implied, my logic look like:
> 
> Host Version 4 Enable == 0 => only V3 compatible mode \
>                                                        => v4 mode is must for auto cmd auto select
> No "Auto CMD Auto Select" definition in v3 spec      /

Ok, we will need the commit message to explain the performance degradation,
and which driver / version / platform, and a comment in the code explaining
we require Version 4 Mode for Auto CMD Auto Select because some controllers
expect it that way.
