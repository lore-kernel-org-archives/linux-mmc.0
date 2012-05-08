From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 07/10] mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
Date: Tue, 8 May 2012 22:40:51 +0800
Message-ID: <20120508144047.GG2199@S2101-09.ap.freescale.net>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
 <201205080153.44313.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32986 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab2EHOlO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 10:41:14 -0400
Received: by dady13 with SMTP id y13so2728598dad.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 May 2012 07:41:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201205080153.44313.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

On Tue, May 08, 2012 at 01:53:44AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > It has wp_gpio copied in struct mxs_mmc_host from platform_data,
> 
> Copy wp_gpio into struct ...
> 
Updated.

> > so that the use of platform_data can be limited in probe function,
> > which will ease the device tree probe.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Otherwise
> Acked-by: Marek Vasut <marex@denx.de>
> 
Thanks.

-- 
Regards,
Shawn
