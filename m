From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv2 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Thu, 27 Jun 2013 11:53:17 -0400
Message-ID: <87y59vmtxu.fsf@octavius.laptop.org>
References: <1371050331-31331-1-git-send-email-dinguyen@altera.com>
	<1371050331-31331-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35086 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab3F0Pxb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:53:31 -0400
In-Reply-To: <1371050331-31331-2-git-send-email-dinguyen@altera.com>
	(dinguyen@altera.com's message of "Wed, 12 Jun 2013 10:18:51 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>

Hi Dinh,

On Wed, Jun 12 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com
> CC: Seungwon Jeon <tgih.jun@samsung.com>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> CC: Pavel Machek <pavel@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> CC: linux-mmc@vger.kernel.org

Thanks, I've taken patch 2 into mmc-next for 3.11.  Since there are no
arch ACKs on patch 1 yet, please submit that one through arm-soc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
