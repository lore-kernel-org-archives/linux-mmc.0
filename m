Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EABC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Mar 2022 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiCaOJ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiCaOJ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2022 10:09:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F58181B02;
        Thu, 31 Mar 2022 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648735691; x=1680271691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tWcn8EYtREQDjOCwLztL+FFxtZFEghku4EDLFEyzCo4=;
  b=lGTLKMzFlAYE+ED7JfiuRovtjHq61lYCh/mMlQiWI9Txq1JVv2Ly/ffB
   NQ9KpZQFMkrsTrTjanAzBVN+J3U3q9IOmeqaBEEBd/plElRfmfl39O4tD
   HXNFLHRms2hMYIUakK/ZTlzyTFE7wP0BSdkMEycEYcLfpga07PuZo/Jd9
   FIYf5JYyMLdnXCNtYGz5zP7m5Z/qGeNrzXORHqteZ0dCm31M9GuPJeYcT
   kah7wDnegngO88VKamBOHx9r1ADNd+FgL8TZcsCBDn8mnBag1LdGpg/RQ
   syFDjU19+sk8yjqRJMcJ5CscWKrAqIEeoz4QqIjPqOgy+SGvkwCwFeuFU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346287924"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="346287924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 07:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="640147365"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 07:08:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZvSa-00A2EW-Tv;
        Thu, 31 Mar 2022 17:07:36 +0300
Date:   Thu, 31 Mar 2022 17:07:36 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
Message-ID: <YkW1qGY3uJPhrmf1@smile.fi.intel.com>
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
 <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 31, 2022 at 07:29:37AM +0000, Christian Löhle wrote:
> Any setup supporting more than 25MHz is able to utilize
> highspeed, so enable it even when not explicitly specified.

I'm not sure about this. I prefer to be on the safer side, i.e.
follow only what is supplied by firmware (ACPI / DT).

-- 
With Best Regards,
Andy Shevchenko


