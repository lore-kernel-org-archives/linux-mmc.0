Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D8C636C9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9818461246
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 17:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhGUQY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:24:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:52220 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUQY5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jul 2021 12:24:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208361412"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="208361412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 10:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="576755219"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 10:05:30 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m6Feu-00Gibw-Cj; Wed, 21 Jul 2021 20:05:24 +0300
Date:   Wed, 21 Jul 2021 20:05:24 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
Message-ID: <YPhT1APE8QweDCoP@smile.fi.intel.com>
References: <mvmtukn6bmu.fsf@suse.de>
 <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de>
 <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
 <mvmlf5z66l9.fsf@suse.de>
 <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
 <mvmh7gn649v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmh7gn649v.fsf@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 06:05:48PM +0200, Andreas Schwab wrote:
> On Jul 21 2021, Andy Shevchenko wrote:
> 
> > What is your DT excerpt for it?
> 
> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts:
> 
> &qspi2 {
> 	status = "okay";
> 	mmc@0 {
> 		compatible = "mmc-spi-slot";
> 		reg = <0>;
> 		spi-max-frequency = <20000000>;
> 		voltage-ranges = <3300 3300>;
> 		disable-wp;
> 	};
> };

Hmm...

I have counted 89 device drivers in the kernel that have OF ID table without
SPI ID table. I'm wondering if all of them need to be fixed.

Or problem is somewhere else?


-- 
With Best Regards,
Andy Shevchenko


