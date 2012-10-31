From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Remove platform data
Date: Wed, 31 Oct 2012 17:38:18 +0100
Message-ID: <201210311738.18915.marex@denx.de>
References: <1351682578-12922-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45323 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913Ab2JaQmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 12:42:08 -0400
In-Reply-To: <1351682578-12922-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> All MXS users have been converted to device tree and the board files have
> been removed.
> 
> No need to keep platform data in the driver.
> 
> Also move bus_width declaration in the beggining of mxs_mmc_probe() to
> avoid: 'warning: ISO C90 forbids mixed declarations and code'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
[...]

You might want to do the same for MXS SPI driver.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
