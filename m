From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: remove imxmmc driver
Date: Wed, 11 Apr 2012 16:05:51 -0400
Message-ID: <87hawqrq3k.fsf@laptop.org>
References: <1334174103-4724-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51090 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761040Ab2DKUFs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Apr 2012 16:05:48 -0400
In-Reply-To: <1334174103-4724-1-git-send-email-s.hauer@pengutronix.de> (Sascha
	Hauer's message of "Wed, 11 Apr 2012 21:55:03 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Sascha,

On Wed, Apr 11 2012, Sascha Hauer wrote:
> This driver is broken since 2.6.31 when the traditional i.MX1
> support was removed.
>
> In theory the i.MX1 mmc controller can be supported by the mxcmmc
> driver which basically is the same hardware. However, the i.MX1
> controller has severe bugs which made several workarounds necessary which
> resulted in a different driver structure. At that time it seemed easier
> to write a second driver to support hardware without bugs.
>
> As noone cared for the i.MX1 driver for a long time and it does
> not compile, remove it.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/Kconfig  |   10 -
>  drivers/mmc/host/Makefile |    1 -
>  drivers/mmc/host/imxmmc.c | 1169 ---------------------------------------------
>  3 files changed, 1180 deletions(-)
>  delete mode 100644 drivers/mmc/host/imxmmc.c

Looks good, but you missed drivers/mmc/host/imxmmc.h.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
