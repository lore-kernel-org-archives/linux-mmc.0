Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC870C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Mar 2022 13:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350663AbiCXNzv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbiCXNzu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2022 09:55:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D87D39800;
        Thu, 24 Mar 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648130059; x=1679666059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e89Vv2Mvsm8AX/GVQLPEwSbd3UxDBlMkPanQzNoNiaU=;
  b=ekfPARDp3tjpJ6m2XOYe0JHg3xEoLfBBM7IgjwHTxfK+7RQ7M0QBzndi
   Rpyba/4knDAjL9OTs+35KoLv97jhCLmvdXx4ih1xmY4GCfACIDNU8bBvg
   1pOJIYufWSIywZL3JYmAO/LjYRJPSgsumnLlgnh26WDgnMVFJBcskudmV
   94irmyYui8NTMuEyshFyHdbdMijfBPBHmNJcILeJa5E4aWUtKtxvsrCVC
   oVZsGY2zqU3LSCym0v5KGTAEz/Fo3rMmV1JXZyRI9OIC//kUIigSf071X
   UzE+R/HpXMsWz4fSsyV/uFc3Gwvwffzdl6O4+UQ0IyQ72I03mRG8eB/pw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258334410"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="258334410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 06:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="519790170"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 06:54:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXNuE-005qrz-Q4;
        Thu, 24 Mar 2022 15:53:38 +0200
Date:   Thu, 24 Mar 2022 15:53:38 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHv4] mmc: block: Check for errors after write on SPI
Message-ID: <Yjx34sDWl4bMSCg3@smile.fi.intel.com>
References: <8052f30adc3747e2beab0e52db26837d@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8052f30adc3747e2beab0e52db26837d@hyperstone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 24, 2022 at 01:27:51PM +0000, Christian Löhle wrote:

...

> v4:
>   - Move block layer handling out of the spi-specific function

In this case some optimizations are possible. See below.

...

> +static int mmc_spi_err_check(struct mmc_card *card)
> +{
> +	u32 status = 0;
> +	int err;
> +
> +	/*
> +	 * SPI does not have a TRAN state we have to wait on, instead the
> +	 * card is ready again when it no longer holds the line LOW.
> +	 * We still have to ensure two things here before we know the write
> +	 * was successful:
> +	 * 1. The card has not disconnected during busy and we actually read our
> +	 * own pull-up, thinking it was still connected, so ensure it
> +	 * still responds.
> +	 * 2. Check for any error bits, in particular R1_SPI_IDLE to catch a
> +	 * just reconnected card after being disconnected during busy.
> +	 */
> +	err = __mmc_send_status(card, &status, 0);

> +	/* All R1 and R2 bits of SPI are errors in our case */
> +	if (err || status) {
> +		if (err)
> +			return err;
> +		return -EIO;
> +	}

	if (err)
		return err;

	/* All R1 and R2 bits of SPI are errors in our case */
	if (status)
		return -EIO;

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


