From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Fri, 24 May 2013 19:10:37 +0200
Message-ID: <201305241910.37975.arnd@arndb.de>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com> <1369410080-436-6-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63047 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3EXRKw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 13:10:52 -0400
In-Reply-To: <1369410080-436-6-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

On Friday 24 May 2013, dinguyen@altera.com wrote:
> 
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.

No objections to the patch, but you seem to be missing a  binding document,
which is mandatory to describe the properties you add.

It also seems odd to have this in the series for the ethernet driver.

	Arnd
