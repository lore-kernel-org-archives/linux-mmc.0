From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
Date: Fri, 10 Dec 2010 17:21:04 +0000
Message-ID: <20101210172104.GA12871@void.printf.net>
References: <20101210162351.GA11798@void.printf.net> <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38002 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab0LJRVI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Dec 2010 12:21:08 -0500
Content-Disposition: inline
In-Reply-To: <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, yauhen.kharuzhy@promwad.com

Hi Nicolas,

On Fri, Dec 10, 2010 at 07:14:32PM +0100, Nicolas Ferre wrote:
> Based on report made by Yauhen in:
> "MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
> I report those changes to the brother driver: atmel-mci.
> 
> So, this patch sets SDIO transfer types: SDIO block and SDIO byte
> transfers instead of using ordinary MMC block transfers.
> It is checking opcode for SDIO CMD53 and setting transfer
> type in MCI_CMDR register properly.
> 
> Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> 
> Hi Chris,
> 
> In addition to the at91_mci multiblock SDIO fix, I add this little one too as
> it concerns the brother driver atmel-mci with same issue.
> 
> I hope that you will be able to queue those fixes to .37-final and stable...

That's fine, this is queued now too.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
