Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F772C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1385964E2B
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBQGBY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 01:01:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:34697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhBQGBX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Feb 2021 01:01:23 -0500
IronPort-SDR: UIxIHHKC0frKkIXsR52ECFUb+mUts79xB9WHtXDJ4fYIsjcTrwyTXC+jZ5K1u1k6wnMtAd+uwU
 gj6mLEf9IEdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="183243000"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="183243000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 22:00:41 -0800
IronPort-SDR: tSgtMsSpUTVgltzLm0RROy0h3b40BzvRlGZ0R28f/EqM37T4ePG/lgR5p0tJhNimsWYnAOlXA7
 h9DAjeB5WYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439239452"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 22:00:37 -0800
Subject: Re: [PATCH 2/2] mmc: core: Add no single read retries
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     DooHyun Hwang <dh0421.hwang@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, satyat@google.com,
        ebiggers@google.com, gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
 <CGME20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c@epcas1p2.samsung.com>
 <20210217052239.13780-3-dh0421.hwang@samsung.com>
 <4035139d-7850-8460-f069-06fc61d13039@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3e6525b5-9cd7-e632-800a-1066c5fa3581@intel.com>
Date:   Wed, 17 Feb 2021 08:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4035139d-7850-8460-f069-06fc61d13039@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/02/21 7:46 am, Adrian Hunter wrote:
> On 17/02/21 7:22 am, DooHyun Hwang wrote:
>> This makes to handle read errors faster by not retrying
>> multiple block read(CMD18) errors with single block reads(CMD17).
>>
>> On some bad SD Cards that have problem with read operations,
>> it is not helpful to retry multiple block read errors with
>> several single block reads, and it is delayed to treat read
>> operations as I/O error as much as retrying single block reads.
> 
> If the issue is that it takes too long, then maybe it would be better to get
> mmc_blk_read_single() to give up after a certain amount of time.
> 

So that a device property would not be needed I mean.  Then everyone would
benefit.
