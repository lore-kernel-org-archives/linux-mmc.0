From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in system manager
Date: Tue, 15 Oct 2013 14:50:48 +0200
Message-ID: <201310151450.48650.arnd@arndb.de>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56440 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116Ab3JOMvw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 08:51:52 -0400
In-Reply-To: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Pavel Machek <pavel@denx.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 14 October 2013, dinguyen@altera.com wrote:
> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
> +{
> +       u32 hs_timing;
> +
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
> +       writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> +}
> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);

This looks like the wrong approach. What are you trying to do? If you want to
set a clock, please use the clk API.

	Arnd
