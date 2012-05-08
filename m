From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 03/10] mmc: mxs-mmc: get rid of the use of cpu_is_xxx
Date: Tue, 8 May 2012 22:35:32 +0800
Message-ID: <20120508143529.GE2199@S2101-09.ap.freescale.net>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-4-git-send-email-shawn.guo@linaro.org>
 <201205080146.45090.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54932 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab2EHOfq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 10:35:46 -0400
Received: by dady13 with SMTP id y13so2722389dad.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 May 2012 07:35:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201205080146.45090.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

On Tue, May 08, 2012 at 01:46:44AM +0200, Marek Vasut wrote:
> > -#define SSP_VERSION_LATEST	4
> > -#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
> > +#define ssp_is_old(host)	(host->devid == IMX23_MMC)
> 
> (host)->devid ...
> 
Fixed, as well as dma_is_apbh and apbh_is_old.  Thanks.

-- 
Regards,
Shawn
