From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 1/3] arm: socfpga: Set the SDMMC clock phase in system
 manager
Date: Sat, 14 Sep 2013 13:00:31 +0200
Message-ID: <20130914110031.GB15077@amd.pavel.ucw.cz>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
 <1378740833-4883-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51796 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3INLAd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Sep 2013 07:00:33 -0400
Content-Disposition: inline
In-Reply-To: <1378740833-4883-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add functionality in the System Manager to set the SDR settings for the
> SD/MMC IP.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Pavel Machek <pavel@denx.de>

> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(void)
> +{
> +	struct device_node *np;
> +	u32 timing[2];
> +	u32 hs_timing;
> +
> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
> +	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> +}
> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);

To get the abstraction right, would it make sense to have timing
parameters as arguments to socfpga_sysmgr_set_dwmmc_drvsel_smpsel(),
so that sysmgr code is not walking MMC's device tree directly?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
