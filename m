From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 02/10] mmc: mxs-mmc: let ssp_is_old take host as parameter
Date: Tue, 8 May 2012 22:32:05 +0800
Message-ID: <20120508143203.GD2199@S2101-09.ap.freescale.net>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-3-git-send-email-shawn.guo@linaro.org>
 <201205080143.49806.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33944 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2EHOcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 10:32:31 -0400
Received: by pbbrp8 with SMTP id rp8so8110466pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 May 2012 07:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201205080143.49806.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

On Tue, May 08, 2012 at 01:43:49AM +0200, Marek Vasut wrote:
> >  #define SSP_VERSION_LATEST	4
> > -#define ssp_is_old()		(host->version < SSP_VERSION_LATEST)
> > +#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
> 
> (host)->version ... to make the macro safer.
> 
Sounds good.

> > -	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > +	if ((sta & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> 
> ^ s/sta/stat/ ... did you try compiling this at all ? :-)
> 
This is an error introduced by a last minute rebase.  Thanks for
catching it.  Fixed.

-- 
Regards,
Shawn
