From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
Date: Tue, 26 Mar 2013 13:36:43 +0800
Message-ID: <20130326053641.GC5148@S2101-09.ap.freescale.net>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:7164
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757627Ab3CZFgK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Mar 2013 01:36:10 -0400
Content-Disposition: inline
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Mon, Mar 25, 2013 at 04:02:29PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch add support for the cd-inverted and non-removeable property (as
> defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
> custom imx28 board.
> 
> This series applies to Chris Ball's cjb/mmc-next branch.

For both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

