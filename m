From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mxs-mmc: Use devm_clk_get()
Date: Thu, 4 Jul 2013 09:27:52 +0800
Message-ID: <20130704012750.GA14617@S2101-09.ap.freescale.net>
References: <1372881758-23502-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:56859
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab3GDB21 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jul 2013 21:28:27 -0400
Content-Disposition: inline
In-Reply-To: <1372881758-23502-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org

On Wed, Jul 03, 2013 at 05:02:37PM -0300, Fabio Estevam wrote:
> Using devm_clk_get() allows us to remove the clk_put() calls, so let's use it
> to simplify the code.
> 
> Rename the 'out_clk_put' label to 'out_clk_disable' now that clk_put is removed.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

