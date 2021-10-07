Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC93C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C79E61029
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 16:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbhJGQut (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:50:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:19567 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242790AbhJGQuo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 Oct 2021 12:50:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312499421"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="312499421"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:42:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="522664785"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:42:40 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYWTd-009bFv-IM;
        Thu, 07 Oct 2021 19:42:37 +0300
Date:   Thu, 7 Oct 2021 19:42:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
Message-ID: <YV8jfavX/W9T25YX@smile.fi.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 05, 2021 at 01:24:24PM +0300, Andy Shevchenko wrote:
> It appears that one of the supported platform magically worked with the
> custom IRQ handler (any hints how?) while having two PCB designs with
> an opposite CD sense level. Here is an attempt to fix it by quirking out
> CD GPIO.
> 
> Patch 1 introduces two additional quirks (it's done this way due to
> patch 3, see below). Patch 2 is an actual fix for the mentioned platform.
> If backported need to be taken with patch 1 together. Patch 3 is (RFT)
> clean up. The questionable part here is the locking scheme. Shouldn't
> we do something similar in the generic IRQ handler of SDHCI? Or Broxton
> case has something quite different in mind?
> 
> Patches 4-6 are dead-code removals. Patch 4 accompanying patch 2, patches
> 5-6 just similar to it, but (functionally) independent. Would like to hear
> if it's okay to do.
> 
> Any comments, hints, advice are welcome!

Adrian, Ulf, any comments on this? At least first two fix the regression and
would be nice to have them in sooner than later (I can split them separately
if required).

-- 
With Best Regards,
Andy Shevchenko


