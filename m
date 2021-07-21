Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EEFC636CA
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422A56120E
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbhGUOX1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:23:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:4035 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239462AbhGUOXW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jul 2021 10:23:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211450913"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="211450913"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 08:03:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="501315527"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 08:03:55 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6DlF-00GgaQ-GI; Wed, 21 Jul 2021 18:03:49 +0300
Date:   Wed, 21 Jul 2021 18:03:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
Message-ID: <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
References: <mvmtukn6bmu.fsf@suse.de>
 <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmpmvb68cg.fsf@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 04:37:51PM +0200, Andreas Schwab wrote:
> On Jul 21 2021, Andy Shevchenko wrote:
> 
> > The driver has OF compatible strings and should be loaded automatically.
> 
> They are never being used.

What do you mean by that?

Can you explain what is the _practical_ issue here? What is your HW setup and
what you are trying to do?

> # udevadm info /sys/devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
> P: /devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
> L: 0
> E: DEVPATH=/devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
> E: DRIVER=mmc_spi
> E: OF_NAME=mmc
> E: OF_FULLNAME=/soc/spi@10050000/mmc@0
> E: OF_COMPATIBLE_0=mmc-spi-slot
> E: OF_COMPATIBLE_N=1
> E: MODALIAS=spi:mmc-spi-slot
> E: SUBSYSTEM=spi

-- 
With Best Regards,
Andy Shevchenko


