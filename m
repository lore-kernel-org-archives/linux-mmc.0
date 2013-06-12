From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv6 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on
 SOCFPGA
Date: Tue, 11 Jun 2013 19:08:16 -0500
Message-ID: <1370995696.7804.17.camel@linux-builds1>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
	 <1370444578-25721-7-git-send-email-dinguyen@altera.com>
	 <20130611232756.GD23774@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:11691
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752354Ab3FLAIP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 20:08:15 -0400
In-Reply-To: <20130611232756.GD23774@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

Hi Olof,

On Tue, 2013-06-11 at 16:27 -0700, Olof Johansson wrote:
> Hi,
> 
> On Wed, Jun 05, 2013 at 10:02:58AM -0500, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add platform specific functionality for the DW SD/MMC driver for
> > SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> > can use this define.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > CC: Seungwon Jeon <tgih.jun@samsung.com>
> > CC: Jaehoon Chung <jh80.chung@samsung.com>
> > CC: Arnd Bergmann <arnd@arndb.de>
> > CC: Olof Johansson <olof@lixom.net>
> > CC: Pavel Machek <pavel@denx.de>
> > CC: linux-mmc@vger.kernel.org
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> This one should be sent to (and applied by) Chris Ball, the MMC maintainer. The
> driver is standalone and can go in independently on the platform code that will
> configure it, so he can merge it without dependencies.

Thanks Olof. I will send to Chris Ball. I kinda thought that since
Jaehoon and Seungwon were maintainers of the dw_mmc driver that I didn't
need to send to Chris.

Dinh
> 
> 
> -Olof
> 



