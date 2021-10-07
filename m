Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCAC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34C760FC3
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbhJGSGB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:06:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:38506 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243474AbhJGSGB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 Oct 2021 14:06:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="207134858"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="207134858"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 11:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="524759859"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 11:03:38 -0700
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <YV8jfavX/W9T25YX@smile.fi.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cc9d92a9-0896-5222-2080-1380afd480ba@intel.com>
Date:   Thu, 7 Oct 2021 21:03:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV8jfavX/W9T25YX@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/10/2021 19:42, Andy Shevchenko wrote:
> On Tue, Oct 05, 2021 at 01:24:24PM +0300, Andy Shevchenko wrote:
>> It appears that one of the supported platform magically worked with the
>> custom IRQ handler (any hints how?) while having two PCB designs with
>> an opposite CD sense level. Here is an attempt to fix it by quirking out
>> CD GPIO.
>>
>> Patch 1 introduces two additional quirks (it's done this way due to
>> patch 3, see below). Patch 2 is an actual fix for the mentioned platform.
>> If backported need to be taken with patch 1 together. Patch 3 is (RFT)
>> clean up. The questionable part here is the locking scheme. Shouldn't
>> we do something similar in the generic IRQ handler of SDHCI? Or Broxton
>> case has something quite different in mind?
>>
>> Patches 4-6 are dead-code removals. Patch 4 accompanying patch 2, patches
>> 5-6 just similar to it, but (functionally) independent. Would like to hear
>> if it's okay to do.
>>
>> Any comments, hints, advice are welcome!
> 
> Adrian, Ulf, any comments on this? At least first two fix the regression and
> would be nice to have them in sooner than later (I can split them separately
> if required).

I am not sure we need new quirks, given that we can just hook the callback
and do anything that way.  However I really haven't had time to look closely
yet, sorry.
