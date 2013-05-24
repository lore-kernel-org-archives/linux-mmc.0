From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on
 SOCFPGA
Date: Fri, 24 May 2013 13:03:08 -0500
Message-ID: <1369418588.9717.0.camel@linux-builds1>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
	 <1369410080-436-6-git-send-email-dinguyen@altera.com>
	 <201305241910.37975.arnd@arndb.de> <201305241912.53751.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:44666
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754040Ab3EXSBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 14:01:08 -0400
In-Reply-To: <201305241912.53751.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

Hi Arnd,

On Fri, 2013-05-24 at 19:12 +0200, Arnd Bergmann wrote:
> On Friday 24 May 2013, Arnd Bergmann wrote:
> 
> > It also seems odd to have this in the series for the ethernet driver.
> 
> After I sent it I realized that your patches are actually for different
> parts of the system, they were just all replies to the same first patch.
> 
> It's usually helpful to add a [PATCH 0/6] message that explains the
> overall intention and who you expect to pick up the patches, to avoid
> the confusion I had.

I apologize for that. Will make sure to include a [PATCH 0/6] message in
the future.

Dinh
> 
> 	Arnd
> 



