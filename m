From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-esdhc-imx: remove "WP" from flag
 ESDHC_FLAG_GPIO_FOR_CD_WP
Date: Tue, 14 Jun 2011 19:51:00 +0800
Message-ID: <20110614115059.GE30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
 <20110614092812.GC5043@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:53246
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302Ab1FNLpf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 07:45:35 -0400
Content-Disposition: inline
In-Reply-To: <20110614092812.GC5043@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Tue, Jun 14, 2011 at 11:28:13AM +0200, Wolfram Sang wrote:
> On Fri, Jun 10, 2011 at 06:42:51PM +0800, Shawn Guo wrote:
> > The use of flag ESDHC_FLAG_GPIO_FOR_CD_WP is all CD related.  It does
> > not necessarily need to bother WP in the flag name.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I'd just squash it into the next one?
> 
I'd like to have this patch to give the exact meaning of the flag,
and then the following patch removes the flag with proper CD only
case handling.

-- 
Regards,
Shawn

