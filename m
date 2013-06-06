From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc: calculate sdclk divider from
 controller clock
Date: Thu, 6 Jun 2013 22:51:01 +0800
Message-ID: <20130606145059.GA28270@S2101-09.ap.freescale.net>
References: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
 <1370438006-13093-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:56892
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899Ab3FFOvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 10:51:09 -0400
Content-Disposition: inline
In-Reply-To: <1370438006-13093-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de

On Wed, Jun 05, 2013 at 03:13:25PM +0200, Lucas Stach wrote:
> The SDCLK is divided down from the host controller clock. Host controller clock
> may be different from the maximum SDCLK, so get it from the platform, instead
> of just using the max SDCLK.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Patch #2 and #3,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

