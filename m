Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B38C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105A560F50
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJVGlz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:41:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:15458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhJVGlx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 Oct 2021 02:41:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="216404805"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="216404805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 23:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="445165146"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 23:39:34 -0700
Subject: Re: [PATCH] MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER
 section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c8de5772-eee6-8417-6880-9fd9d82d5040@intel.com>
Date:   Fri, 22 Oct 2021 09:39:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/10/2021 08:47, Lukas Bulwahn wrote:
> Commit 5c67aa59bd8f ("mmc: sdhci-pci: Remove dead code (struct
> sdhci_pci_data et al)") removes ./include/linux/mmc/sdhci-pci-data.h;
> so, there is no further file that matches 'include/linux/mmc/sdhci*'.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    include/linux/mmc/sdhci*
> 
> Drop this obsolete file pattern in SECURE DIGITAL HOST CONTROLLER
> INTERFACE (SDHCI) DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> applies cleanly on next-20211021
> 
> Ulf, please pick this minor non-urgent cleanup patch on top of the
> commit above.
> 
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44c590b762d1..c47ac3e938b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17024,7 +17024,6 @@ M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci*
> -F:	include/linux/mmc/sdhci*
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
> 

