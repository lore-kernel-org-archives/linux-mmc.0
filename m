Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B14C63777
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EEC21741
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgLCILs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:11:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:1542 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgLCILs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Dec 2020 03:11:48 -0500
IronPort-SDR: AWr0W7MHB77Fuj3qIBMnjoKr4a+DyCEwe11syuh2mPNMvMj2qUvuXexKrHFRDwtoHg/Ejx1UgQ
 kgU7Ls/yT0tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173313650"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="173313650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:11:07 -0800
IronPort-SDR: UNLFDTrOs/+Xk6MkL/F/0LzRGv9RvZc7nGayr+kzFLZaBeSNGVPjoGXRaPund9ZfeZShLIimv7
 uOiDINNhbm+A==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="540018282"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:11:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kkjig-00BhXF-9Y; Thu, 03 Dec 2020 10:12:06 +0200
Date:   Thu, 3 Dec 2020 10:12:06 +0200
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Message-ID: <20201203081206.GR4077@smile.fi.intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
 <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com>
 <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 03, 2020 at 09:10:14AM +0200, Zulkifli, Muhammad Husaini wrote:
> >From: Linus Walleij <linus.walleij@linaro.org>
> >Sent: Thursday, December 3, 2020 2:55 AM
> >On Wed, Dec 2, 2020 at 8:04 AM <muhammad.husaini.zulkifli@intel.com>
> >wrote:

...

> >If it should use any abstraction it should be a selector regulator IMO and
> >while that may seem overengineered it adds something because regulators
> >are used in  the MMC subsystem for vdd and vqmmc because we are handling
> >the OCR mask with that and it can support any amount of present and future
> >voltages for signal levels with that as well. Any future changes to how the
> >different signal voltages are set or which voltages exist can then be done in
> >that regulator driver.
> 
> This is limitation of Keem Bay HW and I would say Keem Bay HW is somewhat
> unique in the way of handling the IO bus line voltage.
> SDcard does not have its own voltage regulator.
> I created one function sdhci_arasan_keembay_io_line_supply_operation() in sdhci-of-arasan.c
> to handle the vqmmc(io line supply operation) specific for Keem Bay SoC.
> 
> For Keem Bay, to actually modelling this as regulator ,for vqmmc, , we need to handle 2 things:
> 1) Output expander pins : using gpio regulator
> 2) voltage rail : call keembay_io_rail_supplied_voltage() to handle the SMCC Arm.
> 
> Other hardware might not need this as they might easily configure the vqmmc
> hooked up to regulator.
> 
> IMHO, we do not need to overengineered it to add custom selector
> regulator just to suit this Keem Bay HW design.

I guess Linus has a point. If it can be abstracted as selector regulator it
will suits generic approach in the MMC code.

And what is the problem to have two or more regulators? Or regulator hierarchy?


-- 
With Best Regards,
Andy Shevchenko


