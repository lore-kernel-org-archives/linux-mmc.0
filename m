From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv5 2/4] clk: socfpga: Add a hook for SD/MMC driver to
 control CIU clock settings
Date: Mon, 9 Dec 2013 13:41:23 -0600
Message-ID: <1386618083.29889.17.camel@linux-builds1>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
	 <1386597462-29471-3-git-send-email-dinguyen@altera.com>
	 <201312091728.07940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:21276
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761533Ab3LITnE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 14:43:04 -0500
In-Reply-To: <201312091728.07940.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dinh.linux@gmail.com, mturquette@linaro.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2013-12-09 at 17:28 +0100, Arnd Bergmann wrote:
> On Monday 09 December 2013, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
> > the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
> > the correct clock-phase for the CIU clock of the SD/MMC IP.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Please see my comments for this patch for v4, it still looks wrong to me.
> The other three patches are good though.

I apologize for missing your V4 comments. It somehow never ended in my
Altera mbox but is there at gmail. I will address them.

Dinh
> 
> 	Arnd
> 



