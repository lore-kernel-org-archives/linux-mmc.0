Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D3C64E8A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 12:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31C12222A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 12:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgLBMZF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:25:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:59805 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgLBMZE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 07:25:04 -0500
IronPort-SDR: 5kc3DcyaKwtX/x/SD0SkSYCIkKL4k3L0EXQ816eiOJdoZnd5zTaiWTMdtkHYyaZndnrbo5rvNM
 PeHqkbEHm1Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160062383"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="160062383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 04:24:22 -0800
IronPort-SDR: xh8lr/WE+6xYxAZ+YfiDaAil3wTohc+XaXKLK0gKVo4tfM0Rryv3JUlq+Jb9iBKdRuwmNgz1Ug
 sWkFZLWjih4w==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="373159679"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 04:24:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kkRCC-00BVMG-A5; Wed, 02 Dec 2020 14:25:20 +0200
Date:   Wed, 2 Dec 2020 14:25:20 +0200
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        mgross@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Message-ID: <20201202122520.GD4077@smile.fi.intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 02, 2020 at 11:53:42AM +0100, Ulf Hansson wrote:
> On Wed, 2 Dec 2020 at 08:02, <muhammad.husaini.zulkifli@intel.com> wrote:

...

> > Kindly help to review this patch set.
> 
> This version looks a lot better to me, but I am still requesting you
> to model the pinctrl correctly. I don't see a reason not to, but I may
> have overlooked some things.

I'm wondering why we need to mock up a pin control from something which has no
pin control interface. It's rather communication with firmware that does pin
control under the hood, but it also may be different hardware in the other /
future generations. Would you accept mocking up the same calls over the kernel
as pin control, as something else?

> Would you mind to re-submit to include the gpio/pinctlr list and the
> maintainers, to get their opinion.

And I will send immediately the same comment which I believe Linus W. supports.
But who knows...

Cc'ed to Linus as I mentioned him.

-- 
With Best Regards,
Andy Shevchenko


