From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Mon, 28 Jan 2013 16:40:06 -0500
Message-ID: <87sj5l6l6x.fsf@laptop.org>
References: <1358389972-24399-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab3A1Vkk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 16:40:40 -0500
In-Reply-To: <1358389972-24399-1-git-send-email-festevam@gmail.com> (Fabio
	Estevam's message of "Thu, 17 Jan 2013 00:32:52 -0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi,

On Wed, Jan 16 2013, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> commit 3f175a6e5 (mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from IO 
> accessory) introduced the following build warnings:
>
> drivers/mmc/host/sdhci-esdhc-imx.c:149:30: warning: unused variable 'boarddata' [-Wunused-variable]
> drivers/mmc/host/sdhci-esdhc-imx.c:181:30: warning: unused variable 'boarddata' [-Wunused-variable]
>
> Remove the unused variables.
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
