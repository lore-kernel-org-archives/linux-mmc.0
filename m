From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] ARM: imx: enable pinctrl dummy states
Date: Sun, 6 May 2012 21:51:40 +0800
Message-ID: <20120506135138.GC19389@S2101-09.ap.freescale.net>
References: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54018 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2EFNve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 May 2012 09:51:34 -0400
Received: by pbbrp8 with SMTP id rp8so5663904pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 May 2012 06:51:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linus.walleij@stericsson.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, w.sang@pengutronix.de, linux-mmc@vger.kernel.org

On Wed, May 02, 2012 at 07:31:20PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Enable pinctrl dummy states for imx platforms without pinctrl
> support.
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

I queued the series and will have it send together with other imx
and mxs driver patches that adopt pinctrl API.

-- 
Regards,
Shawn
