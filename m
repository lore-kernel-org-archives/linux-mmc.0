Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FDC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 09:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EA56109E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 09:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNKBL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:01:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:5631 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhJNKBL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 06:01:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227602521"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227602521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 02:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="571191847"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2021 02:59:04 -0700
Subject: Re: [PATCH v2 3/6] mmc: sdhci: Remove unused prototype declaration in
 the header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
 <20211013201723.52212-4-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <239d60c2-fa0d-51e0-ea4f-558fbabc756d@intel.com>
Date:   Thu, 14 Oct 2021 12:59:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013201723.52212-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/2021 23:17, Andy Shevchenko wrote:
> sdhci_card_detect() is not defined anywhere. Remove it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c593af479832..bb883553d3b4 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -750,7 +750,6 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  	return host->private;
>  }
>  
> -void sdhci_card_detect(struct sdhci_host *host);
>  void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>  		       const u32 *caps, const u32 *caps1);
>  int sdhci_setup_host(struct sdhci_host *host);
> 

