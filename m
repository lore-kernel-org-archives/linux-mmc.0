From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
Date: Sun, 12 Dec 2010 01:13:44 +0000
Message-ID: <20101212011343.GA27152@void.printf.net>
References: <20101210162351.GA11798@void.printf.net> <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com> <20101212004203.GG19897@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40121 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab0LLBNr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Dec 2010 20:13:47 -0500
Content-Disposition: inline
In-Reply-To: <20101212004203.GG19897@game.jcrosoft.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, yauhen.kharuzhy@promwad.com, linux-arm-kernel@lists.infradead.org

On Dec 12, 2010 at 01:42:03AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Based on report made by Yauhen in:
> > "MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
> > I report those changes to the brother driver: atmel-mci.
> > 
> > So, this patch sets SDIO transfer types: SDIO block and SDIO byte
> > transfers instead of using ordinary MMC block transfers.
> > It is checking opcode for SDIO CMD53 and setting transfer
> > type in MCI_CMDR register properly.
> > 
> > Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Thanks, pushed to mmc-next and queued for .37/stable.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
