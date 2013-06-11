From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv6 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on
 SOCFPGA
Date: Tue, 11 Jun 2013 16:27:56 -0700
Message-ID: <20130611232756.GD23774@quad.lixom.net>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
 <1370444578-25721-7-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35120 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab3FKX1w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 19:27:52 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so4310178pbc.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2013 16:27:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1370444578-25721-7-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 05, 2013 at 10:02:58AM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Seungwon Jeon <tgih.jun@samsung.com>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> CC: Pavel Machek <pavel@denx.de>
> CC: linux-mmc@vger.kernel.org

Acked-by: Olof Johansson <olof@lixom.net>

This one should be sent to (and applied by) Chris Ball, the MMC maintainer. The
driver is standalone and can go in independently on the platform code that will
configure it, so he can merge it without dependencies.


-Olof
