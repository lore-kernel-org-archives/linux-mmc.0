From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH 0/4] socfpga: Enable SD/MMC support
Date: Thu, 17 Oct 2013 09:47:41 +0200
Message-ID: <20131017074741.GK14042@pengutronix.de>
References: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42911 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab3JQHsF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 03:48:05 -0400
Content-Disposition: inline
In-Reply-To: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Pavel Machek <pavel@denx.de>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi!

On Wed, Oct 16, 2013 at 07:32:37PM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi,
> 
> This patch series enables support for the Synopsys SD/MMC driver that is
> on the Altera SOCFPGA platform. The reason why this series has 4 patches
> is to implement Arnd's suggestion:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204982.html
> 
> To summarize Arnd's suggestion:
> 
> 1. Create a backend syscon driver to control the system manager.
> 2. Create a clock driver independent of the SOCFPGA clock driver that
>    uses syscon as the low-level interface.
> 3. Make the sdmmc driver use the normal clock API and link its clock to
>    the driver step 2 in the device tree.
> 
> The end approach is a bit different because I did not find the need for a
> syscon driver for the system manager. Since the system manager had already
> been iomap already in the SOCFPGA platform code, I just reused it in the
> new clock driver.
> 

What about the usbgrp, pinmuxgrp, nandgrp, etc. ?
Those are all registers for different subsystems, that are located/controlled by
the systemmgr.
With Arnd's approach they all could call that low-level interface, instead of
having a special case for every IP core. Isn't that the whole idea behind syscon?

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
