Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF80C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Feb 2022 16:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbiBYQzs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiBYQzn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2022 11:55:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D91E6953;
        Fri, 25 Feb 2022 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645808111; x=1677344111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a/2QHHN/ETWTPtmCEfGXBl9buOitSAcfb/bJHn2KyY0=;
  b=aEtKsCDGlXMH+++MMqQOG1eb2JKVNPnIchpUA7Pn4EeVmtTFyOPlwRi/
   Ilqpgpb28m9jcp/DlbzGPESomgkChUTuva5sA8Bd/CpwMwLIOCpEiCyXK
   SY+EhDyV57W5AxuAssbPuPmd7WJpnYlf68+nnmSnHzAaBxYh35c5nYX5J
   4G9npQ7GRcVRdefsQ7RUxdFmxBDwb3wcWifVa0ZiJrMjNwsZ2GkStFihi
   KW0w9ND5ZznU7vRRj7J6waYsSw+lUmUJBJzoiY8IFPSXLP+3ke3HCu/oz
   LBIg8XQXetQ5DHTX3pF/QpDYDvKIsrCjaAc+EamfV8irEO+LZGKjzS0YA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="250112543"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="250112543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="640169939"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:55:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nNdrG-008GpT-3G;
        Fri, 25 Feb 2022 18:54:18 +0200
Date:   Fri, 25 Feb 2022 18:54:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, adrian.hunter@intel.com,
        swboyd@chromium.org, dev@lynxeye.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: check the return value of
 wakeup_source_register()
Message-ID: <YhkJuZb7PfGvmRTY@smile.fi.intel.com>
References: <20220225121858.25638-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225121858.25638-1-baijiaju1990@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Feb 25, 2022 at 04:18:58AM -0800, Jia-Ju Bai wrote:
> The function wakeup_source_register() in mmc_alloc_host() can fail, so
> its return value should be checked.

NAK.

This doesn't explain why this resource must be non-optional.

One should not dumbly use the robots.

-- 
With Best Regards,
Andy Shevchenko


