From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Sun, 20 May 2012 23:45:08 -0400
Message-ID: <87396ukxiz.fsf@laptop.org>
References: <1337571366-7779-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41252 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab2EUDpR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 May 2012 23:45:17 -0400
In-Reply-To: <1337571366-7779-1-git-send-email-marex@denx.de> (Marek Vasut's
	message of "Mon, 21 May 2012 05:36:06 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org

Hi Marek,

On Sun, May 20 2012, Marek Vasut wrote:
> The write-protect GPIO is inverted on some boards. Handle such case.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
>  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> V2: Adjust the subject, Cc linux-mmc

Thanks, looks good.  Since this depends on patches that are going via
arm-soc, I'm going to wait until that's in Linus master before merging.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
