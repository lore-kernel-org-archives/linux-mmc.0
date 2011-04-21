From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND PATCH 4/4] mmc_spi.c: add support for the regulator
 framework
Date: Thu, 21 Apr 2011 13:40:41 +0100
Message-ID: <20110421124041.GF11788@opensource.wolfsonmicro.com>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
 <1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
 <1303388873-15467-5-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52157 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750884Ab1DUMko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 08:40:44 -0400
Content-Disposition: inline
In-Reply-To: <1303388873-15467-5-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

On Thu, Apr 21, 2011 at 02:27:53PM +0200, Antonio Ospite wrote:

> +#ifdef CONFIG_REGULATOR
> +	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
> +
> +	if (IS_ERR(host->vcc)) {
> +		host->vcc = NULL;
> +	} else {
> +		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
> +		if (host->pdata && host->pdata->ocr_mask)
> +			dev_warn(mmc_dev(host->mmc),
> +				"ocr_mask/setpower will not be used\n");
>  	}
> +#endif

Why is this code conditional?  The regulator API will stub itself out
(by returning a null pointer, which plays well with your use of null) if
it's disabled.  I'm also not seeing any corresponding code to release
the regulator.
