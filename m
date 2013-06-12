From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 12 Jun 2013 10:04:11 +0900
Message-ID: <000801ce6708$c0262e10$40728a30$%jun@samsung.com>
References: <1370996924-23048-1-git-send-email-dinguyen@altera.com>
 <1370996924-23048-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50609 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab3FLBEN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 21:04:13 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MO900JQY9N0HC60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Jun 2013 10:04:12 +0900 (KST)
In-reply-to: <1370996924-23048-3-git-send-email-dinguyen@altera.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Pavel Machek' <pavel@denx.de>

On 06/12/13 9:29 AM Dinh Nguyen wrote:
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
> CC: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon


