From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus devices
Date: Sun, 25 Aug 2013 15:51:21 -0400
Message-ID: <87d2p1pn0m.fsf@octavius.laptop.org>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
	<1373472384-13067-1-git-send-email-a-bindra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57934 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881Ab3HYTvZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 15:51:25 -0400
In-Reply-To: <1373472384-13067-1-git-send-email-a-bindra@ti.com>
	(a-bindra@ti.com's message of "Wed, 10 Jul 2013 21:36:24 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: a-bindra@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

On Wed, Jul 10 2013, a-bindra@ti.com wrote:
> From: Amarinder Bindra <a-bindra@ti.com>
>
> OMAP's hs_mmc driver is used for MMC controller operation on many
> omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).
>
> Considering that the device tree entries are already present for these,
> allow the driver to be built using the config ARCH_OMAP2PLUS rather
> than individually adding a config for each SoC to enable the
> support.
>
> Use COMPILE_TEST to enable the build for other platforms.
>
> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
