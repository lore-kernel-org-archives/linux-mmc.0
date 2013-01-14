From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/3] Use devm_* managed functions to ease slot-gpio users
Date: Mon, 14 Jan 2013 14:10:17 -0500
Message-ID: <87pq17twbq.fsf@laptop.org>
References: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53528 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756856Ab3ANTKd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:10:33 -0500
In-Reply-To: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Tue, 11 Dec 2012 22:32:17 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org

Hi Shawn,

On Tue, Dec 11 2012, Shawn Guo wrote:
> Changes since v1:
>  * Add kernel doc for mmc_gpio_request/free_ro/cd() to document the
>    use cases.
>  * Add a patch to remove unncessary mmc_gpio_free_cd() call from
>    existing slot-gpio users.
>
> Shawn Guo (3):
>   mmc: slot-gpio: use devm_* managed functions to ease users
>   mmc: remove unncessary mmc_gpio_free_cd() call from slot-gpio users
>   mmc: sdhci-esdhc-imx: use slot-gpio helpers for CD and WP
>
>  drivers/mmc/core/slot-gpio.c       |   57 ++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci-esdhc-imx.c |   56 ++++++++++-------------------------
>  drivers/mmc/host/sdhci-pxav3.c     |    5 ----
>  drivers/mmc/host/sh_mmcif.c        |    6 ----
>  drivers/mmc/host/tmio_mmc_pio.c    |    8 -----
>  5 files changed, 67 insertions(+), 65 deletions(-)

Thanks for doing this, all merged to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
