From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 04/12] drivers/mmc/host: don't use devm_pinctrl_get_select_default() in probe
Date: Wed, 10 Jul 2013 21:57:16 +0200
Message-ID: <201307102157.16419.marex@denx.de>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de> <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35285 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab3GJT5X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jul 2013 15:57:23 -0400
In-Reply-To: <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, Barry Song <baohua.song@csr.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Jingoo Han <jg1.han@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Wolfram Sang,

> Since commit ab78029 (drivers/pinctrl: grab default handles from device
> core), we can rely on device core for setting the default pins. Compile
> tested only.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Something like that is already in -next:

    mmc: mxs-mmc: Let device core handle pinctrl

Otherwise

Tested-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
