Return-Path: <SRS0=zmAv=DQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8DC433E7
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3437622248
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 13:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbgJINFh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:05:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:62871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbgJINFh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Oct 2020 09:05:37 -0400
IronPort-SDR: XkOFjyLQN8NM+QQ4chjYDo3FuGLdsVAPgTlO3E1qDiYshX45/M8jxmYoJsMkCPx4vYF2I/lMn3
 jo5aRg2HBamw==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="145345673"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="145345673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 06:05:37 -0700
IronPort-SDR: zVJQaCc7NA/YeA6y7T0hCEToccYWtFdUjFmmxuOBQKfVpiXlrIlo6tpUsTyeLhZl3G2Px8Ev9P
 mFCkISKUAbYA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="317025050"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 06:05:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kQs6X-002cS3-1G; Fri, 09 Oct 2020 16:06:37 +0300
Date:   Fri, 9 Oct 2020 16:06:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     muhammad.husaini.zulkifli@intel.com
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, arnd@arndb.de
Subject: Re: [PATCH v5 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Message-ID: <20201009130637.GE4077@smile.fi.intel.com>
References: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 09, 2020 at 02:18:40AM +0800, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Hi.
> 
> The first patch is the header file to handle ATF call.
> 
> The second patch is DT binding for arasan controller for uhs support.
> 
> The third patch is to introduce the structure device pointer in arasan controller probe.
> 
> The fourth patch is to enable UHS-1 Support for Keem Bay EVM.
> 
> All of these patches was tested with Keem Bay evaluation module board.
> 
> Kindly help to review this patch set.

It seems that this is no go for Ulf until you switch to vqmmc GPIO regulators.

-- 
With Best Regards,
Andy Shevchenko


