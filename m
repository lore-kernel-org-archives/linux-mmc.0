From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc:sdhci-esdhc-imx: Use NULL instead of zero
Date: Wed, 11 Dec 2013 20:19:27 -0500
Message-ID: <87iouu7tnk.fsf@octavius.laptop.org>
References: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40736 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3LLBTe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Dec 2013 20:19:34 -0500
In-Reply-To: <1380938365-7769-1-git-send-email-festevam@gmail.com> (Fabio
	Estevam's message of "Fri, 4 Oct 2013 22:59:23 -0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

Hi Fabio,

On Fri, Oct 04 2013, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Fix the following sparse warning:
>
> drivers/mmc/host/sdhci-esdhc-imx.c:617:35: warning: Using plain integer as NULL pointer
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
